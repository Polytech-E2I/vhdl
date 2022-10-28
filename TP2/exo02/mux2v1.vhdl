library ieee;
use ieee.std_logic_1164.all;

entity mux2v1 is
    generic(
        N:  natural
    );

    port(
        D0: in std_logic_vector(N-1 downto 0);
        D1: in std_logic_vector(N-1 downto 0);
        S:  in std_logic;
        Y:  out std_logic_vector(N-1 downto 0)
    );
end;

architecture impl of mux2v1 is
begin
    Y <= D0 when S = '0' else D1;
end architecture;