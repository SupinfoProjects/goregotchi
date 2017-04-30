;------------------------------------------------------------------------------------
; LA LANGUE DE GOREGOTCHI
;------------------------------------------------------------------------------------
langue_sortie 	db	"________$"
				db	"\__//__/$"
				db	"   V    $"

langue_sortie2 	db	"_________$"
				db	"\__//___/$"
				db	"   V     $"


;------------------------------------------------------------------------------------
; MESSAGE A AFFICHER QUAND GOREGOTCHI TIRE LA LANGUE
;------------------------------------------------------------------------------------

avertissement	db 	"Goregotchi te tire la langue...            $"
				db	"Si tu veux le punir tape p.                $"
				db	"Sinon tape c pour continuer.               $"
				db	"Entre une action  !                        $"

largeur_avertissement	equ 44


e_avertissement	db 	"                                           $"
				db	"                                           $"
				db	"                                           $"
				db	"                                           $"
				db	"                                           $"
				db	"                                           $"


refus_jeu	db	"!!! GOREGOTCHI NE VEUX PAS JOUER !!!$"

e_refus_jeu	db	"                                    $"

largeur_refus_jeu	equ	37