.data
table1: .word 4, 5, 6, 7, 8, 9, 10, 21  # Array definition
.text
.globl main
main:
    la $t0, table1       # Load base address of table1 into $t0
    lw $t1, 20($t0)      # Load the 6th element (5th index, 4 bytes per word) into $t1
    # Print the value of $t1
    move $a0, $t1        # Move the value of $t1 to $a0 for printing
    li $v0, 1            # Load syscall for print_int
    syscall              # Print the value in $a0
    li $v0, 10           # Load syscall for exit
    syscall