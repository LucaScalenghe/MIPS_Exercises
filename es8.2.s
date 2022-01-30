LUNG = 6
		.data
anni:	.word 1945, 2008, 1800, 2006, 1748, 1600
ris:	.space LUNG

		.text
		.globl main
		.ent main
		
main:	subu $sp,$sp,4
		sw $ra,($sp)
		la $a0,anni
		la $a1,ris
		li $a2, LUNG
		jal bisestile

		li $t1,LUNG
		la $t2,ris
ciclo_stampa: 
		li $v0,1
		lbu $a0,($t2)
		syscall
		addiu $t2, $t2, 1
		subu $t1, $t1, 1
		bnez $t1, ciclo_stampa
		
		lw $ra,($sp)
		addu $sp,$sp,4
		jr $ra
		.end main
		
			.ent bisestile
bisestile:	lw $t0,($a0)
			li $t3,100
			div $t0,$t3
			mfhi $t1
			bne $t1,$0,div4
			li $t3,400
			div $t0,$t3
			mfhi $t1
			bne $t1,$0,nobis
			j bis
			
div4:		li $t3,4
			div $t0,$t3
			mfhi $t1
			bne $t1,$0,nobis
			
bis:		li $t2,1
			sb $t2,($a1)
			j fine
nobis:		sb $0,($a1)
			
fine:		addi $a2,$a2,-1
			addi $a0,$a0,4
			addi $a1,$a1,1
			bne $a2,$0,bisestile
			jr $ra
			.end bisestile
			