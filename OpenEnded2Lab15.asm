        .data                   # Data segment
array:  .word 5, 12, 7, 19, 3, 9, 15  # Define an array of integers
size:   .word 7  # Size of the array

        .text
        .globl main
main:  
        # Initialize registers
        la   $t0, array         # Load address of array into $t0
        lw   $t1, size          # Load size of array into $t1
        lw   $t2, 0($t0)        # Load first element into $t2 (this will be the initial max value)
        addi $t3, $t0, 4        # Move to the next element in the array
        addi $t4, $t1, -1       # Set loop counter to size - 1

loop:
        # Check if we've traversed all the elements
        beq  $t4, $zero, end     # If loop counter is zero, exit loop

        lw   $t5, 0($t3)         # Load current array element into $t5
        blt  $t2, $t5, update_max # If current max ($t2) < $t5, update max

        addi $t3, $t3, 4         # Move to the next element in the array
        addi $t4, $t4, -1        # Decrease loop counter
        j loop                   # Jump back to loop start

update_max:
        move $t2, $t5            # Update max value ($t2) with current value ($t5)
        addi $t3, $t3, 4         # Move to the next element in the array
        addi $t4, $t4, -1        # Decrease loop counter
        j loop                   # Jump back to loop start

end:
        # Output the max value
        li   $v0, 1              # Syscall code for printing integer
        move $a0, $t2            # Move max value into $a0 for output
        syscall                  # Print the value

        # Exit program
        li   $v0, 10             # Syscall code for program exit
        syscall
