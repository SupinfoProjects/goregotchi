;================================================
;	permet d'afficher différents types de sprite
;================================================
affiche_sprite MACRO sprite,largeur,arret
	LOCAL boucle
	PUSH AX
	PUSH DX

	MOV AH,9h
	MOV DX,sprite

	boucle:
		CALL deplace_curseur
		INT 21h
		INC position_y
		ADD DX,largeur
		CMP position_y,arret
	JNE boucle
	POP DX
	POP AX
ENDM


;==============================================
;	permet d'afficher le footer d'information
;==============================================
affiche_footer_info MACRO 
	MOV footer,OFFSET info_sprite
    affiche_footer footer
ENDM


;==============================================
;	permet d'afficher les footers
;==============================================
affiche_footer MACRO footer
	LOCAL boucle
	PUSH AX
	PUSH DX

	affectexy 0,17
	MOV AH,9h
	MOV DX,footer

	boucle:
		CALL deplace_curseur
		INT 21h
		INC position_y
		ADD DX,colonnes
		CMP position_y,23
	JNE boucle
	POP DX
	POP AX
ENDM

;===================================================
;	permet d'afficher le footer d'information du jeu
;===================================================
affiche_footer_jeu MACRO 
	MOV footer,OFFSET footer_jeu
    affiche_footer footer
ENDM


;=======================================================
;	permet d'afficher le footer d'information des repas
;=======================================================
affiche_footer_nourrir MACRO
	MOV footer,OFFSET footer_repas                                                  
    affiche_footer footer 
ENDM  

;==============================================
;	permet d'effacer le footer d'information
;==============================================
efface_footer MACRO 
	MOV footer,OFFSET efface_info_sprite
    affiche_footer footer
ENDM


;==============================================
;	permet de modifier les variables position
;==============================================
affectexy MACRO a,b
	MOV position_x,a
	MOV position_y,b
ENDM