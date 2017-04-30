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
;| * macher() : permet d'afficher des bouches a la suite pour que goregotchi ait    ;|
;|              l'air de macher                                                     ;|
;|                                                                                  ;|
;| * bebe_refuse_manger() : permet d'afficher goregotchi refusant de manger avec    ;|
;|                          un message informant le joueur                          ;|
;|                                                                                  ;|
;| * afficher_danger() : permet d'afficher un message pour prevenir le joueur que   ;|
;|                       goregotchi peut mourrir de faim                            ;|
;|                                                                                  ;|
;| * reaction_danger() : permet de demander au joueur ce qu'il veut faire face au   ;|
;|                       risque de mort de goregotchi                               ;|
;====================================================================================;
   


nourrir_bebe PROC
    efface_footer                                   ;on efface le footer d'informations
    CALL verif_moment                               ;on verifie si goregotchi doit tirer la langue ou pas
	
	CMP discipline,10d
	JBE verif_refus
	JMP normalement
	
	verif_refus:
	    CALL random                                 ;on appelle la procedure random pour modifier la valeur de refus aleatoirement
	    CMP refus,0                                 ;on compare la variable refus a 0
	    JZ pas_de_repas                             ;si refus = 0 on va au label pas_de_repas pour ne pas manger
	    JMP normalement                             ;sinon refus = 1 donc on va au label normalement pour manger 
	    
	    pas_de_repas:
	        CALL bebe_refuse_manger
	        CALL affiche_refus_manger
	        CALL trois_secondes
	        CALL efface_refus_manger
	        JMP fin_nourrir	    
	    
	normalement:
	affiche_footer_nourrir                          ;on affiche le footer d'informations qui concerne le repas
	
	CALL verif_valeur_joie                          ;on appelle la procedure verif_valeur_joie pour modifier la variable sprite    
	
	demande2: 
	    CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
	    CALL verif_valeur_grandir
	    CALL depuis_quand_faim                      ;on verifie si cela fait plus d'une minute que goregotchi n'a pas mange 
	    CALL depuis_quand_jeu
	    affiche_footer_nourrir
	    CALL animation                              ;on appelle la procedure animation pour faire bouger goregotchi de gauche a droite
	    CALL recupere_touche                        ;on appelle la procedure recupere_touche pour affecter a la variable action le code ascii de la touche presse
	    		
    
        ;           premiere comparaison
        ;-----------------------------------------------
        CMP action,115d                                 ;on compare la variable action au code ascii de s
    	JZ grignotte
    	             
    	             
        ;           deuxieme comparaison
        ;-----------------------------------------------
        CMP action,114d                                 ;on compare la variable action au code ascii de r
    	JZ mange                                        ;Si les chaines sont egales alors ZF=0 et on va au label punition	
    	
    	
    	;           troisieme comparaison
        ;-----------------------------------------------
        CMP action,113d                                 ;on compare la variable action au code ascii de q
    	JZ   fin_nourrir                                ;Si les chaines sont egales on va au label fin_nourrir
    	
	                                                
	JMP demande2                                        ;sinon on redemande de saisir a nouveau
	
	grignotte:
	    
	    ;faim = 5 ?
        ;----------------------------------------
	    CMP faim,5d                                 ;on compare faim a 5
	    JA go                                       ;si faim > 5 goregotchi ne refusera pas de manger
	    efface_footer                               ;on efface le footer d'informations
	    CALL bebe_refuse_manger                     ;sinon faim <= 5 donc on appelle la procedure pour afficher goregotchi refusant de manger
	    CALL refus_manger_texte
	    CALL verif_valeur_joie
	    JMP fin_nourrir                             ;on va au label fin_nourrir
	    
	  go:
	    CALL cerise                                 ;on appelle la procedure cerise pour que goregotchi mange son snack 
        CALL remplace_bouche_bebe                   ;on reaffiche la bouche normale de goregotchi                                    
        ;faim = faim - 5
        ;----------------------------------------
        SUB faim,5d                                 ;on soustrait 5 a faim
        CALL verif_valeur_faim                      ;on verifie la valeur de faim avant de l'afficher avec eventuellement goregotchi affame
        CALL affiche_faim                           ;on affiche la valeur de faim 
        CALL ajustement_fb                          ;on ajutes l'affichage de la jauge de faim
        ;joie = joie + 5
        ;----------------------------------------
        ADD joie,5d                                 ;on soustrait 5 a joie
        CALL verif_valeur_joie                      ;on verifie la valeur de joie avant de l'afficher et on actualise l'humeur de goregotchi
        CALL affiche_joie                           ;on affiche la valeur de joie
        CALL ajustement_jb                          ;on ajuste l'affichage de la jauge de joie
	    JMP fin_nourrir                             ;on va au label fin_nourrir 
	    
	mange:  
	    ;faim = 5 ?
        ;----------------------------------------
	    CMP faim,5d                                 ;on compare faim a 5
	    JA go2                                      ;si faim > 5 goregotchi ne refusera pas de manger
	    efface_footer                               ;on efface le footer d'informations
	    CALL bebe_refuse_manger                     ;sinon faim <= 5 donc on appelle la procedure pour afficher goregotchi refusant de manger
	    JMP fin_nourrir                             ;on va au label fin_nourrir
      
	  go2:  
	    CALL riz                                    ;on appelle la procedure riz pour que goregotchi mange son repas
	    CALL remplace_bouche_bebe                   ;on reaffiche la bouche normale de goregotchi
	    ;faim = faim - 10
        ;----------------------------------------
        SUB faim,10d                                ;on soustrait 10 a faim
        CALL verif_valeur_faim                      ;on verifie la valeur de faim avant de l'afficher avec eventuellement goregotchi affame
        CALL affiche_faim                           ;on affiche la valeur de faim
        CALL ajustement_fb                          ;on ajuste l'affichage de la jauge de faim    
	
	fin_nourrir:
	    RET		   
nourrir_bebe ENDP


macher1 PROC
    PUSH CX
    
    MOV CX,3
    boucle_bouche:
        MOV sprite,OFFSET mache1
        affectexy 35,9 
        affiche_sprite sprite,largeur_bouche_bebe,12        ;\_____/
        
        MOV sprite,OFFSET mache2                            ;_______
        affectexy 35,9                                      ;\_____/
        affiche_sprite sprite,largeur_bouche_bebe,12            
        
        MOV sprite,OFFSET mache3                            ; _____
        affectexy 35,9                                      ;/     \
        affiche_sprite sprite,largeur_bouche_bebe,12        ;\_____/     
        
        MOV sprite,OFFSET mache2                            ;_______
        affectexy 35,9                                      ;\_____/
        affiche_sprite sprite,largeur_bouche_bebe,12            
        
        MOV sprite,OFFSET mache1
        affectexy 35,9 
        affiche_sprite sprite,largeur_bouche_bebe,12        ;\_____/
        
        MOV sprite,OFFSET mache4
        affectexy 35,9 
        affiche_sprite sprite,largeur_bouche_bebe,12        ;_____/'
        
    loop boucle_bouche

    POP CX 
    RET
macher1 ENDP



bebe_refuse_manger PROC 
    ;on affiche l'image du bebe refusant de manger
    ;---------------------------------------------
    MOV sprite,OFFSET bebe_refuse 
    affectexy 23,9
    affiche_sprite sprite,largeur_bebe,12                  
    RET 
bebe_refuse_manger ENDP


reaction_danger PROC 
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
	JZ grignotte2
	
    ;           deuxieme comparaison
    ;-----------------------------------------------
                                            		;ici on va comparer si la chaine saisie par l'utilisateur est egale a "r" avec l'instruction CMPSB qui compare des bytes entre les adresses DS:SI et ES:DI
	MOV AX,DS                                       ;on place DS dans AX car on ne peut pas faire directement MOV ES,DS 
	MOV ES,AX                                       ;ici ES = DS
	LEA SI,action                                   ;DS:SI = adresse de la variable saisie
	LEA DI,repas                                    ;ES:DI = adresse de la variable repas
	
	MOV  CX,1                                       ;on place dans CX le nombre de caracteres a comparer
	REPE CMPSB                                      ;on compare les chaines byte a byte
	JZ mange2                                       ;Si les chaines sont egales alors ZF=0 et on va au label punition	
	
	;sinon le joueur veut qu'il meurt 
	;-----------------------------------------------                                                
    CALL deces    
	JMP fin_de_jeu                                  ;on va au label fin_de_jeu du main pour arreter le programme
    
    
    grignotte2:
        GOTOXY 43,12                                    ;on positionne le curseur
        PRINT "  "                                      ;on efface "()" de la bouche
        CALL cerise
        CALL remplace_bouche_bebe                       ;on reaffiche la bouche normale de goregotchi
        ;on efface le sprite danger
        affectexy 5,16                                  ;on modifie les valeurs des variables position_x et position_y
        MOV sprite,OFFSET e_danger                      ;on place l'adresse de l'asciiart e_danger dans la variable sprite
	    affiche_sprite sprite,largeur_danger,23         ;on affiche l'asciiart e_danger 
        
        CALL initialise_faim                            ;on remet a jour les variable h_faim, min_faim et sec_faim car on vient de manger
        
        SUB faim,5d                                     ;on soustrait a faim 5
        CALL affiche_faim                               ;on affiche la valeur de faim
        CALL ajustement_fb                              ;on ajutse l'affichage de la jauge de faim
        
        ADD joie,5d                                     ;on ajoute 5 a joie
        CALL affiche_joie                               ;on affiche la valeur de joie
        CALL ajustement_jb                              ;on ajuste l'affichage de la jauge 
        CALL verif_valeur_joie                          ;on reaffecte la variable sprite et on actualise l'humeur du bebe
        JMP fin_react
        
    mange2:
        GOTOXY 43,12
        PRINT "  "                                      ;on efface "()" de la bouche
        CALL riz            
        CALL remplace_bouche_bebe                       ;on reaffiche la bouche normale de goregotchi
        CALL initialise_faim                            ;on remet a jour les variable h_faim, min_faim et sec_faim car on vient de manger
        
        ;on efface le sprite danger
        affectexy 5,16                                  ;on modifie les valeurs des variables position_x et position_y
        MOV sprite,OFFSET e_danger                      ;on place l'adresse de l'asciiart e_danger dans la variable sprite
	    affiche_sprite sprite,largeur_danger,23         ;on affiche l'asciiart e_danger
                                                        
        SUB faim,10d                                    ;on soustrait a faim 5
        CALL affiche_faim                               ;on affiche la valeur de faim
        CALL ajustement_fb                              ;on ajutse l'affichage de la jauge de faim
        CALL verif_valeur_joie                          ;on reaffecte la variable sprite et on actualise l'humeur du bebe
    fin_react: 
        RET
reaction_danger ENDP