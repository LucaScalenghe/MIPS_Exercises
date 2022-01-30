RIGHE = 4
COLONNE = 5
			.data
matrice:	.byte 0, 1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23, 9, 24, 8, 25, 43, 62

			.text
			.globl main
			.ent main

main:	subu $sp,$sp,4
		sw $ra,($sp)
		la $a0,matrice
		li $a1, 12
		li $a2, RIGHE
		li $a3, COLONNE
		jal contaVicini
		
		move $a0,$v0
		li $v0,1
		syscall
		
		lw $ra,($sp)
		addu $sp,$sp,4
		jr $ra
		.end main
		
				.ent contaVicini
contaVicini:	move $t0,$a1
ciclo:			beq $t0,$0,next
				addi $a0,$a0,1
				addi $t0,$t0,-1
				j ciclo
				
next:			move $v0,$0
				
Up:				move $t2,$0
				ble $a1,$a2,Down
				sub $t2,$a0,$a3	#cella sopra
				lbu $t1,($t2)
				add $v0,$v0,$t1
				
Down:			move $t3,$0
				sub $t0,$a2,1
				mul $t0,$t0,$a3
				bge $a1,$t0,Left
				add $t3,$a0,$a3	#cella sotto
				lbu $t1,($t3)
				add $v0,$v0,$t1
				
Left:			move $t4,$0
				div $a1,$a3
				mfhi $t0
				beq $t0,$0,Right
				sub $t4,$a0,1	#cella sinistra
				lbu $t1,($t4)
				add $v0,$v0,$t1
				
Right:			move $t5,$0
				sub $t6,$a3,1
				beq $t0,$t6,Corner
				add $t5,$a0,1	#cella destra
				lbu $t1,($t5)
				add $v0,$v0,$t1
				
Corner:			beq $t2,$0,next1
				beq $t4,$0,next2
				sub $t0,$t2,1
				lbu $t1,($t0)
				add $v0,$v0,$t1
next2:			beq $t5,$0,next1
				addi $t0,$t2,1
				lbu $t1,($t0)
				add $v0,$v0,$t1
next1:			beq $t3,$0,fine
				beq $t4,$0,next3
				sub $t0,$t3,1
				lbu $t1,($t0)
				add $v0,$v0,$t1
next3:			beq $t5,$0,fine
				addi $t0,$t3,1
				lbu $t1,($t0)
				add $v0,$v0,$t1
				
fine:			jr $ra
				.end contaVicini