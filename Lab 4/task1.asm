.data
message: .asciiz "Hello, World!\n"   # Define the string to be printed
.text
.globl main
main:# Load the address of the string into $a0
    li $v0, 4                       # System call for print_string
    la $a0, message                 # Load address of the string into $a0
    syscall                         # Make the system call to print
    li $v0, 10                      # System call for exit
    syscall                         # Make the system call to terminate