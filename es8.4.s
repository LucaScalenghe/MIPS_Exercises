DIM = 5
			.data
vet1:		.word 56, 12, 98, 129, 58
vet2:		.word 1, 0, 245, 129, 12
risultato:	.space DIM
			
			.text
			.globl main
			.ent main
			
main:		subu $sp,$sp,4
			sw $ra,($sp)
			la $a0, vet1
			la $a1, vet2
			la $a2, risultato
			li $a3, DIM
			jal CalcolaDistanzaH
			
			li $t0,DIM
			la $t1,risultato
stampa:		li $v0,1
			lbu $a0,($t1)
			syscall
			li $v0,11
			li $a0,'\n'
			syscall
			addi $t1,$t1,1
			addi $t0,$t0,-1
			bne $t0,$0,stampa
		
			lw $ra,($sp)
			addu $sp,$sp,4
			jr $ra
			.end main
			
					.ent CalcolaDistanzaH
CalcolaDistanzaH:	lw $t0,($a0)
					lw $t1,($a1)
					xor $t0,$t0,$t1
					li $t1,1
					move $t2,$0
					move $t4,$0
ciclo:				and $t3,$t0,$t1
					beq $t3,$0,next
					addi $t2,$t2,1
next:				sll $t1,$t1,1
					addi $t4,$t4,1
					bne $t4,32,ciclo
					
					addi $a0,$a0,4
					addi $a1,$a1,4
					sb $t2,($a2)
					addi $a2,$a2,1
					addi $a3,$a3,-1
					bne $a3,$0,CalcolaDistanzaH
					
					jr $ra
					.end CalcolaDistanzaH
					
					