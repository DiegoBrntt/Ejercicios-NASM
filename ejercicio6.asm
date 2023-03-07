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

i:
resd 1

j:
resd 1

lim:
resd 1

contador:
resd 1

 
;--------------SECCION DE LAS CONSTANTES-------------------------------
section .data

fmtInt:
db "%d", 0

fmtString:
db "%s", 0 ; FORMATO PARA CADENAS

fmtLF:
db 0xA, 0 ; SALTO DE LINEA (LF)

msjEntrada:
db "Ingrese cant. de numeros de la secuencia de connell deseados: ", 0

espacio:
db " ", 0


;--------------SECCION DE LAS INSTRUCCIONES-------------------------------
section .text

leerNumero:
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

mostrarNumeroI:
push dword [i]
push fmtInt
call printf
add esp, 8
ret

mostrarNumeroLim:
push dword [lim]
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
push 0
call exit 

;------------PUNTO DE INICIO DEL PROGRAMA-------------
_start:
main:
call mostrarMensajeEntrada
call leerNumero
mov eax, [numero]
call mostrarSaltoDeLinea
call mostrarSaltoDeLinea

mov [i], dword -1
mov [j], dword 0
mov [lim], dword 1
mov [contador], dword 0


secuenciar:
mov eax, [numero]
cmp [j], eax
jge salirDelPrograma
mov ecx, [contador]
cmp ecx, [lim]
jl simple
jge salto

simple:
add [i], dword 2
call mostrarEspacio
call mostrarNumeroI
inc dword [j]
inc dword [contador]
jmp secuenciar


salto:
call mostrarSaltoDeLinea
inc dword [i]
call mostrarNumeroI
inc dword [j]
inc dword [lim]
mov [contador], dword 1
jmp secuenciar