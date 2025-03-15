        .data
msg:    .asciiz "The output Q is: "
        .text
        .globl main
main:
        # Initialize inputs A, B, C (example values, can be changed)
        li   $t0, 1      # A = 1
        li   $t1, 0      # B = 0
        li   $t2, 1      # C = 1
        # Step 1: Compute A * B
        and  $t3, $t0, $t1   # $t3 = A * B
        # Step 2: Compute B + C
        or   $t4, $t1, $t2   # $t4 = B + C
        # Step 3: Compute B * C
        and  $t5, $t1, $t2   # $t5 = B * C
        # Step 4: Compute (B + C) * (B * C)
        and  $t6, $t4, $t5   # $t6 = (B + C) * (B * C)
        # Step 5: Compute Q = (A * B) + ((B + C) * (B * C))
        or   $t7, $t3, $t6   # $t7 = Q
        li   $v0, 4          
        la   $a0, msg       
        syscall
        li   $v0, 1          # System call to print integer
        move $a0, $t7        # Move result (Q) to $a0
        syscall
        li   $v0, 10         
        syscall
