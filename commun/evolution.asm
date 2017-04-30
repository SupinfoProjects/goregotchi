verif_valeur_grandir PROC
    CMP grandir,1d                                  ;on compare grandir a 6
    JZ age_suivant                                 ;si grandir >= 6 on va au label age suivant
    JMP fin_vg                                      ;sinon on va au label fin_vg
    
    age_suivant:
        CALL CLEAR_SCREEN                           ;on efface completement l'ecran
        affectexy 5,1                               ;on modifie les valeurs des variables position_x et position_y
        MOV sprite,OFFSET ecran_evolution           ;on place dans la variable sprite l'adresse de l'asciiart de l'ecran d'evolution
        affiche_sprite sprite,largeur_ecran_ev,22   ;on affiche l'ecran d'evolution 
        CALL trois_secondes                         ;on attends 3 secondes    
        INC age                                     ;on incremente age
        MOV grandir,0                               ;on remet la variable grandir a 0    
        CALL initialise_jeu                         ;on remet a jour les variables h_jeu, min_jeu et sec_jeu car goregotchi evolue
        CALL CLEAR_SCREEN                           ;on efface entierement l'ecran
    fin_vg:
        RET 

verif_valeur_grandir ENDP  


verif_heure_en_cours PROC
    PUSH AX                             ;=====================================;
    PUSH BX                             ;SAUVEGARDE DES REGISTRES DANS LA PILE;
    PUSH CX                             ;=====================================;
    
    
    MOV AH,2Ch             ;quand AH = 2Ch, INT 21h recupere l'heure du systeme
    INT 21h                ;on recupere le temps du systeme
    
    CMP h_up,CH
    JZ heure_egale3
    JMP fin_vhe
    
    heure_egale3:
        CMP min_up,CL
        JZ min_egale3
        JMP fin_vhe
        
        min_egale3:
            CMP sec_up,DH
            JB changement_age
            JMP fin_vhe
            
            changement_age:
                MOV grandir,1d
                
   fin_vhe:        
        POP CX                          ;==========================;
        POP BX                          ;RESTAURATION DES REGISTRES;
        POP AX                          ;==========================;        
        RET 
verif_heure_en_cours ENDP