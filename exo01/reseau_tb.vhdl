library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity reseau_tb is
end reseau_tb;

architecture rtb of reseau_tb is
    signal Ain, Bin, Cin, Din: integer;
    signal Ctrl: std_logic_vector(4 downto 0);
    signal Aout, Bout, Cout, Dout: integer;
begin
    RES: entity work.reseau port map(
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

    -- Ctrl <= "00000";
    -- wait for 1 fs;
    -- Ctrl <= "00001";
    --Ctrl <= std_logic_vector(Ctrl + '1') after 1 fs;
    -- Ctrl <= std_logic_vector(unsigned(Ctrl) + 1) after 1 fs;

    -- CtrlLoop: for i in 0 to 31 generate
    --     Ctrl <= Ctrl + '1' after 1 fs;
    -- end generate;
end rtb;