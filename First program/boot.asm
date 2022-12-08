[BITS 16]   ; directives- tells the assembler that it is running in 64 bit mode
[ORG 0x7c00]

start: ;start of the code...initialize segment registers to zero 
    xor ax,ax  ;it zeros ax register and copies the value in ax registers 
    mov ds,ax
    mov es,ax  
    mov ss,ax
    mov sp,e ;stack pointer initializes to memory location 7c00 

PrintMessage:
    mov ah,0x13
    mov al,1
    mov bx,0xa
    xor dx,dx
    mov bp,Message ;holds te adderess of the string 
    mov cx,MessageLen ;specifies no of characters to print
    int 0x10  ; printing characters is done by calling BIOS service so we use interrupt to call it

End:
    hlt    ;puts the processor in halt state and resumed by interrupts
    jmp End
     
Message:    db "Hello"
MessageLen: equ $-Message

times (0x1be-($-$$)) db 0  ;directive times repeats the command for specific time
;$$ beginning of current section
;$ start 
;$$-$ size from the start of the code to the end of the msg
;1be offset has partition entries  
    db 80h ;80h means it is bootable partiton
    db 0,2,0   ;starting CHS value
    db 0f0h  ;partiton type
    db 0ffh,0ffh,0ffh   ;ending CHS value
    dd 1
    dd (20*16*63-1)  ;size(how many sectors does the partion has)
	
    times (16*3) db 0

    db 0x55 ;signature
    db 0xaa

	
