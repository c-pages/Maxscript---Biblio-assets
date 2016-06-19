


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
				menuItem importer 			"Importer" 
				menuItem importerCorona 	"Importer avec convertion Corona (materials)" 
				menuItem importerProxy 	"Importer en tant que proxy Corona" 
				
				seperator sep01
				
				menuItem supprimer 		"Supprimer de la bibliothèque" 
				
				seperator sep02
				
				menuItem ouvirFichier 		"Ouvir le fichier" 
				
				on importer picked do				(	
					debug "importer" 
					elemSelect = bibliotheque.m_rollPrincipal.elemSelect
					if elemSelect.count>0 do 
						bibliotheque.importerDansScene 	elemSelect
				)
				
				on importerCorona picked do				(	
					debug "importer" 
					elemSelect = bibliotheque.m_rollPrincipal.elemSelect
					if elemSelect.count>0 do 
						bibliotheque.importerDansSceneCorona 	elemSelect
				)
				on importerProxy picked do				(	
					debug "importer" 
					elemSelect = bibliotheque.m_rollPrincipal.elemSelect
					if elemSelect.count>0 do 
						bibliotheque.importerDansSceneProxy 	elemSelect
				)
				
				on ouvirFichier picked do		
					debug "ouvirFichier" 
				
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
		)	
			
)

