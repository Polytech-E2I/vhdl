library ieee;
use ieee.std_logic_1164.all;

entity inverseur is
    generic(
        N:  natural
    );

    port(
        X:      in std_logic_vector(N-1 downto 0);
        Xinv:   out std_logic_vector(N-1 downto 0)
    );
end;

architecture impl of inverseur is
begin
    inv_inst: for k in 0 to N-1 generate
        Xinv(k) <= not X(k);
    end generate;
end;