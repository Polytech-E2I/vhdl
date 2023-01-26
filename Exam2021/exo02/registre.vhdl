library ieee;
use ieee.std_logic_1164.all;

entity registre is
    generic(
        N: natural
    );
    port(
        D:      in std_logic_vector(N-1 downto 0);
        load:   in std_logic;
        nrst:   in std_logic;
        clk:    in std_logic;
        Q:      out std_logic_vector(N-1 downto 0)
    );
end;

architecture impl of registre is
begin
    process(nrst, clk)
    begin
        if nrst = '0' then
            Q <= (others => '0');
        else
            if (clk'event and clk = '1') then
                if load = '1' then
                    Q <= D;
                end if;
            end if;
        end if;
    end process;
end;