library ieee;
use ieee.std_logic_1164.all;

entity reseau is
    port(
        Ain:    in integer;
        Bin:    in integer;
        Cin:    in integer;
        Din:    in integer;
        Ctrl:   in std_logic_vector(4 downto 0);
        Aout:   out integer;
        Bout:   out integer;
        Cout:   out integer;
        Dout:   out integer
    );
end;

architecture impl of reseau is
    -- Base component
    component aiguilleur is
        port(
            Ain, Bin:       in integer;
            C:              in std_logic;
            Aout, Bout:     out integer
        );
    end component;

    -- Intermediary signals
    signal S1, S2, S3, S4, S5, S6: integer := 0;

begin
    AIG1: aiguilleur port map (Ain => Ain, Bin => Bin, C => Ctrl(4), Aout => S1, Bout => S2);
    AIG2: aiguilleur port map (Ain => Cin, Bin => Din, C => Ctrl(3), Aout => S3, Bout => S4);
    AIG3: aiguilleur port map (Ain => S2, Bin => S3, C => Ctrl(2), Aout => S5, Bout => S6);
    AIG4: aiguilleur port map (Ain => S1, Bin => S5, C => Ctrl(1), Aout => Aout, Bout => Bout);
    AIG5: aiguilleur port map (Ain => S6, Bin => S4, C => Ctrl(0), Aout => Cout, Bout => Dout);
end;