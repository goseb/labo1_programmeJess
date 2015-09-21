(clear)

(deffacts Personnage

    ; Personnages

    (travail de Francois est plombier)

    (travail de Marc est menuisier)

    (travail de Gaetan est proprietaire-de-bar)

	(travail de Louis est DJ)

	(travail de Carol est danseuse)

	(travail de Karine est etudiante)
    
    (travail de Karine est chanteuse)

)
(deffacts Relation

    ; Relations personnages

    (relation amoureuse entre Marc et Karine)

    (relation amoureuse entre Gaetan et Karine)

    (drame de renvoi pour Louis)

	(drame de menace pour Gaetan )
    
    (ennemie entre Gaetan et Francois)
    (ennemie entre Francois et Gaetan)


	; Relations metiers

    (responsable du renvoi de DJ est proprietaire-de-bar)

	(responsable de menace est ennemie)

	(responsable du contrat de menuisier est proprietaire-de-bar)

)
(deffacts Location

    ; Acces des lieu

    (acces entre vestiaire et entree)
    (acces entre entree et piste-de-dance)
    (acces entre bar et piste-de-dance)
    (acces entre piste-de-dance et salle-de-bain)
	(acces entre piste-de-dance  et bureau-de-direction)
	(acces entre bureau-de-direction et salon-prive)
    (acces entre salon-prive et salle-de-bain)
	(acces entre ruelle et salon-prive)
   


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

    (evenement produit de-temps 8 a-temps 10)
	(meurtre endroit ruelle )
    (meurtre instrument tranchant)
    (acces de bureau-de-direction par Marc a-heure 9)
    (acces de sale-de-bain par Louis a-heure 10)
    
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

    (arme couteau est dans bureau-de-direction)

	(arme hache est dans entre)
	
	(arme statuette est dans bar)
	
	(arme fusil est dans bureau-de-direction)

    

)
(deffacts Victime

    ; Qui

    (victime Gaetan est morte)


    ; Blessure

    (mort blessure tranchante)


    ; Info lieu

    (mort lieu ruelle)

)


