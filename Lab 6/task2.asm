.data
prompt:      .asciiz "Enter an integer: "           
even_msg:    .asciiz "The result is even.\n"       
odd_msg:     .asciiz "The result is odd.\n"          
.text
.globl main
main:
    li $v0, 4           
    la $a0, prompt
    syscall
    li $v0, 5             
    syscall
    move $t0, $v0         
    # Multiply the input by 3 using addition (addu and addi)
    addu $t1, $t0, $t0    #  (this is 2 * input)
    addu $t2, $t1, $t0    # (this is 3 * input)
    # Check if the result is even or odd
    andi $t3, $t2, 1 # bitwise AND to check if least significant bit is 1 (odd)
    beqz $t3, print_even  # if $t3 == 0, it's even, go to print_even
    li $v0, 4             
    la $a0, odd_msg      
    syscall
    j exit_program        # Jump to exit program
print_even:
    # If the result is even, print the even message
    li $v0, 4             # syscall for print string
    la $a0, even_msg      # load address of even message
    syscall
exit_program:
    li $v0, 10          
    syscall
