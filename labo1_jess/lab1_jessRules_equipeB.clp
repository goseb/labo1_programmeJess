

(batch "jessFact.clp")
;(batch "jessFact_2ieme-histoire.clp")
(defrule DeplacerCorpForce
    
    (corp a ete deplace de ?endroitTrouverPreuve a ?endroitCorp)
    (force de ?personne est eleve)
    
    =>
    
    (printout t ?personne " est assez fort pour deplacer corp " crlf)
    (assert (corp peut etre deplace par ?personne))
    
    )

(defrule DeplacementSansEtreVue
    ;***essai avec or...
    (or (deplacement de ?personne par passage secret)
    
    (deplacement de ?personne est discret))
    =>
     (printout t ?personne " est assez discret pour ne pas etre vue " crlf)
    (assert (deplacement sans etre vue pas ?personne))
    )


(defrule deplacement
    
    (trouver du sang dans ?endroitTrouverPreuve)
    (corp découvert dans ?endroitCorp )
    =>
    (printout t  " meurtre a eu lieu a endroit trouvé sang: " ?endroitTrouverPreuve " et deplacé dans " ?endroitCorp crlf)
    (assert (meurtre a eu lieu a ?endroitTrouverPreuve))
    (assert (corp a ete deplace de ?endroitTrouverPreuve a ?endroitCorp))
    )

(defrule lienVueLieu
    
    (le temoin ?temoin a vue ?personne dans ?lieu a ?heure heure)
    =>
    
    (printout t ?personne " a été vue a " ?lieu " a " ?heure " heure" crlf)
    (printout t ?temoin " le témoin était dans " ?lieu " a " ?heure " heure" crlf)
    
    (assert (presence de ?personne dans ?lieu a-temps ?heure heure))
    (assert (presence de ?temoin dans ?lieu a-temp ?heure heure))
    )

(defrule proximiteLieuAdjacent-Lieu
    
    (presence de ?personne dans ?lieu a-temps ?heure heure)
    (acces entre ?lieuAdjacent et ?lieu en ?minute minutes)
  	;(/ ?minute 60.0)
     ;?a <-(/ ?minute 60.0)
    ;?b <- (+ ?heure ?a)
    ;(bind ?a (+(+ 2 3) (* 3 3)))
      ;?x<- (/ ?temp 60)
    
   ; ?lapsDeTempMin <-(- ?heure ?x)
   ; ?lapsDeTempMax <-(+ ?heure ?x)
     =>
    ;(printout t ?personne " était près de " ?lieu " entre " ?lapsDeTempMin " heure et " ?lapsDeTempMax " heure "crlf)
    ;(assert (proximite de ?personne dans ?lieuAdjacent entre ?lapsDeTempMin et ?lapsDeTempMax ))
    
    (printout t  " proximité de " ?personne " dans "?lieuAdjacent " a " ?heure " heures plus ou moins " ?minute " minutes ----> "  crlf)
    (assert (proximite de ?personne dans ?lieuAdjacent a ?heure en ?minute minutes))
    )

(defrule proximiteLieu-LieuAdjacent
    
    (presence de ?personne dans ?lieu a-temps ?heure heure)
    (acces entre ?lieu et ?lieuAdjacent en ?minute minutes)
  ; ?x<- (/ ?temp 60)
    
    ;?lapsDeTempMin <-(- ?heure ?x)
    ;?lapsDeTempMax <-(+ ?heure ?x)
    
     =>
    
     (printout t " proximité de " ?personne " dans "?lieuAdjacent " a " ?heure " heures plus ou moins " ?minute "minutes" crlf)
    (assert (proximite de ?personne dans ?lieuAdjacent a ?heure en ?minute minutes))
    )

(defrule proximiteMeurtre

    ; était possiblement sur les lieux selon un intervalle de temps

    ;au-lieu, du-temp,au-temp, a-Lheure

 
    (meurtre a eu lieu a ?lieuEvenement)
    ;(acces de ?lieuAcces par ?personne a-heure ?tempAcces)
 ;(proximite de ?personne dans ?lieuAdjacent entre ?lapsDeTempMin et ?lapsDeTempMax)
    (proximite de ?personne dans ?lieuAdjacent a ?heure en ?minute minutes)
     
    (l'evenement s'est produit de-temps ?tempDebut a-temps ?tempFin )

    ;(acces entre ?lieuAcces et ?lieuEvenement)

   ; (test(<= ?lapsDeTempMin ?tempFin ))
    ;(test(>= ?lapsDeTempMax ?tempDebut))
    =>

    (printout t "si " ?personne " était dans " ?lieuAdjacent " entre " ?tempDebut " et " ?tempFin " heure peut être a proximite de " ?lieuEvenement  crlf)

    (assert (personne-lieu ?personne et ?lieuEvenement a ?heure))
)

(defrule arme-lieu-du-meurtre
    (objet ?objet est dans ?lieuEvenement)
    (personne-lieu ?personne et ?lieuEvenement a ?heure)
    (arme potentiel ?arme)
    (test(= ?objet ?arme ))
    
    =>
     (printout t  ?personne " peut être sur lieux du crime avec arme " crlf)
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
(defrule TriangleAmoureux

    (relation amoureuse entre ?premier et ?centre)

    (relation amoureuse entre ?second et ?centre)

    (not (test (eq ?premier ?second)))

    =>

    (printout t "Un triangle amoureux entre " ?premier ", " ?second " et " ?centre " donne un motif a " ?second " pour tuer " ?premier crlf)

    (assert (motif pour tuer ?premier par ?second))

)
(defrule Suspect

    (victime ?victime est morte)

;a un motif    

(motif pour tuer ?victime par ?second)

    =>

    (printout t ?second " a un motif pour tuer " ?victime ", il est donc suspect" crlf)

    (assert (suspect ?second))


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

;Regle de fin !

(defrule meutrier

    (declare (salience 41) )

    (arme-crime-possible ?arme)

    (suspect-a ?nom ?arme)

    (blessure ?blessure peut etre faite par arme ?arme)

    =>

    (printout t "Le crime a été fait par " ?nom " avec le/la " ?arme ", une blessure " ?blessure "." crlf)

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
