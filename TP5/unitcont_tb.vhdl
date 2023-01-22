library ieee;
use ieee.std_logic_1164.all;

entity unitcont_tb is
end;

architecture tb of unitcont_tb is
    constant N: natural := 16;

    -- UUT Helper
    component pgcounter is
        generic(
            addrsize:   natural;
            datasize:   natural
        );
        port(
            addr:       in std_logic_vector(addrsize-1 downto 0);
            jmp:        in std_logic;
            clk:        in std_logic;
            nrst:       in std_logic;
            filename:   in string;

            inst:   out std_logic_vector(datasize-1 downto 0)
        );
    end component;

    -- Helper input signals
    signal addr: std_logic_vector(N-1 downto 0) := (others => '0');
    signal injmp:  std_logic := '0';
    signal clk:  std_logic := '1';
    signal nrst: std_logic := '0';
    constant filename: string := "instructions1.txt";
    -- Helper output signals
    signal inst: std_logic_vector(N-1 downto 0);

    -- UUT Component
    component unitcont is
        generic(
            N: natural
        );

        port(
            inst:   in std_logic_vector(15 downto 0);
            clk:    in std_logic;
            jmp:    out std_logic;
            instout:out std_logic_vector(15 downto 0)
        );
    end component;

    -- UUT output signals
    signal instout: std_logic_vector(15 downto 0);

    constant clock_period: time := 2 fs;

begin
    clk <= not clk after clock_period/2;
    nrst <= '0', '1' after clock_period * 4;

    PGC: pgcounter
        generic map(
            addrsize => N,
            datasize => N
        )
        port map(
            addr => addr,
            jmp => injmp,
            clk => clk,
            nrst => nrst,
            filename => filename,
            inst => inst
        );
    UUT: unitcont
        generic map(
            N => N
        )
        port map(
            inst => inst,
            clk => clk,
            jmp => injmp,
            instout => addr
        );
end;