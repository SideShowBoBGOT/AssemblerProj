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
    ret
InitfFovRad endp

InitfAspectratio proc
    fild [ScreenWidth]
    fild [ScreenHeight]
    fdiv st(0), st(1)
    fstp st(1)
    ret
InitfAspectratio endp

InitProjectionMatrix proc
    push eax
    push ebx
    push ecx
    push edx
    fld [fAspectRatio]
    fld [ffovRad]
    fmul st(0), st(1)
    fstp matp 
    mov [matp+4*8+8], ebx 
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
InitProjectionMatrix endp
mainfunc proc
    call InitfFovRad
    call InitfAspectratio
    call InitProjectionMatrix
mainfunc endp

END