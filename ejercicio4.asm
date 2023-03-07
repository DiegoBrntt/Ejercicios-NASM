global main
global _start ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION

;-------------------FUNCIONES DE C (IMPORTADAS)-------------------------- 
extern printf
extern scanf
extern gets   ; GETS ES PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS!!!
extern exit

;--------------SECCION DE LAS VARIABLES-------------------------------
section .bss  

cantidad:
resd 1      ; 1 dword (4 bytes)

ingreso:
resd 1      ; 1 dword (4 bytes)

sumaPar:
resd 1      ; 1 dword (4 bytes)

promImpar:
resd 1      ; 1 dword (4 bytes)
impares:
resd 1      ; 1 dword (4 bytes)

vector:
resd 100    ;matriz como maximo de 10x10
 
;--------------SECCION DE LAS CONSTANTES-------------------------------
section .data

fmtInt:
db "%d", 0  ; FORMATO PARA NUMEROS ENTEROS

fmtString:
db "%s", 0 ; FORMATO PARA CADENAS

fmtLF:
db 0xA, 0 ; SALTO DE LINEA (LF)

msjEntrada:
db "Ingrese cantidad de numeros deseados: ", 0

msjIngreso:
db "Ingrese un numero: ", 0

msjSumaPar:
db "Suma números pares: ", 0
msjPromImpar:
db "Promedio números impares: ", 0

;--------------SECCION DE LAS INSTRUCCIONES-------------------------------
section .text

leerCantidad:     ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
push cantidad
push fmtInt
call scanf
add esp, 8
ret 

leerIngreso:     ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
push ingreso
push fmtInt
call scanf
add esp, 8
ret 

mostrarMensajeEntrada:  ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
push msjEntrada
push fmtString
call printf
add esp, 8
ret

mostrarMensajeIngreso:  ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
push msjIngreso
push fmtString
call printf
add esp, 8
ret

mostrarMsjSumaPar:  ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
push msjSumaPar
push fmtString
call printf
add esp, 8
ret

mostrarMsjPromImpar:  ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
push msjPromImpar
push fmtString
call printf
add esp, 8
ret


mostrarSumaPar:
push dword [sumaPar]
push fmtInt
call printf
add esp, 8
ret

mostrarPromImpar:
push dword [promImpar]
push fmtInt
call printf
add esp, 8
ret

mostrarSaltoDeLinea:    ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
push fmtLF
call printf
add esp, 4
ret 


salirDelPrograma:   ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
call mostrarMsjPromImpar
call mostrarPromImpar
call mostrarSaltoDeLinea
call mostrarMsjSumaPar
call mostrarSumaPar
call mostrarSaltoDeLinea
push 0
call exit 

;------------PUNTO DE INICIO DEL PROGRAMA-------------
_start:
main:
mov [sumaPar], dword 0
mov [promImpar], dword 0
mov [impares], dword 0
mov eax, 0
mov ebx, 0
call mostrarMensajeEntrada
call leerCantidad
call mostrarSaltoDeLinea

ingresos:
call mostrarMensajeIngreso
call leerIngreso
mov eax, [ingreso]
mov [ebx+vector], eax
inc ebx


verficacion:
mov eax, [ingreso]
mov edx, 0
mov ecx, 2
div ecx
cmp edx, 0
je suma
jne prom

suma:
mov eax, [ingreso]
add [sumaPar], eax
cmp ebx, [cantidad]
jl ingresos
jge salirDelPrograma


prom:
inc dword [impares]
mov eax, [ingreso]
add [promImpar], eax
cmp ebx, [cantidad]
jl ingresos
mov eax, [promImpar]
mov edx, 0
mov ecx, [impares]
div ecx
mov [promImpar], eax
call salirDelPrograma
