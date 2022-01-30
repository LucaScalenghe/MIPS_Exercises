DIM = 3
DIM_RIGA = DIM * 4
			.data
mat1:		.word 4, 45, 15565, 6458, 4531, 124, 548, 2124, 31000
mat2:		.word 6, 5421, 547, 99, 4531, 1456, 4592, 118, 31999
indice:		.word 2
vet_out:	.space DIM_RIGA

			.text
			.globl main
main:		subu $sp,$sp,4
			sw $ra,($sp)
			
			la $a0,mat1
			la $a1,mat2
			la $a2,vet_out
			li $a3,DIM
			lw $t0,indice
			subu $sp,$sp,4
			sw $t0,($sp)
			jal Variazione
			
			li $t0,DIM
			la $t1,vet_out
stampa:		lw $a0,($t1)
			li $v0,1
			syscall
			li $a0,' '
			li $v0,11
			syscall
			addi $t0,$t0,-1
			addi $t1,$t1,4
			bne $t0,$0,stampa
			
			lw $ra,($sp)
			addu $sp,$sp,4
			jr $ra
			.end main
			
			.ent Variazione
Variazione:	lw $t0,($sp)
			addu $sp,$sp,4
			
			mul $t1,$a3,4
			mul $t2,$t1,$t0
			add $a0,$a0,$t2
			
			mul $t2,$t0,4
			add $a1,$a1,$t2
			li $t2,100
			
ciclo:		lw $t3,($a0)
			lw $t4,($a1)
			sub $t4,$t4,$t3
			mul $t4,$t4,$t2
			div $t4,$t4,$t3
			sw $t4,($a2)
			
			addi $a0,$a0,4
			add $a1,$a1,$t1
			addi $a2,$a2,4
			addi $a3,$a3,-1
			bne $a3,$0,ciclo
			
			jr $ra
			.end Variazione
			
			