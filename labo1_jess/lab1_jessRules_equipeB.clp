(batch "fact.clp")
;(batch "jessFact_2ieme-histoire.clp")

(defrule ForceDeTravail
	(force pour etre ?travail est ?force)
	(travail de ?personne est ?travail)
	=>
	(printout t ?personne " a une force " ?force crlf)
	(assert (force de ?personne est ?force))
)

(defrule Alibi
	(declare (salience 30))
	(quart de travail de ?heureDebut a ?heureFin pour ?travail)
	(meurtre s'est produit entre ?heureDebutMeurtre et ?heureFinMeurtre heures)
	(travail de ?personne est ?travail)

	(or (< ?heureFin ?heureDebutMeurtre) (> ?heureDebut ?heureFinMeurtre))
	=>
	(printout t ?personne " n'etait pas sur les lieux lors du meurtre" crlf)
	(assert (alibi pour ?personne))
)

(defquery DernierEmplacement
	(victime vue dans ?lieu a ?heure heure)
)

(defrule TempsMeurtre
    (corp decouvert dans ?lieu a ?temp heures)
    (victime ?victime est morte)
    (not (exists (meurtre s'est produit entre ?test et ?test2 heures)))
    
    =>

    (bind ?result (run-query* DernierEmplacement))
    (bind ?ecart 25)
    (bind ?heureDebut 0)
	(while (?result next)
		(bind ?heureCalcul (?result getInt heure))
		(if (< (- ?temp ?heureCalcul) ?ecart) then
			(bind ?heureDebut ?heureCalcul)
		)
	)

    (printout t "meurtre s'est produit entre " ?heureDebut " et " ?temp " heure" crlf)
    (assert(meurtre s'est produit entre ?heureDebut et ?temp heures))
 )

(defrule SubAccesLieu
	(declare (salience 50))
	; regle qui determine qu'un acces est possible dans les 2 sens
	(acces entre ?lieuAdjacent et ?lieu)
	;(not (exists (acces entre ?lieu et ?lieuAdjacent))
	=>
	(assert (acces entre ?lieu et ?lieuAdjacent))
    (printout t "acces entre " ?lieu " et " ?lieuAdjacent crlf)
)

(deffunction ForcePlusGrande (?forceA ?forceB)
	(if (eq ?forceA faible) then
		(if (eq ?forceB faible) then
			TRUE
		else
			FALSE
		)
	elif (eq ?forceA moyenne) then
		(if (or (eq ?forceB faible) (eq ?forceB moyenne)) then
			TRUE
		else
			FALSE
		)
	else
		TRUE
	)
)

(defrule DeplacerCorpForce
    (force de ?personne est ?force)
    (poids de ?personne2 est ?poids)

    (not (eq ?personne ?personne2))
    (test (ForcePlusGrande ?force ?poids))

    =>   
    (printout t  "corp de " ?personne2  " peut etre déplacé par " ?personne crlf)
    (assert (corps de ?personne2 peut etre deplace par ?personne))
)

(defrule DeplacementCorps
	;il y a se moins en moins de sang lors du deplacement
	
    (trouve ?litreMin litre de sang dans ?endroitTrouverSang1)
    
    (trouve ?litreMax litre de sang dans ?endroitTrouverSang2)
    (test(> ?litreMin ?litreMax ))
   
    =>
    (printout t  "deplacement du corps possible de " ?endroitTrouverSang1 " a " ?endroitTrouverSang2 crlf)
   
    (assert (deplacement de ?endroitTrouverSang1 a ?endroitTrouverSang2))
)

(defrule CheminCorps
	(declare (salience 30))
	;regle qui permet de faire le lien entre des traces de sang et le deplacement du corp
	
    (deplacement de ?endroitSangMax a ?endroitSangMin)
    (deplacement de ?endroitTrouverSang1 a ?endroitTrouverSang2)
    
    (test (eq ?endroitSangMax ?endroitTrouverSang1) )
   
     =>
    (assert (meurtre a eu lieu dans ?endroitSangMax))
    (printout t  "meurtre a eu lieu dans " ?endroitSangMax " corp deplace a " ?endroitSangMin  crlf)
)


(defrule Temoignage
	(declare (salience 40))
	; regle qui dit qu'un temoin qui voit quelqu'un sur les lieux est lui meme sur les lieux
    (le temoin ?temoin a vue ?personne dans ?lieu a ?heure heures)

    =>
    
    (printout t ?personne " a ete vue a " ?lieu " a " ?heure " heures" crlf)
    (printout t ?temoin " le temoin etait dans " ?lieu " a " ?heure " heures" crlf)
    
    (assert (presence de ?personne dans ?lieu a ?heure heures))
    (assert (presence de ?temoin dans ?lieu a ?heure heures))
)

(defrule Proximite
	(declare (salience 30))
    ;regle qui determine la proximite possible d'une personne en rapport aux acces a ce lieu
    (presence de ?personne dans ?lieu a ?heure heures)
	(acces entre ?lieuAdjacent et ?lieu)
    =>
    (printout t "proximite de "?personne " près de " ?lieuAdjacent " et " ?lieu " a " ?heure " heures" crlf)
   
    (assert (proximite de ?personne dans ?lieuAdjacent a ?heure heures))
    (assert (proximite de ?personne dans ?lieu a ?heure heures))
)

(defrule ArmeProximite
    (objet ?arme est dans ?lieu)
    (proximite de ?personne dans ?lieu a ?heure heures)
    (meurtre s'est produit entre ?heureDebutMeurtre et ?heureFinMeurtre heures)
    (test (>= ?heureFinMeurtre ?heure))

    =>
    (printout t ?personne " a pu se procurer " ?arme crlf)
    (assert (arme ?arme est disponible pour ?personne))
)

(defrule ArmePresence
    (objet ?arme est dans ?lieu)
    (presence de ?personne dans ?lieu a ?heure heures)


    (meurtre s'est produit entre ?heureDebutMeurtre et ?heureFinMeurtre heures)

    (test (>= ?heureDebutMeurtre ?heure))
    =>
    (printout t ?personne " a pu se procurer " ?arme crlf)
    (assert (arme ?arme est disponible pour ?personne))
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

    (printout t "Un triangle amoureux qui donne un motif a " ?second " pour tuer " ?premier crlf)
    (assert (motif pour tuer ?premier par ?second))

)

(defquery ObtenirSalaire
	(declare (variables ?travail))
	(travail de ?personne est ?travail)
	(salaire de ?argent dollars pour ?personne)
)

(defrule SalaireMoyen
	(travail de ?unePersonne est ?unTravail)
	(not (exists (salaire moyen de ?argent dollars par annee pour ?unTravail)))
	=>
	(bind ?result (run-query* ObtenirSalaire ?unTravail))
	(bind ?nbSalaire 0)
	(bind ?moyenne 0)
	(while (?result next)
		(bind ?moyenne (+ (?result getInt argent) ?moyenne))
		(bind ?nbSalaire (+ ?nbSalaire 1))
	)

	(bind ?moyenne (/ ?moyenne ?nbSalaire))

	(printout t "le salaire moyen des " ?unTravail " est " ?moyenne crlf)
	(assert (salaire moyen de ?moyenne dollars par annee pour ?unTravail))
)

(defrule JalousieSalaire
	(travail de ?personne est ?travail)
	(travail de ?personne2 est ?travail2)

	(salaire moyen de ?salaire dollars par annee pour ?travail)
	(salaire moyen de ?salaire2 dollars par annee pour ?travail2)

	(test (< ?salaire ?salaire2))
	=>
	(printout t ?personne " est jaloux de " ?personne2 " a cause de son salaire" crlf)
	(assert (jalousie de ?personne envers ?personne2 a cause du salaire))
)

(defrule BesoinArgent
	(jalousie de ?personne envers ?personne2 a cause du salaire)
	(probleme de jeux pour ?personne)
	=>
	(printout t ?personne " veut l'argent de " ?personne2 ", ce qui lui donne un motif pour le tuer" crlf)
	(assert (motif pour tuer ?personne par ?personne2))
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

(defrule SuspectDeplacement
	(victime ?victime est morte)
    (corps de ?victime peut etre deplace par ?personne)
    
    =>
    (printout t ?personne" a pu deplacer le cadavre"  crlf)
    (assert (suspect ?personne a pu deplace le cadavre))
)

(defrule SuspectMotif
    (victime ?victime est morte)
	(motif pour tuer ?victime par ?second) 
    =>

    (printout t ?second " a un motif pour tuer " ?victime ", il est donc suspect" crlf)

    (assert (suspect avec motif ?second))

)

(defrule SuspectArme
	(arme potentiel ?arme)
	(arme ?arme est disponible pour ?personne)

    =>
    (printout t  "suspect " ?personne " avec " ?arme    crlf)
    (assert (suspect avec ?arme est ?personne))
)

(defrule SuspectProximite

    (meurtre a eu lieu dans ?lieuMeurtre)
     
    (proximite de ?personne dans ?lieu a ?Temp heures)
     
    (meurtre s'est produit entre ?tempDebut et ?tempFin heures)

    (and (test(<= ?tempDebut ?Temp ))  (test(>= ?tempFin ?Temp)))
    
    ; TODO peut avoir la clef

    (test(eq ?lieuMeurtre ?lieu))

    =>

    (printout t "suspect de lieu " ?personne " a proximite " ?lieuMeurtre " a " ?Temp " heures "  crlf)

    (assert (suspect ?personne a proximite de ?lieuMeurtre entre ?tempDebut et ?tempFin heures))
)

(defrule Meutrier
	(suspect ?personne a pu deplace le cadavre)
    (suspect avec motif ?personne)
    (suspect avec ?arme est ?personne)
    (suspect ?personne a proximite de ?lieuMeurtre entre ?tempDebut et ?tempFin heures)
   
    =>

    (printout t "Le crime a ete fait par " ?personne " avec la " ?arme " dans " ?lieuMeurtre "." crlf)
    
    (assert (Meurtrier ?personne))

    (halt)
)

(reset)
(run)
