.data
prompt1: .asciiz "Enter an integer: "   # Prompt message
prompt2: .asciiz "\nYou entered: "      # Output message
.text
.globl main
main:# Print the prompt to ask for the integer
    li $v0, 4                     # System call for print_string
    la $a0, prompt1               # Load address of the prompt message
    syscall                       # Print the prompt message
    # Read an integer from the user
    li $v0, 5                     # System call for read_int
    syscall                       # Read the integer from the user
    move $t0, $v0                 # Store the integer in $t0 for later use
    li $v0, 4                     # System call for print_string
    la $a0, prompt2               # Load address of the "You entered:" message
    syscall                       # Print the message
    # Print the integer entered by the user
    li $v0, 1                     # System call for print_int
    move $a0, $t0                 # Load the integer from $t0 into $a0
    syscall                       # Print the integer
    li $v0, 10                    # System call for exit
    syscall                       # Exit the program                 