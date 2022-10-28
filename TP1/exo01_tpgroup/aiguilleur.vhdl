library ieee;
use ieee.std_logic_1164.all;

entity aiguilleur is
    port(
        Ain, Bin: in integer;
        Aout, Bout: out integer;
        C: in std_logic
    );
end aiguilleur;

architecture arch_aiguilleur of aiguilleur is
begin
    Aout <= Ain when C='1' else Bin;
    Bout <= Bin when C='1' else Ain;
end architecture;
