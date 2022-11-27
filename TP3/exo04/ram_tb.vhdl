library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end;

architecture tb of ram_tb is
    constant load_file_name : string := "testfile.txt";
    constant dta : integer := 8;
    constant adr : integer := 4;

    component MA_RAM is
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
    end component;

    signal address : std_logic_vector(adr-1 downto 0);
    signal datain :  std_logic_vector(dta-1 downto 0);
    signal wr_ena :  std_logic := '0';
    signal dataout : std_logic_vector(dta-1 downto 0);

begin
    UUT: MA_RAM
        generic map(
            load_file_name => load_file_name,
            adr => adr,
            dta => dta
        )
        port map(
            address => address,
            datain => datain,
            wr_ena => wr_ena,
            dataout => dataout
        );

    CASES: process
    begin
        wr_ena <= '1';
        for i in 0 to 15 loop
            address <= std_logic_vector(to_unsigned(i, address'length));
            datain <= std_logic_vector(to_unsigned(i+30, datain'length));
            wait for 1 fs;
        end loop;

        datain <= (others => 'U');
        wr_ena <= '0';
        for i in 0 to 15 loop
            address <= std_logic_vector(to_unsigned(i, address'length));
            wait for 1 fs;
        end loop;
    end process;
end;