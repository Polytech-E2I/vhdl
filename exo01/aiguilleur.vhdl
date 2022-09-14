entity aiguilleur is
    port(
        Ain, Bin:   in integer;
        C:          in bit;
        Aout, Bout: out integer
    );
end aiguilleur;


architecture impl01 of aiguilleur is
begin
    Aout <= Ain when C = '0' else Bin;
    Bout <= Bin when C = '0' else Ain;
end architecture impl01;
