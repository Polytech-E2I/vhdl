library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pgcounter_tb is
end;

architecture tb of pgcounter_tb is
    constant filename:  string := "testfile.txt";
    constant addrsize:  natural := 8;
    constant datasize:  natural := 8;

    -- UUT component
    component pgcounter is
        generic(
            addrsize:   natural;
            datasize:   natural
        );
        port(
            addr:   in std_logic_vector(addrsize-1 downto 0);
            jmp:    in std_logic;
            clk:    in std_logic;

            inst:   out std_logic_vector(datasize-1 downto 0)
        );
    end component;

    -- UUT input signals
    signal addr:    std_logic_vector(addrsize-1 downto 0) := (others => 'U');
    signal jmp:     std_logic := '0';
    signal clk:     std_logic := '0';
    -- UUT output signals
    signal inst:    std_logic_vector(datasize-1 downto 0);

    signal address : std_logic_vector(addrsize-1 downto 0);
    signal datain :  std_logic_vector(datasize-1 downto 0);
    signal wr_ena :  std_logic := '0';
    signal dataout : std_logic_vector(datasize-1 downto 0);

    constant clock_period: time := 1 fs;

begin
    UUT: pgcounter
        generic map(
            addrsize => addrsize,
            datasize => datasize
        )
        port map(
            addr => addr,
            jmp => jmp,
            clk => clk,
            inst => inst
        );

    clk <= not clk after clock_period;

    CASES: process
    begin
        datain <= (others => 'U');
        wr_ena <= '0';

        for i in 10 to 26 loop
            wait for 10 fs;
            addr <= std_logic_vector(to_unsigned(i, addr'length));
            wait for 1 fs;
            jmp <= '1';
            wait for 2 fs;
            jmp <= '0';
        end loop;

        wait for 100 fs;
    end process;
end;