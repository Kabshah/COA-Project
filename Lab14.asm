.data
prompt:    .asciiz "Enter a number: "
resultMsg: .asciiz "Factorial is: "
.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $a0, $v0    
    jal factorial
    li $v0, 4
    la $a0, resultMsg
    syscall
    li $v0, 1
    move $a0, $v0   
    syscall
    li $v0, 10
    syscall
factorial:
    addi $sp, $sp, -8    
    sw $ra, 0($sp)       
    sw $a0, 4($sp)      
    li $t0, 1
    ble $a0, $t0, base_case
    addi $a0, $a0, -1    
    jal factorial        
    lw $a0, 4($sp)       
    mul $v0, $a0, $v0   
    j end_factorial
base_case:
    li $v0, 1            
end_factorial:
    lw $ra, 0($sp)       
    addi $sp, $sp, 8     
    jr $ra               
