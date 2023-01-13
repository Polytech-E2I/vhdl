library ieee;
use ieee.std_logic_1164.all;

entity condition is
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
end;

architecture impl of condition is
    constant ZEROS: std_logic_vector(N-1 downto 0) := (others => '0');

    signal iszero:  std_logic;
    signal isneg:   std_logic;
begin
    iszero <= '1' when Xin = ZEROS  else '0';
    isneg  <= Xin(N-1);

    jmp <=
        (
            ( not( (iszero) xor (isneg) ) )
            and
            gt
        )
        or
        (
            (eq and (iszero))
            or
            (lt and (isneg))
        )
        ;
end;