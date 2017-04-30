;====================================================================================;
;| ICI CE TROUVE TOUTE LES PROCEDURES EN RELATION AVEC LE MENU PRINCIPALE DU JEU    ;|
;| -----------------------------------------------------------------------------    ;|
;|                                                                                  ;|
;| * jauge() : permet d'afficher le titre et les differentes jauges du jeu avec leur;|
;|             valeur initiales                                                     ;|
;|                                                                                  ;|
;| * info() : permet d'afficher le footer d'informations indiquant au joueur les    ;|
;|            quelles sont les actions qu'il peut effectuer                         ;|
;|                                                                                  ;|
;| * efface_info() : permet d'effacer le footer d'informations                      ;|
;|                                                                                  ;|
;| * efface_ecran() : permet de scroller pour effacer le contenu de l'ecran         ;|
;|                                                                                  ;|
;| * affiche_discipline() : permet d'afficher la valeur de la variable              ;|
;|                          discipline correctement selon que se soit un chiffre    ;|
;|                          ou un nombre
;|                                                                                  ;|
;| * affiche_joie() : permet d'afficher la valeur de la variable joie correctement  ;|
;|                    selon que se soit un chiffre ou un nombre                     ;|
;|                                                                                  ;|
;| * affiche_faim() : permet d'afficher la valeur de la variable faim correctement  ;|  
;|                                                                                  ;|        
;====================================================================================;

animation PROC
    
    affectexy 23,4 
    affiche_bebe2
    
    affectexy 22,4 
    affiche_bebe2
    
    affectexy 23,4 
    affiche_bebe2
    
    affectexy 25,4 
    affiche_bebe2
    
    affectexy 23,4 
    affiche_bebe2
    RET    
animation ENDP     


lancement_bebe PROC
    ;affichage de l'ecran de demarrage 
    MOV sprite,OFFSET demarrage
    affectexy 10,0
    affiche_sprite sprite,largeur_demarrage,23 
    
    CALL trois_secondes
    
    CALL CLEAR_SCREEN
    
    MOV sprite,OFFSET transition
    affectexy 10,0
    affiche_sprite sprite,largeur_demarrage,23
    
    CALL trois_secondes
    
    CALL CLEAR_SCREEN
     
    ;affichage de l'en-tete (titre et jauges)
    MOV sprite,OFFSET header
    affectexy 0,0    
    affiche_sprite sprite,colonnes,3 
    
    ;initialisation des variables pour la notion  de temps
    CALL initialise_faim
    CALL initialise_jeu
    CALL initialise_croissance 
    
    ;affichage du tamagotchi
    CALL verif_valeur_joie   
    
    RET
    
lancement_bebe ENDP   

ajustement_db PROC
    GOTOXY 76,0
    PRINT "/40"
    RET    
ajustement_db ENDP

ajustement_jb PROC
    GOTOXY 76,1
    PRINT "/40"
    RET    
ajustement_jb ENDP

ajustement_fb PROC
    GOTOXY 76,2
    PRINT "/40"
    RET    
ajustement_fb ENDP       