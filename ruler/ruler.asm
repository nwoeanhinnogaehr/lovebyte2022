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
jmp X
