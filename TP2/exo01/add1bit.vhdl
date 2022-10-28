library ieee;
use ieee.std_logic_1164.all;

entity add1bit is
    port(
        Ain, Bin, Cin:  in std_logic;
        Cout, S:        out std_logic
    );
end add1bit;

architecture addimpl of add1bit is
begin
    S <= Ain xor Bin xor Cin;
    Cout <= (Ain and Bin) or (Ain and Cin) or (Bin and Cin);
end;