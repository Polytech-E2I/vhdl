library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memreg_tb is
end;

architecture tb of memreg_tb is
    constant addrsize: natural := 8;

    -- UUT component
    component memreg is
        generic(
            addrsize: natural
        );
        port(
            Xin:    in std_logic_vector(addrsize-1 downto 0);
            clk:    in std_logic;
            a:      in std_logic;
            d:      in std_logic;
            sa:     in std_logic;

            Aout:   out std_logic_vector(addrsize-1 downto 0);
            FromMem:out std_logic_vector(addrsize-1 downto 0);
            Dout:   out std_logic_vector(addrsize-1 downto 0)
        );
    end component;

        -- UUT input signals
    signal Xin:     std_logic_vector(addrsize-1 downto 0) := (others => 'U');
    signal clk:     std_logic := '0';
    signal a:       std_logic := 'U';
    signal d:       std_logic := 'U';
    signal sa:      std_logic := 'U';
      -- UUT output signals
    signal Aout:    std_logic_vector(addrsize-1 downto 0) := (others => 'U');
    signal FromMem: std_logic_vector(addrsize-1 downto 0) := (others => 'U');
    signal Dout:    std_logic_vector(addrsize-1 downto 0) := (others => 'U');

    constant clock_period: time := 1 fs;

begin
    UUT:memreg
        generic map(
            addrsize => addrsize
        )
        port map(
            Xin => Xin,
            clk => clk,
            a => a,
            d => d,
            sa => sa,

            Aout => Aout,
            FromMem => FromMem,
            Dout => Dout
        );

    clk <= not clk after clock_period;

    Xin <=  std_logic_vector(to_unsigned(10, Xin'length)) after 1 fs,
            std_logic_vector(to_unsigned(37, Xin'length)) after 13 fs;
    a <=    '0',
            '1' after 5 fs,
            '0' after 7 fs;
    d <=    '0',
            '1' after 14 fs,
            '0' after 16 fs;
    sa <=   '0',
            '1' after 20 fs,
            '0' after 22 fs;
end;





