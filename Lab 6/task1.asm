.data
prompt1:   .asciiz "Enter first number for addition: "
prompt2:   .asciiz "Enter second number for addition: "
addition_msg: .asciiz "The result of addition is: "
newline:   .asciiz "\n"
prompt3:   .asciiz "Enter first number for subtraction: "
prompt4:   .asciiz "Enter second number for subtraction: "
subtraction_msg: .asciiz "The result of subtraction is: "
prompt5:   .asciiz "Enter first number for multiplication: "
prompt6:   .asciiz "Enter second number for multiplication: "
multiplication_msg: .asciiz "The result of multiplication is: "
.text .globl main
main:
    # Addition
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
    add $t2, $t0, $t1    
    li $v0, 4             
    la $a0, addition_msg
    syscall
    li $v0, 1            
    move $a0, $t2
    syscall
    li $v0, 4             
    la $a0, newline
    syscall
    # Subtraction
    li $v0, 4            
    la $a0, prompt3     
    syscall
    li $v0, 5            
    syscall
    move $t0, $v0        
    li $v0, 4           
    la $a0, prompt4
    syscall
    li $v0, 5          
    syscall
    move $t1, $v0        
    sub $t2, $t0, $t1    
    li $v0, 4            
    la $a0, subtraction_msg
    syscall
    li $v0, 1             
    move $a0, $t2
    syscall
    li $v0, 4            
    la $a0, newline
    syscall
    # Multiplication
    li $v0, 4            
    la $a0, prompt5      
    syscall
    li $v0, 5            
    syscall
    move $t0, $v0         # store first number  in $t0
    li $v0, 4            
    la $a0, prompt6
    syscall
    li $v0, 5             
    syscall
    move $t1, $v0         # store second number in $t1
    mul $t2, $t0, $t1     
    li $v0, 4             # syscall for print string
    la $a0, multiplication_msg  # load address of multiplication_msg
    syscall
    li $v0, 1             # syscall to print integer
    move $a0, $t2         # move result to $a0
    syscall
    li $v0, 4             # syscall for print string
    la $a0, newline       # print newline after result
    syscall
    li $v0, 10           
    syscall
