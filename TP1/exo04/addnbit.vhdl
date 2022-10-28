library ieee;
use ieee.std_logic_1164.all;

entity addnbit is
    generic(N:natural := 4);
    port(
        Ain, Bin: in std_logic_vector(N-1 downto 0);
        S: out std_logic_vector(N-1 downto 0);
        C: out std_logic
    );
end;

architecture addnimpl of addnbit is
    signal Carry_int: std_logic_vector(N downto 0)
    component add1bit is
        port
        (
            A, B, Cin:  in std_logic;
            Cout, S:    out std_logic
        );
    end component;
begin
    Carry_int(0) <= '0';
    ADDN_inst: for I in 0 to N generate

        ADD: port map
end;