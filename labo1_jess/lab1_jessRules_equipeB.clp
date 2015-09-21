

;(batch "jessFact.clp")
(batch "jessFact_2ieme-histoire.clp")


(defrule proximite

    ; �tait possiblement sur les lieux selon un intervalle de temps

    ;au-lieu, du-temp,au-temp, a-Lheure

 
    (acces de ?lieuAcces par ?personne a-heure ?tempAcces)
 
    (evenement produit de-temps ?tempDebut a-temps ?tempFin )

    (acces entre ?lieuAcces et ?lieuEvenement)

    (test(<= ?tempAcces ?tempFin))
    (test(>= ?tempAcces ?tempDebut))
    =>

    (printout t "si " ?personne " �tait dans " ?lieuAcces" entre " ?tempDebut " et " ?tempFin " heure peut �tre a proximite de " ?lieuEvenement  crlf)

    (assert (personne-lieu ?personne et ?lieuEvenement))

)
(defrule arme-lieu-du-meurtre
    (arme ?arme est dans ?lieuEvenement)
    (personne-lieu ?personne et ?lieuEvenement)
    
    =>
     (printout t  ?personne " peut �tre sur lieux du crime avec arme " crlf)
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

    (printout t "Le crime a �t� fait par " ?nom " avec le/la " ?arme ", une blessure " ?blessure "." crlf)

    (assert (Meurtrier ?nom))

    (halt)

)


(reset)

(run)

