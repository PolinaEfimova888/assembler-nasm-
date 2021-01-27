%macro pushd 0
    push edx
    push ecx
    push ebx
    push eax
%endmacro

%macro popd 0
    pop eax
    pop ebx
    pop ecx
    pop edx
%endmacro

%macro print 2
    pushd
    mov edx, %1
    mov ecx, %2
    mov ebx, 1
    mov eax, 4
    int 0x80

    popd
%endmacro

%macro dprint 1
    pushd
    mov ecx, 10
    mov bx, 0 ; 2 Bytes MAX, Count Numbers
    mov eax, %1
    
%%_divide:
    mov edx, 0
    div ecx
    push dx
    inc bx
    test eax, eax
    jnz %%_divide
    
%%_digit:
    pop ax
    add ax, '0'
    mov [symbol], ax
    print 1, symbol
    dec bx
    cmp bx, 0
    jg %%_digit
    
    popd
%endmacro

%macro calcX2 2
    push ebx
    push ecx
    push edx
    mov edx, 0
    mov ecx, %2
    push ecx
    mov eax, %1
    div ecx
    pop edx
    add eax, edx
    mov edx, 0
    mov ecx, 2
    div ecx
    pop edx
    pop ecx
    pop ebx
%endmacro

section .text

global _start

_start:
    mov eax, [num]
    mov ecx, 2
    div ecx ; Result in EAX, friction part in EDX
    mov [a], eax
    calcX2 [num], eax
    mov[b], eax
    
_while:
    mov eax, [a]
    mov ecx, [b]
    sub eax, ecx
    cmp eax, 1
    jl _end
    
    mov eax, [b]
    mov [a], eax
    calcX2 [num], [a]
    mov[b], eax
    jmp _while
    
_end:    
    dprint [b]
    
    print nl, n
    print len, message
    print nl, n
    
    mov     eax, 1
    int     0x80

section.data
    num DD 121
    
    message DB "Done"
    len EQU $ - message
    
    n DB 0xA, 0xD
    nl EQU $ - n
    
section .bss
    a resd 1 ; Reserve DWORD (1 Count)
    b resd 1
    symbol resb 1
