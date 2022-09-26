entity reseau_tb is
end reseau_tb;

architecture rtb of reseau_tb is
    signal Ain, Bin, Cin, Din: integer;
    signal Ctrl: bit_vector(4 downto 0);
    signal Aout, Bout, Cout, Dout: integer;
begin
    RES: entity work.reseau port map (Ain => Ain, Bin => Bin, Cin => Cin, Din => Din, Ctrl => Ctrl, Aout => Aout, Bout => Bout, Cout => Cout, Dout => Dout);

    Ain <= 1;
    Bin <= 2;
    Cin <= 3;
    Din <= 4;

    -- Ctrl := ('0, '0, '0, '0, '0');
    Ctrl <= "00000";
end rtb;