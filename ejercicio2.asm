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
cadena:
resb 0x0100; 256 bytes

caracter:
resb 1   ; 1 byte (dato)
resb 3   ; 3 bytes (relleno)
 
;--------------SECCION DE LAS CONSTANTES-------------------------------
section .data

fmtInt:
db "%d", 0  ; FORMATO PARA NUMEROS ENTEROS

fmtString:
db "%s", 0 ; FORMATO PARA CADENAS

fmtChar:
db "%c", 0  ; FORMATO PARA CARACTERES

fmtLF:
db 0xA, 0 ; SALTO DE LINEA (LF)

msjEntrada:
db "Ingrese una palabra: ", 0

msjIgual:
db " = ", 0

msjX:
db " ", 0

;--------------SECCION DE LAS INSTRUCCIONES-------------------------------
section .text

leerNumero:     ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
push numero
push fmtInt
call scanf
add esp, 8
ret 

leerCadena:
push cadena
call gets
add esp, 4
ret

mostrarCaracter:
push dword [caracter]
push fmtChar
call printf
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
call leerCadena
call mostrarSaltoDeLinea
mov ebx, 0

impar:
mov al, [ebx+cadena]
mov [caracter], al
cmp al, 0
je par
call mostrarCaracter
add ebx, 2
call impar

par:
CALL mostrarX
mov ebx, 1
call par2

par2:
mov al, [ebx+cadena]
mov [caracter], al
cmp al, 0
je salirDelPrograma
call mostrarCaracter
add ebx, 2
call par2