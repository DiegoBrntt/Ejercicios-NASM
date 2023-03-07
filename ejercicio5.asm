global main
global _start ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION

;-------------------FUNCIONES DE C (IMPORTADAS)-------------------------- 
extern printf
extern scanf
extern gets   ; GETS ES PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS!!!
extern exit

;--------------SECCION DE LAS VARIABLES-------------------------------
section .bss  

caracter:
resb 1               ; 1 byte (dato)
resb 3               ; 3 bytes (relleno)

vector:
resd 100
 
;--------------SECCION DE LAS CONSTANTES-------------------------------
section .data

fmtChar:
db "%c", 0; FORMATO PARA CARACTERES

fmtString:
db "%s", 0 ; FORMATO PARA CADENAS

fmtLF:
db 0xA, 0 ; SALTO DE LINEA (LF)

msjSalida:
db "Mostrando caracteres ordenados: ", 0

msj:
db "Ingrese caracter: ", 0

;--------------SECCION DE LAS INSTRUCCIONES-------------------------------
section .text

leerCaracter:
push caracter
push fmtString
call scanf
add esp, 8
ret

mostrarMensajeSalida:  ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
push msjSalida
push fmtString
call printf
add esp, 8
ret

mostrarMsj:  ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
push msj
push fmtString
call printf
add esp, 8
ret

mostrarCaracter:
push dword [caracter]
push fmtChar
call printf
add esp, 8
ret

mostrarSaltoDeLinea:    ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
push fmtLF
call printf
add esp, 4
ret 


salirDelPrograma:   ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
call mostrarSaltoDeLinea
push 0
call exit 

;------------PUNTO DE INICIO DEL PROGRAMA-------------
_start:
main:
mov ebx, 0

ingresos:
call mostrarMsj
call leerCaracter
mov al, [caracter]
mov [ebx+vector], al
inc ebx
cmp ebx, 10
jl ingresos
call mostrarSaltoDeLinea
call mostrarMensajeSalida
call mostrarSaltoDeLinea

pre:
mov ebx, 0
mov ecx, 0

acomodar:
cmp ebx, 10
jge imprimir
jl comparar

comparar:
cmp ecx, 10
jge continuar
mov al, [ecx+vector]
inc ecx
mov dl, [ecx+vector]
cmp al, dl
jl menor
jg mayor
call comparar

menor:
dec ecx
mov [ecx+vector], al
inc ecx
mov [ecx+vector], dl
call comparar

mayor:
dec ecx
mov [ecx+vector], dl
inc ecx
mov [ecx+vector], al
call comparar

continuar:
mov ecx, 0
inc ebx
call acomodar


imprimir:
mov ebx, 1

imprimir2:
dec ebx
mov al, [ebx+vector]
inc ebx
mov dl, [ebx+vector]
cmp al, dl
je iq
jne imprimir3

iq:
inc ebx
call imprimir2


imprimir3:
mov al, [ebx+vector]
mov [caracter], al
call mostrarCaracter
call mostrarSaltoDeLinea
inc ebx
cmp ebx, 10
jle imprimir2
jg salirDelPrograma
