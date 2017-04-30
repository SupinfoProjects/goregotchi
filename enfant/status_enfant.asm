verif_valeur_joie2 PROC
    MOV debut_goregotchi,OFFSET enfant_debut
    ;joie >= 50 ?
    ;------------
    CMP joie,50d                            ;on compare joie a 50
    JAE change1                             ;si joie >= 50 on va au label change1
    JMP change2                             ;sinon on va au label change2
    
    ;joie >= 50
    ;----------
    change1:
        MOV joie,50d                        ;on affecte 50 a joie
        MOV sprite,OFFSET enfant_tres_joie  ;on place l'adresse de l'asciiart enfant_tres_joie dans la variable sprite
        JMP fin_vvj2
    
    ;joie < 40 ?
    ;-----------
    change2:
        CMP joie,40d                        ;on compare joie a 40
        JB change3                          ;si joie < 40 on va au label change3
        MOV sprite,OFFSET enfant_tres_joie  ;on place l'adresse de l'asciiart enfant_tres_joie dans la variable sprite         
        JMP fin_vvj2
     
     ;joie < 30 ?
     ;-----------   
    change3:
        CMP joie,30d                        ;on compare joie a 30
        JB change4                          ;si joie < 30 on va au label change4
        MOV sprite,OFFSET enfant_joie       ;on place l'adresse de l'asciiart enfant_joie dans la variable sprite
        JMP fin_vvj2
    
    ;joie < 25 ?
    ;-----------    
    change4:
        CMP joie,25d                        ;on compare joie a 30
        JB change5                          ;si joie < 25 on va au label change5
        MOV sprite,OFFSET enfant_ennuye     ;on place l'adresse de l'asciiart enfant_ennuye dans la variable sprite
        JMP fin_vvj2
    
    ;joie < 15 ?
    ;-----------
    change5:
        CMP joie,15d                        ;on compare joie a 15                    
        JB change6                          ;si joie < 15 on va au label change6
        MOV sprite,OFFSET enfant_triste     ;on place l'adresse de l'asciiart enfant_triste dans la variable sprite
        JMP fin_vvj2
    
    ;joie < 15
    ;-----------
    change6:                                    
        MOV debut_goregotchi,OFFSET enfant_debut_tres_triste
        MOV sprite,OFFSET enfant_triste     ;on place l'adresse de l'asciiart enfant_triste dans la variable sprite      
        
    fin_vvj2:
        affiche_enfant                          ;on affiche l'humeur de l'enfant
        RET    
verif_valeur_joie2 ENDP


verif_valeur_faim2 PROC
    
    ;faim > 40 ?
    ;------------  
    CMP faim,40d                    ;on compare faim a 35
    JA vvf2                        ;si faim < 40 on va au label f1  
    
    ;faim = 40 ?
    ;-----------
    CMP faim,40d                            ;on compare faim a 40
    JNE fin_vvf2                            ;si faim != 40 on va au label fin_vvf2
    CALL affiche_faim                       ;on affiche la valeur de faim
    CALL ajustement_fe                      ;on ajuste l'affichage de la jauge de faim
    MOV sprite,OFFSET enfant_affame         ;on place l'adresse de l'asciiart de l'enfant affame dans la varibale sprite
    MOV debut_goregotchi,OFFSET enfant_debut_affame
    affiche_enfant
    JMP fin_vvf2
    
    ;faim = 45 
    ;-----------
    vvf2:
        CALL affiche_faim                               ;on affiche la valeur de faim
        CALL ajustement_fe                              ;on ajuste l'affichage de la jauge de faim 
        MOV sprite,OFFSET enfant_affame                 ;on place l'adresse de l'asciiart de l'enfant affame dans la varibale sprite
        MOV debut_goregotchi,OFFSET enfant_debut_affame ;on place l'adresse de l'asciiart enfant_debut_affame
        affiche_enfant                                  ;on affiche l'enfant affame    
        CALL affiche_danger                             ;on previent le joueur du danger : goregotchi peut mourrir de faim s'il ne fait rien
        CALL reaction_danger2                           ;on demande au joueur s'il veut le faire manger ou pas
        
    fin_vvf2:
        RET
    
verif_valeur_faim2 ENDP 


verif_valeur_dis2 PROC
    
    ;discipline < 50 ?
    ;-----------------
    CMP discipline,50d          ;on compare discipline a 50
    JB change_dis1              ;si discipline < 50 on va au label change_dis1
    MOV discipline,50d          ;on remet discipline a 50
    MOV seconde,0               ;on affecte 0 a la variable seconde
    JMP fin_vvd2
    
    ;discipline < 40 ?
    ;-----------------
    change_dis1:
        CMP discipline,40d      ;on compare discipline a 40
        JB change_dis2          ;si discipline < 40 on va au label change_dis2
        MOV seconde,10d         ;on affecte 10 a la variable seconde
        JMP fin_vvd2
        
    ;discipline < 35 ?
    ;-----------------
    change_dis2:
        CMP discipline,35d      ;on compare discipline a 35
        JB change_dis3          ;si discipline < 35 on va au label change_dis3
        MOV seconde,15d         ;on affecte 15 a la variable seconde
        JMP fin_vvd2
        
    ;discipline < 30 ?
    ;------------------
    change_dis3:
        CMP discipline,30d       ;on compare discipline a 30
        JB change_dis4          ;si discipline < 30 on va au label change_dis4
        MOV seconde,20d         ;on affecte 20 a la variable seconde
        JMP fin_vvd2
        
    ;discipline < 25 ?
    ;------------------
    change_dis4:
        CMP discipline,25d      ;on compare discipline a 25
        JB change_dis5          ;si discipline < 25 on va au label change_dis5
        MOV seconde,25d         ;on affecte 25 a la variable seconde
        JMP fin_vvd2
        
    ;discipline < 20 ?
    ;-----------------
    change_dis5:
        CMP discipline,20d      ;on compare discipline a 20
        JB change_dis6          ;si discipline < 20 on va au label change_dis6
        MOV seconde,30d         ;on affecte 30 a la variable seconde
        JMP fin_vvd2
    
    ;discipline < 15 ?
    ;-----------------    
    change_dis6:
        CMP discipline,15d      ;on compare discipline a 15
        JB change_dis7          ;si discipline < 15 on va au label change_dis7
        MOV seconde,35d         ;on affecte 35 a la variable seconde
        JMP fin_vvd2
    
    ;discipline < 10 ?
    ;------------------
    change_dis7:
        CMP discipline,10d      ;on compare discipline a 10
        JB change_dis8          ;si discipline < 10 on va au label change_dis8
        MOV seconde,40d         ;on affecte 40 a la variable seconde
        JMP fin_vvd2
    
    ;discipline < 5 ?
    ;-----------------
    change_dis8:
        CMP discipline,5d       ;on compare discipline a 5
        JB change_dis9          ;si discipline < 5 on va au label change_dis9
        MOV seconde,45d         ;on affecte 45 a la variable seconde
        JMP fin_vvd2
        
    ;discipline = 0
    ;--------------
    change_dis9:
        MOV seconde,59d         ;on affecte 59 a la variable seconde
            
    
    fin_vvd2:
        RET    
verif_valeur_dis2 ENDP    