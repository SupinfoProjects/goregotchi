;====================================================================================;
;|          ICI CE TROUVE TOUTES LES PROCEDURES POUR PUNIR LE BEBE                  ;|
;|          ------------------------------------------------------                  ;|
;|                                                                                  ;|
;| * punition_juste() : permet de punir le bebe et de modifier la valeur des        ;|
;|                      variables discipline et joie                                ;|
;|                                                                                  ;|
;| * punition_injuste() : permet de punir le bebe et de modifier la valeur des      ;|
;|                        variables discipline et joie                              ;|
;|                                                                                  ;|
;| * coin() : permet d'afficher le coin                                             ;|
;|                                                                                  ;|
;| * bebe_au_coin() : permet  d'afficher le bebe au coin                            ;|
;|                                                                                  ;|
;| * efface_bebe_heureux() : permet d'effacer le bebe heureux                       ;|
;|                                                                                  ;|
;| * efface_bebe_au_coin() : permet d'effacer le bebe au coin                       ;|
;|                                                                                  ;|
;| * efface_coin() : permet d'effacer le coin                                       ;|
;|                                                                                  ;|
;====================================================================================;

punition_juste PROC
    
    CALL punir_proc 
    ;joie >= 5 ?
    ;-------------------------------
    CMP joie,5d                     ;on compare joie a 5
    JAE cinq_j                      ;si joie >= 5 on va au label cinq_j
    
    ;joie < 5 
    ;-------------------------------
    MOV joie,0                      ;on ramene joie a 0 car on aurait du lui soustraire 5
    JMP suivant
    
    cinq_j:
        ;joie = joie - 5
        ;---------------------------
        SUB joie,5d                 ;on soustrait 5 a joie               
    
    suivant:
        CALL verif_valeur_joie          ;on affiche l'humeur du bebe en fonction de la valeur de joie
        CALL affiche_joie               ;on affiche la valeur de la variable joie  
        CALL ajustement_jb
        
        ;discipline = discipline + 5
        ;--------------------------- 
        ADD discipline,5d               ;on ajoute 5 a discipline
        CALL verif_valeur_dis           ;on verifie la valeur de discipline pour modifier la variable seconde avant d'afficher discipline
        CALL affiche_discipline         ;on affiche la valeur de discipline
        CALL ajustement_db
        RET 
punition_juste ENDP 

punition_injuste PROC 
    
    CALL punir_proc
    ;joie >= 10 ?
    ;-----------------------------------
    CMP joie,10d                        ;on compare joie a 10
    JAE dix_j                           ;si joie >= 10 on va au label dix_j  
    
    ;joie < 10
    ;----------
    MOV joie,0                          ;on ramene la variable joie a 0 car on aurait du lui soustraire 10
    JMP suivant2
        
    dix_j:
        ;joie = joie - 10
        ;-------------------------------
        SUB joie,10d

    suivant2:
        CALL verif_valeur_joie          ;on affiche l'humeur du bebe en fonction de la valeur de joie                        
        CALL affiche_joie               ;on affiche la valeur de joie
        CALL ajustement_jb              ;on ajuste l'affichage de la jauge de joie
        
        ;discipline >= 5
        ;-------------------------------
        CMP discipline,5d               ;on compare discipline a 5
        JAE suivant3                    ;si joie >=5 on va au label suivant3
        ;discipline < 5
        MOV discipline,0                ;on ramene discipline a 0 car on aurait du lui soustraire 5
        JMP suivant4                    ;si discpline < 5 c'est que discipline = 0 donc on va diretement 
        
        ;discipline = discipline - 5 
        ;----------------------------
        suivant3:
            SUB discipline,5d   
        
        suivant4:
        CALL verif_valeur_dis           ;on verifie la valeur de discipline avant d'afficher
        CALL affiche_discipline         ;on affiche la valeur de discipline
        CALL ajustement_db              ;on ajuste l'affichage de la jauge de discipline
        RET 
punition_injuste ENDP

punir_proc PROC
    MOV sprite,OFFSET bebe_triste
    affiche_bebe                        ;on affiche le bebe triste                   
    efface_footer                       ;on efface le footer d'informations
    CALL trois_secondes                 ;on attend trois secondes
    CALL coin                           ;on affiche le coin ou le bebe sera puni
    CALL efface_bebe                    ;on efface l'image du bebe heureux
    CALL bebe_au_coin                   ;on affiche le bebe dans le coin
    CALL attente                        ;on attend la minute suivante avant de le sortir du coin
    CALL efface_bebe_au_coin            ;on efface le bebe au coin
    CALL verif_valeur_joie              ;on actualise l'humeur de goregotchi
    CALL efface_coin                    ;on efface le coin
    RET
punir_proc ENDP


coin PROC
    affectexy 0,9                           ;on modifie les variables position_x et position_y
    MOV sprite,OFFSET coin_sprite1          ;on place dans la variable sprite l'adresse de l'asciiart d'une partie du coin
    affiche_sprite sprite,largeur_coin,22   ;on affiche la premiere partie du coin
    
    affectexy 0,22                          ;on modifie les variables position_x et position_y
    MOV AH,9                                ;AH=9h/INT 21h permet d'afficher une chaine de caractere, la fin de la chaine est definie par un $
    MOV DX, OFFSET coin_sprite2             ;on place dans DX l'adresse de la chaine de caractere que l'on veut afficher
    CALL deplace_curseur                    ;on place le curseur au position definie precedemment
    INT 21h                                 ;on affiche la chaine de caractere contenu dans DX
    RET
coin ENDP

 
bebe_au_coin PROC
    affectexy 6,11                          ;on modifie les variables position_x et position_y
    MOV sprite,OFFSET bebe_fache            ;on place dans la variable sprite l'adresse de l'asciiart du bebe fache
    affiche_sprite sprite,largeur_bebe,21   ;on affiche le bebe fache au coin        
    RET                    
bebe_au_coin ENDP  
 
 
 
efface_bebe PROC
    affectexy 25,4                          ;on modifie les variables position_x et position_y
    MOV sprite,OFFSET efface_bebe_sprite    ;on place dans la variable sprite l'adresse de l'asciiart qui permet d'effacer le bebe
    affiche_sprite sprite,largeur_bebe,14   ;on efface le bebe 
    RET                   
efface_bebe ENDP   
 
 
 
efface_bebe_au_coin PROC
    affectexy 6,11                          ;on modifie les variables position_x et position_y
    MOV sprite,OFFSET efface_bebe_sprite    ;on place dans la variable sprite l'adresse de l'asciiart qui permet d'effacer le bebe au coin
    affiche_sprite sprite,largeur_bebe,21   ;on efface le bebe au coin   
    RET        
efface_bebe_au_coin ENDP
 
 
 
efface_coin PROC
    affectexy 0,9                           ;on modifie les variables position_x et position_y
    MOV sprite,OFFSET efface_coin_sprite1   ;on place dans la variable sprite l'adresse de l'asciiart qui permet d'effacer le coin
    affiche_sprite sprite,largeur_coin,22   ;on efface le coin
    MOV AH,9                                ;AH=9h/INT 21h permet d'afficher une chaine de caractere, la fin de la chaine est definie par un $
    MOV DX, OFFSET efface_coin_sprite2      ;on place dans DX l'adresse de la chaine de caractere que l'on veut afficher
    CALL deplace_curseur                    ;on place le curseur au position definie precedemment
    INT 21h                                 ;on affiche la chaine de caractere contenu dans DX
    RET
efface_coin ENDP