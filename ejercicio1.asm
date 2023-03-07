global main
global _start ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION

;-------------------FUNCIONES DE C (IMPORTADAS)-------------------------- 
extern printf
extern scanf
extern gets   ; GETS ES PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS!!!
extern exit

;--------------SECCION DE LAS VARIABLES-------------------------------
section .bss  

numero:
resd 1      ; 1 dword (4 bytes)
divisor:
resd 1      ; 1 dword (4 bytes)
 
;--------------SECCION DE LAS CONSTANTES-------------------------------
section .data

fmtInt:
db "%d", 0  ; FORMATO PARA NUMEROS ENTEROS

fmtString:
db "%s", 0 ; FORMATO PARA CADENAS

fmtLF:
db 0xA, 0 ; SALTO DE LINEA (LF)

msjEntrada:
db "Ingrese un numero entero: ", 0

msjIgual:
db " = ", 0

msjX:
db " x ", 0

;--------------SECCION DE LAS INSTRUCCIONES-------------------------------
section .text

leerNumero:     ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
push numero
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

mostrarX:    ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
push msjX
push fmtString
call printf
add esp, 8
ret

mostrarIgual:    ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
push msjIgual
push fmtString
call printf
add esp, 8
ret

mostrarSaltoDeLinea:    ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
push fmtLF
call printf
add esp, 4
ret 

mostrarNumero:  ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
push dword [numero]
push fmtInt
call printf
add esp, 8
ret 

mostrarDivisor:  ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
push dword [divisor]
push fmtInt
call printf
add esp, 8
ret 


salirDelPrograma:   ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
call mostrarSaltoDeLinea
push 0
call exit 

salirDelPrograma0:   ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
call mostrarX
call mostrarNumero
call mostrarSaltoDeLinea
push 0
call exit 

;------------PUNTO DE INICIO DEL PROGRAMA-------------
_start:
main:
call mostrarMensajeEntrada
call leerNumero
call mostrarSaltoDeLinea
call mostrarNumero
call mostrarIgual
mov [divisor], dword 2

comprobacion:
cmp eax, 0
je salirDelPrograma0

continuar:
mov eax, [numero]
mov edx, 0
mov ecx, [divisor]
div ecx
cmp edx, 0
je imprimirDiv
jne noImp

noImp:
mov eax, [numero]
add [divisor], dword 1
call continuar

imprimirDiv:
mov [numero], eax
call mostrarX
call mostrarDivisor
cmp eax, [divisor]
jle comprobarPrimo
jg continuar

comprobarPrimo:
mov ecx, 2
mov eax, [numero]
mov edx, 0
div ecx
cmp edx, 0
je continuar
mov ecx, 3
mov eax, [numero]
mov edx, 0
div ecx
cmp edx, 0
je continuar
mov ecx, 5
mov eax, [numero]
mov edx, 0
div ecx
cmp edx, 0
je continuar
mov ecx, 7
mov eax, [numero]
mov edx, 0
div ecx
cmp edx, 0
je continuar
mov ecx, 11
mov eax, [numero]
mov edx, 0
div ecx
cmp edx, 0
je continuar
cmp eax, 1
jne salirDelPrograma0
je salirDelPrograma