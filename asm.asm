.model tiny, c
.data
cube    real4  0.0, 0.0, 0.0;    SOUTH:  A1B1D1  A1
        real4  0.0, 1.0, 0.0;                    B1
        real4  1.0, 0.0, 0.0;                    D1
        real4  0.0, 1.0, 0.0;    SOUTH:  B1C1D1  B1
        real4  1.0, 1.0, 0.0;                    C1
        real4  1.0, 0.0, 0.0;                    D1
        real4  0.0, 0.0, 1.0;    NORTH:  A2B2D2  A2
        real4  0.0, 1.0, 1.0;                    B2
        real4  1.0, 0.0, 1.0;                    D2
        real4  0.0, 1.0, 1.0;    NORTH:  B2C2D2  B2
        real4  1.0, 1.0, 1.0;                    C2
        real4  1.0, 0.0, 1.0;                    D2
        real4  1.0, 0.0, 0.0;    EAST:   D1C1D2  D1
        real4  1.0, 1.0, 0.0;                    C1
        real4  1.0, 0.0, 1.0;                    D2
        real4  1.0, 1.0, 0.0;    EAST:   C1C2D2  C1
        real4  1.0, 1.0, 1.0;                    C2
        real4  1.0, 0.0, 1.0;                    D2
        real4  0.0, 0.0, 0.0;    WEST:   A1B1A2  A1
        real4  0.0, 1.0, 0.0;                    B1
        real4  0.0, 0.0, 1.0;                    A2
        real4  0.0, 1.0, 0.0;    WEST:   B1B2A2  B1
        real4  0.0, 1.0, 1.0;                    B2
        real4  0.0, 0.0, 1.0;                    A2
        real4  1.0, 1.0, 0.0;    TOP:    C1B1B2  C1
        real4  0.0, 1.0, 0.0;                    B1
        real4  0.0, 1.0, 1.0;                    B2
        real4  1.0, 1.0, 0.0;    TOP:    C1B2C2  C1
        real4  0.0, 1.0, 1.0;                    B2
        real4  1.0, 1.0, 1.0;                    C2
        real4  1.0, 0.0, 0.0;    BOTTOM: D1A1A2  D1
        real4  0.0, 0.0, 0.0;                    A1
        real4  0.0, 0.0, 1.0;                    A2
        real4  1.0, 0.0, 0.0;    BOTTOM: D1A2D2  D1
        real4  0.0, 0.0, 1.0;                    A2
        real4  1.0, 0.0, 1.0;                    D2
.code 
foo proc 
	
    ret
foo  endp 

ClearConsole  proc 
    
ClearConsole endp 
end