		.data
ora_in: .byte 12, 47
ora_out: .byte 18, 14
X: .byte 1
Y: .byte 40

		.text
		.globl main
		.ent main
		
main:	subu $sp,$sp,4
		sw $ra,($sp)
		la $a0,ora_in # indirizzo di ora_in
		la $a1,ora_out # indirizzo di ora_out
		lbu $a2, X
		lbu $a3, Y
		jal costoParcheggio
		move $a0,$v0
		li $v0,1
		syscall
		
		lw $ra,($sp)
		addu $sp,$sp,4
		jr $ra
		.end main
		
					.ent costoParcheggio
costoParcheggio:	lbu $t0,($a0)
					mul $t0,$t0,60
					lbu $t1,1($a0)
					add $t0,$t0,$t1
					
					lbu $t1,($a1)
					mul $t1,$t1,60
					lbu $t2,1($a1)
					add $t1,$t1,$t2
					
					sub $t2,$t1,$t0
					div $t0,$t2,$a3
					mfhi $t1
					beq $t1,$0,next
					addi $t0,$t0,1
next:				mul $v0,$t0,$a2
					jr $ra
					.end costoParcheggio