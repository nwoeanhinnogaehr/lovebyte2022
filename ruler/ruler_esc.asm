bits 16
mov al,0x13
int 0x10
les ax,[bx]
mov ch,0x80
X:
stosw
sub di,cx
rol ax,cl
xchg ax,di
xchg ax,bx
in al,0x60
xchg ax,bx
dec bx
jnz X
ret
