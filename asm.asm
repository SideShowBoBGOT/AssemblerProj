    .386
    .model flat, c
    .stack 1048576
    .data
;Point Structure:    SIZE    36  bytes
point struct
i   real4   0.0
j   real4   0.0
k   real4   0.0
point ends

;triangle< Structure:    SIZE    36  bytes
triangle struct
point1   point  <0.0,0.0,0.0>
point2   point  <0.0,0.0,0.0>
point3   point  <0.0,0.0,0.0>
triangle ends

angle               dw                  360

ScreenWitriangleh   dw                  320
ScreenHeight        dw                  240
fNear               real4               0.1
fFar                real4               1000.0
fFov                real4               90.0f
fAspectRatio        real4               ?
fFovRad             real4               ?

matp                real4       16      DUP(0.0)

cube                triangle    <<0.0, 0.0, 0.0>, <0.0, 1.0, 0.0>, <1.0, 0.0, 0.0>>;    SOUTH:  A1B1D1
                    triangle    <<0.0, 1.0, 0.0>, <1.0, 1.0, 0.0>, <1.0, 0.0, 0.0>>;    SOUTH:  B1C1D1
                    triangle    <<0.0, 0.0, 1.0>, <0.0, 1.0, 1.0>, <1.0, 0.0, 1.0>>;    NORTH:  A2B2D2
                    triangle    <<0.0, 1.0, 1.0>, <1.0, 1.0, 1.0>, <1.0, 0.0, 1.0>>;    NORTH:  B2C2D2
                    triangle    <<1.0, 0.0, 0.0>, <1.0, 1.0, 0.0>, <1.0, 0.0, 1.0>>;    EAST:   D1C1D2
                    triangle    <<1.0, 1.0, 0.0>, <1.0, 1.0, 1.0>, <1.0, 0.0, 1.0>>;    EAST:   C1C2D2
                    triangle    <<0.0, 0.0, 0.0>, <0.0, 1.0, 0.0>, <0.0, 0.0, 1.0>>;    WEST:   A1B1A2
                    triangle    <<0.0, 1.0, 0.0>, <0.0, 1.0, 1.0>, <0.0, 0.0, 1.0>>;    WEST:   B1B2A2
                    triangle    <<1.0, 1.0, 0.0>, <0.0, 1.0, 0.0>, <0.0, 1.0, 1.0>>;    TOP:    C1B1B2
                    triangle    <<1.0, 1.0, 0.0>, <0.0, 1.0, 1.0>, <1.0, 1.0, 1.0>>;    TOP:    C1B2C2
                    triangle    <<1.0, 0.0, 0.0>, <0.0, 0.0, 0.0>, <0.0, 0.0, 1.0>>;    BOTTOM: D1A1A2
                    triangle    <<1.0, 0.0, 0.0>, <0.0, 0.0, 1.0>, <1.0, 0.0, 1.0>>;    BOTTOM: D1A2D2
p   point   <1.0, 2.0, 3.0>
    .code 
InitfFovRad proc
    fld [fFov]; res = fFov
    fidiv [angle]; res = fFov / 360
    fstp st(1)
    fldpi
    fmul st(0), st(1); res = res * pi
    fstp st(1)
    fptan; res = tan(res)
    fdiv st(0), st(1); st(0) = 1.0/res
    fstp st(0)
    fstp [fFovRad]
    ret
InitfFovRad endp
InitfAspectratio proc
    fild [ScreenWitriangleh]
    fild [ScreenHeight]
    fdiv st(0), st(1)
    fstp st(1)
    fstp [fAspectratio]
    ret
InitfAspectratio endp
InitProjectionMatrix proc
    ;matp[0][0] = fAspectratio * fFovRad
    fld [fAspectRatio]
    fld [fFovRad]
    fmul st(0), st(1)
    fstp st(1)
    fstp matp 
    ;matp[1][1] = fFovRad
    fld [fFovRad]
    fstp [matp+4*4+4]
    ;matp[2][2] = fFar / (fFar - fNear)
    fld [fFar]
    fld [fNear]
    fld [fFar]
    fsub st(0), st(1)
    fdiv st(2), st(0)
    fstp st(0)
    fstp st(0)
    fstp [matp+8*4+8]
    ;matp[3][2] = (fFar * fNear) / (fNear - fFar)
    fld [fNear]
    fld [fFar]
    fld [fNear]
    fsub st(0), st(1)
    fld1
    fdiv st(0), st(1)
    fmul st(0), st(2)
    fmul st(0), st(3)
    fstp [matp+12*4+8]
    fstp st(0)
    fstp st(0)
    fstp st(0)
    ;matp[2][3] = 1.0f
    fld1
    fstp [matp+8*4+12] 
    ret
InitProjectionMatrix endp
CalcNewCoordinate proc
    ;1 - arg push offset input eax to eax
    ;2 - arg push offset output ebx to ebx
    ;3 - arg push offset of matrix ecx to ecx
    ;4 - arg push edx as a counter
    fld [eax].point.i
    fld real4 ptr [ecx+edx]
    fmul st(0), st(1)
    fstp st(1)

    fld [eax].point.j
    fld real4 ptr [ecx+1*4*4+edx]
    fmul st(0), st(1)
    fstp st(1)
    fadd st(0), st(1)
    fstp st(1)

    fld [eax].point.k
    fld real4 ptr [ecx+2*4*4+edx]
    fmul st(0), st(1)
    fstp st(1)
    fadd st(0), st(1)
    fstp st(1)

    fld real4 ptr [ecx+3*4*4+edx]
    fadd st(0), st(1)
    fstp st(1)
    add edx, 4
    ret
CalcNewCoordinate endp
MultiplyMatrixVector proc
    LOCAL w:real4
    push edx
    mov edx, 0
    call CalcNewCoordinate
    fstp [ebx].point.i
    call CalcNewCoordinate
    fstp [ebx].point.j
    call CalcNewCoordinate
    fstp [ebx].point.k
    call CalcNewCoordinate
    fstp [w]

    fld1
    fld1
    fsub st(0), st(1)
    fstp st(1)
    fld [w]
    fcompp

    jnz @F
    fld [w]

    fld [ebx].point.i
    fdiv st(0), st(1)
    fstp [ebx].point.i

    fld [ebx].point.j
    fdiv st(0), st(1)
    fstp [ebx].point.j

    fld [ebx].point.k
    fdiv st(0), st(1)
    fstp [ebx].point.k
    
    fstp st(0)

    @@:
        pop edx
        ret
MultiplyMatrixVector endp
mainfunc proc
    call InitfFovRad
    call InitfAspectratio
    call InitProjectionMatrix
    fld [fFar]
    fstp real4 ptr [p+4]
    mov eax, offset p
    ret
mainfunc endp

END