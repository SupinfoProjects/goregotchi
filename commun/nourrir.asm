cerise PROC
    GOTOXY 31,10                                    ;====================;
    PRINT "/\"                                      ;ON AFFICHE LA CERISE;
    GOTOXY 30,11                                    ;====================;
    PRINT "()()"                                    
    
    CALL macher                                     ;on appelle la procedure macher pour que goregotchi puisse avoir l'air de macher la cerise
    
    GOTOXY 31,10                                    ;=================================;
    PRINT "/ "                                      ;ON EFFACE UNE PARTIE DE LA CERISE;
    GOTOXY 30,11                                    ;=================================;
    PRINT "()  "
    
    CALL macher                                     ;on appelle la procedure macher pour que goregotchi puisse avoir l'air de macher la cerise
    
    GOTOXY 31,10                                    ;=========================;
    PRINT "  "                                      ;ON EFFACE TOUTE LA CERISE;
    GOTOXY 30,11                                    ;=========================;
    PRINT "    "
    
    CALL trois_secondes                             ;on attends 3 secondes
    
    RET 
        
cerise ENDP


riz PROC
    
    affectexy 14,10                                 ;==================;
    MOV sprite,OFFSET plat1                         ;ON AFFICHE LE PLAT;
    affiche_sprite sprite,largeur_plat,14           ;==================;
    
    CALL macher                                     ;on appelle la procedure macher pour que goregotchi puisse avoir l'air de macher
        
    GOTOXY 16,10                                    ;==================================;
    PRINT "    "                                    ;ON EFFACE LA PREMIERE LIGNE DE RIZ;
    GOTOXY 15,11                                    ;==================================;
    PRINT "oo  oo"                              

    CALL macher                                     ;on appelle la procedure macher pour que goregotchi puisse avoir l'air de macher    

    GOTOXY 15,11                                    ;==============================;
    PRINT "      "                                  ;ON EFFACE LA 2EME LIGNE DE RIZ;
    GOTOXY 14,12                                    ;==============================;
    PRINT "oo    oo"
    
    CALL macher                                     ;on appelle la procedure macher pour que goregotchi puisse avoir l'air de macher

    GOTOXY 14,12                                    ;=========================;
    PRINT "        "                                ;ON EFFACE LE RESTE DU RIZ;
                                                    ;=========================;
    
    CALL macher                                     ;on appelle la procedure macher pour que goregotchi puisse avoir l'air de macher
    
    
    GOTOXY 14,13                                    ;=================;
    PRINT "        "                                ;ON EFFACE LE PLAT;
                                                    ;=================;
                                                    
    CALL trois_secondes                             ;on attends 3 secondes
    
    RET
                
riz ENDP     

macher PROC
    CMP age,1               ;on compare age a 1
    JZ petit                ;si age = 1 on va au label petit
    CALL macher2            ;sinon age > 1 donc on appelle la procedure macher2 car goregotchi n'est pas un bebe
    JMP fin_macher          ;on va au label fin_macher
    
    petit:
        CALL macher1        ;on appelle la procedure marcher1 car goregotchi est bebe
    
    fin_macher:
        RET    
macher ENDP   


macher2 PROC
    PUSH CX
    
    MOV CX,3
    boucle_m2:
        MOV sprite,OFFSET mache11
        affectexy 35,9 
        affiche_sprite sprite,largeur_bouche_enfant,12      ;\_____/
        
        MOV sprite,OFFSET mache22                           ;_______
        affectexy 35,9                                      ;\_____/
        affiche_sprite sprite,largeur_bouche_enfant,12            
        
        MOV sprite,OFFSET mache33                           ; _____
        affectexy 35,9                                      ;/     \
        affiche_sprite sprite,largeur_bouche_enfant,12      ;\_____/     
        
        MOV sprite,OFFSET mache22                           ;_______
        affectexy 35,9                                      ;\_____/
        affiche_sprite sprite,largeur_bouche_enfant,12            
        
        MOV sprite,OFFSET mache11
        affectexy 35,9 
        affiche_sprite sprite,largeur_bouche_enfant,12      ;\_____/
        
        MOV sprite,OFFSET mache44
        affectexy 35,9 
        affiche_sprite sprite,largeur_bouche_enfant,12      ;_____/'
       
    loop boucle_m2
    
    POP CX 
    RET
macher2 ENDP 