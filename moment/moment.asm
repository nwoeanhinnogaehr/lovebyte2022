mov al,0x13
int 0x10
lds ax,[bx]
M:
mov ah,0xcd ; skewed rrrola
mul	di
mov cl,0x1f ; init colour
R:
add dx,bx
add dx,dx
add dh,bl
cmp dh,dl
jb D ; jump if hit
loop R ; goto next layer
D:
mov byte [di],cl ; store pix
inc di ; replace with next two lines for dithering
;add di,si
;inc si
jne M
inc bx ; frame counter
jmp M
