;------------------------------------------------------------------------------------
; LE FOOTER D'INFORMATIONS POUR LE JOUEUR
;------------------------------------------------------------------------------------

info_sprite	db	"                                                   Entre une action !          $"
			db	"                                                                               $"
			db	"*-----------------------------------------------------------------------------*$"
			db	"| Tu peux entrer les actions suivantes :                                       |$"
			db	"| jouer = j           punir = p            manger = m            quitter = q  |$"
			db	"*-----------------------------------------------------------------------------*$"

longueur_info	equ 4

efface_info_sprite	db	"                                                                               $"
					db	"                                                                               $"
					db	"                                                                               $"	
					db	"                                                                               $"
					db	"                                                                               $"
					db	"                                                                               $"


header	db	"                            GOREGOTCHI-TAMAGOTCHI            DISCIPLINE  : 20/40$"
		db	"                                                                   JOIE  : 20/40$"
		db	"                                                                   FAIM  : 20/40$"

header2	db	"                            GOREGOTCHI-TAMAGOTCHI            DISCIPLINE  :   /50$"
		db	"                                                                   JOIE  :   /50$"
		db	"                                                                   FAIM  :   /50$"

header3	db	"                            GOREGOTCHI-TAMAGOTCHI            DISCIPLINE  :   /60$"
		db	"                                                                   JOIE  :   /60$"
		db	"                                                                   FAIM  :   /60$"

header4	db	"                            GOREGOTCHI-TAMAGOTCHI            DISCIPLINE  :   /70$"
		db	"                                                                   JOIE  :   /70$"
		db	"                                                                   FAIM  :   /70$"


footer_jeu	db	"        Entre un choix !                                                       $"
			db	"                                                                               $"
			db	"*-----------------------------------------------------------------------------*$"
			db	"| Devine ou iront les yeux ! Tu a le choix entre :                             |$"
			db	"|      a droite = d             a gauche = g                  quitter = q     |$"
			db	"*-----------------------------------------------------------------------------*$"


footer_repas	db	"        Entre un choix !                                                       $"
				db	"                                                                               $"
				db	"*-----------------------------------------------------------------------------*$"
				db	"| Que veux tu qu'il mange ? Tu a le choix entre :                              |$"
				db	"|      un snack = s              un repas = r                 quitter = q     |$"
				db	"*-----------------------------------------------------------------------------*$"




alerte1	db	" _____ ___________ _____ _____ _____ _____ _____  _   _ _____ $"
		db	"|  __ \  _  | ___ \  ___|  __ \  _  |_   _/  __ \| | | |_   _|$"
		db	"| |  \/ | | | |_/ / |__ | |  \/ | | | | | | /  \/| |_| | | |  $"
		db	"| | __| | | |    /|  __|| | __| | | | | | | |    |  _  | | |  $"
		db	"| |_\ \ \_/ / |\ \| |___| |_\ \ \_/ / | | | \__/\| | | |_| |_ $"
		db	" \____/\___/\_| \_\____/ \____/\___/  \_/  \____/\_| |_/\___/ $"

alerte2	db	"                                                   _   _   _  $"
		db	" _____   _  _____ _   _  _   _ _   _ _____ _____  | | | | | | $"
		db	"/  ___| // |  ___| \ | || \ | | | | |_   _|  ___| | | | | | | $"
		db	"\ `--.     | |__ |  \| ||  \| | | | | | | | |__   | | | | | | $"
		db	" `--. \    |  __|| .   || .   | | | | | | |  __|  |_| |_| |_| $"
		db	"/\__/ /    | |___| |\  || |\  | |_| |_| |_| |___   _   _   _  $"
		db	"\____/     \____/\_| \_/\_| \_/\___/ \___/\____/  (_) (_) (_) $"


e_alerte	db	"                                                              $"
			db	"                                                              $"
			db	"                                                              $"
			db	"                                                              $"
			db	"                                                              $"
			db	"                                                              $"
			db	"                                                              $"

largeur_alerte	equ	63

