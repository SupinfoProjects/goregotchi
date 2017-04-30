;====================================================================================;
;|       ICI CE TROUVE TOUTES LES PROCEDURES POUR QUE GOREGOTCHI DESOBEISSE         ;|
;|       ------------------------------------------------------------------         ;|
;|                                                                                  ;| 
;| * bebe_langue() : permet a goregotchi de tirer la langue et de demander au       ;|
;|                   joueur s'il veut le punir                                      ;|
;|                                                                                  ;|
;| * tirage() : permet a goregotchi de tirer la langue plusieurs fois de suite      ;|
;|                                                                                  ;|
;| * verif_moment() : permet de verifier a quel moment le joueur tape une action    ;|
;|                    car goregotchi ne peut desobeir qu'entre 0s et la valeur de   ;|
;|                    la variable seconde (qui vaut 15 au debut du jeu)             ;|
;|                                                                                  ;|
;====================================================================================;
             

bebe_langue PROC 
    PUSH AX                                                 ;=====================================;
    PUSH CX                                                 ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH DI                                                 ;=====================================;
    PUSH SI 
    
    CALL tirage                                             ;on appelle la procedure tirage pour que goregotchi tire la langue plusieurs fois de suite
    
    CALL affiche_avertissement
    
    choix_joueur:
    CALL verif_heure_en_cours                       ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
	CALL verif_valeur_grandir               
    CALL tirage                                             ;on appelle la procedure tirage pour que goregotchi tire la langue plusieurs fois de suite                     
    CALL recupere_touche                                    ;on recupere la touche que le joueur a presse
    
    ;=======================================================;
	;             on compare la chaine saisie               ;
	;=======================================================;
    CMP action,112d                                         ;on compare la variable action au code ascii de p                                  
	JZ chatiment                                            ;Si les caracteres sont egaux on va au label chatiment	
	
	CMP action,99d                                          ;on compare la variable action au code ascii de c
	JZ continuer	                                        ;Si les caracteres sont egaux on va au label continuer
    
    JMP choix_joueur                                        ;sinon on va au label choix_joueur pour recuperer a nouveau a touche presse et faire les comparaisons 
    
    continuer:    
        GOTOXY 8,21                                         ;on positionne le curseur
        PRINT "Tu aurais du le punir..."                    ;on affiche le message
    
        ;===================================================;
    	;          on efface la langue et le texte          ;
    	;===================================================;
        CALL remplace_bouche_bebe
        
        CALL trois_secondes                                 ;on attends 3 secondes
        
        CALL efface_avertissement
        
        ;discipline >= 10 ?
        ;------------------
        CMP discipline,10d                                  ;on compare discipline a 10
        JAE dix                                             ;si discipline >= 10 on va au label dix
        MOV discipline,0                                    ;sinon discipline < 10 donc on ramene cette variable a 0 car on aurait du lui soustraire 10
        JMP passe                                           ;on va au label passe
    
    dix:
        ;discipline = discipline - 10
        ;----------------------------
        SUB discipline,10d                                  ;on soustrait 10 a discipline

    passe:   
        CALL verif_valeur_dis                               ;on verifie la valeur de discipline pour modifier la variable seconde avant d'afficher discipline
        CALL affiche_discipline                             ;on affiche la valeur de discipline
        CALL ajustement_db                                  ;on ajuste l'affichage de la jauge discipline
        JMP fin_bebe_langue                                 ;on va au label fin_bebe_langue car le joueur n'a pas voulu punir goregotchi
    
    ;=======================================================;
	;            le joueur choisit de le punir              ;
	;=======================================================;
    chatiment:
        GOTOXY 8,21                                         ;on positionne le curseur
        PRINT "Bonne decision !"                            ;on affiche le texte "Bonne decision !"
        
        ;on efface la langue
        ;-------------------
        CALL remplace_bouche_bebe
        
        CALL trois_secondes                                 ;on attend 3 secondes    
        
        CALL efface_avertissement
        
        CALL punition_juste                                 ;on appelle la procedure punition_juste pour punir goregotchi

    fin_bebe_langue:
        POP SI                                              ;==========================;
        POP DI                                              ;RESTAURATION DES REGISTRES;
        POP CX                                              ;==========================;
        POP AX   
        RET  
    
bebe_langue ENDP 

remplace_bouche_bebe PROC
    MOV sprite,OFFSET mache1                            ;on place dans sprite l'adresse de l'asciiart mache1 pour afficher le sourir de goregotchi
    affectexy 35,9                                      ;on modifie les valeurs des variables position_x et position_y 
    affiche_sprite sprite,largeur_bouche_bebe,13        ;\_____/  
    RET   
remplace_bouche_bebe ENDP


tirage PROC
    PUSH CX                                                 ;on sauvegarde le contenu de CX
    MOV CX,3                                                ;on place 3 dans CX pour que goregotchi tire la langue 3 fois 
    ;=======================================================;
    ; ici on affiche successivement plusieurs bouche pour   ;
    ;                   tirer la langue                     ;
    ;=======================================================;    
    tirage_langue:
        MOV sprite,OFFSET mache1
        affectexy 35,9 
        affiche_sprite sprite,largeur_bouche_bebe,12        ;\_____/
        
        MOV sprite,OFFSET mache2                            ;_______
        affectexy 35,9                                      ;\_____/
        affiche_sprite sprite,largeur_bouche_bebe,12                
        
        
        MOV sprite,OFFSET langue_sortie                     ;________
        affectexy 35,10                                     ;\__//__/
        affiche_sprite sprite,largeur_bouche_bebe,13        ;   V
        
        
        MOV sprite,OFFSET mache2                            ;_______
        affectexy 35,9                                      ;\_____/
        affiche_sprite sprite,largeur_bouche_bebe,12                
        
        GOTOXY 38,12
        PRINT " "                                           ;on efface le v de la langue
    loop tirage_langue                                      ;on decremente CX et si CX != 0 on va au label tirage_langue
    POP CX                                                  ;on restaure le contenu de CX
    RET
tirage ENDP   


verif_moment PROC
    PUSH AX                 ;=====================================;
    PUSH DX                 ;SAUVEGARDE DES REGISTRES DANS LA PILE;
                            ;=====================================;
    MOV AH,2Ch              
    INT 21h                 ;on recupere l'heure du systeme
    
    CMP DH,seconde          ;on compare l'heure du systeme avec la valeur de la variable seconde
    JA fin_verif_moment     ;si les secondes du systeme sont plus grandes que la variable seconde on va au label fin_verif_moment
    CALL bebe_langue        ;sinon on affiche la langue 
    
    
    fin_verif_moment:
        POP DX              ;==========================;
        POP AX              ;RESTAURATION DES REGISTRES;
        RET                 ;==========================;
verif_moment ENDP 