;Create an assembly language program to verify key in value is digit or character (e.g., 2 is digit / a is character

;equ directive
SYS_EXIT equ 1
SYS_WRITE equ 4
SYS_READ equ 3
STDIN equ 0
STDOUT equ 1
STDERR equ 2

;data segmant
section .data   
        msg1 db 'Please type a digit or a charcter: '   ;Ask user to enter a digit or character
        lenMsg1 equ $-msg1                              ;The length of msg1
        isDigit db ' is digit ',0xA,0xD                 ;Message to print if input is digit
        lenIsDigit equ $-isDigit                        ;The length of isDigit
        isChar db ' is a character ',0xA,0xD                 ;Message to print if input is char
        lenIsChar equ $-isChar                          ;The length of isChar

section .bss                                            ;uninitialized data
        userInput resb 1

section .text                                           ;code segmant
        global _start                                   ;must be declared for using gcc

_start:                                                 ;tell linker entry point

        ;Let user input a digit or a character
        mov eax, SYS_WRITE
        mov ebx, STDOUT
        mov ecx,msg1
        mov edx,lenMsg1
        int 0x80

        ;Read and Store user input
        mov eax,SYS_READ
        mov ebx,STDERR
        mov ecx,userInput
        mov edx,1
        int 0x80

        ;Pass the userInput to eax
        mov eax,[userInput]

        ;Compare the userInput
        cmp eax,30h                                     ;Compare if userInput is digit
        jge CDIGIT                                      ;jump greater equal when userInput is 0(30h) or more than 30h

        cmp eax,41h                                     ;Compare if userInput is alphabet and capital letters
        jge CALPHABET                                   ;jump greater equal when userInput is A(41h) or more than 41h

        cmp eax,61h                                     ;Compare if userInput is alphabet and small letters
        jge CALPHABET_SMALL                             ;jump greater equal when userInput is a(61h) or more than 61h

;Secondary compare
CDIGIT:
        cmp eax,39h
        jle PRINTDIGIT

CALPHABET:
        cmp eax,5Ah
        jle PRINTCHAR

CALPHABET_SMALL:
        cmp eax,7Ah
        jle PRINTCHAR

;Print result
PRINTDIGIT:
        mov eax,SYS_WRITE
        mov ebx,STDOUT
        mov ecx,userInput
        mov edx,1
        int 0x80

        mov eax,SYS_WRITE
        mov ebx,STDOUT
        mov ecx,isDigit
        mov edx,lenIsDigit
        int 0x80

        mov eax,1
        int 0x80

PRINTCHAR:
        mov eax,SYS_WRITE
        mov ebx,STDOUT
        mov ecx,userInput
        mov edx,1
        int 0x80

        mov eax,SYS_WRITE
        mov ebx,STDOUT
        mov ecx,isChar
        mov edx,lenIsChar
        int 0x80

        mov eax,1
        int 0x80
