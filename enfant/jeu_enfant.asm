;========================================================================================;
;|  ICI CE TROUVE TOUTES LES PROCEDURE POUR QUE LE JOUEUR PUISSE JOUER AVEC LE BEBE     ;|
;|  -------------------------------------------------------------------------------     ;|
;|                                                                                      ;|
;| * jeu_bebe() : procedure principale qui permet de                                    ;|
;|                    - remttre la variable victoire a zero                             ;|
;|                    - d'afficher le nombre de fois que le joueur a reussi a deviner   ;|
;|                    - d'ajouter 5 a la jauge HAPPINESS                                ;|
;|                    - d'ajouter 5 a la jauge HUNGRINESS                               ;|
;|                    - d'appeler les autres procedures necessaires au jeu              ;|
;|                                                                                      ;|
;| * affiche_les_yeux() : permet d'afficher les yeux du bebe en fontion des valeurs     ;|
;|                        du tableau binaire                                            ;|
;|                                                                                      ;|
;| * efface_les_yeux() : permet d'effacer les yeux du bebe en fonction des valeurs      ;|
;|                       du tableau binaire                                             ;|
;|                                                                                      ;|
;| * devine() : - demande au joueur d'entrer ou il pense que goregotchi va regarder     ;|
;|              - recupere ce que le joueur a saisie et l'affecte a la variable         ;|
;|                nature_saisie                                                         ;|
;|              - affiche un message en fonction de ce que le joueur a entre            ;|
;|                                                                                      ;|
;| * justesse() : permet de savoir si le joueur a bien devine en comparant la variable  ;|
;|                nature_saisie et ce qu'il y a dans le tableau                         ;|
;|                si les valeurs sont les meme c'est que le joueur a bien devine        ;|
;|                                                                                      ;|
;| * bebe_refuse_jeu() : permet d'afficher le bebe refusant de jouer en faisant un      ;|
;|                       mouvement de tete                                              ;| 
;|                                                                                      ;|
;========================================================================================;

jeu_enfant PROC 
    PUSH AX                                 ;=====================================;
    PUSH BX                                 ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX                                 ;=====================================;
    
    efface_footer                           ;on efface le footer d'informations
    MOV victoire,0                          ;on s'assure qu'au debut du jeu la variable victoire est a zero en lui affectant zero
    CALL verif_moment_enfant                ;on verifie quand le joueur a entre une action pour savoir si goregotchi va tire la langue ou pas
    
    CMP discipline,15d                      ;on compare la valeur de la variable discipline a 15
    JBE teste_refus_e                       ;si discipline est egale ou plus petite que 10 on va au label teste_refus car goregotchi peut refuser de jouer
    JMP debut_e                             ;sinon on va au debut pour jouer normalement
    
    teste_refus_e:
        CALL random                         ;on appelle la procedure random pour modifier la valeur de refus aleatoirement
        CMP refus,0                         ;on compare la variable refus a 0
        JZ pas_de_jeu_e                     ;si refus = 0 on va au label pas_de_jeu pour ne pas jouer 
        JMP debut_e
        
        pas_de_jeu_e:
            CALL enfant_refuse_jeu          ;sinon refus = 1 donc on appelle la procedure enfant_refuse_jeu
            CALL verif_valeur_joie2         ;on appelle la procedure verif_valeur_joie pour afficher l'humeur en cours
            JMP fin_je 
 

    debut_e:
    MOV jeu,5                                ;on affecte 5 a jeu pour que le joueur puisse essayer deviner 5 fois ou iront les yeux   
           
    devinette_e:
        CALL random                         ;on appel la procedure random pour que aleatoire prenne une valeur entre 0 et 1
        CALL devine_e                       ;on appel la procedure devine qui va poser les questions au joueur et lui permettre de taper sa reponse
        
        CMP action,113d                     ;on compare la variable action au code ascii de q
        JZ sortie_dev_e                     ;si les caracteres sont egaux on va au label sortie_dev pour sortir de la boucle
                                            ;sinon on poursuit le jeu normalement
        CALL affiche_les_yeux               ;on appel la procedure affiche_les_yeux pour afficher les yeux en fonction d'aleatoire (la variable comprise entre 0 et 1)
        CALL justesse                       ;on appel la procedure justesse qui va verifier si le joueur a donne la bonne reponse
        CALL efface_les_yeux                ;on appel la procedure efface_les_yeux qui va effacer les yeux avant de recommencer la boucle
        JMP fin_devinette_e                 ;on va au label fin_devinette pour reprendre la boucle
        
        sortie_dev_e:
            MOV jeu,0                        ;on place 0 dans CX pour pouvoir sortir de la boucle
            JMP fin_je
            
        fin_devinette_e:
        CMP jeu,0    
    JNE devinette_e
    
    CALL affiche_nombre_victoire
    
    efface_footer                           ;on efface le footer d'informations 
    
    ;joie = joie + 10
    ;-----------------                           
    ADD joie,10d                            ;on ajoute 10 a la variable joie      
    CALL verif_valeur_joie2                 ;on verifie la valeur de joie avant de l'afficher et on actualise l'humeur de goregotchi 
    CALL affiche_joie                       ;on affiche la valeur de la variable joie
    CALL ajustement_je
    
    ;faim = faim + 5
    ;----------------
    ADD faim,5d                             ;on ajoute 5 a la variable faim
    CALL verif_valeur_faim2                 ;on verifie la valeur de faim avant de l'afficher
    CALL affiche_faim                       ;on affiche la valeur de la variable joie
    CALL ajustement_fe
    
    fin_je:
        POP CX                              ;==========================;
        POP BX                              ;RESTAURATION DES REGISTRES;
        POP AX                              ;==========================;
        RET
jeu_enfant ENDP

 
 
devine_e PROC
    PUSH AX                                             ;=====================================;
    PUSH BX                                             ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX                                             ;=====================================;
	PUSH SI
	PUSH DI		
    
    
    affiche_footer_jeu
    
    CALL verif_valeur_joie2                             ;on appelle la procedure verif_valeur_joie pour modifier la variable sprite    
	
	question_e: 
	    CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
	    CALL verif_valeur_grandir                       ;on verifie la valeur de grandir 
	    CALL depuis_quand_faim_e                        ;on verifie si cela fait plus de 1min que goregotchi n'a pas mange
	    CALL depuis_quand_jeu_e                         ;on verifie si cela fait plus de 1min que goregotchi n'a pas joue
	    affiche_footer_jeu                              ;on affiche le footer d'informations du jeu car si goregotchi s'ennuyait il a ete efface
	    CALL animation2                                 ;on appelle la procedure animation pour faire bouger goregotchi de gauche a droite
	    CALL recupere_touche                            ;on appelle la procedure recupere_touche pour affecter a la variable action le code ascii de la touche presse
	    		
        ;           premiere comparaison
        ;-----------------------------------------------
        CMP action,100d                                 ;on compare la variable action au code ascii de d    
		JZ  saisi_droite_e                              ;Si les chaines sont egales alors ZF=0 et on va au label saisi_droite

		
        ;           deuxieme comparaison
        ;-----------------------------------------------
        CMP action,103d                                 ;on compare la variable action au code ascii de g
		JZ   saisi_gauche_e                             ;Si les chaines sont egales alors ZF=0 et on va au label saisi_gauche
		
		
		
		;           troisieme comparaison
        ;-----------------------------------------------
        CMP action,113d                                 ;on compare la variable action au code ascii de q
		JZ   fin_devine_e                               ;Si les chaines sont egales alors ZF=0 et on va au label fin_devine car le joueur veut revenir au menu principale
		
		JMP question_e                                  ;si apres les trois comparaisons, pas de correspondances, on va au label question 
		
		;           le joueur entre droite
        ;-----------------------------------------------
    saisi_droite_e:        
        GOTOXY 8,18		                                ;on positionne le curseur
        PRINT "Voyons si ils vont a droite..."
        CALL initialise_jeu
                                    
        MOV nature_saisie,1                             ;on place 1 dans la variable nature_saisie car le joueur a entre droite 
        JMP fin_devine_e	
		
		;           le joueur entre gauche
        ;-----------------------------------------------
    saisi_gauche_e:
        GOTOXY 8,18
        PRINT "Voyons si ils vont a gauche..."
        CALL initialise_jeu
        MOV nature_saisie,0                             ;on place 0 dans la variable nature_saisie car le joueur a entre gauche 
    
    fin_devine_e:
        DEC jeu                                         ;on decremente la variable jeu
        POP DI  
        POP SI                                          ;==========================;
        POP CX                                          ;RESTAURATION DES REGISTRES;
        POP BX                                          ;==========================;
        POP AX
        RET  

devine_e ENDP 



enfant_refuse_jeu PROC                          ;====================================;
    PUSH CX                                     ;SAUVEGARDE DU REGISTRES DANS LA PILE;
                                                ;====================================;
    CALL affiche_refus_jouer
    
    MOV CX,3d                                   ;on place 3 dans CX car on veut repeter la boucle 3 fois
   
    mouvement2:
        MOV sprite,OFFSET enfant_r_f              ;visage de face
        affectexy 22,6
        affiche_sprite sprite,largeur_enfant,12 
        
        MOV sprite,OFFSET enfant_r_d              ;visage regardant a droite
        affectexy 22,6
        affiche_sprite sprite,largeur_enfant,12 
        
        MOV sprite,OFFSET enfant_r_f              ;visage de face
        affectexy 22,6
        affiche_sprite sprite,largeur_enfant,12 
        
        MOV sprite,OFFSET enfant_r_g              ;visage regardant a gauche
        affectexy 22,6
        affiche_sprite sprite,largeur_enfant,12 
    LOOP mouvement2
    
    MOV sprite,OFFSET enfant_r_f                  ;visage de face
    affectexy 22,6
    affiche_sprite sprite,largeur_enfant,12 
                                                ;=========================;
    POP CX                                      ;RESTAURATION DU REGISTRES;
    RET                                         ;=========================;
enfant_refuse_jeu ENDP
                