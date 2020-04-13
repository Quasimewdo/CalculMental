.data

TOTALE : .word 5
ope : .asciiz "+-*/"
sep : .asciiz "\n*******************************************************\n"
sep2 : .asciiz "-------------------------------------------------------\n"
mess1 : .asciiz "         Veuillez choisir votre niveau du jeu          \nNiveau facile : taper 1\nNiveau medium : taper 2\nNiveau difficile : taper 3\nVotre choix : "
mess2 : .asciiz "            Vous avez 20 calculs à effectuer           \n"
tf : .asciiz "*             Appreciation : Très Faible              *"
in : .asciiz "*              Appreciation : Insuffisant             *"
pas : .asciiz "*               Appreciation : Passable               *"
bien : .asciiz "*                  Appreciation : Bien                *"
ab : .asciiz "*               Appreciation : Assez Bien             *"
tb : .asciiz "*                Appreciation : Très Bien             *"
exc : .asciiz "*                Appreciation : Excellent             *"
notedeb : .asciiz "*                      "
notefin : .asciiz "                        *\n"
slash : " / "
plus : .asciiz " + "
moins : .asciiz " - "
fois : .asciiz " * "
divi : .asciiz " / "
egal : .asciiz " = ?\n"
point : .asciiz " . "
vrai : .asciiz "Vrai "
faux : .asciiz "Faux "
resultat : .asciiz "     Resultat = "

.text

main :
	subu $sp, $sp, 64
	addiu $fp, $sp, 64
	jal fctNiveau     #Choix deniveau
	ori $a0, $v0, 0 #argument choix
    	
	jal fctMedium
	
	jal fctNote
	ori $a0, $v0, 0
	
	sb $a0, 0($sp)    #Charge la valeur $a0 com argument
	jal fctComment   #Test fonction comment
	
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
	
fctComment : 
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	ori $t0, $a0, 0 #note dans $t0
	la $t1, TOTALE
	lw $t1, 0($t1)
	ori $t2, $0, 10 
	
	la $a0, sep
	ori $v0, $0, 4
	syscall
	
	la $a0, notedeb
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t0, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, slash
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t1, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, notefin
	ori $v0, $0, 4
	syscall
	 
	
	mult $t0, $t2
	mflo $t0
	
	div $t0, $t1
	mflo $t0
	
	ori $t1, $0, 3  #if taux < 3
	bge $t0, $t1, Elif1
	la $a0, tf
	ori $v0, $0, 4
	syscall
	j SUITE
	
Elif1 : slti $t2, $t0, 5 #si $taux < 5, $t2 = 1
	beq $t2, $zero, Elif2
	la $a0, in  
	ori $v0, $0, 4
	syscall
	j SUITE
	
Elif2 : slti $t2, $t0, 6
	beq $t2, $zero, Elif3
	la $a0, pas
	ori $v0, $0, 4
	syscall
	j SUITE
	
Elif3 : slti $t2, $t0, 7
	beq $t2, $zero, Elif4
	la $a0, bien
	ori $v0, $0, 4
	syscall
	j SUITE
	
Elif4 : slti $t2, $t0, 8
	beq $t2, $zero, Elif5
	la $a0, ab
	ori $v0, $0, 4
	syscall
	j SUITE
	
Elif5 : slti $t2, $t0, 9
	beq $t2, $zero, Else
	la $a0, tb
	ori $v0, $0, 4
	syscall
	j SUITE
	
Else :  la $a0, exc
	ori $v0, $0, 4
	syscall
	j SUITE
	
SUITE : la $a0, sep
	ori $v0, $0, 4
	syscall
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 8
	jr $ra	
	
	
	
fctMedium : 
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	ori $a1, $0, 3
	ori $v0, $0, 42
	syscall
	
	ori $t0, $a0, 0 #op1
	
	syscall
	ori $t1, $a0, 0 #op2
	
	ori $a1, $0, 101
	syscall
	ori $t2, $a0, 0 #val1
	
	subi $t1, $t1, 2
	beq $t1, $0, ELSEMedium
	addi $t1, $t1, 2
	
	syscall
	ori $t3, $a0, 0 #val2
	
	bne $t0, $0, ElifOp1  #si op1 == 0
	
	ori $a0, $t2, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t3, 0
	ori $v0, $0, 1
	syscall
	
	add $t2, $t2, $t3 #$t2 stock result temporaire
	j SuiteOp2
	
	
ElifOp1 : 
	subi $t0, $t0, 1
	bne $t0, $0, ElseOp1  #si op1 == 1
	ori $a0, $t2, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t3, 0
	ori $v0, $0, 1
	syscall
	
	sub $t2, $t2, $t3
	j SuiteOp2
	
ElseOp1 : 
	ori $a1, $0, 11
	ori $v0, $0, 42
	syscall
	
	ori $t3, $a0, 0 #val2
	
	subi $t0, $t0, 1
	bne $t0, $0, SuiteOp2  #si op1 == 2
	ori $a0, $t2, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t3, 0
	ori $v0, $0, 1
	syscall
	
	mult $t2, $t3
	mflo $t2
	j SuiteOp2
	

SuiteOp2 : 
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t4, $a0, 0  #val3
	
	bne $t1, $0, ElseOp2	#si op2 == 0
	
	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	add $t2, $t2, $t4
	j SUITEMedium
	
ElseOp2 : 
	subi $t1, $t1, 1
	bne $t1, $0, ElseOp2
	
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	sub $t2, $t2, $t4
	j SUITEMedium
	
	
ELSEMedium : 
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t3, $a0, 0 #val2
	
	ori $a1, $0, 11
	syscall
	ori $t4, $a0, 0 #val3
	
	bne $t0, $0, ElifOp
	
	ori $a0, $t2, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t3, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	mult $t3, $t4
	mflo $t3
	
	add $t2, $t2, $t3
	j SUITEMedium
	
ElifOp : 
	subi $t1, $t1, 1
	bne $t1, $0, ElseOp

	ori $a0, $t2, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t3, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	mult $t3, $t4
	mflo $t3
	
	sub $t2, $t2, $t3
	j SUITEMedium
	
ElseOp : 
	ori $a1, $0, 11
	syscall
	ori $t3, $a0, 0  #val2
	
	ori $a0, $t2, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t3, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	mult $t2, $t3
	mflo $t3
	
	mult $t3, $t4
	mflo $t2
	j SUITEMedium

SUITEMedium :  
	ori $v0, $t2, 0
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 8
	jr $ra	
	
	
fctNote : 
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 8

	addi $t5, $0, 0  #mark
	addi $t6, $0, 1 #i
	la $t7, TOTALE
	lw $t7, 0($t7)
	addi $t7, $t7, 1 #TOTALE
	
POUR :  slt $t8, $t6, $t7
	beq $t8, $zero, SUITENote
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, point
	ori $v0, $0, 4
	syscall
	
	jal fctMedium
	
	ori $t9, $v0, 0 #result
	ori $v0, $0, 5 #answer
	syscall
	bne $t9, $v0, FAUX
	addi $t5, $t5, 1
	
	la $a0, vrai
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, slash
	ori $v0, $0, 4
	syscall
	
	addi $a0, $t7, -1
	ori $v0, $0, 1
	syscall
	
	ori $a0, $0, 10
	ori $v0, $0, 11
	syscall
	
	j SuitePour
	
	
	
FAUX :  la $a0, faux
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, slash
	ori $v0, $0, 4
	syscall
	
	addi $a0, $t7, -1
	ori $v0, $0, 1
	syscall
	
	la $a0, resultat
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t9, 0
	ori $v0, $0, 1
	syscall
	
	addi $a0, $0, 10
	ori $v0, $0, 11
	syscall
	j SuitePour
	
SuitePour :
	la $a0, sep2
	ori $v0, $0, 4
	syscall
	
	addi $t6, $t6, 1
	j POUR
	
SUITENote : 
	ori $v0, $t5, 0

	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 8
	jr $ra	
	


	