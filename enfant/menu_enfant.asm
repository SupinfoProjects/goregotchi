ajustement_de PROC
    GOTOXY 76,0
    PRINT "/50"
    RET   
ajustement_de ENDP


ajustement_je PROC
    GOTOXY 76,1
    PRINT "/50"
    RET   
ajustement_je ENDP


ajustement_fe PROC
    GOTOXY 76,2
    PRINT "/50"
    RET   
ajustement_fe ENDP


animation2 PROC
    affectexy 22,3 
    affiche_enfant2
    
    affectexy 21,3 
    affiche_enfant2
    
    affectexy 22,3 
    affiche_enfant2
    
    affectexy 23,3 
    affiche_enfant2
    
    affectexy 22,3 
    affiche_enfant2
    RET    
animation2 ENDP      


lancement_enfant PROC
    ;affichage de l'en-tete (titre et jauges)
    MOV sprite,OFFSET header2
    affectexy 0,0    
    affiche_sprite sprite,colonnes,3
    
    ;affichage de la valeur de discipline
    CALL affiche_discipline
    CALL ajustement_de
    
    ;affichage de la valeur de joie
    CALL affiche_joie
    CALL ajustement_je
    
    ;affichage de la valeur de faim
    CALL affiche_faim
    CALL ajustement_fe
    
    ;mise a jour des variables pour la notion du temps
    CALL initialise_jeu
    CALL initialise_faim
    CALL initialise_croissance
    RET
lancement_enfant ENDP