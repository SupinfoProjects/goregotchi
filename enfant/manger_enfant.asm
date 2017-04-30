;====================================================================================;
;|      ICI SE TROUVE TOUTES LES PROCEDURES NECESSAIRE POUR FAIRE LE BEBE MANGER    ;|
;|      ------------------------------------------------------------------------    ;|
;|                                                                                  ;|
;| * nourrir_bebe() : permet au joueur de faire un choix entre un snack et un vrai  ;|
;|                    repas                                                         ;|
;|                                                                                  ;|
;| * cerise() : permet d'afficher le bebe mangeant une cerise,la cerise constitue   ;|
;|              le snack                                                            ;|
;|                                                                                  ;|
;| * riz() : permet d'afficher le bebe mangeant une gamelle de "riz"                ;|
;|                                                                                  ;|
;====================================================================================;
   


nourrir_enfant PROC
    efface_footer                                   ;on efface le footer d'informations
    CALL verif_moment_enfant                        ;on verifie si goregotchi doit tirer la langue ou pas
	
	CMP discipline,20d
	JBE verif_refus2 
	JMP va_manger
	
	verif_refus2:
	    CALL random
	    CMP refus,0
	    JZ pas_de_plat
	    JMP va_manger
	    
	    pas_de_plat:
	        CALL enfant_refuse_manger
	        CALL affiche_refus_manger
	        CALL trois_secondes
	        CALL efface_refus_manger
	        JMP fin_ne
	
	va_manger:
	affiche_footer_nourrir
	
	CALL verif_valeur_joie2                         ;on appelle la procedure verif_valeur_joie pour modifier la variable sprite    
	
	demande4:
	    CALL verif_heure_en_cours                   ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
	    CALL verif_valeur_grandir                   ;on verifie la valeur de grandir
	    CALL depuis_quand_faim_e                    ;on verifie si cela fait plus d'une minute que goregotchi n'a pas mange 
	    CALL depuis_quand_jeu_e
	    affiche_footer_nourrir
	    CALL animation2                             ;on appelle la procedure animation pour faire bouger goregotchi de gauche a droite
	    CALL recupere_touche                        ;on appelle la procedure recupere_touche pour affecter a la variable action le code ascii de la touche presse
	    		
    
    ;           premiere comparaison
    ;-----------------------------------------------
    CMP action,115d                                 ;on compare la variable action au code ascii de s
	JZ grignottage
	             
	             
    ;           deuxieme comparaison
    ;-----------------------------------------------
    CMP action,114d                                 ;on compare la variable action au code ascii de r
	JZ mange_repas                                  ;Si les chaines sont egales alors ZF=0 et on va au label punition	
	
	
	;           troisieme comparaison
    ;-----------------------------------------------
    CMP action,113d                                 ;on compare la variable action au code ascii de q
	JZ   fin_ne                                     ;Si les chaines sont egales on va au label fin_nourrir
	
	                                                
	JMP demande4                                    ;et on redemande de saisir a nouveau
	
	grignottage: 
		;faim >= 10 ?
        ;----------------------------------------
	    CMP faim,10d
	    JA snack_e                                  ;si faim > 10 goregotchi ne refusera pas de manger
	    efface_footer                               ;on efface le footer d'informations
	    CALL enfant_refuse_manger                   ;sinon faim <= 5 donc on appelle la procedure pour afficher goregotchi refusant de manger
        CALL refus_manger_texte
	    CALL verif_valeur_joie2                     ;on actualise l'humeur de goregotchi pour lui remettre un visage avec l'humeur en cours
	    JMP fin_ne                                  ;on va au label fin_ne
	 
	 snack_e:
	    CALL cerise                                 ;on appelle la procedure cerise pour que goregotchi mange son snack  
        CALL remplace_bouche_enfant                 ;on reaffiche la bouche normale de goregotchi                   
        ;faim = faim - 5
        ;----------------------------------------
        SUB faim,5d                                 ;on soustrait 5 a faim
        CALL verif_valeur_faim2                     ;on verifie la valeur de faim avant de l'afficher avec eventuellement goregotchi affame
        CALL affiche_faim                           ;on affiche la valeur de faim 
        CALL ajustement_fe                          ;on ajutes l'affichage de la jauge de faim
        ;joie = joie + 5
        ;----------------------------------------
        ADD joie,5d                                 ;on ajoute 5 a joie
        CALL verif_valeur_joie2                     ;on verifie la valeur de joie avant de l'afficher et on actualise l'humeur de goregotchi
        CALL affiche_joie                           ;on affiche la valeur de joie
        CALL ajustement_je                          ;on ajuste l'affichage de la jauge de joie
	    JMP fin_ne                                  ;on va au label fin_ne
	    
	mange_repas:
		;faim <= 10 ?
        ;----------------------------------------
	    CMP faim,10d                                ;on compare faim a 10
	    JA repas_e                                  ;si faim > 10 goregotchi ne refusera pas de manger
	    efface_footer                               ;on efface le footer d'informations
	    CALL enfant_refuse_manger                   ;sinon faim <= 5 donc on appelle la procedure pour afficher goregotchi refusant de manger
	    CALL trois_secondes                         ;on attend 3 seocndes
	    JMP fin_ne                                  ;on va au label fin_ne
	 

	  repas_e:  
	    CALL riz                                    ;on appelle la procedure riz pour que goregotchi mange son repas
	    CALL remplace_bouche_enfant                 ;on reaffiche la bouche normale de goregotchi                   
	    ;faim = faim - 10
        ;----------------------------------------
        SUB faim,10d                                ;on soustrait 10 a faim
        CALL verif_valeur_faim2                     ;on verifie la valeur de faim avant de l'afficher avec eventuellement goregotchi affame
        CALL affiche_faim                           ;on affiche la valeur de faim
        CALL ajustement_fe                          ;on ajuste l'affichage de la jauge de faim    
	fin_ne:
	    RET
		   
nourrir_enfant ENDP


enfant_refuse_manger PROC 
    MOV sprite,OFFSET enfant_refuse                 ;=============================================;
    affectexy 22,9                                  ;ON AFFICHE L'IMAGE DU BEBE REFUSANT DE MANGER;
    affiche_sprite sprite,largeur_enfant,12         ;=============================================; 
    RET 
enfant_refuse_manger ENDP


reaction_danger2 PROC 
    GOTOXY 66,20                                    ;on positionne le curseur
    MOV DX,2                                        ;on definie le nombre de caractere que l'on veut entrer
    LEA DI,action                                   ;on charge l'adresse de la variable action dans DI afin que la chaine saisie par le joueur soit affecte a cette variable
    CALL GET_STRING   
        
    ;           premiere comparaison
    ;-----------------------------------------------
                                            		;ici on va comparer si la chaine saisie par l'utilisateur est egale a "s" avec l'instruction CMPSB qui compare des bytes entre les adresses DS:SI et ES:DI
	MOV AX,DS                                       ;on place DS dans AX car on ne peut pas faire directement MOV ES,DS 
	MOV ES,AX                                       ;ici ES = DS
	LEA SI,action                                   ;DS:SI = adresse de la variable saisie
	LEA DI,snack                                    ;ES:DI = adresse de la variable snack
	
	MOV CX,1                                        ;on place dans CX le nombre de caracteres a comparer
	REPE CMPSB                                      ;on compare les chaines byte a byte
	JZ grignotte3
	
    ;           deuxieme comparaison
    ;-----------------------------------------------
                                            		;ici on va comparer si la chaine saisie par l'utilisateur est egale a "r" avec l'instruction CMPSB qui compare des bytes entre les adresses DS:SI et ES:DI
	MOV AX,DS                                       ;on place DS dans AX car on ne peut pas faire directement MOV ES,DS 
	MOV ES,AX                                       ;ici ES = DS
	LEA SI,action                                   ;DS:SI = adresse de la variable saisie
	LEA DI,repas                                    ;ES:DI = adresse de la variable repas
	
	MOV  CX,1                                       ;on place dans CX le nombre de caracteres a comparer
	REPE CMPSB                                      ;on compare les chaines byte a byte
	JZ mange3                                       ;Si les chaines sont egales alors ZF=0 et on va au label punition	
	
	;sinon le joueur veut qu'il meurt 
	;-----------------------------------------------                                                
	CALL CLEAR_SCREEN                               
	CALL mort
	CALL trois_secondes
	CALL trois_secondes
	CALL CLEAR_SCREEN
	CALL termine 
	JMP fin_de_jeu
    
    
    grignotte3:
        GOTOXY 43,12
        PRINT "  "                                      ;on efface "()" de la bouche
        CALL cerise
        CALL remplace_bouche_enfant
        
        ;on efface le sprite danger
        CALL efface_danger
        
        CALL initialise_faim                            ;on remet a jour les variable h_faim, min_faim et sec_faim car on vient de manger
        
        SUB faim,5d                                     ;on soustrait a faim 5
        CALL affiche_faim                               ;on affiche la valeur de faim
        CALL ajustement_fe                              ;on ajutse l'affichage de la jauge de faim
        
        ADD joie,5d                                     ;on ajoute 5 a joie
        CALL affiche_joie                               ;on affiche la valeur de joie
        CALL ajustement_je                              ;on ajuste l'affichage de la jauge 
        CALL verif_valeur_joie2                         ;on reaffecte la variable sprite et on actualise l'humeur du bebe
        JMP fin_react2
        
    mange3:
        GOTOXY 43,12
        PRINT "  "                                      ;on efface "()" de la bouche
        CALL riz
        CALL remplace_bouche_enfant            
        
        CALL initialise_faim                            ;on remet a jour les variable h_faim, min_faim et sec_faim car on vient de manger
        
        ;on efface le sprite danger
        CALL efface_danger 
        
        SUB faim,10d                                    ;on soustrait a faim 5
        CALL affiche_faim                               ;on affiche la valeur de faim
        CALL ajustement_fe                              ;on ajutse l'affichage de la jauge de faim
        CALL verif_valeur_joie2                         ;on reaffecte la variable sprite et on actualise l'humeur du bebe
    
    fin_react2: 
        RET
reaction_danger2 ENDP