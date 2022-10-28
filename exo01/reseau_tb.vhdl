library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reseau_tb is
end reseau_tb;

architecture rtb of reseau_tb is
    -- UUT component
    component reseau is
        port(
            Ain, Bin, Cin, Din:     in integer;
            Ctrl:                   in std_logic_vector(4 downto 0);
            Aout, Bout, Cout, Dout: out integer
        );
    end component;

    -- UUT input signals
    signal Ain, Bin, Cin, Din:      integer;-- := 0;
    signal Ctrl:                    std_logic_vector(4 downto 0);-- := "00000";
    -- UUT output signals
    signal Aout, Bout, Cout, Dout:  integer;-- := 0;
begin
    UUT: reseau port map(
        Ain => Ain
        , Bin => Bin
        , Cin => Cin
        , Din => Din
        , Ctrl => Ctrl
        , Aout => Aout
        , Bout => Bout
        , Cout => Cout
        , Dout => Dout
    );

    Ain <= 1;
    Bin <= 2;
    Cin <= 3;
    Din <= 4;

    -- Ctrl <= "00000",
    -- "00001" after 10 ns,
    -- "00010" after 20 ns,
    -- "00100" after 30 ns,
    -- "01000" after 40 ns,
    -- "10000" after 50 ns,
    -- "00011" after 60 ns,
    -- "00110" after 70 ns,
    -- "01100" after 80 ns,
    -- "11000" after 90 ns;

    CASES: process
    begin
        for i in 0 to 31 loop
            Ctrl <= std_logic_vector(to_unsigned(i, Ctrl'length));
        end loop;
    end process;
end architecture rtb;