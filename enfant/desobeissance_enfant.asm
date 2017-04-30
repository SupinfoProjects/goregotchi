enfant_langue PROC 
    PUSH AX                                                 ;=====================================;
    PUSH CX                                                 ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH DI                                                 ;=====================================;
    PUSH SI 
    
    CALL tirage2                                            ;on appelle la procedure tirage2 pour que goregotchi tire la langue plusieurs fois de suite
    
    CALL affiche_avertissement

    choix_joueur_e:
        CALL verif_heure_en_cours                           ;on verifie si cela fait 6 min que l'on joue pour modifier la valeur de grandir
        CALL verif_valeur_grandir
        CALL tirage2                                        ;on appelle la procedure tirage2 pour que goregotchi tire la langue plusieurs fois de suite                     
        CALL recupere_touche                                ;on recupere la touche que le joueur a presse
        ;===================================================;
    	;             on compare la chaine saisie           ;
    	;===================================================;
        CMP action,112d                                     ;on compare la variable action au code ascii de p                                  
        JZ chatiment2                                       ;Si les chaines sont egales on va au label chatiment2
        
        CMP action,99d                                      ;on compare la variable action au code ascii de c
        JZ continuer2                                       ;Si les caracteres sont egaux on va au label continuer2
        
    JMP choix_joueur_e                                      ;sinon on va au label choix_joueur pour recuperer a nouveau a touche presse et faire les comparaisons 
    
    continuer2:
        GOTOXY 8,21                                         ;on positionne le curseur
        PRINT "Tu aurais du le punir..."                    ;on affiche le message
    
        ;===================================================;
    	;           on efface la langue et le texte         ;
    	;===================================================;
        CALL remplace_bouche_enfant                
        
        CALL trois_secondes
        
        CALL efface_avertissement
        
        ;discipline >= 10 ?
        ;------------------
        CMP discipline,10d                                      ;on compare discipline a 10
        JAE dix_enf                                             ;si discipline >= 10 on va au label dix
        ;discipline < 10
        MOV discipline,0                                        ;on ramene discipline a 0 
        JMP passe_enf
    
    dix_enf:
        ;discipline = discipline - 10
        ;----------------------------
        SUB discipline,10d                                  ;on soustrait 10 a discipline
     
    passe_enf:   
        CALL verif_valeur_dis2                              ;on verifie la valeur de discipline pour modifier la variable seconde avant d'afficher discipline
        CALL affiche_discipline                             ;on affiche la valeur de discipline
        CALL ajustement_de                                  ;on ajuste l'affichage de la jauge discipline
        JMP fin_enfant_langue                               ;on va au label fin_bebe_langue car le joueur n'a pas voulu punir goregotchi
    
    ;=======================================================;
	;            le joueur choisit de le punir              ;
	;=======================================================;
    chatiment2:
        GOTOXY 8,21                                         ;on positionne le curseur
        PRINT "Bonne decision !"                            ;on affiche le texte "Bonne decision !"
        
        CALL remplace_bouche_enfant                         ;on efface la langue                        
        
        CALL trois_secondes                                 ;on attend 3 secondes    
        
        CALL efface_avertissement                           ;on efface le texte d'avertissement
       
        CALL punition_juste_e                               ;on appelle la procedure punition_juste pour punir goregotchi

    fin_enfant_langue:
        POP SI                                              ;==========================;
        POP DI                                              ;RESTAURATION DES REGISTRES;
        POP CX                                              ;==========================;
        POP AX   
        RET  
    
enfant_langue ENDP

verif_moment_enfant PROC
    PUSH AX                 ;=====================================;
    PUSH DX                 ;SAUVEGARDE DES REGISTRES DANS LA PILE;
                            ;=====================================;
    MOV AH,2Ch              
    INT 21h                 ;on recupere l'heure du systeme
    
    CMP DH,seconde          ;on compare l'heure du systeme avec la valeur de la variable seconde
    JA fin_verif_moment_e   ;si les secondes du systeme sont plus grandes que la variable seconde on va au label fin_verif_moment
    CALL enfant_langue      ;sinon on affiche la langue 
    
    fin_verif_moment_e:
        POP DX              ;==========================;
        POP AX              ;RESTAURATION DES REGISTRES;
        RET                 ;==========================;
verif_moment_enfant ENDP 