.data

TOTALE : .word 5
ope : .asciiz "+-*/"
sep : .asciiz "\n*******************************************************\n"
sep2 : .asciiz "-------------------------------------------------------\n"
mess1 : .asciiz "         Veuillez choisir votre niveau du jeu          \nNiveau facile : taper 1\nNiveau medium : taper 2\nNiveau difficile : taper 3\nVotre choix : "
mess2 : .asciiz "            Vous avez "
mess3 : .asciiz " calculs à effectuer           \n"
erreur : .asciiz "\nErreur : Veuillez taper 1, 2 ou 3\nVotre choix : "
tf : .asciiz "*             Appreciation : Très Faible              *"
in : .asciiz "*              Appreciation : Insuffisant             *"
pas : .asciiz "*               Appreciation : Passable               *"
bien : .asciiz "*                  Appreciation : Bien                *"
ab : .asciiz "*               Appreciation : Assez Bien             *"
tb : .asciiz "*                Appreciation : Très Bien             *"
exc : .asciiz "*                Appreciation : Excellent             *"
notedeb : .asciiz "*                      "
notefin : .asciiz "                        *\n"
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

# -- Fonction main
main :
	subu $sp, $sp, 64
	addiu $fp, $sp, 64
	jal fctNiveau     	#Choix deniveau
	ori $a0, $v0, 0 	#argument choix
    	
	#jal fctHard
	sb $a0, 0($sp)
	jal fctNote
	ori $a0, $v0, 0
	
	sb $a0, 0($sp)    	#Charge la valeur $a0 com argument
	jal fctComment   	#Test fonction comment
	
	ori $v0, $0, 10
	syscall
	
# -- Fonction niveau pour choisir le niveau de difficulté
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
	
	subi $t0, $t0, 49
	bgez $t0, verifChoix
	j Erreur
	
verifChoix : 
	subi $t0, $t0, 2
	blez $t0, SuiteChoix
	j Erreur
	
Erreur : 
	la $a0, erreur
	ori $v0, $0, 4
	syscall
	
	ori $v0, $0, 12
	syscall
	ori $t0, $v0, 0		#nouvel choix

	
SuiteChoix : 
	addi $t0, $t0, 51
    	la $a0, sep
	ori $v0, $0, 4
	syscall
	
	la $a0, mess2
	ori $v0, $0, 4
	syscall
	
	la $t1, TOTALE
	lw $t1, 0($t1)
	
	ori $a0, $t1, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, mess3
	ori $v0, $0, 4
	syscall
	
	ori $v0, $t0, 0
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 8
	jr $ra
	
# -- Fonction comment donne une appréciation en fonction de note obtenue
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
	
	la $a0, divi
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


# -- Fonction easy : addition ou soustraction entre deux valeurs compris entre 0 et 100
fctEasy : 
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 8
	jr $ra	
	
	
# -- Fonction medium : composition deux opérateurs (+, -, *) et trois valeurs
# Multiplication entre une valeur compris entre 0 et 100 et une valeur compris entre 0 et 10
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
	
	
# -- Fonction hard : Composition de 3 opérateurs choisi parmi (+, -, *, /) et 4 valeurs
# Obligation d'une (et une seule) division entiere entre valeurs <= 100 et <= 10
# Multiplication de valeurs comprises entre <= 100 et <= 10
fctHard : 
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	ori $a1, $0, 3
	ori $v0, $0, 42
	syscall
	
	addi $t0, $a0, 1       	#div = rand % 3 + 1
	
	ori $a1, $0, 101
	syscall
	
	ori $t4, $a0, 0        	#val1 = rand % 101
	
	subi $t0, $t0, 1	#div -= div
	bne $t0, $0, Div2	#si div != 0 -> Div2
	ori $a1, $0, 3
	syscall
	ori $t2, $a0, 0		#op2 = rand % 3
	syscall
	ori $t3, $a0, 0		#op3 = ranf % 3
	ori $a1, $0, 10
	syscall
	addi $t5, $a0, 1	#val2 = rand % 10 + 1
	
TQ1 :   div $t4, $t5           
	mfhi $t8		#$t8 = val1 % val2
	beqz $t8, FinTQ1	#si $t8 == 0 -> FinTQ1
	ori $a1, $0, 101
	syscall
	ori $t4, $a0, 0		#réinitialise val1
	ori $a1, $0, 10
	syscall
	addi $t5, $a0, 1	#réinitialise val2
	j TQ1
	
FinTQ1 : 
	ori $a0, $t4, 0		
	ori $v0, $0, 1
	syscall			#printf(val1)
	
	la $a0, divi
	ori $v0, $0, 4
	syscall			#printf(" / ")
	
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall			#printf(val2)
	
	div $t4, $t5
	mflo $t4 		#result = val1 / val2
	
	subi $t3, $t3, 2	#op3 = op3 - 2
	beqz $t3, Div1Else	#si op3 == 0 -> Div1Else (.ie. si op3 == 2)  
	addi $t3, $t3, 2	#op3 = op3 + 2 (remet la valeur op3)
	
	bnez $t2, Div1op2Cas1	#si op2 != 0 -> Div1op2Cas1
	
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	
	ori $t6, $a0, 0 	#val3 = rand % 101
	
	la $a0, plus
	ori $v0, $0, 4
	syscall			#printf(" + ")
	
	ori $a0, $t6, 0		
	ori $v0, $0, 1
	syscall			#printf(val3)
	
	add $t4, $t4, $t6	#result = result + val3
	j Div1op3		#switch op3
	
Div1op2Cas1 : 
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t6, $a0, 0 	#val3 = rand % 101

	subi $t2, $t2, 1	#op2 = op2 -1
	bnez $t2, Div1op2Cas2	#si op2 != 0 -> Div1op2Cas2 (.ie. si op2 != 1)
	la $a0, moins
	ori $v0, $0, 4
	syscall			#printf(" - ")
	
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall			#printf(val3)
	
	sub $t4, $t4, $t6	#result = result - val3
	j Div1op3		#switch op3	
	
Div1op2Cas2 : 
	ori $a1, $0, 11
	ori $v0, $0, 42
	syscall			
	
	ori $t6, $a0, 0		#val3 = rand % 11
	
	la $a0, fois
	ori $v0, $0, 4
	syscall			#printf(" * ")
	
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall			#printf(val3)
	
	mult $t4, $t6
	mflo $t4		#result = reslut * val3
	
	
Div1op3 : 
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t7, $a0, 0 	#val4 = rand % 101
	
	bnez $t3, Div1op3Cas1	#si op3 != 0 -> Div1op3Cas1
	
	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t7, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	add $t4, $t4, $t7	#result = result + val4
	j SUITEHard
	
Div1op3Cas1 : 
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t7, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	sub $t4, $t4, $t7	#result = result - val4
	j SUITEHard
	
	
	
Div1Else : 
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t6, $a0, 0 	#val3 = rand % 101
	
	ori $a1, $0, 11
	syscall
	ori $t7, $a0, 0 	#val4 = rand % 11
	
	ori $a1, $0, 2
	syscall
	ori $t2, $a0, 0 	#op2 = rand % 2
	
	bnez $t2, Div1ElseOp2Cas1	#si op2 != 0 -> switch cas op2 == 1
	la $a0, plus
	ori $v0, $0, 4
	syscall			#printf(" + ")
	
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall			#printf(val3)
	
	la $a0, fois
	ori $v0, $0, 4
	syscall			#printf(" * ")
	
	ori $a0, $t7, 0
	ori $v0, $0, 1
	syscall			#printf(val4)
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	mult $t6, $t7
	mflo $t6		#val3 * val4
	
	add $t4, $t4, $t6	#result = result + val3 * val4
	j SUITEHard
	
Div1ElseOp2Cas1 : 
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t7, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	mult $t6, $t7
	mflo $t6
	
	sub $t4, $t4, $t6	#result = result - val3 * val4
	j SUITEHard
	
Div2 : 
	subi $t0, $t0, 1
	bnez $t0, Div3		#si div - 1 != 0 -> Div3 (.ie. div != 2)
	ori $a1, $0, 3
	ori $v0, $0, 42
	syscall
	ori $t1, $a0, 0 	#op1 = rand %3
	
	syscall
	ori $t3, $a0, 0 	#op3 = rand % 3
	
	subi $t3, $t3, 2
	beqz $t3, Div2Else	#si op3 == 2 -> Div2Else
	addi $t3, $t3, 2
	
	ori $a1, $0, 101
	syscall
	ori $t5, $a0, 0 	#val2 = rand % 101
	
	ori $a1, $0, 10
	syscall
	addi $t6, $a0, 1 	#val3 = rand % 10 + 1
	
	bnez $t1, Div2op1Cas1	#si op1 != 0 -> op1 == 1
	
TQ2 :   div $t5, $t6
	mfhi $t8		#$t8 = val2 % val3
	beqz $t8, FinTQ2	#si == 0 -> FinTQ2 
	ori $a1, $0, 101
	syscall
	ori $t5, $a0, 0 	#réinitialise val2
	
	ori $a1, $0, 10
	syscall
	addi $t6, $a0, 1 	#réinitialise val3
	j TQ2
	
FinTQ2 : 
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, divi
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall
	
	div $t5, $t6
	mflo $t5
	add $t4, $t4, $t5
	j Div2op3
	
Div2op1Cas1 : 

TQ3 :   div $t5, $t6
	mfhi $t8
	beqz $t8, FinTQ3
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t5, $a0, 0 	#réinitialise val2
	
	ori $a1, $0, 10
	syscall
	addi $t6, $a0, 1 	#réinitialise val3
	j TQ3
	
FinTQ3 : 
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, divi
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall
	
	div $t5, $t6
	mflo $t5
	sub $t4, $t4, $t5
	j Div2op3
	

Div2op1Cas2 : 

TQ4 :   mult $t4, $t5
	mflo $t9
	div $t9, $t6
	mfhi $t8
	beqz $t8, FinTQ4
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t5, $a0, 0 	#réinitialise val2
	
	ori $a1, $0, 10
	syscall
	addi $t6, $a0, 1 	#réinitialise val3
	j TQ4
	
FinTQ4 : 
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, divi
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall
	
	mult $t4, $t5
	mflo $t4
	div $t4, $t6
	mflo $t4
	
Div2op3 : 
	bnez $t3, Div2op3Cas1
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t7, $a0, 0
	
	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t7, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	add $t4, $t4, $t7
	j SUITEHard
	
Div2op3Cas1 : 
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t7, $a0, 0
	
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t7, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	sub $t4, $t4, $t7
	j SUITEHard


Div2Else : 
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t5, $a0, 0 	#val2
	
	ori $a1, $0, 10
	syscall
	addi $t6, $a0, 1 	#val3
	
TQ5 :   div $t5, $t6
	mfhi $t8
	beqz $t8, FinTQ5
	ori $a1, $0, 101
	syscall
	ori $t5, $a0, 0 	#réinitialise val2
	ori $a1, $0, 10
	syscall
	addi $t6, $a0, 1 	#réinitialise val3
	j TQ5
	
FinTQ5 : 
	ori $a1, $0, 11
	syscall
	ori $t7, $a0, 0		#val4 = rand % 11
	
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall			#print(val1)
	
	div $t5, $t6
	mflo $t8
	mult $t8, $t7
	mflo $t8
	
	bnez $t1, Div2ElseOp1Cas1
	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	add $t8, $t4, $t8
	j FinDiv2Else
	
Div2ElseOp1Cas1 : 
	subi $t1, $t1, 1
	bnez $t1, Div2ElseOp1Cas2
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	sub $t8, $t4, $t8
	j FinDiv2Else
	
Div2ElseOp1Cas2 : 
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	mult $t4, $t8
	mflo $t8
	j FinDiv2Else
	
FinDiv2Else : 
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, divi
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t7, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	ori $t4, $t8, 0 	#résult
	j SUITEHard
	
Div3 : 
	ori $a1, $0, 3
	ori $v0, $0, 42
	syscall
	ori $t1, $a0, 0 	#op1 = rand % 3
	
	syscall
	ori $t2, $a0, 0 	#op2 = rand % 3
	
	subi $t2, $t2, 2
	beqz $t2, Div3Else
	addi $t2, $t2, 2
	
	ori $a1, $0, 101
	syscall
	ori $t6, $a0, 0 	#val3 = rand % 101
	
	ori $a1, $0, 10
	syscall
	addi $t7, $a0, 1  	#val4 = rand % 10 + 1
	
TQ6 :   div $t6, $t7
	mfhi $t8
	beqz $t8, FinTQ6
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t6, $a0, 0 	#réinitialise val3
	
	ori $a1, $0, 10
	syscall
	addi $t7, $a0, 1  	#réinitialise val4
	j TQ6
	
FinTQ6 : 
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall 		#printf(val1)
	
	bnez $t1, Div3op1Cas1
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t5, $a0, 0		#val2 = rand % 101
	
	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall
	
	add $t4, $t4, $t5
	j Div3op2
	
Div3op1Cas1 : 
	subi $t1, $t1, 1
	bnez $t1, Div3op1Cas2
	
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t5, $a0, 0		#val2 = rand % 101
	
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall
	
	sub $t4, $t4, $t5
	j Div3op2
	
Div3op1Cas2 : 
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall
	
	mult $t4, $t5
	mflo $t4
	
Div3op2 : 
	div $t6, $t7
	mflo $t8		#$t8 = val3 / val4
	
	bnez $t2, Div3op2Cas1
	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	add $t4, $t4, $t8
	j FinDiv3op2
	
Div3op2Cas1 : 
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	sub $t4, $t4, $t8
	
FinDiv3op2 : 
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, divi
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t7, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	j SUITEHard
	
Div3Else : 
	ori $a1, $0, 2
	ori $v0, $0, 42
	syscall
	ori $t1, $a0, 0 	#op1 = rand % 2
	
	ori $a1, $0, 11
	syscall
	ori $t6, $a0, 0 	#val3 = rand % 11
	
	ori $a1, $0, 10
	syscall
	addi $t7, $a0, 1 	#val4 = rand % 10 + 1
	
	ori $a0, $t4, 0
	ori $v0, $0, 1
	syscall			#print(val1)
	
	ori $a1, $0, 101
	ori $v0, $0, 42
	syscall
	ori $t5, $a0, 0		#val2 = rand % 101
	
TQ7 :   mult $t5, $t6
	mflo $t8
	div $t8, $t7
	mfhi $t8		#$t8 = (val2 * val3) % val4
	beqz $t8, FinTQ7
	ori $a1, $0, 11
	ori $v0, $0, 42
	syscall
	ori $t6, $a0, 0		#réinitialise val3
	
	ori $a1, $0, 10
	syscall
	addi $t7, $a0, 1	#réinitialise val4
	j TQ7
	
FinTQ7 :
	mult $t5, $t6
	mflo $t8
	div $t8, $t7
	mflo $t8
	
	bnez $t1, Div3ElseCas1

	la $a0, plus
	ori $v0, $0, 4
	syscall
	
	add $t8, $t4, $t8
	j FinDiv3Else
	
Div3ElseCas1 : 
	subi $t1, $t1, 1
	bnez $t1, Div3ElseCas2
	la $a0, moins
	ori $v0, $0, 4
	syscall
	
	sub $t8, $t4, $t8
	j FinDiv3Else
	
Div3ElseCas2 : 
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	mult $t4, $t8
	mflo $t8
	

FinDiv3Else : 
	ori $a0, $t5, 0
	ori $v0, $0, 1
	syscall 
	
	la $a0, fois
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t6, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, divi
	ori $v0, $0, 4
	syscall
	
	ori $a0, $t7, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, egal
	ori $v0, $0, 4
	syscall
	
	ori $t4, $t8, 0		#result
	
	
SUITEHard : 
	ori $v0, $t4, 0
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 8
	jr $ra	


	
# -- Fonction note compte et mettre à jour la note du jeu
fctNote : 
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 8

	addi $s0, $0, 0  	#mark = 0
	addi $s1, $0, 1 	#i = 1
	la $s2, TOTALE
	lw $s2, 0($s2)
	addi $s2, $s2, 1 	#$s2 = TOTALE + 1
	ori $s5, $a0, 0		#choix
	
POUR :  slt $s3, $s1, $s2	#i < TOTALE + 1
	beq $s3, $zero, SUITENote
	ori $a0, $s1, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, point
	ori $v0, $0, 4
	syscall
	
	subi $s5, $s5, 49
	bnez $s5, apMedium
	addi $s5, $s5, 49
	jal fctEasy
	j Test
	
apMedium : 
	subi $s5, $s5, 1
	bnez $s5, apHard
	addi $s5, $s5, 50
	jal fctMedium
	j Test
	
apHard : 
	subi $s5, $s5, 1
	jal fctHard
	
	
Test : 
	ori $s4, $v0, 0 #result
	ori $v0, $0, 5 #answer
	syscall
	bne $s4, $v0, FAUX
	addi $s0, $s0, 1
	
	la $a0, vrai
	ori $v0, $0, 4
	syscall
	
	ori $a0, $s0, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, divi
	ori $v0, $0, 4
	syscall
	
	addi $a0, $s2, -1
	ori $v0, $0, 1
	syscall
	
	ori $a0, $0, 10
	ori $v0, $0, 11
	syscall
	
	j SuitePour
	
	
	
FAUX :  la $a0, faux
	ori $v0, $0, 4
	syscall
	
	ori $a0, $s0, 0
	ori $v0, $0, 1
	syscall
	
	la $a0, divi
	ori $v0, $0, 4
	syscall
	
	addi $a0, $s2, -1
	ori $v0, $0, 1
	syscall
	
	la $a0, resultat
	ori $v0, $0, 4
	syscall
	
	ori $a0, $s4, 0
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
	
	addi $s1, $s1, 1
	j POUR

	
SUITENote : 
	ori $v0, $s0, 0

	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 8
	jr $ra	
	


	