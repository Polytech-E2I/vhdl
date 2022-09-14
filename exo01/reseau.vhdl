
entity reseau is
    port(
        Ain:    in integer;
        Bin:    in integer;
        Cin:    in integer;
        Din:    in integer;
        Ctrl:   in bit_vector(4 downto 0);
        Aout:   out integer;
        Bout:   out integer;
        Cout:   out integer;
        Dout:   out integer
    );
end reseau;