library ieee;
use ieee.std_logic_1164.all;

entity increment is
    generic(
        N:  natural
    );

    port(
        X:      in std_logic_vector(N-1 downto 0);
        Xplus1: out std_logic_vector(N-1 downto 0)
    );
end;

architecture impl of increment is
    component addnbit is
        generic(
            N:      natural
        );
        port(
            Ain, Bin: in std_logic_vector(N-1 downto 0);
            S: out std_logic_vector(N-1 downto 0);
            C: out std_logic
        );
    end component;

    signal tmp0:    std_logic_vector(N-1 downto 1) := (others => '0');
    signal tmp1:    std_logic_vector(N-1 downto 0);
begin

    ADDN: addnbit
        generic map(
            N => N
        )
        port map(
            Ain => X,
            Bin => tmp1,
            S => Xplus1,
            C => open
        );

    tmp1 <= tmp0 & '1';
end;
