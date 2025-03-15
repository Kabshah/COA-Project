.data
prompt1: .asciiz "Enter the first number: " 
prompt2: .asciiz "Enter the second number: "
prompt3: .asciiz "Enter the third number: "
msg: .asciiz "The sum is: "
.text .globl main
main:
li $v0,4 
la $a0,prompt1 
syscall
li $v0,5 
syscall 
move $t0,$v0
li $v0,4 
la $a0,prompt2 
syscall
li $v0,5 
syscall 
move $t1, $v0

li $v0,4
la $a0,prompt3
syscall
li $v0,5 
syscall

move $t2,$v0
add $t3, $t0, $t1
add $t3, $t2,$t3
li $v0,4  
la $a0,msg 
syscall

li $v0,1
move $a0,$t3
syscall
li $v0,10 
syscall