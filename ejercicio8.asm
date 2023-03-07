global main
global _start ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION

;-------------------FUNCIONES DE C (IMPORTADAS)-------------------------- 
extern printf
extern scanf
extern exit

;--------------SECCION DE LAS VARIABLES-------------------------------
section .bss  

numero:
resd 1

max:
resd 1

contador:
resd 1

i:
resd 1

j:
resd 1

filas:
resd 1

columnas:
resd 1

salto:
resd 1

matriz:
resd 100

 
;--------------SECCION DE LAS CONSTANTES-------------------------------
section .data

fmtInt:
db "%d", 0

fmtString:
db "%s", 0 ; FORMATO PARA CADENAS

fmtLF:
db 0xA, 0 ; SALTO DE LINEA (LF)

msjEntrada:
db "Ingrese cant. de filas y columnas deseadas: ", 0

msjIngreso:
db "Ingrese numero deseado para insertar en matriz: ", 0

espacio:
db " ", 0

msjMatriz:
db "Matriz: ", 0

msjMatriz2:
db "Matriz transpuesta: ", 0


;--------------SECCION DE LAS INSTRUCCIONES-------------------------------
section .text

leerNumero:
push numero
push fmtInt
call scanf
add esp, 8
ret

leerFilas:
push filas
push fmtInt
call scanf
add esp, 8
ret


leerColumnas:
push columnas
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

mostrarMensajeMatriz:  ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
push msjMatriz
push fmtString
call printf
add esp, 8
ret

mostrarMensajeMatriz2:  ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
push msjMatriz2
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

mostrarEspacio:  ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
push espacio
push fmtString
call printf
add esp, 8
ret


mostrarNumero:
push dword [numero]
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
call mostrarSaltoDeLinea
call mostrarSaltoDeLinea
push 0
call exit 

;------------PUNTO DE INICIO DEL PROGRAMA-------------
_start:
main:
call mostrarMensajeEntrada
call leerFilas
call mostrarSaltoDeLinea
call mostrarSaltoDeLinea
call mostrarSaltoDeLinea

mov eax, [filas]
mul dword [filas]
mov [max], eax
mov esi, 0
mov [i], dword 0
mov [j], dword 0

ingresos:
mov ecx, [i]
cmp ecx, [max]
jge preImprimir
call mostrarSaltoDeLinea
call mostrarMensajeIngreso
call leerNumero
mov eax, [numero]
mov [esi+matriz], eax
add esi, 4
inc dword [i]
call ingresos

preImprimir:
call mostrarSaltoDeLinea
call mostrarSaltoDeLinea
call mostrarMensajeMatriz
call mostrarSaltoDeLinea
mov esi, 0
mov [i], dword 0
mov [j], dword 0

imprimirMatriz:
mov ecx, [i]
cmp ecx, [max]
jge preInvertirMatriz
mov ecx, [j]
cmp ecx, [filas]
jge imprimirCambioFilaMatriz
mov eax, [esi+matriz]
mov [numero], eax
call mostrarNumero
call mostrarEspacio
add esi, 4
inc dword [i]
inc dword [j]
call imprimirMatriz

imprimirCambioFilaMatriz:
call mostrarSaltoDeLinea
mov eax, [esi+matriz]
mov [numero], eax
call mostrarNumero
call mostrarEspacio
add esi, 4
inc dword [i]
mov [j], dword 1
call imprimirMatriz

preInvertirMatriz:
call mostrarSaltoDeLinea
call mostrarSaltoDeLinea
call mostrarMensajeMatriz2
call mostrarSaltoDeLinea
mov ecx, [filas]
dec ecx
mov eax, 4
mul ecx
mov [salto], eax
mov [contador], dword 0
mov esi, 0
add [salto], dword 4

mov [j], dword 0
mov [i], dword 0


imprimirMatrizInv:
mov ecx, [i]
cmp ecx, [max]
jge salirDelPrograma
mov ecx, [j]
cmp ecx, [filas]
jge imprimirCambioFilaMatrizInv
mov eax, [esi+matriz]
mov [numero], eax
call mostrarNumero
call mostrarEspacio
add esi, [salto]
inc dword [i]
inc dword [j]
call imprimirMatrizInv

imprimirCambioFilaMatrizInv:
call mostrarSaltoDeLinea
add [contador], dword 4
mov esi, [contador]
mov [j], dword 0
call imprimirMatrizInv
