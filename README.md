# Calculadora de Fracciones en MIPS con el simulador Mars

## Resumen del Proyecto
Este proyecto consiste en una **calculadora de fracciones** implementada en lenguaje ensamblador MIPS. Fue desarrollada como una iniciativa personal para los estudiantes que desean aprender sobre programación en ensamblador y cómo manejar operaciones matemáticas con validaciones y flujos de control.

La calculadora permite realizar las siguientes operaciones hasta el momento:
- **Suma** de fracciones
- **Resta** de fracciones
- **Multiplicación** de fracciones
- **División** de fracciones

Además, la calculadora incluye validaciones matemáticas importantes, como:
- Evitar divisiones por cero
- Manejar correctamente fracciones con denominadores iguales o diferentes
- Simplificar los resultados de las operaciones y mostrarlos según amerite el caso

---

## Estructura y Flujo del Programa

### Estructura General
El programa se organiza en dos grandes secciones:
1. **Datos (`.data`)**:
   - Contiene los mensajes de texto que se muestran al usuario, como el menú principal y los errores.
   - Define las variables para almacenar los numeradores y denominadores.

2. **Texto (`.text`)**:
   - Implementa la lógica principal del programa, dividida en las siguientes partes:
     - **Menú principal**: Ejecuta un bucle de un menú con las operaciones disponibles y recibe lo que ingresa el usuario.
     - **Operaciones matemáticas**: Gestionan la lógica para cada operación (suma, resta, multiplicación, división).
     - **Validaciones**: Realiza el manejo de casos como denominadores iguales, división por cero, y simplificación de fracciones con sus respectivos casos.
     - **Impresión de resultados**: Muestra los resultados en pantalla, tanto sin simplificar como simplificados, y de ser posible, en números enteros.

### Flujo del Programa
1. **Menú Principal**:
   - Muestra las opciones al usuario y permite seleccionar una operación o salir del programa.
   - Si el usuario ingresa una opción inválida, muestra un mensaje de error y vuelve al menú.

2. **Entrada de Datos**:
   - Solicita al usuario de manera clara los valores de los numeradores y denominadores de las dos fracciones.

3. **Operaciones**:
   - Dependiendo de la opción seleccionada, se realiza la operación correspondiente:
     - **Suma**: Verifica si los denominadores son iguales o diferentes y aplica la lógica adecuada.
     - **Resta**: Similar a la suma, maneja casos de denominadores iguales y diferentes.
     - **Multiplicación**: Multiplica los numeradores y denominadores.
     - **División**: Realiza la operación cruzada entre numeradores y denominadores.

4. **Simplificación**:
   - Implementa el **algoritmo de Euclides** para encontrar el máximo común divisor (MCD) y simplificar la fracción resultante. Se salta este paso si el numerador es cero

5. **Resultados**:
   - Imprime la fracción resultante sin simplificar.
   - Luego, muestra la fracción simplificada.
   - Si la fracción simplificada puede convertirse en un número entero, también lo muestra.

6. **Repetición**:
   - Una vez que se muestra el resultado, el programa regresa al menú principal para permitir nuevas operaciones.

### Validaciones Clave
- **División por cero**: Si alguno de los denominadores es cero, el programa muestra un error y regresa al menú.
- **Denominadores iguales en suma y resta**: Realiza las operaciones directamente para simplificar los cálculos.
- **Simplificación**: Siempre intenta reducir la fracción al menor término posible.
- **Resultado entero**: Si el numerador es divisible por el denominador, muestra el resultado como un número entero.

---

## Cómo Ejecutar
1. Descarga e instala un simulador MIPS como **SPIM** o **QtSPIM**. o puedes usar **Mars**
2. Carga el archivo `calculadoraFracciones.asm` en el simulador.
3. Ejecuta el programa y sigue las instrucciones en pantalla.

---

Apreciaría cualquier retroalimentación y/o sugerencias en el programa.
