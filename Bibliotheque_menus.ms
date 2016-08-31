/* #######################################################################################################################

	2017 Christophe Pages (http://www.c-pages.fr) 

##########################################################################################################################
	
	Bibiotheque d'assets 
	
##########################################################################################################################

	Structs regroupant les differents menus ( clique droit et menu de la fenêtre principale )
	
######################################################################################################################## */ 




------------------------------------------------------------- ------------------------------------------
-------declaration (a voir comment pas la faire en global)  ------------------------------------------
------------------------------------------------------------- ------------------------------------------





-------------------------------------------------------------
------- le struct ------------------------------------------
-------------------------------------------------------------
struct Menus (
	public 
	
		fn creerMenuElements = (
			debug "creerMenuTest"
			-------------------------------------------------------------
			------- le menu ------------------------------------------
			-------------------------------------------------------------
			rcMenu rcMenuElements
			(
				menuItem importer 				"Importer" 
				menuItem importerCollapsed 	"Importer collapsed" 		
				menuItem importerProxy 		"Importer Proxy Corona" 
				
				seperator sep01
				
				subMenu  "Options d'import" (
					menuItem matNeRienFaire 		"Matériaux d'origine" 								checked:( not bibliotheque.prefs.apercus.convertToCoronaMats )
					menuItem matconvertCorona 		"Convertir matériaux en Corona" 		checked:( bibliotheque.prefs.apercus.convertToCoronaMats )
				)
				
				seperator sep02
				
				menuItem supprimer 			"Supprimer de la bibliothèque" 
				
				seperator sep03
				
				menuItem ouvirFichierMax 		"Ouvir le fichier max" 
				menuItem ouvirFichierExplo 	"Ouvir dans l'explorateur" 
				
				on matNeRienFaire picked do	(	
					bibliotheque.m_convertToCoronaMats = false
				)
				on matconvertCorona picked do	(	
					bibliotheque.m_convertToCoronaMats = true
				)
				
				on importer picked do	(	
					debug "importer" 
					elemSelect = bibliotheque.m_rollPrincipal.elemSelect
					if elemSelect.count>0 do 
						bibliotheque.importer.fichier 	elemSelect
				)
				
				on importerCollapsed picked do	(	
					debug "importer" 
					elemSelect = bibliotheque.m_rollPrincipal.elemSelect
					if elemSelect.count>0 do 
						bibliotheque.importer.fichier 	elemSelect  applatir:true
				)
				on importerProxy picked do	(	
					debug "importer" 
					elemSelect = bibliotheque.m_rollPrincipal.elemSelect
					if elemSelect.count>0 do 
						bibliotheque.importer.proxy 	elemSelect
				)
				
				on ouvirFichier picked do		(	
					debug "importer" 
					elemSelect = bibliotheque.m_rollPrincipal.elemSelect
					if elemSelect.count>0 do loadMaxFile elemSelect[1].fichier
				)
				
				on supprimer picked do			
					bibliotheque.suprimerElems ()
				
			
			)
			
			
			
			
			popUpMenu 	rcMenuElements
		),
		
		
		fn creerMenuArbo = (
			debug "creerMenuTest"
			-------------------------------------------------------------
			------- le menu ------------------------------------------
			-------------------------------------------------------------
			rcMenu rcMenuDossiers
			(
				menuItem nouveauDossier 	"Nouveau dossier" 
				menuItem supprimer 			"Supprimer" 
				
				on nouveauDossier picked do
					bibliotheque.nouveauNoeud()
				
				on supprimer picked do 
					bibliotheque.suprimerNoeud()
				
			)
			
			
			
			
			popUpMenu 	rcMenuDossiers
		),
		
		fn getMenuRolloutPrincipal = (
			
			rcMenu rcRolloutPrincipal
			(
				---- menu ----
				subMenu "Edit"	(
					menuItem m_nouveauDossier 	"Nouveau dossier" 
					menuItem m_supprimer 			"Supprimer"					
				)
				subMenu "Vues" (
					menuItem m_afficherInfos 	"Infos"  		checked:( bibliotheque.getInfosOuvert() )
					menuItem m_afficherApercus	"Création des aperçus" 
				)
				subMenu "Préferences"	(
					menuItem m_preferences 			"Préferences" 
					menuItem m_resetPreferences 	"Reinitialiser" 
				)
				
				
				
				
				---- evenements ----
				on m_nouveauDossier picked do	
					bibliotheque.nouveauNoeud()
				on m_supprimer picked do 
					bibliotheque.suprimerNoeud()
				
				on m_afficherInfos picked do	
					bibliotheque.ouvrirInfos()
				on m_afficherApercus picked do	
					bibliotheque.ouvrirApercus()
				
				on m_resetPreferences picked do 
					if queryBox "Etes-vous sûr de vouloir réinitialiser les préférences de la bibliotheque ?" do
						bibliotheque.prefs.reset()				
				on m_preferences picked do 					
					bibliotheque.ouvrirPreferences()
				
			)
			return rcRolloutPrincipal
		)
		
		
		
)

