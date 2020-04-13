.data
ope : .asciiz "+-*/"
sep : .asciiz "\n*******************************************************\n"
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

.text

main :
	subu $sp, $sp, 64
	addiu $fp, $sp, 64
	jal fctNiveau     #Choix deniveau
	ori $a0, $v0, 0 #argument choix
	
	ori $v0,$0,5      #lire un integer note
    	syscall
    	
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
	ori $t1, $0, 20  #TOTALE
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
	
