/* #######################################################################################################################

	2017 Christophe Pages (http://www.c-pages.fr) 

##########################################################################################################################
	
	Bibiotheque d'assets 
	
##########################################################################################################################

	Organisation des preferences dans des structs
	
######################################################################################################################## */ 
	



------------------------------------------------------------------------------
------ Rendus  -------------------------------------------------------------
------------------------------------------------------------------------------
-- Les preferences actives pour les rendus des  aperçus			--
------------------------------------------------------------------------------
struct prefsApercus (
	taille								= [256,256],		
	angleVue 						= 40,
	angleVueDetail 				= 9,	
	coefDistance					= 1.2,
	moteur							= Corona_1_4(),	
	noiseLevel 					= 7,
	noiseLevelDetail				= 11,
	denoiseAmount 				= .4,
	exposition 					= -5,
	highlightCompress			= 1.4,
	temperatureRendu 		= 5000,
	contraste 						= 3,
	nom 								= "apercu_",
	nomDetail 					= "apDetail_",
	nomVide 						= "apVide" ,
	nomCalqueImport 			= "ImportTemp",
	dossier 							= "C:\\Users\\kris\\AppData\\Local\\Autodesk\\3dsMax\\2017 - 64bit\\ENU\\scripts\\biblio\\apercus",
	dossierImport 				=	"C:\Users\kris\Documents\donnees 3D",
	convertToCoronaMats 	= true
)




------------------------------------------------------------------------------
------ Rollout ---------------------------------------------------------------
------------------------------------------------------------------------------
-- Les preferences pour la fenetre de la bibliotheque				--
------------------------------------------------------------------------------
struct prefsRollPrincipale (
	
	taille 			= [1300,900],		---- la taille de la fenetre	---
	pos 				= [50,50],			---- la position de la fenetre ---	
	infos				=	true,					---- si l'onglet "infos" est ouvert ---
	edition			=	false,				---- si la fenetre edition est ouverte ---	
	accroche		=	false,				---- si le mode accroche fenetres est activé --- ( depreciated )
	isOpen 			= false,
	couleurFond 	= (color 56 56 56),
	tailleApercus = [255, 255 ]

)

------------------------------------------------------------------------------
-- Les preferences pour la fenetre des infos							--
------------------------------------------------------------------------------
struct prefsRollInfos (
	
	taille 			= [1300,900],		---- la taille de la fenetre	---
	pos 				= [50,50]				---- la position de la fenetre ---	

)

------------------------------------------------------------------------------
-- Les preferences pour la creation de proxies						--
------------------------------------------------------------------------------
struct prefsProxies (	
	dossier 							= "C:\\Users\\kris\\AppData\\Local\\Autodesk\\3dsMax\\2017 - 64bit\\ENU\\scripts\\biblio\\proxies"
)
------------------------------------------------------------------------------
-- Les preferences pour les nouveau asset						--
------------------------------------------------------------------------------
struct prefsAssets (	
	dossier 							= "C:\\Users\\kris\\AppData\\Local\\Autodesk\\3dsMax\\2017 - 64bit\\ENU\\scripts\\biblio\\assets"
)





------------------------------------------------------------------------------------------------------------------------------------------------------------
------ LES PRéFéRENCES ----------------------------------------------------------------------------------------------------------------------------------
-- le struct principal qui regroupe les differents structs de préferences					--------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
struct preference (

private
	---- le chemin de preferences	----
	fichier = "$userScripts\biblio\prefs.ini",

public	
	---- les structs des diferenetes preferences	----
	fenetre 			=  prefsRollPrincipale (),
	fenInfos	 	=  prefsRollInfos 		(),
	apercus 		= 	prefsApercus 		(),
	proxies	 		= 	prefsProxies 			(),
	assets	 		= 	prefsAssets 			(),
	
public	
	---- les fonctions	----
	fn enregistrer = (
		
		---- APERCUS ----
		setINISetting   fichier		"apercus"   "tailleX"  						( apercus.taille.x 					as string )
		setINISetting   fichier		"apercus"   "tailleY"  						( apercus.taille.y 					as string )
		setINISetting   fichier		"apercus"   "angleVue"					( apercus.angleVue				as string )
		setINISetting   fichier		"apercus"   "angleVueDetail"  			( apercus.angleVueDetail 		as string )
		setINISetting   fichier		"apercus"   "moteur"  					( apercus.moteur 					as string )
		setINISetting   fichier		"apercus"   "noiseLevel"  				( apercus.noiseLevel 				as string )
		setINISetting   fichier		"apercus"   "noiseLevelDetail"			( apercus.noiseLevelDetail 		as string )
		setINISetting   fichier		"apercus"   "denoiseAmount"			( apercus.denoiseAmount 		as string )
		setINISetting   fichier		"apercus"   "exposition"  				( apercus.exposition 				as string )
		setINISetting   fichier		"apercus"   "highlightCompress"		( apercus.highlightCompress	as string )
		setINISetting   fichier		"apercus"   "temperatureRendu"		( apercus.temperatureRendu	as string )
		setINISetting   fichier		"apercus"   "contraste"  					( apercus.contraste 				as string )
		setINISetting   fichier		"apercus"   "nom"  						( apercus.nom 						as string )
		setINISetting   fichier		"apercus"   "nomVide"  					( apercus.nomVide 				as string )
		setINISetting   fichier		"apercus"   "nomCalqueImport"		( apercus.nomCalqueImport 	as string )
		setINISetting   fichier		"apercus"   "dossier"  					( apercus.dossier 					as string )
		setINISetting   fichier		"apercus"   "dossierImport"  			( apercus.dossierImport 			as string )
		setINISetting   fichier		"apercus"   "convertToCoronaMats"	( apercus.convertToCoronaMats	as string )
		
		---- FENETRE ----
		setINISetting   fichier		"fenetre"   "tailleX"  	( fenetre.taille.x 	as string )
		setINISetting   fichier		"fenetre"   "tailleY"  	( fenetre.taille.y 	as string )
		setINISetting   fichier		"fenetre"   "posX"  		( fenetre.pos.x 		as string )
		setINISetting   fichier		"fenetre"   "posY"  		( fenetre.pos.y 		as string )
		setINISetting   fichier		"fenetre"   "infos"  		( fenetre.infos 		as string )
		setINISetting   fichier		"fenetre"   "edition"  	( fenetre.edition 	as string )
		setINISetting   fichier		"fenetre"   "accroche"	( fenetre.accroche	as string )
		setINISetting   fichier		"fenetre"   "tailleApercusX"  	( fenetre.tailleApercus.x 	as string )
		setINISetting   fichier		"fenetre"   "tailleApercusY"  	( fenetre.tailleApercus.y 	as string )
	),
	fn charger = (
		---- si existe pas on initialise le fichier ----
		if not doesFileExist fichier then enregistrer ()
		---- sinon on charge ----
		else (
			
			---- APERCUS ----
			apercus.taille.x 						= ( getINISetting   fichier		"apercus"   "tailleX"  						)	as integer 
			apercus.taille.y 						= ( getINISetting   fichier		"apercus"   "tailleY"  						)	as integer 
			apercus.angleVue					= ( getINISetting   fichier		"apercus"   "angleVue"					)	as float 
			apercus.angleVueDetail 			= ( getINISetting   fichier		"apercus"   "angleVueDetail"  			)	as float
			apercus.moteur 						= execute ( ( filterString ( getINISetting   fichier		"apercus"   "moteur"  ) ":")[1] +"()" )
			apercus.noiseLevel 				= ( getINISetting   fichier		"apercus"   "noiseLevel"  				)	as float 
			apercus.noiseLevelDetail 		= ( getINISetting   fichier		"apercus"   "noiseLevelDetail"			)	as float 
			apercus.denoiseAmount 			= ( getINISetting   fichier		"apercus"   "denoiseAmount"			)	as float 
			apercus.exposition 				= ( getINISetting   fichier		"apercus"   "exposition"  				)	as float 
			apercus.highlightCompress 	= ( getINISetting   fichier		"apercus"   "highlightCompress"		)	as float 
			apercus.temperatureRendu 	= ( getINISetting   fichier		"apercus"   "temperatureRendu"		)	as float 
			apercus.contraste 					= ( getINISetting   fichier		"apercus"   "contraste"  					)	as float 
			apercus.nom 							= ( getINISetting   fichier		"apercus"   "nom"  						)	
			apercus.nomVide 					= ( getINISetting   fichier		"apercus"   "nomVide"  					)
			apercus.nomCalqueImport 		= ( getINISetting   fichier		"apercus"   "nomCalqueImport"		)
			apercus.dossier 						= ( getINISetting   fichier		"apercus"   "dossier"  					)
			apercus.dossierImport 			= ( getINISetting   fichier		"apercus"   "dossierImport"  			)
			apercus.convertToCoronaMats	=  if ( getINISetting   fichier		"apercus"   "convertToCoronaMats"	) == "true" then true else false
			
			---- FENETRE ----
			fenetre.taille.x		= ( getINISetting   fichier		"fenetre"  	"tailleX"  	)	as integer 
			fenetre.taille.y		= ( getINISetting   fichier		"fenetre"   "tailleY"  	)	as integer 
			fenetre.pos.x			= ( getINISetting   fichier 		"fenetre"   "posX"  		)	as integer 
			fenetre.pos.y			= ( getINISetting   fichier		"fenetre"   "posY"  		)	as integer 
			fenetre.infos			= if ( getINISetting   fichier	"fenetre"  	"infos"  		)	== "true" then true else false
			fenetre.edition 		= if ( getINISetting   fichier	"fenetre"   "edition"  	)	== "true" then true else false
			fenetre.accroche	= if ( getINISetting   fichier	"fenetre"  	"accroche"	)	== "true" then true else false
		)
	),
	fn reset = (
		fenetre 			=  prefsRollPrincipale ()
		fenInfos	 	=  prefsRollInfos 		()
		apercus 		= 	prefsApercus 		()
		proxies	 		= 	prefsProxies 			()
		assets	 		= 	prefsAssets 			()
		enregistrer ()
	)
	
)




