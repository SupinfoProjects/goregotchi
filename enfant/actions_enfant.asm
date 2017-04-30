action_du_joueur2 PROC
    PUSH AX                                             ;=====================================;    
    PUSH BX                                             ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX                                             ;=====================================;
    PUSH DX

        CALL verif_valeur_joie2
        
		;         debut de la demande de saisie
		;-----------------------------------------------
    demande3:     
        CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
	    CALL verif_valeur_grandir
        CALL depuis_quand_faim_e                        ;on verifie si cela fait plus d'une minute que goregotchi n'a pas mange           
        CALL depuis_quand_jeu_e                         ;on verifie si cela fait plus d'une minute que goregotchi n'a pas joue
        affiche_footer_info                             ;on affiche le footer d'informations car si goregotchi s'ennuyait il a ete efface
        CALL animation2                                 ;on fait bouger goregotchi de gauche a droite
        CALL recupere_touche                            ;on verifier que le joueur a presse une touche
        
        
        ;           premiere comparaison
        ;-----------------------------------------------
        CMP action,106d                                 ;on compare la variable action au code ascii de j 
		JZ divertir2                                    ;Si les caracteres sont egaux on va au label divertir2

        ;           deuxieme comparaison
        ;-----------------------------------------------
        CMP action,112d                                 ;on compare la variable action au code ascii de p                                  
		JZ punition2                                    ;Si les caracteres sont egaux on va au label punition2	
		
		;           troisieme comparaison
        ;-----------------------------------------------
        CMP action,109d                                 ;on compare la variable action au code ascii de m
		JZ nourrir2                                     ;Si les caracteres sont egaux on va au label nourrir2
             
        ;           quatrieme comparaison
        ;-----------------------------------------------
        CMP action,113d                                 ;on compare la variable action au code ascii de m
		JZ arreter2                                     ;Si les caracteres sont egaux on va au label arreter2
		
		
		JMP demande3                                    ;si apres les quatres comparaisons, il n'y a aucune correspondance, on va au label demande afin de reverifier si le joueur a presse une touche
	    
	    
	    ;           le joueur veut joueur
        ;-----------------------------------------------
    divertir2:
        CALL jeu_enfant                                 ;on appelle la procedure jeu_enfant pour jouer avec goregotchi
        CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
        CALL verif_valeur_grandir                       ;on verifie la valeur de grandir pour savoir s'il faut passer a l'age suivant
        CALL depuis_quand_faim_e                        ;on appelle la procedure depuis_quand_faim pour modifier la valeur de faim si cela fait plus de 1min que goregotchi n'a pas mange
        CALL initialise_jeu                             ;on met a jour les variable h_jeu, min_jeu et sec_jeu car on vient de jouer
        JMP fin_action2                                 ;une fois que l'on a jouer on va au label fin_action
		
		;          le joueur veut punir
        ;-----------------------------------------------
    punition2:
        CALL depuis_quand_faim_e                        ;on appelle la procedure depuis_quand_faim pour modifier la valeur de faim si cela fait plus de 1min que goregotchi n'a pas mange
        CALL punition_injuste_e                         ;on appelle la procedure punition_injuste_e pour punir goregotchi injustement
        CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
        CALL verif_valeur_grandir                       ;on verifie la valeur de grandir pour savoir s'il faut passer a l'age suivant
        CALL depuis_quand_faim_e                        ;on appelle la procedure depuis_quand pour modifier la valeur de faim si cela fait plus de 1min que goregotchi n'a pas mange
        CALL depuis_quand_jeu_e                         ;on verifie si cela fait plus d'une minute que goregotchi n'a pas joue
        JMP fin_action2                                 ;une fois que l'on a puni on va au label fin_action
        
        ;          le joueur veut nourrir
        ;-----------------------------------------------
    nourrir2:
        CALL nourrir_enfant
        CALL initialise_faim                            ;on remet a jour les variable h_faim, min_faim et sec_faim car on vient de manger
        CALL verif_valeur_joie2                         ;on appelle la procedure verif_valeur_joie pour actualiser l'humeur en cours
        CALL verif_valeur_faim2                         ;on appelle la procedure verif_valeur_faim pour afficher eventuellement goregotchi affame
        CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
        CALL verif_valeur_grandir                       ;on verifie la valeur de grandir pour savoir s'il faut passer a l'age suivant
        CALL depuis_quand_jeu_e                         ;on verifie si cela fait plus d'une minute que goregotchi n'a pas joue
        JMP fin_action2                                 ;une fois que l'on a nourri on va au label fin_action
        
     arreter2:
        CALL CLEAR_SCREEN                               ;on efface l'ecran entierement
	    CALL termine                                    ;on affiche l'ecran de fin de jeu
        JMP fin_de_jeu                                  ;on va au label fin_de_jeu du main pour arreter le programme   
    
    fin_action2:        
        POP DX                                          ;==========================;        
        POP CX                                          ;RESTAURATION DES REGISTRES;
        POP BX                                          ;==========================;
        POP AX
        RET   

action_du_joueur2 ENDP   