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

depuis_quand_faim_e PROC
    PUSH AX                             ;=====================================;
    PUSH BX                             ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX                             ;=====================================;
    
    MOV AH,2Ch
    INT 21h                             ;on recupere le temps du systeme
    
    CMP h_faim,CH                       ;on compare les heures en cours avec h_faim
    JZ heure_egale_e                    ;si les heures sont egales on va au label heure egale 
    JMP fin_dqf_e                       ;sinon on va au label fin_dq car ce n'est meme pas la peine verifier les minutes
    
    heure_egale_e:
        CMP min_faim,CL                 ;on compare la valeur de min_faim avec les minutes en cours
        JZ min_egale_e                  ;si min_faim et les minutes en cours sont egale on va au label min_egale
        JMP fin_dqf_e                   ;sinon ce n'est pas la peine de verifier les secondes
        
        min_egale_e:
            CMP sec_faim,DH             ;on compare la valeur de sec_faim avec les secondes en cours
            JB gain_faim_e              ;si la valeur de sec_faim est plus petite que les secondes en cours on va au label gain_faim
            JMP fin_dqf_e               ;sinon on va au label fin_dq car il n'y aura pas de gain de points de faim
            
            gain_faim_e:
                ADD faim,5              ;on ajoute 5 a la variable faim
                CALL verif_valeur_faim2 ;on verifie la valeur de faim pour eventuellement afficher goregotchi affame
                CALL affiche_faim       ;on affiche la valeur de la variable faim
                CALL ajustement_fe      ;on ajuste l'affichage de la jauge de faim    
                CALL initialise_faim    ;on met a jour les variables h_faim, min_faim et sec_faim
                       
    fin_dqf_e:        
        POP CX                          ;==========================;
        POP BX                          ;RESTAURATION DES REGISTRES;
        POP AX                          ;==========================;        
        RET 
depuis_quand_faim_e ENDP    


depuis_quand_jeu_e PROC
    PUSH AX                             ;=====================================;
    PUSH BX                             ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX                             ;=====================================;
    
    MOV AH,2Ch
    INT 21h                             ;on recupere le temps du systeme
    
    CMP h_jeu,CH                        ;on compare les heures en cours avec h_jeu
    JZ heure_egale2_e                   ;si les heures sont egales on va au label heure egale 
    JMP fin_dqj_e                       ;sinon on va au label fin_dq car ce n'est meme pas la peine verifier les minutes
    
    heure_egale2_e:
        CMP min_jeu,CL                  ;on compare la valeur de min_jeu avec les minutes en cours
        JZ min_egale2_e                 ;si min_faim et les minutes en cours sont egale on va au label min_egale
        JMP fin_dqj_e                   ;sinon ce n'est pas la peine de verifier les secondes
        
        min_egale2_e:
            CMP sec_jeu,DH              ;on compare la valeur de sec_faim avec les secondes en cours
            JB alerte_jeu_e             ;si la valeur de sec_faim est plus petite que les secondes en cours on va au label gain_faim
            JMP fin_dqj_e               ;sinon on va au label fin_dq car il n'y aura pas de gain de points de faim
            
            alerte_jeu_e:
                CALL alerte_joueur_e    ;on appelle la procedure alerter_joueur pour prevenir que goregotchi s'ennuie
                CALL initialise_jeu     ;on met a jour les variables h_jeu, min_jeu et sec_jeu pour que l'alerte s'affiche dans 1min si goregotchi ne joue pas             
    fin_dqj_e:        
        POP CX                          ;==========================;
        POP BX                          ;RESTAURATION DES REGISTRES;
        POP AX                          ;==========================;        
        RET 
depuis_quand_jeu_e ENDP


alerte_joueur_e PROC
    PUSH CX
    
    efface_footer
    
    MOV sprite,OFFSET enfant_ennuye             ;on place l'adresse de l'asciiart enfant_ennuye dans la variable sprite
    affiche_enfant                              ;on affiche l'enfant ennuye
    
    CALL affiche_alerte
    
    CALL verif_valeur_joie2                    ;on actualise l'humeur de goregotchi 
    POP CX
    RET
    
alerte_joueur_e ENDP