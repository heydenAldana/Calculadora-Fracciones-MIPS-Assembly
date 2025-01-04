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
	sms_ErrorDenominador: .asciiz "\n- ERROR: No se puede realizar la operacion por indeterminacion\n"
	sms_ErrorDivision: .asciiz "\n- ERROR: No se puede realizar la division porque el resultado\n  es una fraccion con denominador cero, lo cual es INDETERMINACION\n\n"
	
	sms_mas: .asciiz "   +   "
	sms_menos: .asciiz "   -   "
	sms_mul: .asciiz "   *   "
	sms_div: .asciiz "   /   "
	sms_simboloFraccion: .asciiz " / "
	sms_igual: .asciiz "   =   "
	
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
		li $v0, 4
		la $a0, sms_newLine
		syscall
		# Relizar operacion segun opcion elegida y se muestra (se hace por interno)
		beq $t0, 1, suma
		beq $t0, 2, resta
		beq $t0, 3, multiplicacion
		beq $t0, 4, division
		# Repetir el bucle main
		li $v0, 4
		la $a0, sms_newLine
		syscall
		j main
		
		salirPrograma: 
			li $v0, 10
			syscall
		
	# --- OPERACIONES MATEMATICAS
	# Operacion de suma (manejo de varios casos)
	suma:
		beq $t2, 0, msgErrorDenominador
		beq $t4, 0, msgErrorDenominador
		# Suma por metodo XD
		mul $t5, $t1, $t4
		mul $t6, $t2, $t3
		mul $t7, $t2, $t4
		add $t6, $t6, $t5
		# --- Mostrar suma de fracciones
		# Imprimir primera fraccion
		li $v0, 1
		add $a0, $zero, $t1
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t2
		syscall
		# Imprimir simbolo correspondiente
		li $v0, 4
		la $a0, sms_mas
		syscall
		# Imprimir segunda fraccion
		li $v0, 1
		add $a0, $zero, $t3
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t4
		syscall
		# Imprimir simbolo igual
		li $v0, 4
		la $a0, sms_igual
		syscall
		# Imprimir fraccion resultante (hacer validaciones)
		li $v0, 1
		add $a0, $zero, $t6
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t7
		syscall
		# Volver al main
		li $v0, 4
		la $a0, sms_newLine
		syscall
		li $v0, 4
		la $a0, sms_newLine
		syscall
		j main
		
	# Operacion de resta (manejo de varios casos similar a la suma)
	resta:
		beq $t2, 0, msgErrorDenominador
		beq $t4, 0, msgErrorDenominador
		# Resta por metodo XD
		mul $t5, $t1, $t4
		mul $t6, $t2, $t3
		mul $t7, $t2, $t4
		sub $t6, $t6, $t5
		# --- Mostrar resta de fracciones
		# Imprimir primera fraccion
		li $v0, 1
		add $a0, $zero, $t1
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t2
		syscall
		# Imprimir simbolo correspondiente
		li $v0, 4
		la $a0, sms_menos
		syscall
		# Imprimir segunda fraccion
		li $v0, 1
		add $a0, $zero, $t3
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t4
		syscall
		# Imprimir simbolo igual
		li $v0, 4
		la $a0, sms_igual
		syscall
		# Imprimir fraccion resultante (hacer validaciones)
		li $v0, 1
		add $a0, $zero, $t6
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t7
		syscall
		# Volver al main
		li $v0, 4
		la $a0, sms_newLine
		syscall
		li $v0, 4
		la $a0, sms_newLine
		syscall
		j main
		
	# Operacion de multiplicación
	multiplicacion:
		beq $t2, 0, msgErrorDenominador
		beq $t4, 0, msgErrorDenominador
		# Suma por metodo XD
		mul $t6, $t1, $t3
		mul $t7, $t3, $t4
		# --- Mostrar multiplicacion de fracciones
		# Imprimir primera fraccion
		li $v0, 1
		add $a0, $zero, $t1
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t2
		syscall
		# Imprimir simbolo correspondiente
		li $v0, 4
		la $a0, sms_mul
		syscall
		# Imprimir segunda fraccion
		li $v0, 1
		add $a0, $zero, $t3
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t4
		syscall
		# Imprimir simbolo igual
		li $v0, 4
		la $a0, sms_igual
		syscall
		# Imprimir fraccion resultante (hacer validaciones)
		li $v0, 1
		add $a0, $zero, $t6
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t7
		syscall
		# Volver al main
		li $v0, 4
		la $a0, sms_newLine
		syscall
		li $v0, 4
		la $a0, sms_newLine
		syscall
		j main
		
	# Operacion de division (cuidado con el numerador cero)
	division:
		# Para dividir, se multiplica cruzado en X
		mul $t6, $t1, $t4
		mul $t7, $t2, $t3
		# Se evalua despues del resultado, no antes
		beq $t7, 0, msgErrorDivision
		# --- Mostrar division de fracciones
		# Imprimir primera fraccion
		li $v0, 1
		add $a0, $zero, $t1
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t2
		syscall
		# Imprimir simbolo correspondiente
		li $v0, 4
		la $a0, sms_div
		syscall
		# Imprimir segunda fraccion
		li $v0, 1
		add $a0, $zero, $t3
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t4
		syscall
		# Imprimir simbolo igual
		li $v0, 4
		la $a0, sms_igual
		syscall
		# Imprimir fraccion resultante (hacer validaciones)
		li $v0, 1
		add $a0, $zero, $t6
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t7
		syscall
		# Volver al main
		li $v0, 4
		la $a0, sms_newLine
		syscall
		li $v0, 4
		la $a0, sms_newLine
		syscall
		j main
		
		
	# --- MANEJO DE ERRORES Y VALIDACIONES MATEMATICAS
	# Se muestra mensaje si alguno de los denominadores es cero (para division se maneja diferente)
	msgErrorDenominador:
		jal limpiarRegistros
		li $v0, 4
		la $a0, sms_ErrorDenominador
		syscall
		j main
		
	# Se muestra mensaje si algun numerador es cero (SOLO DIVISION)
	msgErrorDivision:
		jal limpiarRegistros
		li $v0, 4
		la $a0, sms_ErrorDivision
		syscall
		j main
	
	# Mostrar mensaje de error si el usuario no ingresa una opcion valida
	mostrarMensajeOpcionInvalida:
		li $v0, 4
		la $a0, sms_opcionInvalida
		syscall 
		j main
		
	# Restablece los valores de los registros a cero
	limpiarRegistros:
		addi $t1, $zero, 0 
		addi $t2, $zero, 0 
		addi $t3, $zero, 0 
		addi $t4, $zero, 0 
		addi $t5, $zero, 0 
		addi $t6, $zero, 0 
		addi $t7, $zero, 0 
		jr $ra