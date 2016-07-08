/* #######################################################################################################################

	2017 Christophe Pages (http://www.c-pages.fr) 

##########################################################################################################################
	
	Organisation des preferences dans des structs
	
######################################################################################################################## */ 
	



------------------------------------------------------------------------------
------ Rendus  -------------------------------------------------------------
------------------------------------------------------------------------------
-- Les preferences actives pour les rendus des  aperçus			--
------------------------------------------------------------------------------
struct renduApercus (
	tutu="",
	m_convertToCoronaMats 	= true
)

------------------------------------------------------------------------------
------ Rollout ---------------------------------------------------------------
------------------------------------------------------------------------------
-- Les preferences pour la fenetre de la bibliotheque				--
------------------------------------------------------------------------------
struct rollPrincipale (
	taille 			= [1300,900],		---- la taille de la fenetre	---
	pos 				= [50,50],			---- la position de la fenetre ---	
	infos				=	true,					---- si l'onglet "infos" est ouvert ---
	edition			=	false,				---- si la fenetre edition est ouverte ---	
	accroche		=	false,				---- si le mode accroche fenetres est activé --- ( depreciated )
	isOpen 			= false,
	couleurFond 	= (color 56 56 56)

)

------------------------------------------------------------------------------
------ Les préférences ----------------------------------------------------
-- Regroupe les differents structs de préferences					--
------------------------------------------------------------------------------
struct preference (

private
	fichier = "$userScripts\biblio\prefs.ini",

public	
	fenetre 	=  	rollPrincipale (),
	apercus = 	renduApercus(),
	
	fn enregistrer = (
			setINISetting   fichier		"fenetre"   "tailleX"  	( fenetre.taille.x 	as string )
			setINISetting   fichier		"fenetre"   "tailleY"  	( fenetre.taille.y 	as string )
			setINISetting   fichier		"fenetre"   "posX"  		( fenetre.pos.x 		as string )
			setINISetting   fichier		"fenetre"   "posY"  		( fenetre.pos.y 		as string )
			setINISetting   fichier		"fenetre"   "infos"  		( fenetre.infos 		as string )
			setINISetting   fichier		"fenetre"   "edition"  	( fenetre.edition 	as string)
			setINISetting   fichier		"fenetre"   "accroche"	( fenetre.accroche	as string )
		),
	fn charger = (
		---- si existe pas on initialise le fichier ----
		if not doesFileExist fichier then enregistrer ()
		---- sinon on charge ----
		else (
			fenetre.taille.x		= ( getINISetting   fichier		"fenetre"  	 "tailleX"  	)	as integer 
			fenetre.taille.y		= ( getINISetting   fichier		"fenetre"   "tailleY"  	)	as integer 
			fenetre.pos.x			= ( getINISetting   fichier 		"fenetre"    "posX"  	)	as integer 
			fenetre.pos.y			= ( getINISetting   fichier		"fenetre"   "posY"  		)	as integer 
			fenetre.infos			= if ( getINISetting   fichier		"fenetre"  	"infos"  		)	== "true" then true else false
			fenetre.edition 		= if ( getINISetting   fichier		"fenetre"   "edition"  	)	== "true" then true else false
			fenetre.accroche	= if ( getINISetting   fichier		"fenetre"  	"accroche"	)	== "true" then true else false
		)
	)
	
)




