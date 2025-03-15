.data
    prompt: .asciiz "Enter an integer: "
    prime_msg: .asciiz "The number is prime.\n"
    not_prime_msg: .asciiz "The number is not prime.\n"
    newline: .asciiz "\n"
.text
    main:
        # Prompt user to enter an integer
        li $v0, 4                  # syscall to print string
        la $a0, prompt             # load the address of the prompt
        syscall

        # Read integer input
        li $v0, 5                  # syscall to read integer
        syscall
        move $t0, $v0              # store the input in $t0

        # Handle edge cases: 0, 1, and negative numbers
        blez $t0, not_prime        # if $t0 <= 0, jump to not_prime
        li $t1, 1                  # load 1 into $t1
        beq $t0, $t1, not_prime    # if $t0 == 1, jump to not_prime

        # Check divisors from 2 to sqrt(input)
        li $t1, 2                  # $t1 = 2 (divisor)
    check_divisor:
        mul $t2, $t1, $t1          # $t2 = $t1 * $t1 (square of divisor)
        bgt $t2, $t0, prime        # if $t2 > $t0, number is prime

        div $t3, $t0, $t1          # divide $t0 by $t1
        mfhi $t4                   # get remainder
        beqz $t4, not_prime        # if remainder == 0, jump to not_prime

        addi $t1, $t1, 1           # $t1 = $t1 + 1 (next divisor)
        j check_divisor            # repeat loop

    prime:
        # Print "The number is prime."
        li $v0, 4                  # syscall to print string
        la $a0, prime_msg          # load the address of prime_msg
        syscall
        j exit                     # jump to exit

    not_prime:
        # Print "The number is not prime."
        li $v0, 4                  # syscall to print string
        la $a0, not_prime_msg      # load the address of not_prime_msg
        syscall

    exit:
        li $v0, 10                 # syscall to exit
        syscall
