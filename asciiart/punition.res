;------------------------------------------------------------------------------------
; LE COIN
;------------------------------------------------------------------------------------

coin_sprite1	db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"
				db	"||$"

largeur_coin	equ 3
hauteur_coin1	equ 14

coin_sprite2	db	"\\______________________________________$"



;------------------------------------------------------------------------------------
; AVEC CES SPRITES ON EFFACE LE COIN
;------------------------------------------------------------------------------------

efface_coin_sprite1	db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"
					db	"  $"

efface_coin_sprite2	db	"                                        $"



porte	db	"    __$"
		db	"   //|$"
		db	"  //||$"
		db	" // ||$"
		db	"||  ||$"
		db	"||  ||$"
		db	"||  ||$"
		db	"||  ||$"
		db	"||  ||$"
		db	"||O ||$"
		db	"||  ||$"
		db	"||  ||$"
		db	"||  ||$"
		db	"||  ||$"
		db	"||  //$"
		db	"|| // $"
		db	"||//  $"

largeur_porte	equ	7
hauteur_porte	equ	16

e_porte	db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"
		db	"      $"

consigne	db	"  ______                 _                 _ $"
			db	" / _____)               (_)               // $"
			db	"| /      ___  ____   ___ _  ____ ____   ____ $"
			db	"| |     / _ \|  _ \ /___) |/ _  |  _ \ / _  )$"
			db	"| \____| |_| | | | |___ | ( ( | | | | ( (/ / $"
			db	" \______)___/|_| |_(___/|_|\_|| |_| |_|\____)$"
			db	"                          (_____|            $"

largeur_consigne	equ 46
hauteur_consigne	equ	7

e_consigne	db	"                                             $"
			db	"                                             $"
			db	"                                             $"
			db	"                                             $"
			db	"                                             $"
			db	"                                             $"
			db	"                                             $"
			