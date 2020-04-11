.data
ope : .asciiz "+-*/"
sep : .asciiz "\n*******************************************************\n"
mess1 : .asciiz "         Veuillez choisir votre niveau du jeu          \nNiveau facile : taper 1\nNiveau medium : taper 2\nNiveau difficile : taper 3\nVotre choix : "
mess2 : .asciiz "            Vous avez 20 calculs à effectuer           \n"

.text

main :
	subu $sp, $sp, 64
	addiu $fp, $sp, 64
	jal fctNiveau     #Choix deniveau
	addiu $a0, $v0, 0 #argument choix
	
	sb $a0, 0($sp)
	jal fctNote
	
	ori $v0, $0, 10
	syscall
	
fctNiveau : 
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	la $a0, sep
	ori $v0, $0, 4
	syscall
	
	la $a0, mess1
	ori $v0, $0, 4
	syscall
	
    	ori $v0,$0,12      
    	syscall

	ori $t0, $v0, 0
    	
    	la $a0, sep
	ori $v0, $0, 4
	syscall
	
	la $a0, mess2
	ori $v0, $0, 4
	syscall
	
	ori $v0, $t0, 0
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
	
	
	