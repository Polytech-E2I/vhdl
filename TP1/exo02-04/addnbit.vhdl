library ieee;
use ieee.std_logic_1164.all;

entity addnbit is
    generic(
        N:          natural
    );
    port(
        Ain, Bin:   in std_logic_vector(N-1 downto 0);
        S:          out std_logic_vector(N-1 downto 0);
        C:          out std_logic
    );
end;

architecture impl of addnbit is
    signal Carry_int: std_logic_vector(N downto 0) := (others => '0');

    component add1bit is
        port
        (
            Ain, Bin, Cin:  in std_logic;
            Cout, S:        out std_logic
        );
    end component;

begin
    Carry_int(0) <= '0';
    ADDN_inst: for I in 0 to N-1 generate
        ADD: add1bit port map(
            -- Ain => Ain(I),
            -- Bin => Bin(I),
            -- Cin => Carry_int(I),
            -- Cout => Carry_int(I+1),
            -- S => S(I)
            Ain(I),
            Bin(I),
            Carry_int(I),
            Carry_int(I+1),
            S(I)
        );
    end generate;

    C <= Carry_int(N);
end;