library ieee;
use ieee.std_logic_1164.all;

entity pgcounter is
    generic(
        addrsize:   natural;
        datasize:   natural
    );
    port(
        addr:       in std_logic_vector(addrsize-1 downto 0);
        jmp:        in std_logic;
        clk:        in std_logic;
        filename:   in string;

        inst:   out std_logic_vector(datasize-1 downto 0)
    );
end;

architecture impl of pgcounter is
    component loadcount is
        generic(
            N: natural
        );

        port(
            E:      in std_logic_vector(N-1 downto 0);
            st:     in std_logic;
            clk:    in std_logic;
            nrst:   in std_logic;

            S: out std_logic_vector(N-1 downto 0)
        );
    end component;

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

    constant CONSTANT1: std_logic := '1';
    constant CONSTANT0: std_logic := '0';
    constant DATAUNDEF: std_logic_vector(datasize-1 downto 0) := (others => 'U');
    signal loadout:     std_logic_vector(addrsize-1 downto 0) := (others => 'U');

begin
    LOAD: loadcount
        generic map(
            N => addrsize
        )
        port map(
            E => addr,
            st => jmp,
            clk => clk,
            nrst => CONSTANT1,
            S => loadout
        );
    ROM: MA_RAM
        generic map(
            load_file_name => filename,
            dta => datasize,
            adr => addrsize
        )
        port map(
            address => loadout,
            datain => DATAUNDEF,
            wr_ena => CONSTANT0,
            dataout => inst
        );
end;