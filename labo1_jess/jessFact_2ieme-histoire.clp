(clear)

(deffacts Personnages

    ; Personnages
    (travail de Bubble-gum est danceuse)
    (travail de Candy est danceuse)
    (travail de LeBoss est patron)
    (travail de Jack est bouncer)
	(travail de Tom est bouncer)
	(travail de Jinzo est concierge)
	(travail de Fancy est coregraphe)
	(travail de Etranger est client)
    
    ; poids
    (poids de Jack est moyenne)
    (poids de Candy est faible)
    (poids de Jinzo est moyenne)
    (poids de LeBoss est moyenne)
	(poids de Bubble-Gum est eleve)
	(poids de Etranger est eleve)

    ;Foce physique
    (force de Bubble-Gum est au moins faible)
    (force de Fancy est au moins faible)
    (force de LeBoss est au moins moyenne)
    (force de Tom est au moins eleve)
    (force de Robert est au moins moyenne)
)

(deffacts Travail
	(salaire moyen de 30000 dollars par annee pour concierge)
	(salaire moyen de 30000 dollars par annee pour bouncer)
	(salaire moyen de 70000 dollars par annee pour coregraphe)

	(salaire de 50000 dollars pour Etranger)
	(salaire de 55000 dollars pour Bubble-gum)
	(salaire de 200000 dollars pour LeBoss)

	(force pour etre bouncer est eleve)
	(force pour etre concierge est moyenne)
)

(deffacts Relations
    ; Relations personnages
    (relation amoureuse entre Bubble-gum et Fancy)
    (relation amoureuse entre LeBoss et Fancy)
    (relation amoureuse entre Candy et LeBoss)

    (drame de renvoi pour Tom)
	(drame de manque-drogue Bubble-gum)
    (drame de refus-dance pour Etranger)
    
    (responsable de renvoi est patron)
	(responsable de manque-drogue est patron)

	(personne responsable de refus-dance est Candy)
)

(deffacts Acces-au-Lieux
    ; Acces des lieu
    (acces entre bar et piste-dance)
    (acces entre scene-dance et vestiere)
    (acces entre salle-jeux et bureau-patron)
    (acces entre salle-jeux et bar)
    (acces entre salle-jeux et toilette)
    (acces entre vestiere et bureau-patron)
    (acces entre bar et cabines)
    (acces entre scene-dance et cabines)

    (porte barre pour bureau-patron)
    (porte barre pour vestiere)

    (clef pour bureau-patron entre les mains des patron)
    (clef pour vestiere entre les mains des patron)
    (clef pour vestiere entre les mains des danceuse)
    (clef pour vestiere entre les mains des bouncer)
    (clef pour vestiere entre les mains des concierge)
)	

(deffacts Faits
    (le temoin Jinzo a vue Bubble-gum dans bar a 22)
    (le temoin LeBoss a vue Tom dans bureau-patron a 18)
    (le temoin Bubble-gum a LeBoss John dans cabine a 22)
    (le temoin Etranger a vue Jack dans toilette a 20)
    (le temoin LeBoss a vue Fancy dans Vestiere a 23)
    (le temoin Etranger a vue Fancy dans scene-dance a 21)

    (oublie des clefs dans toilette par patron)

    (evennement dance requis pour danceuse)
    (evennement dance requis pour coregraphe)

    (presence requise pour dance de LeBoss)

    (presence requise pour deal de Bubble-gum)
    (presence requise pour deal de Tom)

    (evennement dance dans scene-dance a 22 heure)
    (evennement deal dans toilette a 19 heure)

    (probleme de jeux pour Jack)
    (probleme de jeux pour Etranger)
    (probleme de jeux pour Jinzo)
)

(deffacts Armes
    ; Liste des armes et leurs blessures
    (blessure tranchante peut etre faite par arme ciseau)
    (blessure tranchante peut etre faite par arme epee)
    (blessure contendante peut etre faite par arme bouteille)
    (blessure contendante peut etre faite par arme soulier)
    (blessure contendante peut etre faite par arme baguette-billard)
    (blessure trou peut etre faite par arme baguette-billard)
    (blessure trou peut etre faite par arme ciseau)

    (blessure profonde demande une force moyenne)
    (blessure peu-profonde demande une force faible)

    ; Liste des lieu ou sont les armes
    (objet ciseau est dans vestiere)
	(objet epee est dans bureau-patron)
	(objet bouteille est dans bar)
    (objet soulier est dans vestiere)
    (objet baguette-billard est dans salle-jeux)
)

(deffacts Victime
    ; Qui
    (victime Candy est morte)

    ; Blessure
    (mort blessure trou peu-profonde)

    ; Info lieu
    (corps decouvert dans cabine a 23)

    ; Traces
	(trouve 2 litre de sang dans cabine)
    (trouve 3 litre de sang dans bar)

    ; Ou
    (victime vue dans piste a 22)
)
