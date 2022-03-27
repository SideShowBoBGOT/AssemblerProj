    .386
    .model flat, c
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
    ;matp[2][2] = fFar / (ffar - fNear)
    fld [fFar]
    fld [fFar]
    fld [fNear]
    fsub st(1), st(2)
    fdiv st(0), st(1)
    fstp [mat+8*8+16]
    fstp st(0)
    fstp st(0)
    ;matp[3][2] = (fFar * fNear) / (fNear - fFar)
    fld [fFar]
    fld [fNear]
    fld [fFar]
    fmul st(0), st(1)
    fsub st(1), st(2)
    fdiv st(0), st(1)
    fstp [mat+12*8+16]
    fstp st(0)
    fstp st(0)
    ;matp[2][3] = 1.0f
    fld1
    fstp [matp+8*8+24] 
    ret
InitProjectionMatrix endp
mainfunc proc
    call InitfFovRad
    call InitfAspectratio
    call InitProjectionMatrix
    ret
mainfunc endp

END