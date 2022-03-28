    .386
    .model flat, c
vec3d struct
i   real4   0.0
j   real4   0.0
k   real4   0.0
vec3d ends

triangle struct
poins   vec3d   3   DUP(0.0)
triangle ends

    .data
angle               dw      360
ScreenWidth         dw      320
ScreenHeight        dw      240
fNear               real4   0.1
fFar                real4   1000.0
fFov                real4   90.0f
fAspectRatio        real4   ?
fFovRad             real4   ?
matp    real4   16      DUP(0.0)
point   vec3d   <0.0,0.0,0.0>


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
    fild [ScreenWidth]
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
    fstp [matp+4*8+8]
    ;matp[2][2] = fFar / (fFar - fNear)
    fld [fFar]
    fld [fNear]
    fld [fFar]
    fsub st(0), st(1)
    fdiv st(2), st(0)
    fstp st(0)
    fstp st(0)
    fstp [matp+8*8+16]
    ;matp[3][2] = (fFar * fNear) / (fNear - fFar)
    fld [fNear]
    fld [fFar]
    fld [fNear]
    fsub st(0), st(1)
    fld1
    fdiv st(0), st(1)
    fmul st(0), st(2)
    fmul st(0), st(3)
    fstp [matp+12*8+16]
    fstp st(0)
    fstp st(0)
    fstp st(0)
    ;matp[2][3] = 1.0f
    fld1
    fstp [matp+8*8+24] 
    ret
InitProjectionMatrix endp
MultiplyMatrixVector proc
    
MultiplyMatrixVector endp
mainfunc proc
    call InitfFovRad
    call InitfAspectratio
    call InitProjectionMatrix
    
    ret
mainfunc endp

END