affiche_les_yeux PROC
    
    CMP aleatoire,1                 ;on compare aleatoire a 1
    JZ a_droite                     ;si aleatoire est egale a 1, on va au label a_droite 
                                    ;sinon on affiche les yeux a gauche
;   on affiche les yeux a gauche         
;-----------------------------------    
    a_gauche:

        GOTOXY 32,7                 ;on positionne le curseur
        PRINT "O"                   ;oeil gauche 
        GOTOXY 43,7                 ;on positionne le curseur
        PRINT "O"                   ;oeil droit
        JMP fin_affiche             ;une fois les yeux affiches on va au label fin_affiche

        
;   on affiche les yeux a droite         
;-----------------------------------        
    a_droite:

        GOTOXY 35,7                 ;on positionne le curseur
        PRINT "O"                   ;on affiche l'oeil gauche
        GOTOXY 46,7                 ;on positionne le curseur
        PRINT "O"                   ;on affiche l'oeil droit

    fin_affiche:
        RET
affiche_les_yeux ENDP



efface_les_yeux PROC
    
    CMP aleatoire,1                 ;on compare aleatoire a 1 
    JZ a_droite2                    ;si aleatoire est egale a 1, on va au label a_droite2
                                    ;sinon on efface les yeux a gauche
                            
;   on efface les yeux a gauche         
;-----------------------------------
    a_gauche2:
        GOTOXY 31,5                 ;on positionne le curseur
        PRINT " "                   ;on efface l'oeil gauche
        GOTOXY 42,5                 ;on positionne le curseur
        PRINT " "                   ;on efface l'oeil droit
        JMP fin_efface              ;une fois les yeux effaces on va au label fin_efface

;   on efface les yeux a droite         
;-----------------------------------        
    a_droite2:
        GOTOXY 34,5                 ;on positionne le curseur
        PRINT " "                   ;on efface l'oeil gauche
        GOTOXY 45,5                 ;on positionne le curseur
        PRINT " "                   ;on efface l'oeil droit      
           
    fin_efface:   
        RET       
efface_les_yeux ENDP       

justesse PROC                                   ;====================================;
    PUSH CX                                     ;SAUVEGARDE DU REGISTRES DANS LA PILE;
                                                ;====================================;
    
    CMP nature_saisie,0                         ;on compare nature_saisie a 0
    JZ verif1                                   ;si nature_saisie = 0 on va au label verif1 
                                                
    
    ; quand le joueur a entre "droite"
    ;----------------------------------
    verif2:
        MOV CL,nature_saisie                    ;on place nature_saisie dans CL
        CMP aleatoire,CL                        ;on compare nature_saisie et aleatoire
        JZ egale                                ;si nature_saisie = aleatoire alors on va au label egale
        JMP non_egale                           ;sinon on va au label non_egale 
                                                
   
    ; quand le joueur a entre "gauche"
    ;----------------------------------
    verif1:
        MOV CL,nature_saisie                    ;on place nature_saisie dans CL
        CMP aleatoire,CL                        ;on compare nature_saisie et aleatoire
        JZ egale                                ;si nature_saisie = aleatoire alors on va au label egale
        JMP non_egale                           ;sinon on va au label non_egale
    
    ; quand le joueur A DEVINER
    ;----------------------------------
     egale:
        INC victoire                            ;on incremente victoire
                                    
        GOTOXY 8,18                             ;on positionne le curseur
        PRINT "                              "  ;on efface l'ancien message
        GOTOXY 8,18                             ;on positionne le curseur
        PRINT "Bien joue !!!"                   ;on affiche le message "Bien joue !!!"
                        
        JMP fin_justesse                        ;on va au label fin_justesse
    
    ; quand le joueur N'A PAS DEVINER
    ;----------------------------------   
     non_egale:
        
        GOTOXY 8,18                             ;on positionne le curseur
        PRINT "                              "  ;on efface l'ancien message   
        GOTOXY 8,18                             ;on positionne le curseur
        PRINT "Rate... Tu es nul ! :'("         ;on affiche le message "Rate... Tu es nul ! :'("
        
    fin_justesse:
                                                ;=========================;
        POP CX                                  ;RESTAURATION DU REGISTRES;        
        RET                                     ;=========================;
justesse ENDP  