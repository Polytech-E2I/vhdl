library ieee;
use ieee.std_logic_1164.all;

entity addnbit is
    generic(M:natural := 4);
    port(
        Ain, Bin: in std_logic_vector(M-1 downto 0);
        S: out std_logic_vector(M-1 downto 0);
        C: out std_logic
    );
end;

architecture addnimpl of addnbit is
begin
end;