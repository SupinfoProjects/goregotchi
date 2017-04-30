random PROC
    PUSH AX             ;=====================================;
    PUSH BX             ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX             ;=====================================;
    PUSH DX
    
    MOV AH, 2Ch
    INT 21h             ;on recupere l'heure du systeme
    MOV DH, 0           ;on met DH a 0 pour que DX = DH + DL soit DX = DL
    MOV AX, DX          ;on place les 1/100eme en cours dans AX (les 1/100 sont stocke dans DL)        
    MOV BL, 2d          ;on place l'operande dans BL
    DIV BL              ;on divise AX par BL donc par 2    
    MOV aleatoire, AH   ;on place le reste dans la variable aleatoire
    MOV refus,AH        ;on place le reste dans la variable refus 
    
    POP DX              ;==========================;
    POP CX              ;RESTAURATION DES REGISTRES;
    POP BX              ;==========================;
    POP AX
    RET
random ENDP     
