;====================================================================================;
;|       ICI CE TROUVE TOUTES LES PROCEDURES QUI CONCERNENT LE COMPORTEMENT         ;|
;|       ------------------------------------------------------------------         ;|
;|                                                                                  ;|
;| * verif_valeur_joie() : permet que la variable joie reste entre 0 et 40,         ;|
;|                         affihce l'humeur du bebe en fonction de sa valeur        ;|
;|                                                                                  ;|
;| * verif_valeur_faim() : permet d'afficher le bebe affame si faim = 35            ;|
;|                                                                                  ;|
;| * verif_valeur_dis() : permet que la variable discipline reste entre 0 et 40,    ;|
;|                        modifie la variable seonde en fonction de la valeur de    ;|
;|                        discipline                                                ;|
;|                                                                                  ;|
;====================================================================================;
 



verif_valeur_joie PROC
    MOV debut_goregotchi, OFFSET bebe_debut
    ;joie >= 40 ?
    ;--------------------------- 
    CMP joie,40d
    JAE suite1
    JMP suite2   
    
    ;joie >= 40 
    ;--------------------------- 
    suite1:   
        MOV joie,40d            ;on remet joie a 40 (valeur max)
        MOV sprite,OFFSET bebe_tres_joie
        JMP fin_v_joie   
    
        
    ;joie = 30 ?
    ;--------------------------- 
    suite2:
        CMP joie,30d            ;on compare joie a 30
        JB suite3               ;si joie < 30 on va au label suite3
                                ;sinon 40 > joie >= 30
        MOV sprite,OFFSET bebe_tres_joie
        JMP fin_v_joie
    
    ;joie = 20 ?
    ;---------------------------
    suite3:
        CMP joie,20d            ;on compare joie a 20
        JB suite4               ;si joie < 20 on va au label suite4
        
        MOV sprite,OFFSET bebe_joie
        JMP fin_v_joie
        
    
    ;joie = 10 ?
    ;---------------------------    
    suite4:
        CMP joie,10d            ;on compare joie a 10
        JB suite5               ;si joie est plus petit que 10 on va au label suite3 
        
        MOV sprite,OFFSET bebe_ennuye
        JMP fin_v_joie
    
    ;joie = 5 ?
    ;---------------------------    
    suite5:
        CMP joie,5d             ;on compare joie a 5
        JB suite6               ;si joie < 5 on va au label suite6 
        
        MOV sprite,OFFSET bebe_triste
        JMP fin_v_joie
    
    ;joie = 0 
    ;---------------------------    
    suite6:
        MOV debut_goregotchi, OFFSET bebe_debut_tres_triste
        MOV sprite,OFFSET bebe_triste
               
    
    fin_v_joie:
        affiche_bebe            ;on affiche l'humeur du bebe   
        RET
verif_valeur_joie ENDP 


verif_valeur_faim PROC
    
    ;faim = 35 ?
    ;---------------------------  
    CMP faim,35d                ;on compare faim a 35
    JB fin_v_f                  ;si faim < 35 on va au label f1  
    
    CALL affiche_faim           
    CALL ajustement_fb
    
    MOV sprite,OFFSET bebe_affame
    affectexy 23,8
    affiche_sprite sprite,largeur_bebe,14
    efface_footer
    MOV sprite,OFFSET danger
    CALL affiche_danger
    CALL reaction_danger
    
    fin_v_f:
        RET
    
verif_valeur_faim ENDP  


verif_valeur_dis PROC
    ;discipline > 40 ?
    ;--------------------------
    CMP discipline,40d          ;on compare discipline a 40
    JB teste2                   ;sinon si discipline < 40 (CF=1) on va au label teste2
    
    ;discipline >= 40 
    ;--------------------------
    teste1: 
        MOV discipline,40d      ;on remet discipline a 40 car c'est la valeur max
        MOV seconde,0           ;on s'assure que la variable seconde = 0
        JMP fin_dis
                                
                                
    ;discipline = 35 ?          ;on sait que discipline < 40
    ;--------------------------
    teste2:
        CMP discipline,35d      ;on compare discipline a 35
        JB teste3               ;si discipline < 35 on va au label teste3
    
        ;discipline = 35 
        ;----------------------
        MOV seconde,5d          ;on affecte 5 a la variable seconde
        JMP fin_dis
    
    
    ;discipline = 30 ? 
    ;--------------------------    
    teste3:
        CMP discipline,30d      ;on compare discipline a 30
        JB teste4               ;si discipline < 30 on va au label teste4
        
        ;discipline = 30 
        ;----------------------
        MOV seconde,10d         ;on affecte 10 a la variable seconde
        JMP fin_dis                     
    
    
    ;discipline = 25 ? 
    ;--------------------------
    teste4:
        CMP discipline,25d      ;on compare discipline a 25
        JB teste5               ;si discipline < 25 on va au label teste5
        
        ;discipline = 25 
        ;----------------------
        MOV seconde,15d         ;on affecte 15 a la variable seconde
        JMP fin_dis
    
    ;discipline = 20 ? 
    ;--------------------------
    teste5:
        CMP discipline,20d      ;on compare discipline a 20
        JB teste6               ;si discipline < 20 on va au label teste6
        
        ;discipline = 20 
        ;----------------------
        MOV seconde,20d         ;on affecte 20 a la variable seconde
        JMP fin_dis
    
    
    ;discipline = 15 ? 
    ;--------------------------
    teste6:
        CMP discipline,15d      ;on compare discipline a 15
        JB teste7               ;si discipline < 15 on va au label teste7
        
        ;discipline = 25 
        ;----------------------
        MOV seconde,25d         ;on affecte 25 a la variable seconde
        JMP fin_dis
    
    
    ;discipline = 10 ? 
    ;--------------------------
    teste7:
        CMP discipline,10d      ;on compare discipline a 10
        JB teste8               ;si discipline < 10 on va au label teste8
        
        ;discipline = 25 
        ;----------------------
        MOV seconde,35d         ;on affecte 35 a la variable seconde
        JMP fin_dis
    
    
    ;discipline = 5 ? 
    ;--------------------------
    teste8:
        CMP discipline,5d       ;on compare discipline a 5
        JB teste9               ;si discipline < 5 on va au label teste9
        
        ;discipline = 25 
        ;----------------------
        MOV seconde,45d         ;on affecte 45 a la variable seconde
        JMP fin_dis
    
    
    ;discipline = 0 ? 
    ;--------------------------
    teste9:
        CMP discipline,0        ;on compare discipline a 0
        JB teste10              ;si discipline < 0 on va au label teste10
        
        ;discipline = 25 
        ;----------------------
        MOV seconde,59d         ;on affecte 59 a la variable seconde
        JMP fin_dis
     
     
    ;discipline < 0 ? 
    ;------------------------- 
    teste10:
        MOV discipline,0        ;on remet la variable discipline a 0
        MOV seconde,59d         ;on affecte 59 a la variable seconde
    
    
    fin_dis:
        RET    
    
verif_valeur_dis ENDP     