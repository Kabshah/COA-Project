.data
prompt:         .asciiz "Select operation: 1-Add, 2-Subtract, 3-Multiply, 4-Divide: "
inputPrompt1:   .asciiz "Enter the first number: "
inputPrompt2:   .asciiz "Enter the second number: "
resultMsg:      .asciiz "The result is: "
errorMsg:       .asciiz "Invalid operation selected.\n"
.text
.globl main
main:
    # Prompt user for operation choice
    li $v0, 4
    la $a0, prompt
    syscall
    # Read operation choice
    li $v0, 5
    syscall
    move $t0, $v0        # Store choice in $t0
    # Prompt user for first number
    li $v0, 4
    la $a0, inputPrompt1
    syscall
    # Read first number
    li $v0, 5
    syscall
    move $t1, $v0        # Store first number in $t1
    # Prompt user for second number
    li $v0, 4
    la $a0, inputPrompt2
    syscall
    # Read second number
    li $v0, 5
    syscall
    move $t2, $v0        # Store second number in $t2
    # Switch control structure for operation
    beq $t0, 1, add_op      # If choice is 1, perform addition
    beq $t0, 2, sub_op      # If choice is 2, perform subtraction
    beq $t0, 3, mul_op      # If choice is 3, perform multiplication
    beq $t0, 4, div_op      # If choice is 4, perform division
    j invalid_op            # Default case: Invalid operation
add_op:
    add $t3, $t1, $t2       # t3 = t1 + t2
    j print_result
sub_op:
    sub $t3, $t1, $t2       # t3 = t1 - t2
    j print_result
mul_op:
    mul $t3, $t1, $t2       # t3 = t1 * t2
    j print_result
div_op:
    beq $t2, 0, div_error   # Check for division by zero
    div $t1, $t2            # Perform integer division
    mflo $t3                # Store quotient in t3
    j print_result
div_error:
    li $v0, 4
    la $a0, errorMsg
    syscall
    j main                 # Restart the program
invalid_op:
    li $v0, 4
    la $a0, errorMsg
    syscall
    j main                 # Restart the program
print_result:
    li $v0, 4
    la $a0, resultMsg
    syscall
    li $v0, 1
    move $a0, $t3          # Move result to $a0 for printing
    syscall
    li $v0, 10
    syscall
