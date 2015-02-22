ESCOM Compiladores
=============

Proyecto Final de la materia Compiladores
Calculadora hecha con flex y bison capaz de realizar las operaciones matemáticas:

Asignación
Impresión
Suma
Resta
Multiplicación
División
Seno
Coseno
Tangente
Potenciación
Raíz Cuadrada

CLasificadas en 3 tipos de operaciones: Operaciones de Asignacion, Operaciones de Impresion y Operaciones Matematicas.

Implementa restricción de operaciones (divisiones entre 0 etc..) y manejo de parentésis.

=============
ESPECIFICACIONES DE ENTRADA Y SALIDA

La entrada se proporciona mediante un archivo que
contiene las operaciones a realizar.

La salida se muestra en otro archivo donde aparecen
las impresiones indicadas en el archivo de entrada o
los mensajes de error en caso de que alguna
operación quede indeterminada.

El nombre de ambos archivos se envían desde
consola

Sintaxis:
./Calculadora entrada.txt salida.txt


=============
COMPILACION

 bison –d archivo.y

 flex archivo.l

 gcc lex.yy.c archivo.tab.c –o salida -ly –lfl
