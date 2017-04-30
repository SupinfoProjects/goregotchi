;les différentes bouches pour que le bebe puisse macher
;-------------------------------------------------------
mache1	db	"        $"
		db	"        $"
		db	"\______/$"

mache2	db	"        $"
		db	"________$"
		db	"\______/$"

mache3  db	" ______ $"
		db	"/      \$"
		db	"\______/$"

mache4	db	"        $"
		db	"        $"
		db	" _____/'$"

largeur_bouche_bebe	equ	9

;------------------------------------------------------------------------------------
; LE BEBE REFUSE
;------------------------------------------------------------------------------------
bebe_refuse	db	"  ##         ______          ##  $"
			db	"  ##        /      \ NAH!    ##  $"
			db	"   ##       \______/        ##   $"

enfant_refuse	db	"  ##          _______          ##  $"
				db	"  ##         /       \  NON !  ##  $"
				db	"   ##        \_______/        ##   $"				

largeur_bouche_enfant	equ	10

mache11	db	"         $"
		db	"         $"
		db	"\_______/$"

mache22	db	"         $"
		db	"_________$"
		db	"\_______/$"

mache33  db	" _______ $"
		db	"/       \$"
		db	"\_______/$"

mache44	db	"         $"
		db	"         $"
		db	" ______/'$"


;------------------------------------------------------------------------------------
; REPAS DE GOREGOTCHI
;------------------------------------------------------------------------------------
plat1	db	"  oooo  $"
		db	" oooooo $"
		db	"oooooooo$"
		db	"\______/$"

largeur_plat	equ 9

non db	"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$"
	db 	"!!! GOREGOTCHI NE VEUT PAS MANGER !!!$"
	db	"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$"

e_non	db	"                                     $"
		db	"                                     $"
		db	"                                     $"

texte_refuse	db	"Goregotchi refuse de manger !!!!    $"
				db	"Il a deja assez mange quand meme... $"
				db	"On dirait que tu veux l'engraisser !$"

largeur_texte_refuse	equ	37				


e_texte_refuse	db	"                                    $"
				db	"                                    $"
				db	"                                    $"


danger		db	"          ###               !!! GOREGOTCHI A TRES FAIM !!!        $"
			db	"         #####                                                    $"
			db	"       ### | ###         SI TU NE LE NOURRIS PAS IL VA MOURRIR !  $"
			db	"      ##   |   ##                                                 $"
			db	"    ###    |    ###        Snack (s), repas (r), ou  autre  :     $"
			db	"  ###       o       ###                                           $"
			db	"########################   SI TU NE TAPE PAS s OU r IL MEURT !    $"

largeur_danger	equ	67

e_danger		db	"                                                                  $"
				db	"                                                                  $"
				db	"                                                                  $"
				db	"                                                                  $"
				db	"                                                                  $"
				db	"                                                                  $"
				db	"                                                                  $"				