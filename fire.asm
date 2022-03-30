        BITS 16
        org 100h

        mov ax,13h         ; Init VGA 320x200 256 color mode
        int 10h            ; cli/sti ommited

        xor ax,ax          ; zero registers
        xor bx,bx
        xor cx,cx

                           ; Set palette
        mov dx,3c8h        ; 0x3c8 'PEL Write Index' (write start color index)
        out dx,al          ; start with color index 0
        inc dx             ; 0x3c9 'PEL Data Register' (write 3x 6bit RGB value)
        mov cl,32          ; indexes 0 - 31 black -> red gradient
l1:     inc ax
        out dx,al          ; R = 1 - 63
        xchg ax,bx
        out dx,al          ; G = 0
        out dx,al          ; B = 0
        xchg bx,ax
        inc ax
        loop l1

        xchg ax,cx         ; ax = 0 ; cx = 64
        shr cx,1           ; cx = 32
l2:     inc ax             ; indexes 32 - 63: red -> yellow gradient
        xchg ax,bx
        mov al,63
        out dx,al          ; R = 63
        mov ax,bx
        out dx,al          ; G = 1 - 63
        xor ax,ax
        out dx,al          ; B = 0
        xchg ax,bx
        inc ax
        loop l2

        xchg ax,cx         ; ax = 0 ; cx = 64
        shr cl,1           ; cx = 32
l3:     inc ax             ; indexes 64 - 95: yellow -> white gradient
        xchg ax,bx
        mov al,63
        out dx,al          ; R = 63
        out dx,al          ; G = 63
        xchg ax,bx
        out dx,al          ; B = 1 - 63
        inc ax
        loop l3

        mov cl,96          ; indexes 96 - 127: white
        dec ax             ; ax = 63
l4:     out dx,al          ; R|G|B = 63
        loop l4

        push word 0a000h   ; set ds to VGA framebuffer segment
        pop ds
        mov di,640         ; length of 2 lines/columns (640 pixels / bytes) for late use

                           ; main loop (drawing single pixel as 2x2 square)

l5:     mov cx,320         ; 1 line/column is 320 pixels / bytes
l6:     mov si,19520       ; we start on line 61, reserving top for other use (maybe text)
        sub si,cx
l7:     mov al,[si]        ; al = current pixel color index
        add al,[si+2]      ; al += index of right pixel neighbour
        lahf               ; ah bit 0 = 1 if cary
        add al,[si-2]      ; al += index of right pixel neighbour
        adc ah,bh          ; ah += 1 if cary
        add al,[si+642]    ; al += index of above right pixel neighbour
        adc ah,bh          ; ah += 1 if cary
        shr ax,1           ; ax / 2
        shr al,1           ; al / 2
        jz l8              ; al is zero, avoid underflow
        dec ax             ; al is nonzero? decay color index by 1
l8:     mov ah,al          ; duplicate ah from al (2 pixels of same index)
        mov [si-640],ax    ; put 1st doble-pixel 2 rows above
        mov [si-320],ax    ; second pixel 1 row above
        add si,di          ; increment double-row counter
        jnc short l7       ; not last double-row? process next
        sub si,di          ; we are too deep, fix that
        lea dx,[edx+edx*4] ; almoust PRNG, result in dh ; db 67h,8dh,14h,92h
        mov [si],dh        ; store new pixel
        or byte [si],160   ; be sure, pixel is not too dark ; 10100000b
l9:     dec cx
        loop l6            ; next column
        in al,60h          ; read key
        cmp al,1           ; is it escape?
        jne l5             ; nope, back to main loop
        mov ax,3           ; yeah, restore text mode 3
        int 10h
        ret                ; and exit
