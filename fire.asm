        BITS 16
        org 100h

        mov ax,13h
        int 10h
        xor ax,ax
        xor bx,bx
        xor cx,cx
        mov dx,3c8h
        out dx,al
        inc dx
        mov cl,32
l1:     inc ax
        out dx,al
        xchg ax,bx
        out dx,al
        out dx,al
        xchg bx,ax
        inc ax
        loop l1
        xchg ax,cx
        shr cx,1
l2:     inc ax
        xchg ax,bx
        mov al,63
        out dx,al
        mov ax,bx
        out dx,al
        xor ax,ax
        out dx,al
        xchg ax,bx
        inc ax
        loop l2
        xchg ax,cx
        shr cl,1
l3:     inc ax
        xchg ax,bx
        mov al,63
        out dx,al
        out dx,al
        xchg ax,bx
        out dx,al
        inc ax
        loop l3
        mov cl,96
        dec ax
l4:     out dx,al
        loop l4
        push word 0a000h
        pop ds
        mov di,640
l5:     mov cx,320
l6:     mov si,19520
        sub si,cx
l7:     mov al,[si]
        add al,[si+2]
        lahf
        add al,[si-2]
        adc ah,bh
        add al,[si+642]
        adc ah,bh
        shr ax,1
        shr al,1
        jz l8
        dec ax
l8:     mov ah,al
        mov [si-640],ax
        mov [si-320],ax
        add si,di
        jnc short l7
        sub si,di
        lea dx,[edx+edx*4] ;db 67h,8dh,14h,92h
        mov [si],dh
        or byte [si],160
l9:     dec cx
        loop l6
        in al,60h
        cmp al,1
        jne l5
        mov ax,3
        int 10h
        ret
