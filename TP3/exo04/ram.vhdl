library ieee;
use ieee.std_logic_textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use std.textio.all;

entity MA_RAM is
    generic(
        load_file_name : string;
        dta : integer := 8;
        adr : integer := 4
    );
    port(
        address : in std_logic_vector(adr-1 downto 0);
        datain :  in std_logic_vector(dta-1 downto 0);
        wr_ena :  in std_logic;
        dataout : out std_logic_vector(dta-1 downto 0)
    );
end;

architecture beh of MA_RAM is
begin
    p_init_mem: process
        subtype myword is std_logic_vector(0 to datain'length-1);
        type storage_array is
            array(natural range 0 to 2**address'length - 1) of myword;
        variable storage : storage_array;
        variable index : natural;
        variable mem_data : line;
        variable vdata : integer;
        file load_file : text is load_file_name;
    begin
        index := 0;

        while not endfile(load_file) loop

            readline(load_file, mem_data);
            if mem_data'length > 0 then
                read(mem_data, vdata);
                storage(index) := std_logic_vector(conv_unsigned(vdata, datain'length));
                index := index + 1;
            end if;

            if index = (2**address'length) then
                index := 0;
            end if;
        end loop;

        loop
            wait on address, wr_ena, datain;
            if wr_ena = '0' then
                index := conv_integer(unsigned(address));
                dataout <= std_logic_vector(storage(index));
            else
                index := conv_integer(unsigned(address));
                storage(index) := datain;
            end if;
        end loop;
    end process;
end;