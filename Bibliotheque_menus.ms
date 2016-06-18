


------------------------------------------------------------- ------------------------------------------
-------declaration (a voir comment pas la faire en global)  ------------------------------------------
------------------------------------------------------------- ------------------------------------------





-------------------------------------------------------------
------- le struct ------------------------------------------
-------------------------------------------------------------
struct Menus (
	public 
		biblio,
		fn creerMenuTest = (
			debug "creerMenuTest"
			-------------------------------------------------------------
			------- le menu ------------------------------------------
			-------------------------------------------------------------
			rcMenu rcMenuDossiers
			(
-- 				menuItem renommer 			"Renommer" 
				menuItem nouveauDossier 	"Nouveau dossier" 
				menuItem supprimer 			"Supprimer" 
				
				on renommer picked do
				(	debug "renommer" )
				on nouveauDossier picked do
				(	
					debug "nouveauDossier" 
					noeudSelect = bibliotheque.m_rollPrincipal.noeudSelect
					if noeudSelect != undefined do (
						bibliotheque.arbo.creerNoeud  nom:"NouveauDossier" 	parent:noeudSelect 
					
						bibliotheque.arbo.ecrireFichier()
-- 						bibliotheque.m_rollPrincipal.
									--- maj interface ---
						
						bibliotheque.m_rollPrincipal.remplirTreeView 	bibliotheque.arbo.root
						bibliotheque.m_rollPrincipal.maj_UI ()
						bibliotheque.m_rollPrincipal.afficherInfos()
					)
					
				)
				on supprimer picked do
				(	debug "supprimer" 
					noeudSelect = bibliotheque.m_rollPrincipal.noeudSelect
					if noeudSelect.nomUnique != "ROOT" do (
						debug ("supprimer : noeudSelect : " + noeudSelect.nom )
						noeudSelect.retirer()
						bibliotheque.arbo.ecrireFichier()
										--- maj interface ---
						bibliotheque.m_rollPrincipal.remplirTreeView 	bibliotheque.arbo.root
						bibliotheque.m_rollPrincipal.maj_UI ()
						bibliotheque.m_rollPrincipal.afficherInfos()
					)
				)
				
			)
			
			
			
			
			popUpMenu 	rcMenuDossiers
		)	
			
)


-----------------------------------------------------------
----- le menu ------------------------------------------
-----------------------------------------------------------

-- rcMenu rcMenuDossiers
-- (
-- 	menuItem renommer 			"Renommer" 
-- 	menuItem nouveauDossier 	"Nouveau dossier" 
-- 	menuItem supprimer 			"Supprimer" 
-- 	
-- 	/*
-- 	subMenu "Importer dans la bilbl." (
-- 		menuItem importerFichier "Fichier" --checked:FichierChecked
-- 		menuItem importerDossier "Dossier" --checked:dossierChecked--enabled:CheckedGroup
-- 		menuItem importerDossierEtSousDossiers "Dossier et ces sous-dossiers"  --checked:DossierEtSousDossiersChecked--enabled:checkedSolo
-- 	


-- 	)
-- 	subMenu "Options d'import dans la bibl." (
-- 			menuItem ApercuAuto "Aperçu"	checked:Check_ApercuAuto_Import
-- 			menuItem CollapseAuto "Collapse"	checked:Check_CollapseAuto_Import
-- 			menuItem ConvertMRAuto "Convertion en mr Arch&Design"	checked:Check_ConvertMRAuto_Import
-- 			menuItem CopyArbo "Copier l'arborescence (import dos. et sous-dos.)"	enabled:false--checked:CopyArbo
-- 		)	
-- 	
-- 	menuItem ScanAprecuBiblio "Créer les aperçus manquants de la bibliothèque"

-- 	seperator sep04
-- 		
-- 	menuItem NouveauDossier "Nouveau dossier"
-- 	menuItem RenommerDossier "Renommer"	
-- 	menuItem SupprimerDossier "Supprimer"	enabled:false
-- 		seperator sep05
-- 	menuItem Explorer "Explorer le dossier" --enabled:CheckedGroup
-- 		
-- 	on RenommerDossier picked do
-- 	(
-- 		Arbo_ActX.SelectedNode.BeginEdit()
-- 	)*/
-- ) 

