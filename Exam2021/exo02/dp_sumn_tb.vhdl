library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dp_sumn_tb is
end;

architecture tb of dp_sumn_tb is
    constant N: natural := 8;

    -- UUT component
    component dp_sumn is
        generic(
            N: natural
        );

        port(
            in1: in std_logic_vector(N-1 downto 0);
            in2: in std_logic_vector(N-1 downto 0);
            clk: in std_logic;
            nrst:in std_logic;

            done:   out std_logic;
            sumout: out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- UUT input signals
    signal in1:     std_logic_vector(N-1 downto 0);
    signal in2:     std_logic_vector(N-1 downto 0);
    signal clk:     std_logic := '1';
    signal nrst:    std_logic;
    -- UUT output signals
    signal done:    std_logic;
    signal sumout:  std_logic_vector(N-1 downto 0);

    constant clock_period: time := 2 fs;
begin
    clk <= not clk after clock_period/2;
    nrst <= '1';

    in1 <= std_logic_vector(to_unsigned(10, in1'length));
    in2 <= std_logic_vector(to_unsigned(1, in2'length));

    UUT: dp_sumn generic map(N => N)
        port map(
            in1 => in1,
            in2 => in2,
            clk => clk,
            nrst => nrst,

            done => done,
            sumout => sumout
        );
end;