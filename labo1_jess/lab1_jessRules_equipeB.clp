(batch "fact.clp")

(defrule EvennementObligatoire
	(evennement ?evennement requis pour ?travail)
	(travail de ?personne est ?travail)

	=>
	(printout t ?personne " est convie a l'evennement " ?evennement crlf)
	(assert (presence requise pour ?evennement de ?personne))
)

(defrule PresenceEvennement
	(presence requise pour ?evennement de ?personne)
	(evennement ?evennement dans ?lieu a ?heure heure)

	(meurtre s'est produit entre ?heureDebut et ?heureFin)
	(test (>= ?heureFin ?heure))
	(not (exists (victime ?personne est morte)))

	=>

	(printout t ?personne " s'est presente a evennement " ?evennement crlf)
	(assert (presence de ?personne dans ?lieu a ?heure))
)

(defrule ClefEnPossession
	(clef pour ?lieu entre les mains des ?travail)
	(travail de ?personne est ?travail)
	(not (exists (oublie des clefs dans ?endroitPerdu par ?personne)))

	=>

	(printout t ?personne " a peut-etre les clefs pour " ?lieu crlf)
	(assert (porte-clef de ?personne peut contenir clef pour ?lieu))
)

(defrule VolClef
	(oublie des clefs dans ?lieu par ?personne)
	(travail de ?proprietaire est ?travail)
	(clef pour ?porte entre les mains des ?travail)

	(proximite de ?voleur dans ?lieu a ?heure)

	(meurtre s'est produit entre ?heureDebut et ?heureFin)

	(test (>= ?heureFin ?heure))

	=>

	(printout t ?voleur " a peut-etre vole la clef pour " ?porte crlf)
	(assert (porte-clef de ?voleur peut contenir clef pour ?porte))
)

(defrule ForceDeTravail
	(force pour etre ?travail est ?force)
	(travail de ?personne est ?travail)
	=>
	(printout t ?personne " a une force " ?force crlf)
	(assert (force de ?personne est au moins ?force))
)

(defquery DernierEmplacement
	(victime vue dans ?lieu a ?heure)
)

(defrule TempsMeurtre
    (corps decouvert dans ?lieu a ?temp)
    (victime ?victime est morte)
    (not (exists (meurtre s'est produit entre ?test et ?test2)))
    
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
    (assert(meurtre s'est produit entre ?heureDebut et ?temp))
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
    (force de ?personne est au moins ?force)
    (poids de ?personne2 est ?poids)

    (not (eq ?personne ?personne2))
    (test (ForcePlusGrande ?force ?poids))

    =>   
    (printout t  "corps de " ?personne2  " peut etre deplace par " ?personne crlf)
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
    (printout t  "meurtre a eu lieu dans " ?endroitSangMax " corps deplace a " ?endroitSangMin  crlf)
)

(defrule Temoignage
	(declare (salience 40))
	; regle qui dit qu'un temoin qui voit quelqu'un sur les lieux est lui meme sur les lieux
    (le temoin ?temoin a vue ?personne dans ?lieu a ?heure)

    =>
    
    (printout t ?personne " a ete vue a " ?lieu " a " ?heure " heures" crlf)
    (printout t ?temoin " le temoin etait dans " ?lieu " a " ?heure " heures" crlf)
    
    (assert (presence de ?personne dans ?lieu a ?heure))
    (assert (presence de ?temoin dans ?lieu a ?heure))
)

(defrule Proximite
	(declare (salience 30))
    (presence de ?personne dans ?lieu a ?heure)
	(acces entre ?lieuAdjacent et ?lieu)
	(or (not (exists (porte bartre pour ?lieuAdjacent))) (and (exists (porte barre pour ?lieuAdjacent)) (exists (porte-clef de ?personne peut contenir clef pour ?lieuAdjacent))))

    =>
    (printout t "proximite de "?personne " pres de " ?lieuAdjacent " et " ?lieu " a " ?heure " heures" crlf)
   
    (assert (proximite de ?personne dans ?lieuAdjacent a ?heure))
    (assert (proximite de ?personne dans ?lieu a ?heure))
)

(defrule ArmeProximite
    (objet ?arme est dans ?lieu)
    (proximite de ?personne dans ?lieu a ?heure)
    (meurtre s'est produit entre ?heureDebutMeurtre et ?heureFinMeurtre)
    (test (>= ?heureFinMeurtre ?heure))

    =>
    (printout t ?personne " a pu se procurer " ?arme crlf)
    (assert (arme ?arme est disponible pour ?personne))
)

(defrule ArmePresence
    (objet ?arme est dans ?lieu)
    (presence de ?personne dans ?lieu a ?heure)


    (meurtre s'est produit entre ?heureDebutMeurtre et ?heureFinMeurtre)

    (test (>= ?heureDebutMeurtre ?heure))
    =>
    (printout t ?personne " a pu se procurer " ?arme crlf)
    (assert (arme ?arme est disponible pour ?personne))
)

(defrule BlessureArme
    (mort blessure ?type ?profondeur)
    (blessure ?type peut etre faite par arme ?arme)

    =>

	(printout t  ?arme " est une arme potentiel "  crlf)
	(assert (arme potentiel ?arme))
)

(defrule BlessureForce
    (mort blessure ?type ?profondeur)
    (force de ?personne est au moins ?forceA)
    (blessure ?profondeur demande une force ?forceB)

    (test (ForcePlusGrande ?forceA ?forceB))
    =>

	(printout t ?personne " a la force pour faire une blessure " ?profondeur crlf)
	(assert (force pour blessure ?profondeur par ?personne))
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
	(assert (motif pour tuer ?personne2 par ?personne))
)

(defrule ResponsableDrame
    (responsable de ?drame est ?travailResponsable)
    (travail de ?responsable est ?travailResponsable)

    =>

    (printout t ?responsable " est responsable de " ?drame crlf)
    (assert (personne responsable de ?drame est ?responsable)) 
)

(defrule TravailResponsable
	(personne responsable de ?drame est ?responsable)
	(responsable de ?drame est ?travailResponsable)
	=>
	(printout t ?responsable " travail comme " ?travailResponsable " puisqu'il est responsable de " ?drame crlf)
	(assert (travail de ?responsable est ?travailResponsable))
)

(defrule DrameMotif
	(drame de ?acte pour ?cible)
    (personne responsable de ?acte est ?personne)
	=>
	(printout t ?cible " a vecu " ?acte " a cause de " ?personne " ce qui lui donne un motif pour le tuer" crlf)
    (assert (motif pour tuer ?personne par ?cible)) 
)

(defrule SuspectBlessure
	(victime ?victime est morte)
	(force pour blessure ?profondeur par ?personne)
	(mort blessure ?type ?profondeur)

	=>
	(printout t ?personne " a pu faire la blessure a " ?victime crlf)
	(assert (suspect ?personne a pu faire la blessure a ?victime))
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
	(motif pour tuer ?victime par ?personne)

    =>

    (printout t ?personne " a un motif pour tuer " ?victime ", il est donc suspect" crlf)
    (assert (suspect avec motif ?personne))

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
     
    (proximite de ?personne dans ?lieuMeurtre a ?Temp)
     
    (meurtre s'est produit entre ?tempDebut et ?tempFin)

    (and (test(<= ?tempDebut ?Temp ))  (test(>= ?tempFin ?Temp)))

    =>

    (printout t "suspect de lieu " ?personne " a proximite " ?lieuMeurtre " a " ?Temp " heures" crlf)

    (assert (suspect ?personne a proximite de ?lieuMeurtre entre ?tempDebut et ?tempFin))
)

(defrule Meutrier
	(suspect ?personne a pu deplace le cadavre)
    (suspect avec motif ?personne)
    (suspect avec ?arme est ?personne)
    (suspect ?personne a pu faire la blessure a ?victime)
    (suspect ?personne a proximite de ?lieuMeurtre entre ?tempDebut et ?tempFin)
   
    =>

    (printout t "Le crime a ete fait par " ?personne " avec la " ?arme " dans " ?lieuMeurtre "." crlf)
    
    (assert (Meurtrier ?personne))

    (halt)
)

(reset)
(run)
