
(clear)

(deffacts Personnage

    ; Personnages

    (travail de Robert est vice-president)

    (travail de Alicia est menagere)

    (travail de Mary est conseiller)

	(travail de Peter est diplomate)

	(travail de Luis est paysagiste)

	(travail de John est guarde-du-corps)

)

(deffacts RelationPersonnage

    ; Relations personnages

    (relation amoureuse entre Robert et Alicia)

    (relation amoureuse entre Alicia et Sergio)

    (drame de renvoi pour John)

	(drame de transfert pour Peter )

    (drame de contrat pour Luis)
    

	; Relations metiers

    (responsable du renvoi de guarde-du-corps est vice-president)

	(responsable du transfert de diplomate est vice-president)

	(responsable du contrat de paysagiste est conseiller)

)

(deffacts Lieu

    ; Acces des lieu

    (acces entre cafeteria et salle-de-conference)
    (acces entre hall-entree et jardin)
    (acces entre bureauVP et salle-de-conference)
	(acces entre sale-de-bain et salle-de-conference)
	(acces entre halle-entre et cafeteria)
    (acces entre cabane-jardinier et jardin)
	(acces entre salle-de-conference et jardin)
    (acces entre cuisine et cafeteria)

)

(deffacts Evenement

    ; Personnage dans lieu a un moment donne == ;au-lieu, du-temp,au-temp, a-Lheure


    (acces du-temp 8 au-temp 10)
	(meurtre au-lieu jardin )
    (meurtre instrument contendante)
    (acces de salle-de-conference par garde-du-corp a-heure 9)
    (acces de sale-de-bain par Mary a-heure 10)

)

(deffacts Arme

    ; Liste des armes et leurs blessures

    (blessure tranchante peut etre faite par arme couteau)

    (blessure tranchante peut etre faite par arme hache)

    (blessure contendante peut etre faite par arme statuette)

	(blessure contendante peut etre faite par arme hache)

	(blessure projectile peut etre faite par arme fusil)

	(blessure projectile peut etre faite par arme arc)


    ; Liste des lieu ou sont les armes

    (arme couteau est dans cuisinne)

(arme hache est dans halle)

(arme statuette est dans bureauVP)

(arme fusil est dans locker)

    (arme arc est dans jardin)

)

(deffacts Victime

    ; Qui

    (victime Robert est morte)


    ; Blessure

    (mort blessure contendante)


    ; Info lieu

    (mort lieu cour-arriere)

)

/*
(defrule SubAccesLieu

    ; Acces dans un sens est double sens 

    (acces ?personnage a-lieu ?lieuAcces)
    (acces entre ?lieuAcces et ?lieuEvenement)
 
	=>

	;(printout t "acces entre " ?lieu1 " et " ?lieu2 " est vrai dans les deux sens" crlf)

    (assert (acces ?personnage a-lieu ?lieuEvenement))

 )*/

(defrule Lieu-proximite-evenement

    ; était possiblement sur les lieux selon un intervalle de temps

    ;au-lieu, du-temp,au-temp, a-Lheure

 
    (acces de ?lieuAcces par ?personne a-heure ?tempAcces)
 
    (acces du-temp ?tempDebut au-temp ?tempFin )

    (acces entre ?lieuAcces et ?lieuEvenement)

    (test(<= ?tempAcces ?tempFin))
    (test(>= ?tempAcces ?tempDebut))
    =>


    (printout t "si " ?personne " était dans " ?lieuAcces" entre " ?tempDebut " et " ?tempFin " heure peut être a proximite de " ?lieuEvenement  crlf)

    (assert (proximite entre ?personne et ?lieuEvenement))

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

