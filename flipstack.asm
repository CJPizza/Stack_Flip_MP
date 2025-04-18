;%include 'io64.inc'

section .data
bayt db 0x0
elmt_column dq 0x0
row dq 0x0
print_number db "%d ", 0
newlineprint db 10, 0

section .text
bits 64
default rel
global fliphorizontal
extern printf

fliphorizontal:

    ;for now we will just try printing the contents of a 2d 8-bit unsigned integer array from C
    ;rcx contains the address of the 3d array output
    ;rdx containes the address of the 3d array output
    ;r8 = rows (in number of elmts)
    ;r9 = columns (in number of elmts)
    ;mov rsi, rcx ;rsi = address of 2d array, we will be using rsi as base pointer
    
    push rbx
    xor r10, r10 ; r10 row iterator
    mov [elmt_column], r9 ; column has the og number of elements in a column
    mov r15, r8
    ;moved to row_loop
    ;inc r8
    ;shr r8, 1 ; to do only half of the columns (avoid mirroring)

    row_loop:
        
        ;mov r8, [row] ;in case we want to modify rdx = 3
        cmp r10, r15 ;row check
        jge end_row
        
        ;no need to do avoid mirroring since we are passing to diff array
        mov r12, r9 ; to do only half of the columns [r12]
        ;inc r12
        ;shr r12, 1 ; to do only half of the columns (avoid mirroring)
        
        xor r11, r11 ; r11 column iterator
        ;dec r9 ; (if commented) r9 = 2 = (3+1)/2 (index above middle be it odd or even), less than this we want to keep on going
            column_loop:
                ;mov r8, [elmt_column] ;in case we want to modify r8
                cmp r11, r12 ;[0, 1, 2]
                jge end_column
        
        
                ;for rcx
        
                mov rax, r10
                mov r8, r9 ; to return r8 to its original value for elmnt calculation
                imul r8, 3 ; since there are 3 elements per column
                imul rax, r8 ; 1st: 0*3(3); 2nd: 1*3(3); 3rd: 2*3(3) 
                
                ;convert row pixel r13 = r11 * 3
                mov r13, r11
                imul r13, 3
                add rax, r13
                ;movzx rsi, byte [rcx + rax]
                
                ;wait, dont need initial values
                
                ;for double trouble diba nahh jk
                
        
                ;for rdx
        
                mov rbx, r10
                imul rbx, r8 ; 1st: 0*9; 2nd: 1*9; 3rd: 2*9
                mov r13, r12 ; 1st: 3; 2nd: 2; 3rd: 1
                dec r13 ; 1st: 2; 2nd: 2; 3rd: 2
                sub r13, r11 ; 1st: 2; 2nd: 1; 3rd: 0
                imul r13, 3 ; 1st: 2*3; 2nd: 1*3; 3rd: 0*3
                add rbx, r13 ; 1,1st: 0+6; 1,2nd: 0+3; 1,3rd: 0+0
                ;movzx rdi, byte [rcx + rbx]
                ;push word [rcx + rbx]
                ;push word [rcx + rbx + 2]

                push word [rcx + rbx]; 1st: {0x01,0x02}; 2nd: {2,3}; 3rd: {3,4}
                push word [rcx + rbx + 2]
                push word [rcx + rbx + 1]
                push word [rcx + rbx]; 1st:
           
           
                pop si
                mov byte [rdx + rax], sil
                pop si
                mov byte [rdx + rax + 1], sil
                pop si
                mov byte [rdx + rax + 2], sil
                
                pop si
                
                ;shr rsi, 16

                xor rsi, rsi
                ;pop word [rcx + rbx], r8w ;now 1st value {last in pop word} is at rcx+rbx
                
                ;mov byte [rdx + rbx], dl
                ;shr rdx, 8
                ;mov byte [rdx + rbx + 1], dl
                ;shr rdx, 8
                ;mov byte [rdx + rbx + 2], dl
        
                inc r11
                jmp column_loop
        end_column:
            inc r10
            jmp row_loop

    end_row:
    pop rbx
    xor rax, rax
    ;at some point rax is returned therefore the function should return the value in rax
    ret