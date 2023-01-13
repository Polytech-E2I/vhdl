library ieee;
use ieee.std_logic_1164.all;

entity unitcont is
    generic(
        N: natural
    );

    port(
        inst:   in std_logic_vector(15 downto 0);
        clk:    in std_logic;
        jmp:    out std_logic
    );
end;

architecture impl of unitcont is

    component instdecodeur is
        port(
            Xin:    in std_logic_vector(15 downto 0);
            W:      out std_logic_vector(15 downto 0);
            ci:     out std_logic;
            sm:     out std_logic;
            opc:    out std_logic_vector(5 downto 0);
            dst:    out std_logic_vector(2 downto 0);
            cnd:    out std_logic_vector(2 downto 0)
        );
    end component;

    component memreg is
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
    end component;

    component mux2v1 is
        generic(
            N:  natural
        );

        port(
            D0: in std_logic_vector(N-1 downto 0);
            D1: in std_logic_vector(N-1 downto 0);
            S:  in std_logic;
            Y:  out std_logic_vector(N-1 downto 0)
        );
    end component;

    component alu is
        generic(
            N: natural
        );

        port(
            X:  in std_logic_vector(N-1 downto 0);
            Y:  in std_logic_vector(N-1 downto 0);

            zx: in std_logic;
            nx: in std_logic;
            zy: in std_logic;
            ny: in std_logic;
            f:  in std_logic;
            no: in std_logic;

            S:  out std_logic_vector(N-1 downto 0)
        );
    end component;

    component condition is
        generic(
            N: natural
        );
        port(
            Xin:    in std_logic_vector(N-1 downto 0);
            lt:     in std_logic;
            eq:     in std_logic;
            gt:     in std_logic;

            jmp:    out std_logic
        );
    end component;

    signal ID_OUT_DST:      std_logic_vector(2 downto 0) := (others => 'U');
    signal ID_OUT_SM:       std_logic := 'U';
    signal ID_OUT_OPC:      std_logic_vector(5 downto 0) := (others => 'U');
    signal ID_OUT_CI:       std_logic := 'U';
    signal ID_OUT_CND:      std_logic_vector(2 downto 0) := (others => 'U');
    signal ID_OUT_W:        std_logic_vector(N-1 downto 0) := (others => 'U');

    signal MEMREG_OUT_A:    std_logic_vector(N-1 downto 0) := (others => 'U');
    signal MEMREG_OUT_MEM:  std_logic_vector(N-1 downto 0) := (others => 'U');
    signal MEMREG_OUT_D:    std_logic_vector(N-1 downto 0) := (others => 'U');

    signal MUX1_OUT:        std_logic_vector(N-1 downto 0) := (others => 'U');
    signal ALU_OUT:         std_logic_vector(N-1 downto 0) := (others => 'U');
    signal MUX2_OUT:        std_logic_vector(N-1 downto 0) := (others => 'U');

begin
    CMP_INST: instdecodeur
        port map(
            Xin => inst,

            W => ID_OUT_W,
            ci => ID_OUT_CI,
            sm => ID_OUT_SM,
            opc => ID_OUT_OPC,
            dst => ID_OUT_DST,
            cnd => ID_OUT_CND
        );
    CMP_MEMREG: memreg
        generic map(
            addrsize => N
        )
        port map(
            Xin => MUX2_OUT,
            clk => clk,

            a  => ID_OUT_DST(2),
            d  => ID_OUT_DST(1),
            sa => ID_OUT_DST(0),

            Dout => MEMREG_OUT_D,
            Aout => MEMREG_OUT_A,
            FromMem => MEMREG_OUT_MEM
        );

    CMP_MUX1: mux2v1
        generic map(
            N => N
        )
        port map(
            D0 => MEMREG_OUT_A,
            D1 => MEMREG_OUT_MEM,
            S => ID_OUT_SM,

            Y => MUX1_OUT
        );

    CMP_ALU: alu
        generic map(
            N => N
        )
        port map(
            X => MEMREG_OUT_D,
            Y => MUX1_OUT,

            zx => ID_OUT_OPC(5),
            nx => ID_OUT_OPC(4),
            zy => ID_OUT_OPC(3),
            ny => ID_OUT_OPC(2),
            f  => ID_OUT_OPC(1),
            no => ID_OUT_OPC(0),

            S => ALU_OUT
        );

    CMP_MUX2: mux2v1
        generic map(
            N => N
        )
        port map(
            D0 => ID_OUT_W,
            D1 => ALU_OUT,
            S => ID_OUT_CI,

            Y => MUX2_OUT
        );

    CMP_COND: condition
        generic map(
            N => N
        )
        port map(
            Xin => MUX2_OUT,

            lt => ID_OUT_CND(2),
            eq => ID_OUT_CND(1),
            gt => ID_OUT_CND(0),

            jmp => jmp
        );
end;