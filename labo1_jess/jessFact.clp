(clear)

(deffacts Personnages

    ; Personnages
    (travail de Robert est vice-president)
    (travail de Alicia est menagere)
    (travail de Steve est concierge)
    (travail de Mary est conseiller)
	(travail de Peter est diplomate)
	(travail de Sergio est diplomate)
	(travail de Luis est paysagiste)
	(travail de John est guarde-du-corps)
	(travail de Steven est guarde-du-corps)
    
    ; poids
    (poids de Robert est moyenne)
    (poids de Alicia est faible)
    (poids de Steve est moyenne)
    (poids de Mary est moyenne)
	(poids de Peter est eleve)
	(poids de Sergio est eleve)

    ;Foce physique
    (force de Mary est faible)
    (force de Alicia est eleve)
    (force de Peter est moyenne)
    (force de Luis est eleve)
    (force de Robert est moyenne)
    (force pour etre guarde-du-corps est eleve)

    ;Loisirs
    (Loisir de Sergio est d'utiliser couteau)
    (Loisir de Luis est d'utiliser marteau)
    (Loisir de John est d'utiliser fusil)
)

(deffacts Travail
	(quart de travail de 0 a 6 heures pour menagere)
	(quart de travail de 10 a 18 heures pour guarde-du-corps)
	(quart de travail de 8 a 16 heures pour paysagiste)
	(quart de travail de 8 a 17 heures pour conseiller)
)

(deffacts Salaire
	(salaire moyen de 30000 dollars par annee pour menagere)
	(salaire moyen de 30000 dollars par annee pour concierge)
	(salaire moyen de 40000 dollars par annee pour paysagiste)
	(salaire moyen de 40000 dollars par annee pour guarde-du-corps)
	(salaire moyen de 70000 dollars par annee pour conseiller)

	(salaire de 100000 dollars pour Peter)
	(salaire de 150000 dollars pour Sergio)
	(salaire de 200000 dollars pour Robert)
)

(deffacts Relations
    ; Relations personnages
    (relation amoureuse entre Robert et Alicia)
    (relation amoureuse entre Alicia et Sergio)
    (relation amoureuse entre Alicia et Luis)

    (drame de renvoi pour John)
	(drame de transfert pour Peter )
    (drame de perte-contrat pour Luis)
    
    (responsable du renvoi de guarde-du-corps est conseiller)
	(responsable du transfert de diplomate est vice-president)
	(responsable du perte-contrat de paysagiste est conseiller)
)

(deffacts Acces-au-Lieux
    ; Acces des lieu
    (acces entre cafeteria et hall-entre)
    (acces entre hall-entre et jardin)
    (acces entre hall-entre et bureau-diplomate)
    (acces entre toilette et hall-entre)
    (acces entre toilette et cafeteria)

    (acces entre bureau-diplomate et bureau-vp)
    (acces entre jardin et cabane-jardin)
    (acces entre cafeteria et piece-concierge)

    (porte barre bureau-vp)
    (porte barre cabane-jardin)
    (porte barre piece-concierge)

    (clef pour bureau-vp dans les mains des vice-president)
    (clef pour cabane-jardin dans les mains des paysagiste)
    (clef pour piece-concierge dans les mains des vice-president)
)	

(deffacts Faits
    ; Personnage dans lieu a un moment donne == ;au-lieu, du-temp,au-temp, a-Lheure
    ;(l'evenement s'est produit de-temps 8 a-temps 10)

    ;(acces de jardin par garde-du-corp a-heure 9)
    ;(acces de sale-de-bain par Mary a-heure 10)

   ; (trouver du sang dans bureauVP)

    ;(le temoin Steve a vue Mary dans jardin a 7 heure)
    (le temoin Peter a vue Mary dans salle-de-conference a 9 heures)
    (le temoin Alicia a vue Peter dans bureau-diplomate a 6 heures)
    (le temoin Luis a vue John dans bureau-diplomate a 9 heures)
    (le temoin Sergio a vue John dans bureau-diplomate a 10 heures)
    (le temoin Luis a vue John dans jardin a 12 heures)
    (le temoin Alicia a vue Luis dans salle-de-conference a 6 heures)

    ;(presence de John dans jardin a-temps 9 heure)
   ;(presence de John dans salle-de-conference a-temps 8 heure)    

   (probleme de jeux pour Alicia)
 )

(deffacts Armes
    ; Liste des armes et leurs blessures
    (blessure tranchante peut etre faite par arme couteau)
    (blessure tranchante peut etre faite par arme hache)
    (blessure contendante peut etre faite par arme statuette)
	(blessure contendante peut etre faite par arme hache)
    (blessure contendante peut etre faite par arme pelle)
    (blessure contendante peut etre faite par arme marteau)


    ; Liste des lieu ou sont les armes

    (objet couteau est dans cafeteria)
	(objet hache est dans hall-entre)
	(objet statuette est dans salle-de-conference)
    (objet pelle est dans jardin-cabane)
    (objet marteau est dans piece-concierge)
)

(deffacts Victime
    ; Qui
    (victime Robert est morte)

    ; Blessure
    (mort blessure contendante)

    ; Info lieu
    (corp decouvert dans jardin a 10 heures )

    ; Traces
	(trouve 1 litre de sang dans salle-de-conference)
    (trouve 2 litre de sang dans bureau-vp)

    ; Ou
    (victime vue dans salle-de-conference a 7 heure)
)


