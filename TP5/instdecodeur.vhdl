library ieee;
use ieee.std_logic_1164.all;

entity instdecodeur is
    port(
        Xin:    in std_logic_vector(15 downto 0);
        W:      out std_logic_vector(15 downto 0);
        ci:     out std_logic;
        sm:     out std_logic;
        opc:    out std_logic_vector(5 downto 0);
        dst:    out std_logic_vector(2 downto 0);
        cnd:    out std_logic_vector(2 downto 0)
    );
end;

architecture impl of instdecodeur is
begin
    process(Xin)
    begin
        if (Xin(15) = '0') then
            W <= Xin;
            dst(2) <= '1';
        else
            ci <= Xin(15);
            sm <= Xin(12);
            opc <= Xin(11 downto 6);
            dst <= Xin(5 downto 3);
            cnd <= Xin(2 downto 0);
        end if;
    end process;
end;