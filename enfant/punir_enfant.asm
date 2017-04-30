;====================================================================================;
;|          ICI CE TROUVE TOUTES LES PROCEDURES POUR PUNIR LE BEBE                  ;|
;|          ------------------------------------------------------                  ;|
;|                                                                                  ;|
;| * punition_juste() : permet de punir le bebe et de modifier la valeur des        ;|
;|                      variables discipline et joie                                ;|
;|                                                                                  ;|
;| * punition_injuste() : permet de punir le bebe et de modifier la valeur des      ;|
;|                        variables discipline et joie                              ;|
;|                                                                                  ;|
;| * coin() : permet d'afficher le coin                                             ;|
;|                                                                                  ;|
;| * bebe_au_coin() : permet  d'afficher le bebe au coin                            ;|
;|                                                                                  ;|
;| * efface_bebe_heureux() : permet d'effacer le bebe heureux                       ;|
;|                                                                                  ;|
;| * efface_bebe_au_coin() : permet d'effacer le bebe au coin                       ;|
;|                                                                                  ;|
;| * efface_coin() : permet d'effacer le coin                                       ;|
;|                                                                                  ;|
;====================================================================================;

punition_juste_e PROC

    CALL punis_enfant               ;on punit l'enfant en le consignant
    
    ;joie >= 5 ?
    ;-------------------------------
    CMP joie,5d                     ;on compare joie a 5
    JAE cinq_enfant                 ;si joie >= 5 on va au label cinq_j
    
    ;joie < 5 
    ;-------------------------------
    MOV joie,0                      ;on ramene joie a 0 car on aurait du lui soustraire 5
    JMP suivant_enfant
    
    cinq_enfant:
        ;joie = joie - 5
        ;---------------------------
        SUB joie,5d                 ;on soustrait 5 a joie
    
    suivant_enfant:
        CALL verif_valeur_joie2         ;on affiche l'humeur du bebe en fonction de la valeur de joie
        CALL affiche_joie               ;on affiche la valeur de la variable joie  
        CALL ajustement_je              ;on ajuste l'affichage de la jauge de joie
        
        ;discipline = discipline + 5
        ;--------------------------- 
        ADD discipline,5d               ;on ajoute 5 a discipline
        CALL verif_valeur_dis2          ;on verifie la valeur de discipline pour modifier la variable seconde avant d'afficher discipline
        CALL affiche_discipline         ;on affiche la valeur de discipline
        CALL ajustement_de              ;on ajuste l'affichage de la jauge de discipline
        RET 
punition_juste_e ENDP 

punition_injuste_e PROC 
    
    CALL punis_enfant                   ;on punit l'enfant en le consignant
    ;joie >= 10 ?
    ;-----------------------------------
    CMP joie,10d                        ;on compare joie a 10
    JAE dix_enfant                      ;si joie >= 10 on va au label dix_j
    
    ;joie < 10
    ;----------
    MOV joie,0                          ;on ramene la variable joie a 0 car on aurait du lui soustraire 10
    JMP suivant_enfant2
    
    dix_enfant:
        ;joie = joie - 10
        ;-------------------------------
        SUB joie,10d

    suivant_enfant2:         
        CALL verif_valeur_joie2         ;on affiche l'humeur du bebe en fonction de la valeur de joie                        
        CALL affiche_joie               ;on affiche la valeur de joie
        CALL ajustement_je              ;on ajustement l'affichage de la jauge de joie

        ;discipline >= 5
        ;-------------------------------
        CMP discipline,5d
        JAE suivant_enfant3             ;si joie >=5 on va au label suivant3
        ;discipline < 5
        MOV discipline,0                ;on ramene discipline a 0 car on aurait du lui soustraire 5
        JMP suivant_enfant4             ;si discpline < 5 c'est que discipline = 0 donc on va diretement 
        
        ;discipline = discipline - 5
        ;----------------------------
        suivant_enfant3:
            SUB discipline,5d   
        
        suivant_enfant4:
        CALL verif_valeur_dis2          ;on verifie la valeur de discipline avant d'afficher
        CALL affiche_discipline         ;on affiche la valeur de discipline
        CALL ajustement_de              ;on ajuste l'affichage de la jauge de discipline
        RET 
punition_injuste_e ENDP 



punis_enfant PROC
    MOV sprite,OFFSET enfant_triste                 ;on place l'adresse de l'asciiart enfant_triste dans la variable sprite
    affiche_enfant                                  ;on affiche le l'enfant triste                   
    efface_footer                                   ;on efface le footer d'informations
    CALL trois_secondes                             ;on attend trois secondes
    
    CALL affiche_la_porte
    
    MOV sprite,OFFSET efface_enfant_sprite          ;==================;
    affectexy 22,3                                  ;ON EFFACE L'ENFANT;
    affiche_sprite sprite,largeur_enfant,15d        ;==================;
    
    MOV sprite,OFFSET enfant_f_g                    ;===========================================;
    affectexy 8,3                                   ;ON AFFICHE L'ENFANT BOUDANT DEVANT LA PORTE;
    affiche_sprite sprite,largeur_enfant,15         ;===========================================;
    
    MOV jeu,4                                       ;on utilise la variable jeu exceptionnellement comme compteur donc on lui affecte 4
    
    clignotte_consigne: 
        CALL affiche_consigne
        
        CALL trois_secondes                         ;on attends 3 secondes  
        
        CALL efface_consigne
        
        DEC jeu                                     ;on decremente notre compteur jeu
        CMP jeu,0                                   ;on compare notre compteur jeu a 0
    JNE clignotte_consigne                          ;tant que jeu != 0 on va au label clignotte_consigne
    
    
    MOV sprite,OFFSET efface_enfant_sprite          ;==================;    
    affectexy 8,3                                   ;ON EFFACE L'ENFANT;
    affiche_sprite sprite,largeur_enfant,15         ;==================;
       
    CALL verif_valeur_joie2                         ;on actualise l'humeur de goregotchi
    
    CALL efface_la_porte
    
    RET
    
punis_enfant ENDP
