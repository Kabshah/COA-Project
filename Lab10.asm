.data
    prompt1: .asciiz "Enter an integer: "
    less_than_10: .asciiz "The number is less than 10.\n"
    greater_or_equal_10: .asciiz "The number is greater than or equal to 10.\n"
    left_shift_result: .asciiz "After left shift by 4 bits: "
    right_shift_result: .asciiz "After right shift by 4 bits: "
    newline: .asciiz "\n"
.text
    main:
        li $v0, 4                 # syscall to print string
        la $a0, prompt1           # load the address of the prompt
        syscall
        li $v0, 5                 # syscall to read integer
        syscall
        move $t0, $v0             # store input in $t0
        # Check if input is less than 10
        li $t1, 10                # load 10 into $t1
        blt $t0, $t1, less_10     # if input < 10, jump to less_10
        # Input is greater than or equal to 10
        li $v0, 4                 # syscall to print string
        la $a0, greater_or_equal_10
        syscall
        j shift_operations        # jump to shift_operations
    less_10:
        li $v0, 4                 # syscall to print string
        la $a0, less_than_10
        syscall
    shift_operations:
        sll $t2, $t0, 4           # $t2 = $t0 << 4
        li $v0, 4                 # syscall to print string
        la $a0, left_shift_result
        syscall
        li $v0, 1                 # syscall to print integer
        move $a0, $t2             # load left-shifted value
        syscall
        li $v0, 4                 # print newline
        la $a0, newline
        syscall
        srl $t3, $t0, 4           # $t3 = $t0 >> 4
        li $v0, 4                 # syscall to print string
        la $a0, right_shift_result
        syscall
        li $v0, 1                 # syscall to print integer
        move $a0, $t3             # load right-shifted value
        syscall
        li $v0, 4                 # print newline
        la $a0, newline
        syscall
        li $v0, 10                # syscall to exit
        syscall
