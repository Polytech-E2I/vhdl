library ieee;
use ieee.std_logic_1164.all;

entity sous1bit is
    port(
        Ain, Bin, Cin: in std_logic;
        Cout, S: out std_logic
    );
end;

architecture sousimpl of sous1bit is
begin
    S <= Ain xor Bin xor Cin;
    Cout <= ((not Ain) and Bin) or ((not Ain) and Cin) or (Bin and Cin);
end;