
affiche_discipline PROC
    PUSH BX
    
    ;comparaison pour discipline
    ;-----------------------------------
    MOV BX,10d                          ;on place 10 dans BX
    CMP discipline,BX                   ;on compare discipline a 10
    JL chiffre1                         ;si discipline est plus petit que 10 on va au label chiffre1
                                        ;sinon discipline est superieur ou egale a 10 
    GOTOXY 74,0                         ;on place le curseur a la 1ere ligne au caractere 77 c'est a dire a l'endroit ou l'on va afficher la valeur de la jauge                     
    MOV AX,0                            ;on place 0 dans AX pour etre sur qu'il ne contient que la valeur de discipline
    MOV AX, discipline                  ;on place dans AX la valeur de la variable discipline
    CALL PRINT_NUM_UNS                  ;on appelle la procedure qui permet d'afficher le contenu de AX a l'ecran a l'endroit ou on a place le curseur
    JMP fin_d
    
    
    ; discipline < 10
    ;-----------------------------------
    chiffre1:
        GOTOXY 74,0                     ;on se place la ou on affiche le 1er chiffre de la valeur de discipline
        MOV AX,0                        ;on place 0 dans AX pour etre sur qu'il ne contient que la valeur de discipline
        MOV AX,discipline               ;on place la valeur de discipline dans AX
        CALL PRINT_NUM_UNS              ;on affiche la valeur de discipline qui n'est compose que d'un chiffre
        PRINT " "                       ;on efface le premier chiffre de l'ancienne valeur de discipline
                              
     fin_d:
        POP BX
        RET 
affiche_discipline ENDP



affiche_joie PROC
    PUSH BX
    ;comparaison pour joie
    ;-----------------------------------
    CMP joie,BX                         ;on compare joie a 10
    JL chiffre2                         ;si joie est plus petit que 10 on va au label chiffre2
                                        ;sinon joie est superieur ou egale a 10
    GOTOXY 74,1                         ;on place le curseur a la deuxieme ligne au caractere 77 c'est a dire a l'endroit ou l'on va afficher la valeur de la jauge
    MOV AX,0                            ;on place 0 dans AX pour etre sur qu'il ne contient que la valeur de joie
    MOV AX, joie                        ;on place dans AX la valeur de la variable joie            
    CALL PRINT_NUM_UNS                  ;on appelle la procedure qui permet d'afficher le contenu de AX a l'ecran a l'endroit ou on a place le curseur
    JMP fin_j
    
    ; joie < 10
    ;-----------------------------------
    chiffre2:
        GOTOXY 74,1                     ;on se place la ou on affiche le 1er chiffre de la valeur de joie
        MOV AX,0                        ;on place 0 dans AX pour etre sur qu'il ne contient que la valeur de joie
        MOV AX,joie                     ;on place la valeur de joie dans AX
        CALL PRINT_NUM_UNS              ;on affiche la valeur de joie qui n'est compose que d'un chiffre
        PRINT " "                       ;on efface le premier chiffre de l'ancienne valeur de joie
    
    fin_j:
        GOTOXY 76,1
        PRINT "/40"
        POP BX
        RET 
    
affiche_joie ENDP



affiche_faim PROC
     PUSH BX
    ;comparaison pour faim
    ;-----------------------------------
    CMP faim,BX                         ;on compare faim a 10
    JL chiffre3                         ;si faim est plus petit que 10 on va au label chiffre3
                                        ;sinon faim est superieur ou egale a 10
    GOTOXY 74,2                         ;on place le curseur a la troisieme ligne au caractere 77 c'est a dire a l'endroit ou l'on va afficher la valeur de la jauge
    MOV AX,0                            ;on place 0 dans AX pour etre sur qu'il ne contient que la valeur de faim
    MOV AX, faim                        ;on place dans AX la valeur de la variable colere
    CALL PRINT_NUM_UNS                  ;on appelle la procedure qui permet d'afficher le contenu de AX a l'ecran a l'endroit ou on a place le curseur 
    JMP fin_f
    
    ; faim < 10
    ;-----------------------------------    
    chiffre3:
        GOTOXY 74,2                     ;on se place la ou on affiche le 1er chiffre de la valeur de faim
        MOV AX,0                        ;on place 0 dans AX pour etre sur qu'il ne contient que la valeur de faim
        MOV AX,faim                     ;on place la valeur de faim dans AX
        CALL PRINT_NUM_UNS              ;on affiche la valeur de faim qui n'est compose que d'un chiffre
        PRINT " "                       ;on efface le premier chiffre de l'ancienne valeur de faim
    
    fin_f:
        POP BX
        RET     
    
affiche_faim ENDP



deplace_curseur PROC
    PUSH AX                     ;===================================;
    PUSH BX                     ;SAUVEGARDE DES DIFFERENTS REGISTRES;
    PUSH DX                     ;===================================;
    
    MOV AH,2h                   ;on place 2h dans AH
    MOV DH,position_y           ;DH indique le numero de la ligne donc on lui affecte la valeur de position_y
    MOV DL,position_x           ;DL indique le numero de la colonne donc on lui affecte la valeur de position_x
    MOV BH,0                    ;on place dans BH le numero de la page (0 pour la premiere)
    INT 10h                     ;on positionne le curseur
    
    
    POP DX                      ;=====================================;
    POP BX                      ;RESTAURATION DES DIFFERENTS REGISTRES;
    POP AX                      ;=====================================;
    RET
deplace_curseur ENDP        



recupere_touche PROC     
    MOV AH,01h
    INT 16h
    
    MOV action,AL
    MOV AH,6
    MOV DL,255
    INT 21h
    RET    
recupere_touche ENDP 
