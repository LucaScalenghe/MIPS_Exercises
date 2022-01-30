NUM = 5
DIM = NUM * 4
SCONTO = 30
ARROTONDA = 0
		.data
prezzi: .word 39, 1880, 2394, 1000, 1590
scontati: .space DIM

		.text
		.globl main
		.ent main
		
main:	subu $sp,$sp,4
		sw $ra,($sp)
		la $a0, prezzi
		la $a1, scontati
		li $a2, NUM
		li $a3, SCONTO
		li $t0, ARROTONDA
		subu $sp,$sp,4
		sw $t0,($sp)
		jal calcola_sconto
		
		li $t0,NUM
		la $t1,scontati
		move $t2,$v0
stampa:	li $v0,1
		lw $a0,($t1)
		syscall
		li $v0,11
		li $a0,'\n'
		syscall
		addi $t1,$t1,4
		addi $t0,$t0,-1
		bne $t0,$0,stampa
		move $a0,$t2
		li $v0,1
		syscall
		
		lw $ra,($sp)
		addu $sp,$sp,4
		jr $ra
		.end main
		
				.ent calcola_sconto
calcola_sconto:	lw $t0,($sp)
				addu $sp,$sp,4
				li $t1,100
				move $v0,$0
ciclo:			lw $t2,($a0)
				mul $t3,$t2,$a3
				div $t3,$t3,$t1
				mfhi $t4
				beq $t0,$0,dif
				
				li $t5,50
				blt $t4,$t5,fine
				
dif:			beq $t4,$0,fine
				addi $t3,$t3,1
fine:			add $v0,$v0,$t3
				sub $t2,$t2,$t3
				sw $t2,($a1)
				
				addi $a0,$a0,4
				addi $a1,$a1,4
				addi $a2,$a2,-1
				bne $a2,$0,ciclo
				
				jr $ra
				.end calcola_sconto
				