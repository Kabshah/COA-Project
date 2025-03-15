.data
prompt1: .asciiz "Enter 3 integers for 1st addition:\n"
prompt2: .asciiz "Enter 3 integers for 2nd addition:\n"
result1Msg: .asciiz "The sum of 1st addition is: "
result2Msg: .asciiz "The sum of 2nd addition is: "
newline: .asciiz "\n"  # Declare the newline string

.text
.globl main
main:
    # Handle 1st addition
    li $v0, 4                # Print string syscall
    la $a0, prompt1          # Load address of prompt1
    syscall                  # Execute syscall

    # Input 3 integers for 1st addition
    li $v0, 5                # Read integer syscall
    syscall
    move $t0, $v0            # Store the 1st number in $t0

    li $v0, 5
    syscall
    move $t1, $v0            # Store the 2nd number in $t1

    li $v0, 5
    syscall
    move $t2, $v0            # Store the 3rd number in $t2

    # Compute sum for 1st addition
    add $t3, $t0, $t1        # $t3 = $t0 + $t1
    add $t3, $t3, $t2        # $t3 = $t3 + $t2

    # Handle 2nd addition
    li $v0, 4                # Print string syscall
    la $a0, prompt2          # Load address of prompt2
    syscall                  # Execute syscall

    # Input 3 integers for 2nd addition
    li $v0, 5
    syscall
    move $t4, $v0            # Store the 1st number in $t4

    li $v0, 5
    syscall
    move $t5, $v0            # Store the 2nd number in $t5

    li $v0, 5
    syscall
    move $t6, $v0            # Store the 3rd number in $t6

    # Compute sum for 2nd addition
    add $t7, $t4, $t5        # $t7 = $t4 + $t5
    add $t7, $t7, $t6        # $t7 = $t7 + $t6

    # Display result of 1st addition
    li $v0, 4                # Print string syscall
    la $a0, result1Msg       # Load address of result1Msg
    syscall                  # Execute syscall

    li $v0, 1                # Print integer syscall
    move $a0, $t3            # Load sum of 1st addition into $a0
    syscall                  # Execute syscall

    # Newline after 1st result
    li $v0, 4
    la $a0, newline          # Load address of newline
    syscall                  # Execute syscall

    # Display result of 2nd addition
    li $v0, 4                # Print string syscall
    la $a0, result2Msg       # Load address of result2Msg
    syscall                  # Execute syscall

    li $v0, 1                # Print integer syscall
    move $a0, $t7            # Load sum of 2nd addition into $a0
    syscall                  # Execute syscall

    # Exit the program
    li $v0, 10               # Exit syscall
    syscall
