affiche_avertissement PROC
    MOV sprite,OFFSET avertissement                         ;on place dans sprite l'adresse de l'asciiart contenant le texte avertissant le joueur
    affectexy 8,17                                          ;on modifie les valeurs des variables position_x et position_y
    affiche_sprite sprite,largeur_avertissement,21          ;on appelle le macro affiche_sprite pour afficher le texte d'avertissement    
    RET
affiche_avertissement ENDP 


efface_avertissement PROC
    MOV sprite,OFFSET e_avertissement                       ;on place dans sprite l'adresse de l'asciiart permettant d'effacer le texte d'avertissement
    affectexy 8,17                                          ;on modifie les valeurs des variables position_x et position_y
    affiche_sprite sprite,largeur_avertissement,22          ;on appelle le macro affiche_sprite pour effacer le texte d'avertissement
    RET    
efface_avertissement ENDP 
    
affiche_danger PROC
    affectexy 5,16                                  ;on modifie les valeurs des variables position_x et position_y    
    MOV sprite,OFFSET danger                        ;on place l'adresse de l'asciiart danger dans la variable sprite
    affiche_sprite sprite,largeur_danger,23         ;on affiche le message de danger 
    RET  
affiche_danger ENDP 
   
efface_danger PROC   
    affectexy 5,16                                  ;on modifie les valeurs des variables position_x et position_y
    MOV sprite,OFFSET e_danger                      ;on place l'adresse de l'asciiart e_danger dans la variable sprite
    affiche_sprite sprite,largeur_danger,23         ;on affiche l'asciiart e_danger 
    RET   
efface_danger ENDP
    

refus_engraissement PROC 
    affectexy 20,16
    MOV sprite,OFFSET texte_refuse 
    affiche_sprite sprite,largeur_texte_refuse,19
    RET
refus_engraissement ENDP  

efface_engraissement PROC
    affectexy 20,16
    MOV sprite,OFFSET e_texte_refuse 
    affiche_sprite sprite,largeur_texte_refuse,19 
    RET    
efface_engraissement ENDP  

affiche_refus_manger PROC
    affectexy 20,16
    MOV sprite,OFFSET non
    affiche_sprite sprite,38,19
    RET    
affiche_refus_manger ENDP 

efface_refus_manger PROC
    affectexy 20,16
    MOV sprite,OFFSET e_non
    affiche_sprite sprite,38,19
    RET    
efface_refus_manger ENDP   


refus_manger_texte PROC
	CALL refus_engraissement                    ;on affiche le texte informant le joueur que goregotchi a assez mange
    CALL trois_secondes                         ;on attend 3 secondes
    CALL trois_secondes                         ;on attend 3 secondes
    CALL efface_engraissement                   ;on efface le texte informant le joueur que goregotchi a assez mange
    RET
refus_manger_texte ENDP 



affiche_nombre_victoire PROC
    GOTOXY 8,18                             ;on positionne le curseur
    PRINT "Vous avez reussi "               ;on affiche le debut message du message de victoire
                                            
    MOV AX,victoire                         ;on place la valeur de la variable victoire dans AX 
    CALL PRINT_NUM_UNS                      ;on affiche le contenu du registre AX (le nombre de victoire) a la position courante du curseur 
    PRINT " fois"                           ;on affiche la chaine "fois" juste apres avoir affiche le nombre de victoire 
    
    CALL trois_secondes                     ;on attends 3 secondes pour que le joueur ait le temps de lire le message
    
    GOTOXY 8,23                             ;on positionne le curseur 
    PRINT "                         "       ;on efface le message de victoire
    RET    
affiche_nombre_victoire ENDP    



affiche_refus_jouer PROC
    affectexy 20,19                             ;on modifie les variables position_x et position_y
    MOV sprite,OFFSET refus_jeu                 ;on place dans la variable sprite l'adresse de l'asciiart qui concerne le refus de jouer
    affiche_sprite sprite,largeur_refus_jeu,20  ;on affiche l'asciiart qui contient le texte informant le joueur que goregotchi n'a pas envie de jouer
    RET    
affiche_refus_jouer ENDP        



affiche_alerte PROC
    PUSH CX
    
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
    
    clignotte_e:
        affectexy 10,16                             ;on positionne le curseur
        MOV sprite,OFFSET e_alerte                  ;on place l'adresse de l'asciiart e_alerte dans la variable sprite
        affiche_sprite sprite,largeur_alerte,23     ;on efface le l'asciiart alerte
        
        affectexy 10,16                             ;on positionne le curseur
        MOV sprite,OFFSET alerte2                   ;on place l'adresse de l'asciiart alerte2 dans la variable sprite
        affiche_sprite sprite,largeur_alerte,23     ;on affiche l'asciiart alerte2
    loop clignotte_e
    
    affectexy 10,16                             ;on positionne le curseur
    MOV sprite,OFFSET e_alerte                  ;on place l'adresse de l'asciiart e_alerte dans la variable sprite
    affiche_sprite sprite,largeur_alerte,23     ;on efface le l'asciiart alerte
        
    POP CX
    RET
affiche_alerte ENDP   


remplace_bouche_enfant PROC
    MOV sprite,OFFSET mache11                           ;==================================;
    affectexy 35,9                                      ;ON REMPLACE ______/' PAR \______/ ;
    affiche_sprite sprite,largeur_bouche_enfant,12      ;==================================;      
    RET                                                  
remplace_bouche_enfant ENDP 


affiche_la_porte PROC
    affectexy 0,1                                   ;===================;
    MOV sprite,OFFSET porte                         ;ON AFFICHE LA PORTE;
    affiche_sprite sprite,largeur_porte,18          ;===================;
    RET
affiche_la_porte ENDP 


efface_la_porte PROC
    affectexy 0,1                                   ;==================;
    MOV sprite,OFFSET e_porte                       ;ON EFFACE LA PORTE;
    affiche_sprite sprite,largeur_porte,18          ;==================;
    RET    
efface_la_porte ENDP 


affiche_consigne PROC
    affectexy 32,16                             ;===================;
    MOV sprite,OFFSET consigne                  ;ON AFFICHE CONSIGNE;
    affiche_sprite sprite,largeur_consigne,23   ;===================;
    RET    
affiche_consigne ENDP  

efface_consigne PROC
    affectexy 32,16                             ;==================;
    MOV sprite,OFFSET e_consigne                ;ON EFFACE CONSIGNE;
    affiche_sprite sprite,largeur_consigne,23   ;==================;
    RET
efface_consigne ENDP