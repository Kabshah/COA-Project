        .data
msg:    .asciiz "Result in $t0 after clearing MSB: "
        .text
        .globl main
main:
        li   $t0, 0xFFFFFFFF    # Load $t0 with all bits set to 1
        lui  $t1, 0x7FFF        # Load upper 16 bits of the mask into $t1
        ori  $t1, $t1, 0xFFFF   # Combine with lower 16 bits to form 0x7FFFFFFF
        and  $t0, $t0, $t1      # Clear the MSB of $t0
        li   $v0, 4             # System call to print string
        la   $a0, msg           # Load address of message
        syscall
        li   $v0, 1             # System call to print integer
        move $a0, $t0           # Move result to $a0 for printing
        syscall
        li   $v0, 10            
        syscall