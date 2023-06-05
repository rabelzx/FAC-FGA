.data
	inVali: .asciiz "Entrada invalida."
	espaco: .asciiz "\n"
.text
main:
	li $v0,5 # Primeiro n�mero a ser recebido
	syscall
	
	move $t0, $v0 # Move para $t0 o valor contido em $v0
	
	li $v0,5 # Segundo n�mero a ser recebido
	syscall
	
	move $t1, $v0 # Move para $t1 o valor contido em $v0
	
	addi $t2,$t2, 2 # Em t2 ser� guardado o valor para a condicional
	
	blt $t0,$t2,saidaInva # Se A menor que 2 pule para o saidaInva
	blt $t1,$t2,saidaInva # Se B menor que 2 pule para o saidaInva
	
	move $s1, $t0 # Move para $s1 o valor contido em $t0 para ser utilizado no MDC
	move $s2, $t1 # Move para $s2 o valor contido em $t1 para ser utilizado no MDC
	
	# O loop do MDC � do while
	
	loopMDC:
		# Equa��o a ser realizada  restoM = c % d;
		div $t6,$s1,$s2 # div = c / d
		
		mfhi $t7 # restoM = c % d
		
		move $s1,$s2 # c = d
		
		move $s2, $t7 # d = restoM
		
		beqz $t7,imprimeMDC # se o restoM for igual a zero encerra o programa
		
		j loopMDC
	
	imprimeMDC:
		li $v0 , 1 # L� Int
		move $a0,$s1 # Move para $a0 o valor contido em $s1
		syscall
		
		j loopMMC # Pula para o loop do MMC
	
	loopMMC:
		mul $t3,$t0,$t1
		div $t4,$t3,$s1
		
		j imprimeMMC
	
	imprimeMMC:
		li $v0, 4 # L� String
		la $a0, espaco # Passa para $a0 o valor contido em espaco, no caso o valor eh \n
		syscall
		
		li $v0, 1 # Imprime Int
		move $a0,$t4 # Move para $a0 o valor contido em $t6
		syscall
		
		j saida # Pula para o loop do MDC
	
	saida:
		li $v0, 10 # Encerra o Programa
		syscall
	
	saidaInva:
		li $v0, 4 # L�  String 
		la $a0, inVali # Carrega em $a0 o valor contido na vari�vel inVali
		syscall
		
		li $v0,10 # Encerra o Programa
		syscall
