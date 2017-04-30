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
;| * alerte_joueur() : permet d'informer le joueur que goregotchi s'ennuie                              ;|
;|                                                                                                      ;|
;========================================================================================================;    

depuis_quand_faim PROC
    PUSH AX                             ;=====================================;
    PUSH BX                             ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX                             ;=====================================;
    
    MOV AH,2Ch
    INT 21h                             ;on recupere le temps du systeme
    
    CMP h_faim,CH                       ;on compare les heures en cours avec h_faim
    JZ heure_egale                      ;si les heures sont egales on va au label heure egale 
    JMP fin_dqf                         ;sinon on va au label fin_dq car ce n'est meme pas la peine verifier les minutes
    
    heure_egale:
        CMP min_faim,CL                 ;on compare la valeur de min_faim avec les minutes en cours
        JZ min_egale                    ;si min_faim et les minutes en cours sont egale on va au label min_egale
        JMP fin_dqf                      ;sinon ce n'est pas la peine de verifier les secondes
        
        min_egale:
            CMP sec_faim,DH             ;on compare la valeur de sec_faim avec les secondes en cours
            JB gain_faim                ;si la valeur de sec_faim est plus petite que les secondes en cours on va au label gain_faim
            JMP fin_dqf                 ;sinon on va au label fin_dq car il n'y aura pas de gain de points de faim
            
            gain_faim:
                ADD faim,5              ;on ajoute 5 a la variable faim
                CALL verif_valeur_faim  ;on verifie la valeur de faim pour eventuellement afficher goregotchi affame
                CALL affiche_faim       ;on affiche la valeur de la variable faim
                CALL ajustement_fb      ;on ajuste l'affichage de la jauge de faim    
                CALL initialise_faim    ;on met a jour les variables h_faim, min_faim et sec_faim
                       
    fin_dqf:        
        POP CX                          ;==========================;
        POP BX                          ;RESTAURATION DES REGISTRES;
        POP AX                          ;==========================;        
        RET 
depuis_quand_faim ENDP    


depuis_quand_jeu PROC
    PUSH AX                             ;=====================================;
    PUSH BX                             ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX                             ;=====================================;
    
    MOV AH,2Ch
    INT 21h                             ;on recupere le temps du systeme
    
    CMP h_jeu,CH                        ;on compare les heures en cours avec h_jeu
    JZ heure_egale2                     ;si les heures sont egales on va au label heure egale 
    JMP fin_dqj                         ;sinon on va au label fin_dq car ce n'est meme pas la peine verifier les minutes
    
    heure_egale2:
        CMP min_jeu,CL                  ;on compare la valeur de min_jeu avec les minutes en cours
        JZ min_egale2                   ;si min_faim et les minutes en cours sont egale on va au label min_egale
        JMP fin_dqj                     ;sinon ce n'est pas la peine de verifier les secondes
        
        min_egale2:
            CMP sec_jeu,DH              ;on compare la valeur de sec_faim avec les secondes en cours
            JB alerte_jeu               ;si la valeur de sec_faim est plus petite que les secondes en cours on va au label gain_faim
            JMP fin_dqj                 ;sinon on va au label fin_dq car il n'y aura pas de gain de points de faim
            
            alerte_jeu:
                CALL alerte_joueur      ;on appelle la procedure alerter_joueur pour prevenir que goregotchi s'ennuie
                CALL initialise_jeu     ;on met a jour les variables h_jeu, min_jeu et sec_jeu pour que l'alerte s'affiche dans 1min si goregotchi ne joue pas             
    fin_dqj:        
        POP CX                          ;==========================;
        POP BX                          ;RESTAURATION DES REGISTRES;
        POP AX                          ;==========================;        
        RET 
depuis_quand_jeu ENDP


alerte_joueur PROC
    PUSH CX
    
    efface_footer
    
    MOV sprite,OFFSET bebe_ennuye               ;on place l'adresse de l'asciiart bebe_ennuye dans la variable sprite
    affiche_bebe                                ;on affiche le bebe ennuye
    
    affectexy 10,17                             ;on positionne le curseur
    MOV sprite,OFFSET alerte1                   ;on place l'adresse de l'asciiart alerte1 dans la variable sprite
    affiche_sprite sprite,largeur_alerte,23     ;on affiche l'asciiart alerte1
    
    CALL trois_secondes                         ;on attends 3 secondes
    
    affectexy 10,16                             ;on positionne le curseur
    MOV sprite,OFFSET e_alerte                  ;on place l'adresse de l'asciiart e_alerte dans la variable sprite
    affiche_sprite sprite,largeur_alerte,23     ;on efface le l'asciiart alerte
    
    affectexy 10,16                             ;on positionne le curseur
    MOV sprite,OFFSET alerte2                   ;on place l'adresse de l'asciiart alerte2 dans la variable sprite
    affiche_sprite sprite,largeur_alerte,23     ;on affiche l'asciiart alerte2
     
    CALL trois_secondes                         ;on attends 3 secondes
    
    MOV CX,3                                    ;on place 3 dans CX car on veut repeter la boucle 3 fois
    
    clignotte:
        affectexy 10,16                             ;on positionne le curseur
        MOV sprite,OFFSET e_alerte                  ;on place l'adresse de l'asciiart e_alerte dans la variable sprite
        affiche_sprite sprite,largeur_alerte,23     ;on efface le l'asciiart alerte
        
        affectexy 10,16                             ;on positionne le curseur
        MOV sprite,OFFSET alerte2                   ;on place l'adresse de l'asciiart alerte2 dans la variable sprite
        affiche_sprite sprite,largeur_alerte,23     ;on affiche l'asciiart alerte2
    loop clignotte
    
    affectexy 10,16                             ;on positionne le curseur
    MOV sprite,OFFSET e_alerte                  ;on place l'adresse de l'asciiart e_alerte dans la variable sprite
    affiche_sprite sprite,largeur_alerte,23     ;on efface le l'asciiart alerte
    
    fin_aj:
        CALL verif_valeur_joie                  ;on actualise l'humeur de goregotchi 
        POP CX
        RET
    
alerte_joueur ENDP