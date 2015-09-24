

(batch "jessFact.clp")
;(batch "jessFact_2ieme-histoire.clp")




(defrule DeplacerCorpForce
; regle qui permet de v�rifier si une personne �tait assez fort pour d�placer le corp
    (corps a ete deplace de ?endroitTrouverPreuve a ?endroitCorp)
    (force de ?personne est eleve)
    =>   
    (printout t ?personne " est assez fort pour deplacer corp " crlf)
    (assert (corp peut etre deplace par ?personne))
    
    )

(defrule DeplacementSansEtreVue
    ;regle qui v�rifie un deplacement selon la discretion d'un personnages
    (or (deplacement de ?personne par passage secret)
    (deplacement de ?personne est discret))
    =>
    (printout t ?personne " est assez discret pour ne pas etre vue " crlf)
    (assert (deplacement sans etre vue pas ?personne))
    )


(defrule DeplacementCorps
	;regle qui permet de faire le lien entre des traces de sang et un d�placement possible du corp
	; nous consid�rons qu'il y a se moins en moins de sang pour le d�placement
	
    (quantite ?litreMin de sang dans ?endroitTrouverPreuve)
    
    (quantite ?litreMax de sang dans ?secondEndroit)
    (test(< ?litreMin ?litreMax ))
   
    =>
    (printout t  " deplacement possible entre: " ?endroitTrouverPreuve " et " ?secondEndroit crlf)
   ; (assert (meurtre a eu lieu a ?endroitTrouverPreuve))
    (assert (deplacement de ?secondEndroit a ?endroitTrouverPreuve))
   
    
)


(defrule CheminCorps
	;regle qui permet de faire le lien entre des traces de sang et un deplacement possible du corp
	
    ;(trouver du sang dans ?endroitTrouverPreuve)
    (deplacement de ?sangMax a ?sangMin)
    (deplacement de ?endroitTrouverPreuve a ?secondEndroit)
    
    ;(corp decouvert dans ?endroit )
 
    
    ;( while(exists (deplacement de ?sangMax a ?sangMin) then
     ;  (= ?sangMax ?sangMin); deplacement de ?premierEndroit a ?secondEndroit)
        
   ;; do	
    
    (test (eq ?sangMax ?endroitTrouverPreuve) )
   
    
     =>   
        (assert (meurtre a eu lieu a ?sangMax) )
    (printout t  " meurtre a eu lieu a " ?sangMax crlf)
    
       
    )
    ;(printout t  " meurtre a eu lieu a endroit trouvé sang: " ?endroitTrouverPreuve " et deplacé dans " ?endroitCorp crlf)
   
    ;(assert (l)


(defrule Temoignage
	; regle qui dit qu'un temoin qui voit quelqu'un sur les lieux est lui même sur les lieux
    (le temoin ?temoin a vue ?personne dans ?lieu a ?heure heure)

    =>
    
    (printout t ?personne " a ete vue a " ?lieu " a " ?heure " heure" crlf)
    (printout t ?temoin " le temoin etait dans " ?lieu " a " ?heure " heure" crlf)
    
    (assert (presence de ?personne dans ?lieu a-temps ?heure heure))
    (assert (presence de ?temoin dans ?lieu a-temp ?heure heure))
)

(defrule SubAccesLieu
	; regle qui determine que l'acces est possible dans les 2 sens
	(acces entre ?lieuAdjacent et ?lieu en ?minute minutes)
	;(not (exists (acces entre ?lieu et ?lieuAdjacent en ?minute minutes))
	=>
	(assert (acces entre ?lieu et ?lieuAdjacent en ?minute minutes))
        
)

(defrule Proximite
    
    (presence de ?personne dans ?lieu a-temps ?heure heure)
    (acces entre ?lieuAdjacent et ?lieu en ?minute minutes)
  	;(/ ?minute 60.0)
	;?a <- (+ ?minute 0.016)
 	
     =>
    (bind ?a 1)
    (bind ?a(* ?minute 0.016))
        
    (bind ?lapsDeTempMin (- ?heure ?a))
   	(bind ?lapsDeTempMax (+ ?heure ?a))
       
    (printout t ?personne " a pu etre s proximite de " ?lieuAdjacent " entre " ?lapsDeTempMin " heure et " ?lapsDeTempMax " heure "crlf)
    (assert (proximite de ?personne dans ?lieuAdjacent entre ?lapsDeTempMin et ?lapsDeTempMax ))
     
)

(defrule suspectProximite

    ; était possiblement sur les lieux selon un intervalle de temps

    ;au-lieu, du-temp,au-temp, a-Lheure
 
    (meurtre a eu lieu a ?lieuEvenement)

    ;(acces de ?lieuAcces par ?personne a-heure ?tempAcces)
 	;(proximite de ?personne dans ?lieuAdjacent entre ?lapsDeTempMin et ?lapsDeTempMax)
    ;(proximite de ?personne dans ?lieuAdjacent a ?heure en ?minute minutes)
     
    (proximite de ?personne dans ?lieu entre ?TempMin et ?TempMax)
    
    (l'evenement s'est produit de-temps ?tempDebut a-temps ?tempFin )

    ;(acces entre ?lieuAcces et ?lieuEvenement)

    (or (test(<= ?TempMin ?tempFin ))  (test(>= ?TempMax ?tempDebut)))
   ;(test)+-
    
    (test(eq ?lieuEvenement ?lieu))
    =>

    (printout t "si " ?personne " etait dans " ?lieu " entre " ?tempDebut " et " ?tempFin " heure peut etre a proximite de " ?lieuEvenement  crlf)

    (assert (personne-lieu ?personne et ?lieuEvenement de ?tempDebut a-temps ?tempFin))
)

(defrule armeLieu
    (objet ?objet est dans ?lieuEvenement)
    (arme potentiel ?arme)
    (test(eq ?objet ?arme))
    =>
    (assert(arme ?arme et dans lieu ?lieuEvenement))
    )

(defrule suspectArme
    ;(objet ?objet est dans ?lieuEvenement)
    (personne-lieu ?personne et ?lieuEvenement de ?tempDebut a-temps ?tempFin)
    ;(arme potentiel ?arme)
    (arme ?arme et dans lieu ?lieu)
    
    (test(eq ?lieuEvenement ?lieu ))
    =>
    (printout t  ?personne " peut etre sur lieux du crime avec " ?arme  crlf)
    (assert (arme-lieu-du-meurtre ?personne))
)

(defrule BlessureArme

    ; Blessure -> Arme

    (mort blessure ?type )

    (blessure ?type peut etre faite par arme ?arme)

    =>

	(printout t  ?arme " est une arme potentiel "  crlf)
	(assert (arme potentiel ?arme))
)

(defrule SubRelationAmoureuse

    ; Si A est en relation avec B, donc B est en relation avec A

    (relation amoureuse entre ?premier et ?second)

    (not (exists (relation amoureuse entre ?second et ?premier)))

    =>

    (printout t "La relation amoureuse entre " ?premier " et " ?second " est vrai dans les deux sens" crlf)

    (assert (relation amoureuse entre ?second et ?premier))
)

; Motifs

(defrule TriangleAmoureux

    (relation amoureuse entre ?premier et ?centre)

    (relation amoureuse entre ?second et ?centre)

    (not (test (eq ?premier ?second)))

    =>

    (printout t "Un triangle amoureux entre " ?premier ", " ?second " et " ?centre " donne un motif a " ?second " pour tuer " ?premier crlf)

    (assert (motif pour tuer ?premier par ?second))

)

(defrule ResponsableDrame

    (drame de ?acte pour ?cible)

    (travail de ?cible est ?travail)

    (responsable du ?acte de ?travail est ?travailResponsable)

    (travail de ?responsable est ?travailResponsable)

    =>

    (printout t ?cible " a vecu " ?acte " a cause de " ?responsable " ce qui lui donne un motif pour le tuer" crlf)

    (assert (motif pour tuer ?responsable par ?cible)) 
)

(defrule SuspectMotif
    (victime ?victime est morte)

	;a un motif
	(motif pour tuer ?victime par ?second)
    =>

    (printout t ?second " a un motif pour tuer " ?victime ", il est donc suspect" crlf)

    (assert (suspect avec motif ?second))


)

;Regle de fin !

(defrule Meutrier

    (declare (salience 41) )

    (arme-crime-possible ?arme)

    (suspect-a ?nom ?arme)

    (blessure ?blessure peut etre faite par arme ?arme)

    =>

    (printout t "Le crime a ete fait par " ?nom " avec le/la " ?arme ", une blessure " ?blessure "." crlf)

    (assert (Meurtrier ?nom))

    (halt)

)


(reset)

(run)

/*
(defrule lienTemps
    
    (l'evenement s'est produit de-temps ?tempDebut a-temps ?tempFin)
    (l'evenement s'est produit a ?lieu)
    (il y avait ?personne dans ?lieu a-temps ?tempMilieu)
    (test(<= ?tempMilieu ?tempFin))
    (test(>= ?tempMilieu ?tempDebut))
    =>
    
    (assert ())
    )*/

/*

essai d'un query
(defquery trouverArme
 ;trouver un type d'arme
  (declare (variables ?personne))
  (objet de nom ?personne arme ?arme)
    )


(defrule testQuery
    
    
    (corp peut etre deplace par ?personne)
    
    (bind ?result run-query* trouverArme ?personne)
	(while ?result next)
    =>
    (printout t ?result  crlf)
    )


*/
