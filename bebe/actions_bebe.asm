;====================================================================================;
;|      ICI CE TROUVE LA PROCEDURE QUI PERMET AU JOUEUR DE RENTRER UNE ACTION       ;|
;|      ---------------------------------------------------------------------       ;|
;|                                                                                  ;|
;| * action_du_joueur() : permet au joueur de saisir un lettre et la compare aux    ;|
;|                        lettres qui correspondent a une action                    ;|
;|                        si aucune lettre ne correspond le joueur saisie a nouveau ;|
;|                        une lettre                                                ;|
;|                                                                                  ;|
;====================================================================================;                                




action_du_joueur PROC
    PUSH AX                                             ;=====================================;    
    PUSH BX                                             ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX                                             ;=====================================;
    PUSH DX

        CALL verif_valeur_joie                          ;on appelle la procedure verif_valeur_joie pour actualiser l'humeur de goregotchi
                                   
		;         debut de la demande de saisie
		;-----------------------------------------------
    demande:
        CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
        CALL depuis_quand_faim                          ;on verifie si cela fait plus d'une minute que goregotchi n'a pas mange           
        CALL depuis_quand_jeu                           ;on verifie si cela fait plus d'une minute que goregotchi n'a pas joue
        affiche_footer_info                             ;on affiche le footer d'informations car si goregotchi s'ennuyait il a ete efface
        CALL animation                                  ;on fait bouger goregotchi de gauche a droite
        CALL recupere_touche                            ;on verifier que le joueur a presse une touche
        
        
        ;           premiere comparaison
        ;-----------------------------------------------
        CMP action,106d                                 ;on compare la variable action au code ascii de j 
		JZ divertir                                     ;Si les caracteres sont egaux on va au label divertir

        ;           deuxieme comparaison
        ;-----------------------------------------------
        CMP action,112d                                 ;on compare la variable action au code ascii de p                                  
		JZ punition                                     ;Si les caracteres sont egaux on va au label punition	
		
		;           troisieme comparaison
        ;-----------------------------------------------
        CMP action,109d                                 ;on compare la variable action au code ascii de m
		JZ nourrir                                      ;Si les caracteres sont egaux on va au label nourrir
             
        ;           quatrieme comparaison
        ;-----------------------------------------------
        CMP action,113d                                 ;on compare la variable action au code ascii de m
		JZ arreter                                      ;Si les caracteres sont egaux on va au label arreter
		
		
		JMP demande                                     ;si apres les 4 comparaisons, il n'y a pas correspondance, on va au label demande afin de reverifier si le joueur a presse une touche
	    
	    
	    ;           le joueur veut joueur
        ;-----------------------------------------------
    divertir:
        CALL jeu_bebe                                   ;on appelle la procedure jeu_bebe pour jouer avec goregotchi
        CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
        CALL verif_valeur_grandir                       ;on verifie la valeur de grandir pour savoir s'il faut passer a l'age suivant
        CALL depuis_quand_faim                          ;on appelle la procedure depuis_quand_faim pour modifier la valeur de faim si cela fait plus de 1min que goregotchi n'a pas mange
        CALL initialise_jeu                             ;on met a jour les variable h_jeu, min_jeu et sec_jeu car on vient de jouer
        JMP fin_action                                  ;une fois que l'on a jouer on va au label fin_action
		
		;          le joueur veut punir
        ;-----------------------------------------------
    punition:
        CALL depuis_quand_faim                          ;on appelle la procedure depuis_quand_faim pour modifier la valeur de faim si cela fait plus de 1min que goregotchi n'a pas mange
        CALL punition_injuste                           ;on appelle la procedure punition_injuste pour punir goregotchi injustement
        CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
        CALL verif_valeur_grandir                       ;on verifie la valeur de grandir pour savoir s'il faut passer a l'age suivant
        CALL depuis_quand_faim                          ;on appelle la procedure depuis_quand pour modifier la valeur de faim si cela fait plus de 1min que goregotchi n'a pas mange
        CALL depuis_quand_jeu                           ;on verifie si cela fait plus d'une minute que goregotchi n'a pas joue
        JMP fin_action                                  ;une fois que l'on a puni on va au label fin_action
        
        ;          le joueur veut nourrir
        ;-----------------------------------------------
    nourrir:
        CALL nourrir_bebe                               ;on appelle la procedure nourrir_bebe pour nourrir goregotchi selon les choix du joueur
        CALL initialise_faim                            ;on remet a jour les variable h_faim, min_faim et sec_faim car on vient de manger
        CALL verif_valeur_joie                          ;on appelle la procedure verif_valeur_joie pour actualiser l'humeur en cours
        CALL verif_valeur_faim                          ;on appelle la procedure verif_valeur_faim pour afficher eventuellement goregotchi affame
        CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
        CALL verif_valeur_grandir                       ;on verifie la valeur de grandir pour savoir s'il faut passer a l'age suivant
        CALL depuis_quand_jeu                           ;on verifie si cela fait plus d'une minute que goregotchi n'a pas joue
        JMP fin_action                                  ;une fois que l'on a nourri on va au label fin_action
        
     arreter:
        CALL CLEAR_SCREEN                               ;on efface l'ecran entierement
	    CALL termine                                    ;on affiche l'ecran de fin de jeu
        JMP fin_de_jeu                                  ;on va au label fin_de_jeu du main pour arreter le programme   
    
    fin_action:        
        POP DX                                          ;==========================;        
        POP CX                                          ;RESTAURATION DES REGISTRES;
        POP BX                                          ;==========================;
        POP AX
        RET   

action_du_joueur ENDP   