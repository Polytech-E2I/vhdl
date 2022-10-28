library ieee;
use ieee.std_logic_1164.all;

entity alarme is
    port(
        V, P, F:    in std_logic;
        S:          out std_logic
    );
end;

architecture impl of alarme is
begin
    S <= V and (F or P);
end;