# La calculadora puede realizar operaciones de:
#	- Suma
#	- Resta
#	- Multiplicacion
#	- Division
# Y se toma en consideracion validaciones lógicas a nivel matemático y casos especiales.

.data
	sms_Menu: .asciiz "\t\t= = = CALCULADORA DE FRACCIONES = = =\n\nA continuación se le despliega el siguiente menú de opciones: \n\t1. Suma\n\t2. Resta\n\t3. Multiplicacion\n\t4. Division\n\t5. Salir del programa\n\n Digite la opcion que quiera:\t"
	sms_preguntarNum1: .asciiz "\n- Por favor, digite el primer numerador: "
	sms_preguntarNum2: .asciiz "\n- Por favor, digite el segundo numerador: "
	sms_preguntarDen1: .asciiz "\n- Por favor, digite el primer denominador: "
	sms_preguntarDen2: .asciiz "\n- Por favor, digite el segundo  denominador: "
	sms_newLine: .asciiz "\n"
	sms_opcionInvalida: .asciiz "\n- AVISO: Debe digitar un número dentro de las opciones disponibles\n\n"

	sms_mas: .asciiz "  +  "
	sms_menos: .asciiz "  -  "
	sms_mul: .asciiz "  *  "
	sms_div: .asciiz "  /  "
	sms_simboloFraccion: .asciiz " / "
	sms_igual: .asciiz "  =  "
	
	num1: .word 0
	den1: .word 1
	num2: .word 0
	den2: .word 1
.text
	main:
		# Pide la entrada de la opcion a elegir
		li $v0, 4
		la $a0, sms_Menu
		syscall
		li $v0, 5
		syscall
		move $t0, $v0
		# Validaciones especiales (opcion invalida, selecciona SALIR)
		bgt $t0, 5, mostrarMensajeOpcionInvalida
		blt $t0, 1, mostrarMensajeOpcionInvalida
		beq $t0, 5, salirPrograma
		# Pedir entrada de datos de numerador y denominador
		li $v0, 4
		la $a0, sms_preguntarNum1
		syscall
		li $v0, 5
		syscall
		move $t1, $v0
		li $v0, 4
		la $a0, sms_preguntarDen1
		syscall
		li $v0, 5
		syscall
		move $t2, $v0
		li $v0, 4
		la $a0, sms_preguntarNum2
		syscall
		li $v0, 5
		syscall
		move $t3, $v0
		li $v0, 4
		la $a0, sms_preguntarDen2
		syscall
		li $v0, 5
		syscall
		move $t4, $v0
		
		
		# Repetir el bucle main
		li $v0, 4
		la $a0, sms_newLine
		syscall
		j main
		
		salirPrograma: 
			li $v0, 10
			syscall
		
	mostrarMensajeOpcionInvalida:
		li $v0, 4
		la $a0, sms_opcionInvalida
		syscall 
		j main