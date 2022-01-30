			.data
str_orig:	.asciiz "% nella citta' dolente, % nell'eterno dolore , % tra la perduta gente"
str_sost:	.asciiz "per me si va"
str_new:	.space 200

			.text
			.globl main
			.ent main
			
main: 		subu $sp,$sp,4
			sw $ra,($sp)
			la $a0,str_orig
			la $a1,str_sost
			la $a2,str_new
			jal sostituisci
			
			la $a0,str_new
			li $v0, 4
			syscall
			lw $ra,($sp)
			addu $sp,$sp,4
			jr $ra
			.end main

				.end sostituisci
sostituisci:	move $t1,$0
ciclo1:			lb $t0,($a0)
				beq $t0,0,end
				beq $t0,'%',next
				sb $t0,($a2)
				addi $t1,$t1,1
				addi $a2,$a2,1
				j fine
				
next:			move $t3,$a1
ciclo2:			lb $t2,($t3)
				beq $t2,0,fine
				sb $t2,($a2)
				addi $t1,$t1,1
				addi $a2,$a2,1
				addi $t3,$t3,1
				j ciclo2
				
fine:			addi $a0,$a0,1
				j ciclo1

end:			jr $ra
				.end sostituisci