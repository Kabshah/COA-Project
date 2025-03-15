.data

frameBuffer: 	.space 	0x80000
xVel:		.word	0
yVel:		.word	0
xPos:		.word	50
yPos:		.word	27
tail:		.word	7624
appleX:		.word	32
appleY:		.word	16
snakeUp:	.word	0x0000ff00
snakeDown:	.word	0x0100ff00
snakeLeft:	.word	0x0200ff00
snakeRight:	.word	0x0300ff00
xConversion:	.word	64
yConversion:	.word	4

.text
main:

	la 	$t0, frameBuffer
	li 	$t1, 8192
	li 	$t2, 0x00d3d3d3
l1:
	sw   	$t2, 0($t0)
	addi 	$t0, $t0, 4
	addi 	$t1, $t1, -1
	bnez 	$t1, l1
	
	la	$t0, frameBuffer
	addi	$t1, $zero, 64
	li 	$t2, 0x00000000
drawBorderTop:
	sw	$t2, 0($t0)
	addi	$t0, $t0, 4
	addi	$t1, $t1, -1
	bnez	$t1, drawBorderTop
	
	la	$t0, frameBuffer
	addi	$t0, $t0, 7936
	addi	$t1, $zero, 64
drawBorderBot:
	sw	$t2, 0($t0)
	addi	$t0, $t0, 4
	addi	$t1, $t1, -1
	bnez	$t1, drawBorderBot
	
	la	$t0, frameBuffer
	addi	$t1, $zero, 256
drawBorderLeft:
	sw	$t2, 0($t0)
	addi	$t0, $t0, 256
	addi	$t1, $t1, -1
	bnez	$t1, drawBorderLeft
	
	la	$t0, frameBuffer
	addi	$t0, $t0, 508
	addi	$t1, $zero, 255
drawBorderRight:
	sw	$t2, 0($t0)
	addi	$t0, $t0, 256
	addi	$t1, $t1, -1
	bnez	$t1, drawBorderRight
	
	la	$t0, frameBuffer
	lw	$s2, tail
	lw	$s3, snakeUp
	add	$t1, $s2, $t0
	sw	$s3, 0($t1)
	addi	$t1, $t1, -256
	sw	$s3, 0($t1)
	
	jal 	drawApple

gameUpdateLoop:

	lw	$t3, 0xffff0004
	
	addi	$v0, $zero, 32
	addi	$a0, $zero, 66
	syscall
	
	beq	$t3, 100, moveRight
	beq	$t3, 97, moveLeft
	beq	$t3, 119, moveUp
	beq	$t3, 115, moveDown
	beq	$t3, 0, moveUp
	
moveUp:
	lw	$s3, snakeUp
	add	$a0, $s3, $zero
	jal	updateSnake
	
	jal 	updateSnakeHeadPosition
	
	j	exitMoving 	

moveDown:
	lw	$s3, snakeDown
	add	$a0, $s3, $zero
	jal	updateSnake
	
	jal 	updateSnakeHeadPosition
	
	j	exitMoving
	
moveLeft:
	lw	$s3, snakeLeft
	add	$a0, $s3, $zero
	jal	updateSnake
	
	jal 	updateSnakeHeadPosition
	
	j	exitMoving
	
moveRight:
	lw	$s3, snakeRight
	add	$a0, $s3, $zero
	jal	updateSnake
	
	jal 	updateSnakeHeadPosition

	j	exitMoving

exitMoving:
	j 	gameUpdateLoop

updateSnake:
	addiu 	$sp, $sp, -24
	sw 	$fp, 0($sp)
	sw 	$ra, 4($sp)
	addiu 	$fp, $sp, 20
	
	lw	$t0, xPos
	lw	$t1, yPos
	lw	$t2, xConversion
	mult	$t1, $t2
	mflo	$t3
	add	$t3, $t3, $t0
	lw	$t2, yConversion
	mult	$t3, $t2
	mflo	$t0
	la 	$t1, frameBuffer
	add	$t0, $t1, $t0
	lw	$t4, 0($t0)
	sw	$a0, 0($t0)
	
	lw	$t2, snakeUp
	beq	$a0, $t2, setVelocityUp
	
	lw	$t2, snakeDown
	beq	$a0, $t2, setVelocityDown
	
	lw	$t2, snakeLeft
	beq	$a0, $t2, setVelocityLeft
	
	lw	$t2, snakeRight
	beq	$a0, $t2, setVelocityRight
	
setVelocityUp:
	addi	$t5, $zero, 0
	addi	$t6, $zero, -1
	sw	$t5, xVel
	sw	$t6, yVel
	j exitVelocitySet
	
setVelocityDown:
	addi	$t5, $zero, 0
	addi	$t6, $zero, 1
	sw	$t5, xVel
	sw	$t6, yVel
	j exitVelocitySet
	
setVelocityLeft:
	addi	$t5, $zero, -1
	addi	$t6, $zero, 0
	sw	$t5, xVel
	sw	$t6, yVel
	j exitVelocitySet
	
setVelocityRight:
	addi	$t5, $zero, 1
	addi	$t6, $zero, 0
	sw	$t5, xVel
	sw	$t6, yVel
exitVelocitySet:
	li 	$t2, 0x00ff0000
	bne	$t2, $t4, headNotApple
	jal 	newAppleLocation
	jal	drawApple
	j	exitUpdateSnake

headNotApple:
	li	$t2, 0x00d3d3d3
	beq	$t2, $t4, validHeadSquare
	addi 	$v0, $zero, 10
	syscall

validHeadSquare:
	lw	$t0, tail
	la 	$t1, frameBuffer
	add	$t2, $t0, $t1
	li 	$t3, 0x00d3d3d3
	lw	$t4, 0($t2)
	sw	$t3, 0($t2)

	lw	$t5, snakeUp
	beq	$t5, $t4, setNextTailUp
	
	lw	$t5, snakeDown
	beq	$t5, $t4, setNextTailDown
	
	lw	$t5, snakeLeft
	beq	$t5, $t4, setNextTailLeft
	
	lw	$t5, snakeRight
	beq	$t5, $t4, setNextTailRight
	
setNextTailUp:
	addi	$t0, $t0, -256
	sw	$t0, tail
	j exitUpdateSnake
	
setNextTailDown:
	addi	$t0, $t0, 256
	sw	$t0, tail
	j exitUpdateSnake
	
setNextTailLeft:
	addi	$t0, $t0, -4
	sw	$t0, tail
	j exitUpdateSnake
	
setNextTailRight:
	addi	$t0, $t0, 4
	sw	$t0, tail
	j exitUpdateSnake
	
exitUpdateSnake:
	lw 	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra
	
updateSnakeHeadPosition:
	addiu 	$sp, $sp, -24
	sw 	$fp, 0($sp)
	sw 	$ra, 4($sp)
	addiu 	$fp, $sp, 20
	
	lw	$t3, xVel
	lw	$t4, yVel
	lw	$t5, xPos
	lw	$t6, yPos
	add	$t5, $t5, $t3
	add	$t6, $t6, $t4
	sw	$t5, xPos
	sw	$t6, yPos
	
	lw 	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra

drawApple:
	addiu 	$sp, $sp, -24
	sw 	$fp, 0($sp)
	sw 	$ra, 4($sp)
	addiu 	$fp, $sp, 20
	
	lw	$t0, appleX
	lw	$t1, appleY
	lw	$t2, xConversion
	mult	$t1, $t2
	mflo	$t3
	add	$t3, $t3, $t0
	lw	$t2, yConversion
	mult	$t3, $t2
	mflo	$t0
	
	la 	$t1, frameBuffer
	add	$t0, $t1, $t0
	li	$t4, 0x00ff0000
	sw	$t4, 0($t0)
	
	lw 	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra	

newAppleLocation:
	addiu 	$sp, $sp, -24
	sw 	$fp, 0($sp)
	sw 	$ra, 4($sp)
	addiu 	$fp, $sp, 20

redoRandom:		
	addi	$v0, $zero, 42
	addi	$a1, $zero, 63
	syscall
	add	$t1, $zero, $a0
	
	addi	$v0, $zero, 42
	addi	$a1, $zero, 31
	syscall
	add	$t2, $zero, $a0
	
	lw	$t3, xConversion
	mult	$t2, $t3
	mflo	$t4
	add	$t4, $t4, $t1
	lw	$t3, yConversion
	mult	$t3, $t4
	mflo	$t4
	
	la 	$t0, frameBuffer
	add	$t0, $t4, $t0
	lw	$t5, 0($t0)
	
	li	$t6, 0x00d3d3d3
	beq	$t5, $t6, goodApple
	j redoRandom

goodApple:
	sw	$t1, appleX
	sw	$t2, appleY	

	lw 	$ra, 4($sp)
	lw 	$fp, 0($sp)
	addiu 	$sp, $sp, 24
	jr 	$ra
