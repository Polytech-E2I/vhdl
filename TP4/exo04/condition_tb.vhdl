library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity condition_tb is
end;

architecture tb of condition_tb is
    constant N: natural := 8;

    -- UUT component
    component condition is
        generic(
            N: natural
        );
        port(
            Xin:    in std_logic_vector(N-1 downto 0);
            lt:     in std_logic;
            eq:     in std_logic;
            gt:     in std_logic;

            jmp:    out std_logic
        );
    end component;

    -- UUT input signals
    signal Xin: std_logic_vector(N-1 downto 0) := (others => 'U');
    signal lt:  std_logic := '0';
    signal eq:  std_logic := '0';
    signal gt:  std_logic := '0';
    -- UUT output signals
    signal jmp: std_logic;

    constant clock_period: time := 1 fs;

begin
    UUT: condition
        generic map(
            N => N
        )
        port map(
            Xin => Xin,
            lt => lt,
            eq => eq,
            gt => gt,
            jmp => jmp
        );

    gt <= not gt after clock_period;
    eq <= not eq after clock_period * 2;
    lt <= not lt after clock_period * 4;

    Xin <=
        (others => '0'),
        std_logic_vector(to_signed(13, Xin'length)) after 8 fs,
        std_logic_vector(to_signed(-13, Xin'length)) after 16 fs,
        (others => '1') after 24 fs
    ;
end;