.data
prompt1: .asciiz "Enter a character: "    # Prompt message
prompt2: .asciiz "\nYou entered: "       # Output message
.text
.globl main
main:# Print the first prompt
    li $v0, 4              # System call for print_string
    la $a0, prompt1        # Load address of the first prompt
    syscall
    # Read a character from the user
    li $v0, 12             # System call for read_char
    syscall
    move $t0, $v0          # Store the character in $t0 for later use
    # Print the second prompt
    li $v0, 4              # System call for print_string
    la $a0, prompt2        # Load address of the second prompt
    syscall
    # Print the character entered by the user
    li $v0, 11             # System call for print_char
    move $a0, $t0          # Load the character from $t0 into $a0
    syscall
    li $v0, 10             # System call for exit
    syscall