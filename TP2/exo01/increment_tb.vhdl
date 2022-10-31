library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity increment_tb is
end;

architecture tb of increment_tb is
    constant nombre_bits: integer := 4;
    --- UUT component
    component increment is
        generic(
            N:  natural
        );

        port(
            X:      in std_logic_vector(N-1 downto 0);
            Xplus1: out std_logic_vector(N-1 downto 0)
        );
    end component;

    --- UUT input signals
    signal X:       std_logic_vector(nombre_bits-1 downto 0) := (others => 'U');
    --- UUT output signals
    signal Xplus1:  std_logic_vector(nombre_bits-1 downto 0) := (others => 'U');

begin
    UUT: increment
        generic map(
            N => nombre_bits
        )
        port map(
            X => X,
            Xplus1 => Xplus1
        );

    CASES: process
    begin
        for i in 0 to 10 loop
            X <= std_logic_vector(to_unsigned(i, X'length));
            wait for 1 fs;
        end loop;
    end process;
end;