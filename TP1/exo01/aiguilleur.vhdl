library ieee;
use ieee.std_logic_1164.all;

entity aiguilleur is
    port(
        Ain, Bin:   in integer;
        C:          in std_logic;
        Aout, Bout: out integer
    );
end;

architecture impl of aiguilleur is
begin
    Aout <= Ain when C = '0' else Bin;
    Bout <= Bin when C = '0' else Ain;
end;