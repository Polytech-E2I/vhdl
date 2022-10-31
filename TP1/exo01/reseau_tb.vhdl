library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reseau_tb is
end;

architecture tb of reseau_tb is
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

    CASES: process
    begin
        for i in 0 to 31 loop
            Ctrl <= std_logic_vector(to_unsigned(i, Ctrl'length));
            wait for 1 fs;
        end loop;
    end process;
end;