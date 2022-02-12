mov al,0x13
int 0x10
lds cx,[bx]
X:
mov ax,0xcccd
mul	di
Y:
mov cl,0x1f
S:
add dl,dl
add dx,si
add dl,cl
mov bx,dx
and bl,0x80
cmp bl,bh
jg D
loop S
D:
cmp cl,0x10
jge W
jcxz H
add cl,0x30
jmp W
H:
xor ax,bp
add ax,si
test ax,0xfff
jne W
mov cl,0xf
W:
mov byte [di],cl
add di,bp
inc bp
jno X
inc si
jmp X
