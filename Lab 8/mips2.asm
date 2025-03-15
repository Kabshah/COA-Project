        .data
msg:    .asciiz "Result in $t0 after setting MSB and LSB: "
        .text
        .globl main
main:
        li   $t0, 0x12345678    # Load $t0 with some initial value
        lui  $t1, 0x8000        # Load upper 16 bits of the mask into $t1
        ori  $t1, $t1, 0x0001   # Combine with lower 16 bits to form 0x80000001
        or   $t0, $t0, $t1      # Set MSB and LSB in $t0
        li   $v0, 4             # System call to print string
        la   $a0, msg           # Load address of message
        syscall
        li   $v0, 1             # System call to print integer
        move $a0, $t0           # Move result to $a0 for printing
        syscall
        li   $v0, 10            
        syscall