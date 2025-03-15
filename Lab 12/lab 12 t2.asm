.data
array: .space 400            
value: .word 18              
.text
.globl main
main:
    li $t0, 0             
    la $t1, array            
    lw $t2, value            
loop:
    beq $t0, 100, end_loop   
    sw $t2, 0($t1)           
    addi $t1, $t1, 4         
    addi $t0, $t0, 1       
    j loop                   
end_loop:
    li $v0, 10               
    syscall
