;========================================================================================================;
;|      ICI CE TROUVE LES PROCEDURES QUI PERMETTENT D'AVOIR UNE NOTION DE TEMPS PENDANT LA PARTIE       ;|
;|      -----------------------------------------------------------------------------------------       ;|
;|                                                                                                      ;|
;| * initialise() : permet de modifier les valeurs des variables h_faim, min_faim, et sec_faim.         ;|
;|                  ces variables representent l'heure a laquelle goregotchi a mange pour la derniere   ;|
;|                  fois                                                                                ;|
;|                                                                                                      ;|
;| * depuis_quand() : permet de verifier si cela fait plus d'une minute que goregotchi n'a pas mange    ;|
;|                    en comparant l'heure du systeme avec la valeur des variables h_faim, min_faim et  ;|
;|                    sec_faim                                                                          ;|
;|                                                                                                      ;|
;========================================================================================================;    


initialise_faim PROC
    MOV AH,2Ch              ;quand AH = 2Ch, INT 21h recupere l'heure du systeme
    INT 21h                 ;on recupere le temps du systeme
    MOV h_faim,CH           ;on place les heures en cours dans la variable h_faim
    MOV min_faim,CL         ;on place les minutes en cours dans la variable min_faim
    MOV sec_faim,DH         ;on place les secondes en cours dans la variable sec_faim
    
    CMP CL,58d              ;on compare les minutes en cours a 58
    JBE addition3           ;si les minutes en cours sont plus petites ou egale a 58 on va au label addition3
    
    SUB min_faim,59d        ;sinon on soustrait a min_faim 59 pour que min_faim prenne la valeur des minutes pour lesquelles goregotchi gagne des points de faim (donc a encore plus faim)
    INC h_faim              ;on fait h_faim++ pour que h_faim prenne la valeur des heures pour lesquelles goregotchi gagne des points de faim (donc a encore plus faim)
    JMP fin_initialise_f
    
    addition3:
        ADD min_faim,1      ;on ajoute a min_faim 1 car toutes les deux minutes goregotchi gagne des points de faim (donc a encore plus faim)
    fin_initialise_f:
        RET
initialise_faim ENDP



initialise_jeu PROC
    MOV AH,2Ch             ;quand AH = 2Ch, INT 21h recupere l'heure du systeme
    INT 21h                ;on recupere le temps du systeme
    MOV h_jeu,CH           ;on place les heures en cours dans la variable h_jeu
    MOV min_jeu,CL         ;on place les minutes en cours dans la variable min_jeu
    MOV sec_jeu,DH         ;on place les secondes en cours dans la variable sec_jeu
    
    CMP CL,58d             ;on compare les minutes en cours a 58
    JBE addition4          ;si les minutes en cours sont plus petites ou egale a 58 on va au label addition4
    
    SUB min_jeu,59d        ;sinon on soustrait a min_jeu 59 pour que min_faim prenne la valeur des minutes pour lesquelles goregotchi gagne des points de faim (donc a encore plus faim)
    INC h_jeu              ;on fait h_jeu++ pour que h_jeu prenne la valeur des heures pour lesquelles goregotchi gagne des points de faim (donc a encore plus faim)
    JMP fin_initialise_j
    
    addition4:
        ADD min_jeu,1      ;on ajoute a min_jeu 1 car toutes les deux minutes goregotchi gagne des points de faim (donc a encore plus faim)
    fin_initialise_j:
        RET
initialise_jeu ENDP   
                     
                     
initialise_croissance PROC
    MOV AH,2Ch             ;quand AH = 2Ch, INT 21h recupere l'heure du systeme
    INT 21h                ;on recupere le temps du systeme
    
    MOV h_up,CH
    MOV min_up,CL
    MOV sec_up,DH 
    
    CMP CL,54d
    JBE addition5
    
    SUB min_up,54d
    INC h_jeu
    JMP fin_initialise_c
    
    addition5:
        ADD min_up,6
        
    fin_initialise_c:
        RET
initialise_croissance ENDP