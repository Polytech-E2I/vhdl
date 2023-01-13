library ieee;
use ieee.std_logic_1164.all;

entity memreg is
    generic(
        addrsize: natural
    );
    port(
        Xin:    in std_logic_vector(addrsize-1 downto 0);
        clk:    in std_logic;
        a:      in std_logic;
        d:      in std_logic;
        sa:     in std_logic;

        Aout:   out std_logic_vector(addrsize-1 downto 0);
        FromMem:out std_logic_vector(addrsize-1 downto 0);
        Dout:   out std_logic_vector(addrsize-1 downto 0)
    );
end;

--------------------------------------------------------------------

architecture impl of memreg is
    component registre is
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
    end component;

    component MA_RAM is
        generic(
            load_file_name : string;
            dta : integer := 8;
            adr : integer := 4
        );
        port(
            address : in std_logic_vector(adr-1 downto 0);
            datain :  in std_logic_vector(dta-1 downto 0);
            wr_ena :  in std_logic;
            dataout : out std_logic_vector(dta-1 downto 0)
        );
    end component;

    signal REGAOUT: std_logic_vector(addrsize-1 downto 0);
    constant CONSTANT1: std_logic := '1';
    constant filename:  string := "testfile.txt";

begin

    REGA: registre
        generic map(
            N => addrsize
        )
        port map(
            D => Xin,
            load => a,
            nrst => CONSTANT1,
            clk => clk,
            Q => REGAOUT
        );
    REGB: registre
        generic map(
            N => addrsize
        )
        port map(
            D => Xin,
            load => d,
            nrst => CONSTANT1,
            clk => clk,
            Q => Dout
        );

    ROM: MA_RAM
        generic map(
                load_file_name => filename,
                dta => addrsize,
                adr => addrsize
        )
        port map(
            address => REGAOUT,
            datain => Xin,
            wr_ena => sa,
            dataout => FromMem
        );

    Aout <= REGAOUT;

end;