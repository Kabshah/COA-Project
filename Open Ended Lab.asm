.data
prompt1: .asciiz "Enter first number: "
prompt2: .asciiz "Enter second number: "
equal_msg: .asciiz "The numbers are equal.\n"
smallest_msg: .asciiz "The smallest number is: "
.text
.globl main
main:
    li $v0, 4               
    la $a0, prompt1       
    syscall
    li $v0, 5              
    syscall
    move $t0, $v0          
    li $v0, 4              
    la $a0, prompt2        
    syscall
    li $v0, 5               
    syscall
    move $t1, $v0          
    beq $t0, $t1, numbers_equal  
    bge $t0, $t1, second_is_small 
    li $v0, 4               
    la $a0, smallest_msg  
    syscall
    move $a0, $t0          
    li $v0, 1              
    syscall
    j end_program
second_is_small:
    li $v0, 4               
    la $a0, smallest_msg    
    syscall
    move $a0, $t1          
    li $v0, 1              
    syscall
    j end_program
numbers_equal:
    li $v0, 4               
    la $a0, equal_msg       
    syscall
end_program:
    li $v0, 10              
    syscall