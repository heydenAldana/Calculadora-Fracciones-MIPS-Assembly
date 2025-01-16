# La calculadora puede realizar operaciones de:
#	- Suma
#	- Resta
#	- Multiplicacion
#	- Division
# Y se toma en consideracion validaciones lógicas a nivel matemático y casos especiales.

.data
	sms_Menu: .asciiz "\t\t= = = CALCULADORA DE FRACCIONES = = =\n\nA continuación se le despliega el siguiente menú de opciones: \n\t1. Suma\n\t2. Resta\n\t3. Multiplicacion\n\t4. Division\n\t5. Potencia (acepta numeros enteros y fracciones)\n\t6. Salir del programa\n\n Digite la opcion que quiera:\t"
	sms_preguntarNum1: .asciiz "\n- Por favor, digite el primer numerador: "
	sms_preguntarNum2: .asciiz "\n- Por favor, digite el segundo numerador: "
	sms_preguntarDen1: .asciiz "\n- Por favor, digite el primer denominador: "
	sms_preguntarDen2: .asciiz "\n- Por favor, digite el segundo  denominador: "
	sms_preguntarExponenteEntero: .asciiz "\n- Por favor, digite el exponente al cual quiere elevar la fraccion: "
	sms_preguntarExponenteNum: .asciiz "\n- Por favor, digite el exponente al cual quiere elevar el numerador: "
	sms_preguntarExponenteDen: .asciiz "\n- Por favor, digite el exponente al cual quiere elevar el denominador: "
	sms_preguntarExponenteFraccional: .asciiz "\n- Puede elegir lo siguiente:\n\tEscriba (E/e) para elevar la fraccion con un solo exponente\n\tEscriba (F/f) para elevar la fraccion con sus propios exponentes por separado:  "
	sms_newLine: .asciiz "\n"
	sms_opcionInvalida: .asciiz "\n- AVISO: Debe digitar un número dentro de las opciones disponibles, y seguir las indicaciones dadas\n\n"
	sms_ErrorDenominador: .asciiz "\n- ERROR: No se puede realizar la operacion por indeterminacion\n"
	sms_ErrorDivision: .asciiz "\n- ERROR: No se puede realizar la division porque el resultado\n  es una fraccion con denominador cero, lo cual es INDETERMINACION\n\n"
	
	sms_mas: .asciiz "   +   "
	sms_menos: .asciiz "   -   "
	sms_mul: .asciiz "   *   "
	sms_div: .asciiz "   /   "
	sms_simboloFraccion: .asciiz " / "
	sms_igual: .asciiz "   =   "
	sms_abreParentesis: .asciiz " ( "
	sms_cierraParentesis: .asciiz " ) "
	sms_potencia: .asciiz " ^ "
	
	num1: .word 0
	den1: .word 1
	num2: .word 0
	den2: .word 1
.text
	main:
		li $v0, 4
		la $a0, sms_newLine
		syscall
		jal limpiarRegistros
		# Pide la entrada de la opcion a elegir
		li $v0, 4
		la $a0, sms_Menu
		syscall
		li $v0, 5
		syscall
		move $t0, $v0
		# Validaciones especiales (opcion invalida, selecciona SALIR)
		bgt $t0, 6, mostrarMensajeOpcionInvalida
		blt $t0, 1, mostrarMensajeOpcionInvalida
		beq $t0, 6, salirPrograma
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
		beq $t0, 5, potencia
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
		beq $t2, $t4, sumaMismoDenominador
		sumaDistintoDenominador:
			mul $t5, $t1, $t4
			mul $t6, $t2, $t3
			mul $t7, $t2, $t4
			add $t6, $t6, $t5
			j continuarOperacionSuma
		sumaMismoDenominador:
			add $t6, $t1, $t3
			add $t7, $zero, $t2
		# --- Mostrar suma de fracciones
		continuarOperacionSuma:
			li $v0, 4
			la $a0, sms_newLine
			syscall
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
			j mostrarResultado
		
	# Operacion de resta (manejo de varios casos similar a la suma)
	resta:
		beq $t2, 0, msgErrorDenominador
		beq $t4, 0, msgErrorDenominador
		beq $t2, $t4, restaMismoDenominador
		restaDistintoDenominador:
			mul $t5, $t1, $t4
			mul $t6, $t2, $t3
			mul $t7, $t2, $t4
			sub $t6, $t6, $t5
			j continuarOperacionResta
		restaMismoDenominador:
			sub $t6, $t1, $t3
			add $t7, $zero, $t2
		# --- Mostrar resta de fracciones
		continuarOperacionResta:
			li $v0, 4
			la $a0, sms_newLine
			syscall
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
			j mostrarResultado
		
	# Operacion de multiplicación
	multiplicacion:
		beq $t2, 0, msgErrorDenominador
		beq $t4, 0, msgErrorDenominador
		# Suma por metodo XD
		mul $t6, $t1, $t3
		mul $t7, $t3, $t4
		# --- Mostrar multiplicacion de fracciones
		li $v0, 4
		la $a0, sms_newLine
		syscall
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
		j mostrarResultado
		
	# Operacion de division (cuidado con el numerador cero)
	division:
		# Para dividir, se multiplica cruzado en X
		mul $t6, $t1, $t4
		mul $t7, $t2, $t3
		# Se evalua despues del resultado, no antes
		beq $t7, 0, msgErrorDivision
		# --- Mostrar division de fracciones
		li $v0, 4
		la $a0, sms_newLine
		syscall
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
		j mostrarResultado
	
	potencia:
		beq $t2, 0, msgErrorDenominador
		# Pedir que elija si el exponente es entero o fraccion
		li $v0, 4
		la $a0, sms_preguntarExponenteFraccional
		syscall
		li $v0, 12
		syscall
		# Guardar entrada de caracter y evaluar si eligio alguna, de lo contrario, mostrar mensaje de error 
		# por opcion invalida
		move $s0, $v0
		beq $s0, 'E', calcularPotenciaEntero
		beq $s0, 'e', calcularPotenciaEntero
		beq $s0, 'F', calcularPotenciaFraccion
		beq $s0, 'f', calcularPotenciaFraccion
		j mostrarMensajeOpcionInvalida
		# Realizar calculo con variables inicializadas, utilizando $s1 y $s2 para guardar el exponente, #s3 y $s4 como indices (num y den)
		addi $s3, $zero, 1
		addi $s4, $zero, 1
		addi $t6, $zero, 1
		addi $t7, $zero, 1
		# Bloque de codigo para el calculo de potencias con un exponente entero
		calcularPotenciaEntero:
			# Solicitara ingresar el exponente, luego opera dependiendo el caso
			li $v0, 4
			la $a0, sms_preguntarExponenteEntero
			syscall
			li $v0, 5
			syscall
			move $s1, $v0
			# Caso base: exponente cero
			calcularPotenciaExpCero:
				addi $t6, $zero, 1
				addi $t7, $zero, 1
				bgtz $s1, calcularPotenciaExpUno
				bltz $s1, calcularPotenciaExpNegativo
				j finCalcularPotencia
			# Caso donde el exponente es negativo
			calcularPotenciaExpNegativo:
				mul $t6, $t6, $t2          
    				mul $t7, $t7, $t1           
    				subi $s3, $s3, 1           
    				bgt $s3, $s1, calcularPotenciaExpNegativo  
				j finCalcularPotencia
			# Caso cuando el exponente es uno
			calcularPotenciaExpUno:
				add $t6, $zero, $t1
				add $t7, $zero, $t2
				bgt $s1, 1, buclePotenciaExpEntero
				j finCalcularPotencia
			# Caso cuando el exponente es mayor a uno
			buclePotenciaExpEntero:
    				mul $t6, $t6, $t1          
    				mul $t7, $t7, $t2           
    				addi $s3, $s3, 1           
    				beq $s3, $s1, buclePotenciaExpEntero  
    				j finCalcularPotencia
    		# Bloque de codigo para el calculo de potencias con un exponente fraccional
		calcularPotenciaFraccion:
		# Solicita ambos numerador y denominador del exponente, luego opera segun el caso
			li $v0, 4
			la $a0, sms_preguntarExponenteNum
			syscall
			li $v0, 5
			syscall
			move $s1, $v0
			li $v0, 4
			la $a0, sms_preguntarExponenteDen
			syscall
			li $v0, 5
			syscall
			move $s2, $v0
			# Verifica que el denominador del exponente no sea cero
			beq $s2, 0, msgErrorDenominador
			# Caso base cuando el exponente numerador es cero
			calcularPotenciaExpFraccionCero:
				addi $t6, $zero, 1
				addi $t7, $zero, 1
				bgtz $s1, calcularPotenciaExpNum
				j finCalcularPotencia
			# Calcula el numerador resultante
			calcularPotenciaExpNum:
				mul $t6, $t6, $t1
				addi $s3, $s3, 1
				blt $s3, $s1, calcularPotenciaExpNum
				j calcularPotenciaExpDen
			# Calcula el denominador resultante
			calcularPotenciaExpDen:
				mul $t7, $t7, $t2
				addi $s4, $s4, 1
				blt $s4, $s2, calcularPotenciaExpDen
				j finCalcularPotencia
		# Aqui se muestra ya la operacion de potencia antes de mostrar el resultado final
		finCalcularPotencia:
			li $v0, 4
			la $a0, sms_newLine
			syscall
			# Muestra la potencia con exponente entero en el formato (a/b) ^ n
			mostrarOperacionPotenciaEntero:
				# Imprimir primera fraccion entre parentesis
				beq $s0, 'F',mostrarOperacionPotenciaFraccion
				beq $s0, 'f', mostrarOperacionPotenciaFraccion
				li $v0, 4
				la $a0, sms_abreParentesis
				syscall
				li $v0, 1
				add $a0, $zero, $t1
				syscall
				li $v0, 4
				la $a0, sms_simboloFraccion
				syscall
				li $v0, 1
				add $a0, $zero, $t2
				syscall
				li $v0, 4
				la $a0, sms_cierraParentesis
				syscall
				# Elevado a la (mostrar exponente)
				li $v0, 4
				la $a0, sms_potencia
				syscall
				li $v0, 1
				add $a0, $zero, $s1
				syscall
				# Imprimir simbolo igual
				li $v0, 4
				la $a0, sms_igual
				syscall
				j mostrarResultado
			# Muestra la potencia con exponente entero en el formato ((a^ n)/(b^ n))
			mostrarOperacionPotenciaFraccion:
				li $v0, 4
				la $a0, sms_abreParentesis
				syscall	
				li $v0, 4
				la $a0, sms_abreParentesis
				syscall	
				li $v0, 1
				add $a0, $zero, $t1
				syscall	
				li $v0, 4
				la $a0, sms_potencia
				syscall
				li $v0, 1
				add $a0, $zero, $s1
				syscall
				li $v0, 4
				la $a0, sms_cierraParentesis
				syscall
				li $v0, 4
				la $a0, sms_simboloFraccion
				syscall
				li $v0, 4
				la $a0, sms_abreParentesis
				syscall	
				li $v0, 1
				add $a0, $zero, $t2
				syscall	
				li $v0, 4
				la $a0, sms_potencia
				syscall
				li $v0, 1
				add $a0, $zero, $s2
				syscall
				li $v0, 4
				la $a0, sms_cierraParentesis
				syscall
				li $v0, 4
				la $a0, sms_cierraParentesis
				syscall
				# Imprimir simbolo igual
				li $v0, 4
				la $a0, sms_igual
				syscall
				j mostrarResultado
				
		
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
		jal limpiarRegistros
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
		addi $s0, $zero, 0 
		addi $s1, $zero, 0 
		addi $s2, $zero, 0 
		addi $s3, $zero, 0 
		jr $ra

	# Imprimir el resultado, luego mostrarlo simplificado
	mostrarResultado:
		# Imprimir fraccion resultante
		li $v0, 1
		add $a0, $zero, $t6
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t7
		syscall
		# --- Simplificar la fraccion 
		# Guardar copias del numerador$s0  y denominador $s1
    		add $s0, $zero, $t6
    		add $s1, $zero, $t7
    		# Calcular el MCD usando el algoritmo de Euclides Mientras el denominador no sea 0
    		bucleSimplificar:
    			beq $s1, 1, mostrarFraccionDividida
        		beq $s1, $zero, finSimplificar 
        		beq $s0, 1, main 
        		beq $s0, $zero, mostrarFraccionDividida 
        		div $s0, $s1                    
        		mfhi $s2                        
        		move $s0, $s1                   
        		move $s1, $s2                   
        		j bucleSimplificar               
    		finSimplificar:
        		move $s2, $s0                  
        		# Dividir numerador y denominador entre el MCD $s0
        		div $t6, $t6, $s2               
        		div $t7, $t7, $s2               
        	# Imprimir fraccion resultante luego de ser simplificada
        	li $v0, 4
		la $a0, sms_igual
		syscall
		li $v0, 1
		add $a0, $zero, $t6
		syscall
		li $v0, 4
		la $a0, sms_simboloFraccion
		syscall
		li $v0, 1
		add $a0, $zero, $t7
		syscall
		# Verifica si se puede dividir la fraccion simplificada
		blt $t7, $t6, mostrarFraccionDividida
        	mostrarFraccionDividida:
        		div $t6, $t7
        		mfhi $s2
        		bnez $s2, main
        		mflo $s2
        		li $v0, 4
			la $a0, sms_igual
			syscall
			li $v0, 1
			move $a0, $s2,
			syscall
		# Volver al main
		li $v0, 4
		la $a0, sms_newLine
		syscall
		li $v0, 4
		la $a0, sms_newLine
		syscall
		j main
