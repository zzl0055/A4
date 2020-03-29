;author: Zehao Luo
;date: 11/15/2019
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

	s1 byte"GARDEN"
	s2 byte"DANGER"
	c1 byte 26 dup(0) 
	c2 byte 26 dup(0)  
.code
	main proc
		mov eax,0               
		mov esi, 0              
		mov ecx, lengthof s1    
		CounterLoop:             
			movzx edi, s1[esi]   
			sub edi, 65		     
			inc c1[edi]			
			movzx edi, s2[esi]	 
			sub edi, 65			 
			inc c2[edi]
			inc esi				 
		loop CounterLoop         
		mov esi, 0				 
		mov ecx, lengthof c1	 
		VerifyLoop:
			mov bl, c1[esi]		 
			mov dl, c2[esi]	     
			cmp	bl, dl			
			jne	NoAna			 
			inc esi              
		loop VerifyLoop
		mov eax, 1				
		NoAna:
		invoke ExitProcess,0
	main endp
end main