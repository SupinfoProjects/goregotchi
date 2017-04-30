name "GOREGOTCHI"

ORG 100h
JMP main

;les .asm commun
include "commun/attente.asm"
include "commun/debut_et_fin.asm"
include "commun/random.asm"
include "commun/initialisation.asm" 
include "commun/menu.asm"
include "commun/evolution.asm"
include "commun/divertir.asm"
include "commun/nourrir.asm" 
include "commun/affichage.asm"
include "commun/desobeissance.asm"


;les .asm du bebe
include "bebe/actions_bebe.asm" 
include "bebe/desobeissance_bebe.asm"
include "bebe/jeu_bebe.asm"
include "bebe/manger_bebe.asm"
include "bebe/menu_bebe.asm" 
include "bebe/punir_bebe.asm"
include "bebe/status_bebe.asm"
include "bebe/temps_bebe.asm"    

;les .asm de l'enfant
include "enfant/actions_enfant.asm"
include "enfant/desobeissance_enfant.asm"
include "enfant/jeu_enfant.asm"
include "enfant/manger_enfant.asm"
include "enfant/menu_enfant.asm"
include "enfant/punir_enfant.asm"
include "enfant/status_enfant.asm"
include "enfant/temps_enfant.asm"

;les .res des asciiarts 
include "asciiart/asciiart_bebe.res" 
include "asciiart/asciiart_enfant.res"

include "asciiart/ecrans.res"
include "asciiart/desobeissance.res"
include "asciiart/header_et_footer.res"
include "asciiart/manger.res"
include "asciiart/punition.res" 

;les .inc des macros
include "macro/affichage_divers.inc"
include "macro/affichage_bebe.inc"
include "macro/affichage_enfant.inc"
include emu8086.inc

;--------------------------------------------------------------------
;LES CONSTANTES                                                       
;--------------------------------------------------------------------
lignes equ 25d
colonnes equ 80d

;-------------------------------------------------------------------
;                       LES VARIABLES                                                     
;-------------------------------------------------------------------

    ;les jauges
    joie DW 20d                         ;on utilise DW au lieu de DB parce que l'on va placer les variables dans le registre AX qui est sur 16bits donc il nous faut une variable sur 16bits
    discipline dw 20d
    faim dw 20d
    
    ;le positionnement
    position_x db ?
    position_y db ? 
    
    ;variable pour comparer ce que le joueur a saisi
    jouer   db "j"                    
    punir   db "p"                    
    manger  db "m"                  
    quitter db "q" 
    snack   db "s"
    repas   db "r"
    droite  db "d"                       ;variable pour comparer ce que le joueur a saisi
    gauche  db "g"                       ;variable pour comparer ce que le joueur a saisi
    
    
    min_faim db ?
    sec_faim db ?
    h_faim db ? 
    
    min_jeu db ?
    sec_jeu db ?
    h_jeu db ? 
    
        
    min_up db ?
    sec_up db ?
    h_up db ?
    
    sprite  dw ?                        ;variable qui prendra la valeur de l'adresse d'un asciiart pour affichier l'humeur correspondante
        
    aleatoire db ?                      ;variable qui prendra la valeur 0 ou 1 selon la procedure random
    
    victoire dw 0                       ;stocke le nombre de victoire du joueur (le nombre de fois que le joueur a bien devine)
    
    action  db ?                        ;variable pour stocker ce que le joueur va saisir, on a limite la saisie a 6 caracteres
    
    nature_saisie db ?                  ;variable pour stocker la saisie du joueur sont forme binaire (1 pour droite, 0 pour gauche)
    
    seconde db 15d                      ;variable qui permet de tire la langue quand le joueur tape j entre 0 et 15s (temps systeme)
    
    grandir db 0                        ;variable qui permet de passer a l'age suivant
    
    jeu db 0                            ;variable pour stocker le nombre de fois que le joueur joue
    
    refus db ?                          ;variable permettant a goregotchi de refuser de jouer 
    
    age db 1                            ;variable definissant l'age de goregotchi
        
    footer dw ?
    
    debut_goregotchi dw ?
    
main:
    CALL lancement_bebe
    
    etape1:
        affiche_footer_info
        CALL action_du_joueur
        CMP age,2
    JNE etape1

    CALL lancement_enfant    

    etape2:
        affiche_footer_info
        CALL action_du_joueur2
        CMP age,3
    JNE etape2    

        
    fin_de_jeu:
        MOV AX, 4c00h                       ;retour au systeme d'exploitation
        INT 21h
 

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_GET_STRING
DEFINE_PRINT_STRING 
DEFINE_CLEAR_SCREEN 
END