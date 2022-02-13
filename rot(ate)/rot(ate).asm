; rot(ate) by byteobserver

bits 32
db "cp $0 /tmp/,;sed -i 1d $_;$_<>/dev/fb0|aplay -c4",10
org 0x68590000-($-$$)
top:
    db $7F,"ELF" ; e_ident
    dd 1 ; p_type
    dd 0 ; p_offset
    dd top ; p_vaddr
    dw 2 ; e_type, p_paddr
    dw 3 ; e_machine
    dd entry ; e_version, p_filesz
    dw entry-top
main:
    pop ecx ; pop previous sample
    push strict dword 4 ; overlaps with header, dword 4 must be here

    ; compute bytebeat
    mov eax,esi
    shr eax,2
    test ah,ch
    jp mode1
    sub eax,0x10020 ; overlaps with header, dword 0x10020 must be here
    and cl,ah
mode1:
    and ecx,eax
    ror eax,cl
    or eax,ecx
    inc esi

    ; write output
    mov ecx,esp
    xchg eax,[ecx]
    mov edx,eax
    int 0x80

    ; seek to beginning of file if error EFBIG is encountered
    ; otherwise, this does some harmless no-op syscall
    add eax,45 ; map EFBIG to lseek-2
    cdq
    xor ecx,ecx
entry:
    ; fork into two processes, for audio (child) and video (parent)
    ; or, if we had EFBIG, lseek to the beginning of the file
    add al,2
    int 0x80
    dec eax
    js main
    inc ebx ; only happens for audio process, and only once on startup
    jmp main
