;==============================================
;	permet d'afficher les sprites d'enfant
;==============================================
affiche_enfant MACRO
	LOCAL boucle,boucle2
	PUSH AX
	PUSH DX

	affectexy 22,3
	MOV AH,9h
	MOV DX,debut_goregotchi
	boucle:
		CALL deplace_curseur
		INT 21h
		INC position_y
		ADD DX,largeur_enfant
		CMP position_y,10d
	JNE boucle
	
	MOV DX,sprite
	boucle2:
		CALL deplace_curseur
		INT 21h
		INC position_y
		ADD DX,largeur_enfant
		CMP position_y,15d
	JNE boucle2
	POP DX
	POP AX
ENDM

;==============================================
;	permet d'afficher les sprites d'enfant
;==============================================
affiche_enfant2 MACRO
	LOCAL boucle,boucle2
	PUSH AX
	PUSH DX

	MOV AH,9h
	MOV DX,debut_goregotchi
	boucle:
		CALL deplace_curseur
		INT 21h
		INC position_y
		ADD DX,largeur_enfant
		CMP position_y,10d
	JNE boucle

	MOV DX,sprite
	boucle2:
		CALL deplace_curseur
		INT 21h
		INC position_y
		ADD DX,largeur_enfant
		CMP position_y,15d
	JNE boucle2
	POP DX
	POP AX
ENDM