;====================================================================================;
;|      ICI CE TROUVE LES PROCEDURES POUR AFFICHER LES ECRANS DE DEBUT ET DE FIN    ;|
;|      ------------------------------------------------------------------------    ;|
;|                                                                                  ;|
;| * termine() : affiche l'ecran de fin de jeu                                      ;|
;|                                                                                  ;|
;| * mort() : affiche le cerceuil a la mort de goregotchi                           ;|
;|                                                                                  ;|
;===================================================================================;|

termine PROC
    affectexy 3,0                               ;on modifie les valeurs des variables position_x et position_y
    MOV sprite,OFFSET ecran_fin                 ;on place l'adresse de l'asciiart "ecran_fin" dans la variable sprite
    affiche_sprite sprite,largeur_ecran_fin,23  ;on appelle le macro affiche_sprite pour afficher l'asciiart de l'ecran de fin de jeu
    RET
termine ENDP 


mort PROC
    affectexy 20,2                              ;on modifie les valeurs des variables position_x et position_y
    MOV sprite,OFFSET cerceuil                  ;on place l'adresse de l'asciiart "cerceuil" dans la variable sprite
    affiche_sprite sprite,largeur_cerceuil,21   ;on appelle le macro affiche_sprite pour afficher l'asciiart du cerceuil a l'ecran
    RET    
mort ENDP   

deces PROC
	CALL CLEAR_SCREEN                               ;on efface entierement l'ecran
	CALL mort                                       ;on appelle la procedure mort pour afficher le cerceuil de goregotchi
	CALL trois_secondes                             ;on attends 3 secondes
	CALL trois_secondes                             ;on attends 3 secondes
	CALL CLEAR_SCREEN                               ;on efface entierement l'ecran
	CALL termine                                    ;on appelle la procedure termine pour afficher l'ecran de fin de jeu    
    RET
deces ENDP