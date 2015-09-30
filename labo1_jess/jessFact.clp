(clear)

(deffacts Personnages

    ; Personnages
    (travail de Robert est vice-president)
    (travail de Alicia est menagere)
    (travail de Steve est concierge)
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
    (force de Mary est au moins faible)
    (force de Alicia est au moins eleve)
    (force de Peter est au moins moyenne)
    (force de Luis est au moins eleve)
    (force de Robert est au moins moyenne)

    (personne responsable de perte-contrat-paysagiste est Mary)
)

(deffacts Travail
	(salaire moyen de 30000 dollars par annee pour menagere)
	(salaire moyen de 30000 dollars par annee pour concierge)
	(salaire moyen de 40000 dollars par annee pour paysagiste)
	(salaire moyen de 40000 dollars par annee pour guarde-du-corps)
	(salaire moyen de 70000 dollars par annee pour conseiller)

	(salaire de 100000 dollars pour Peter)
	(salaire de 150000 dollars pour Sergio)
	(salaire de 200000 dollars pour Robert)

	(force pour etre guarde-du-corps est eleve)
)

(deffacts Relations
    ; Relations personnages
    (relation amoureuse entre Robert et Alicia)
    (relation amoureuse entre Alicia et Luis)

    (drame de renvoi pour John)
    (drame de renvoi pour Steven)
	(drame de transfert pour Peter)
    (drame de perte-contrat-paysagiste pour Luis)
    
    (responsable de renvoi-guarde-du-corps est conseiller)
	(responsable de transfert-diplomate est vice-president)
	(responsable de perte-contrat-paysagiste est conseiller)
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

    (porte barre pour bureau-vp)
    (porte barre pour cabane-jardin)
    (porte barre pour piece-concierge)

    (clef pour bureau-vp entre les mains des vice-president)
    (clef pour bureau-vp entre les mains des concierge)
    (clef pour cabane-jardin entre les mains des paysagiste)
    (clef pour piece-concierge entre les mains des concierge)
)	

(deffacts Faits
    (le temoin Peter a vue Mary dans salle-de-conference a 9)
    (le temoin Alicia a vue Peter dans bureau-diplomate a 6)
    (le temoin Luis a vue John dans bureau-diplomate a 9)
    (le temoin Sergio a vue John dans bureau-diplomate a 10)
    (le temoin Luis a vue John dans jardin a 12)
    (le temoin Alicia a vue Luis dans salle-de-conference a 6)
    (le temoin Steve a vue John dans bureau-diplomate a 7)
    (le temoin Sergio a vue John dans bureau-diplomate a 10)
    (le temoin Steven a vue Steven dans jardin a 16)

    (oublie des clefs dans cafeteria par Steve)

    (evennement conference requis pour diplomate)
    (evennement conference requis pour vice-president)

    (presence requise pour diner de Luis)
    (presence requise pour diner de Mary)

    (evennement conference dans salle-de-conference a 8 heure)
    (evennement diner dans cafeteria a 8 heure)

    (probleme de jeux pour Alicia)
    (probleme de jeux pour Mary)
)

(deffacts Armes
    ; Liste des armes et leurs blessures
    (blessure tranchante peut etre faite par arme couteau)
    (blessure tranchante peut etre faite par arme hache)
    (blessure contendante peut etre faite par arme statuette)
	(blessure contendante peut etre faite par arme hache)
    (blessure contendante peut etre faite par arme pelle)
    (blessure contendante peut etre faite par arme marteau)

    (blessure profonde demande une force moyenne)
    (blessure peu-profonde demande une force faible)

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
    (mort blessure contendante peu-profonde)

    ; Info lieu
    (corps decouvert dans jardin a 10)

    ; Traces
	(trouve 1 litre de sang dans salle-de-conference)
    (trouve 2 litre de sang dans bureau-vp)

    ; Ou
    (victime vue dans salle-de-conference a 7)
)
