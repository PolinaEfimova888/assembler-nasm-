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

%macro dprint 0
    pushd
    mov ecx, 10
    mov bx, 0
    
    %%_divide:
        mov edx,0
        div ecx
        push dx
        inc bx
        test eax, eax
        jnz %%_divide
        
    mov cx,bx
    
    %%_digit:
        pop ax
        add ax, '0'
        mov [count], ax
        print 1, count
        dec cx
        mov ax, cx
        cmp cx, 0
        jg %%_digit   
    popd
%endmacro     

section .text

global _start

_start:
    
    ;ищем сумму массива x
    mov bx, 0
    mov eax, 0 
     
_loop:
    add eax, [x + ebx]    
    add bx, 4
cmp bx, alen
jne _loop
     
    mov [count2], eax    
    mov eax, [count2]
      
    ;ищем сумму массива y
    mov bx, 0
    mov eax, 0  
    
_poop:
    add eax, [y + ebx]    
    add bx, 4
cmp ebx, alen2
jne _poop

    mov [count3], eax   
    mov eax, [count3]
  
    
    ;длинна массива
    mov edx, 0
    mov eax, alen
    mov ecx, 4
    div ecx
    
    mov [l], eax

    ;AVG массива x
    mov edx, 0
    mov eax, [count2]
    mov ecx, [l]
    div ecx
    
    mov [avg1], eax
   
   ;AVG массива y 
    mov edx, 0
    mov eax, [count3]
    mov ecx, [l]
    div ecx
    
    mov [avg2], eax
    
    ;разность массивов
    mov ax, [avg2]
    mov bx, [avg1]
    sub ax, bx
    dprint
    
    print nlen, newline
    print len, message
    print nlen, newline

    mov eax, 1
    int 0x80

section .data
    x dd 5, 3, 2, 6, 1, 7, 4
    alen equ $ - x
    
    y dd 0, 10, 1, 9, 2, 8, 5
    alen2 equ $ - y
    

    message db "Done"
    len equ $ - message
    
    newline db 0xA, 0xD
    nlen equ $ - newline
    
section .bss
    count resd 1
    count2 resd 1 ;сумма массива x
    count3 resd 1 ;сумма массива y
    l resd 1 ;длина массива
    avg1 resd 1 ;AVG x
    avg2 resd 1 ;AVG y
