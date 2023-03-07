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
 
;--------------SECCION DE LAS CONSTANTES-------------------------------
section .data

fmtInt:
db "%d", 0  ; FORMATO PARA NUMEROS ENTEROS

fmtString:
db "%s", 0 ; FORMATO PARA CADENAS

fmtLF:
db 0xA, 0 ; SALTO DE LINEA (LF)

msjEntrada:
db "Ingrese un año: ", 0

msjNoBi:
db "NO es bisiesto. ", 0

msjBi:
db "Es bisiesto. ", 0

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

mostrarNpBi:    ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
push msjNoBi
push fmtString
call printf
add esp, 8
ret

mostrarBi:    ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
push msjBi
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


salirDelPrograma:   ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
call mostrarBi
call mostrarSaltoDeLinea
push 0
call exit 

salirDelProgramaNo:   ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
call mostrarNpBi
call mostrarSaltoDeLinea
push 0
call exit 

;------------PUNTO DE INICIO DEL PROGRAMA-------------
_start:
main:
call mostrarMensajeEntrada
call leerNumero
mov eax, [numero]
mov edx, 0
mov ecx, 4
div ecx
cmp edx, 0
jne salirDelProgramaNo
mov eax, [numero]
mov edx, 0
mov ecx, 100
div ecx
cmp edx, 0
jne salirDelPrograma
mov eax, [numero]
mov edx, 0
mov ecx, 400
div ecx
cmp edx, 0
jne salirDelProgramaNo
je salirDelPrograma

