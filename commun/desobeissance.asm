tirage2 PROC
    PUSH CX                                                 ;on sauvegarde le contenu de CX
    MOV CX,3                                                ;on place 3 dans CX pour que goregotchi tire la langue 3 fois 
    ;=======================================================;
    ; ici on affiche successivement plusieurs bouche pour   ;
    ;                   tirer la langue                     ;
    ;=======================================================;     
    tirage_enfant:
        MOV sprite,OFFSET mache11
        affectexy 35,9 
        affiche_sprite sprite,largeur_bouche_enfant,12       ;\_____/
        
        MOV sprite,OFFSET mache22                            ;_______
        affectexy 35,9                                       ;\_____/
        affiche_sprite sprite,largeur_bouche_enfant,12                
        
        
        MOV sprite,OFFSET langue_sortie2                     ;________
        affectexy 35,10                                      ;\__//__/
        affiche_sprite sprite,largeur_bouche_enfant,13       ;   V
        
        
        MOV sprite,OFFSET mache22                            ;_______
        affectexy 35,9                                       ;\_____/
        affiche_sprite sprite,largeur_bouche_enfant,12                
        
        GOTOXY 38,12
        PRINT " "                                           ;on efface le v de la langue
    loop tirage_enfant                                      ;on decremente CX et si CX != 0 on va au label tirage_enfant
    POP CX                                                  ;on restaure le contenu de CX
    RET    
tirage2 ENDP  
