;=====================================================================================;
;|  ICI CE TROUVE TOUTES LES PROCEDURES QUI PERMETTENT D'ATTENDRE PENDANT LA PARTIE  ;|
;|  -------------------------------------------------------------------------------  ;|
;|                                                                                   ;|
;| * attente() : permet d'attendre 20 secondes avant de sortir du coin goregotchi    ;|                                                          
;|                                                                                   ;|
;| * trois_secondes() : permet d'attendre 3 secondes avant de faire autre chose      ;|
;|                      elle est par exemple utilise pour pemettre au joueur de lire ;|
;|                      les messges a l'ecran avant qu'on ne les efface              ;|
;|                                                                                   ;|
;=====================================================================================;
           


attente PROC
   
    MOV AH, 2Ch
    INT 21h                 ;on recupere l'heure du systeme
    
    MOV BH,DH               ;on place les secondes en cours dans BH

    CMP DH,39               ;on compare les secondes en cours a 39
    JBE addition            ;si les secondes en cours sont plus petites ou egales a 39 on va au label addition
    SUB BH,40d              ;sinon on soutrait a BH 40 pour que BH soit egale aux secondes que l'on veut atteindre avant d'arreter la procedure
    JMP verification        ;on va au label verification
    
    addition:
        ADD BH,20d          ;on ajoute 20 a BH donc on ajoute 20 au seconde en cours 
    
    verification:
        INT 21h             ;on recupere a nouveau l'heure du systeme pour mettre a jour DH
        CMP BH,DH           ;on compare les secondes en cours avec BH soit les secondes que l'on veut atteindre et les secondes en cours
    JNE verification        ;tant que les secondes en cours ne sont pas egale aux secondes que l'on veut atteindre on va au label verification 
                             
    RET
        
attente ENDP  


trois_secondes PROC
    MOV AH, 2Ch
    INT 21h                 ;on recupere le l'heure du systeme
    
    MOV BH,DH               ;on place les secondes en cours dans BH
    
    CMP DH,56d              ;on compare DH a 56
    JBE addition2           ;si les secondes en cours sont plus petite ou egale a 56 on va au label addition2
    SUB BH,57d              ;sinon on soustrait a BH 57 pour que BH soit egale aux secondes que l'on veut atteindre avant d'arreter la procedure
    
    addition2:
        ADD BH,3d           ;on ajoute a BH 3 onc on ajoute 3 au seconde en cours
    
    verification2:
        INT 21h             ;on recupere a nouveau l'heure du systeme pour mettre a jour DH
        CMP BH,DH           ;on compare les secondes en cours avec BH soit les secondes que l'on veut atteindre et les secondes en cours
    JNE verification2       ;tant que les secondes en cours ne sont pas egale aux secondes que l'on veut atteindre on va au label verification2
    
    RET         

trois_secondes ENDP