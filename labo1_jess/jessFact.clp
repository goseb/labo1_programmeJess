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

(deffacts Relation

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

(deffacts Location

    ; Acces des lieu

    (acces entre cafeteria et salle-de-conference)
    (acces entre hall-entree et jardin)
    (acces entre bureauVP et salle-de-conference)
	(acces entre sale-de-bain et salle-de-conference)
	(acces entre halle-entre et cafeteria)
    (acces entre cabane-jardinier et jardin)
	(acces entre salle-de-conference et jardin)
    (acces entre cuisine et cafeteria)
    
   (passage secret entre cuisine et jardin)

)

(deffacts Evenement
	 
    (meurtre est un evenement)
    (rencontre est un evenement)
    (travailler est un evenement)
    (quitter travail est un evenement)
    (renvoyer est un evenement)
  

)

(deffacts Faits

      ; Personnage dans lieu a un moment donne == ;au-lieu, du-temp,au-temp, a-Lheure

    (acces de-temps 8 a-temps 10)
	(meurtre endroit jardin )
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
    (blessure contendante peut etre faite par arme pelle)

	(blessure projectile peut etre faite par arme fusil)

	;(blessure projectile peut etre faite par arme arc)


    ; Liste des lieu ou sont les armes

    (arme couteau est dans cuisinne)

	(arme hache est dans halle)
	
	(arme statuette est dans bureauVP)
	
	(arme fusil est dans locker)

    (arme pelle est dans jardin)

)

(deffacts Victime

    ; Qui

    (victime Robert est morte)


    ; Blessure

    (mort blessure contendante)


    ; Info lieu

    (mort lieu jardin)

)


