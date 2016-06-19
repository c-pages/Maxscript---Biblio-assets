


struct Import (

		biblio ,
	private
		
		fn setSelectionLocked 	bool = (
			fn selLocked   = (
				selectionlock = false
				sel = selection as array
				clearselection()
				if selection.count != 0 then selectionlock = true else selectionlock = false
				select sel
				return selectionlock 
			)
			case bool of (
				-- to lock
				true: if not selLocked() do (max spacebar)
				-- and unlock
				false: if selLocked() do (max spacebar)
			)
		),
		fn deLockSelection = ( setSelectionLocked false ),
	public
		fn fichier  _fichier	= (
			deLockSelection ()
			mergeMAXFile  	_fichier	#select
		),
		fn corona 	_fichier	= ( 
			deLockSelection ()
			mergeMAXFile  	_fichier	#select
			biblio.conversion.matsToCorona  (selection as array )
		),
		fn proxy  _fichier	 _element  =(
			deLockSelection ()
			
			if doesFileExist _element.proxy then  (
				mergeMAXFile  	_element.proxy		#select 
			)
			 else (
				mergeMAXFile  	_fichier	#select
				biblio.conversion.objsToProxy 	(selection as array ) 	_element
			)	
		)
		
)





struct Ajout (

		biblio ,
	
	private
		fn ajouterAsset	fichierMax  noeudParent = (
			
-- 			resetMaxFile #noPrompt
			
			if classOf noeudParent == Element do
				noeudParent = noeudParent.parent
			
			-- le nom --
			_nom = getFilenameFile  fichierMax
			
			-- apercu --
			_apercu = biblio.apercu.creer 	fichierMax
			
			-- creation de l'element dans l'arbo ---
			nouvelAsset = biblio.arbo.creerElement 	nom:_nom  type:#model	fichier:fichierMax  apercu:_apercu	parent:noeudParent
			debug ( " 	# creation element : " + nouvelAsset.nomUnique + " / " + nouvelAsset.nom )
			debug ( " 	# noeudParent : " + noeudParent.nomUnique + " / " + noeudParent.nom )
			
			biblio.arbo.ecrireFichier()
			
		) ,

	public
		-- ajout asset dans la biblio --
		fn dossier 	_dossier = (
			
			local nomApercu
			local sceneCourante = ""
			
			selectionTV = biblio.m_rollPrincipal.getListeSelection()
			
			debug (" _dossier ::::::::::::::::::: " + _dossier as string )
			debug (" selectionTV ::::::::::::::::::: " + selectionTV as string )
			
			if selectionTV !=undefined do (
				
				holdMaxFile() 
				
				debug "ajouterAssetFichier"
				fichiersDossier = getFiles ( _dossier+  "\\*.max") 
				debug (" fichiersDossier ::::::::::::::::::: " + fichiersDossier as string )
				fichiersAImporter = 	for fichier in fichiersDossier /*where getFilenameType fichier =="max" */	collect fichier
				
				for fichierAImporter in fichiersDossier do
				(
					debug ( "-----------------Importer " + fichierAImporter + "   --------------------------" )
					
					noeudParent = biblio.arbo.getParNomUnique 	selectionTV.name
					ajouterAsset	fichierAImporter noeudParent
										
					
				)
			
				-- actualiser le treeview ---
				biblio.m_rollPrincipal.remplirTreeView 	biblio.arbo.root
				
				fetchMaxFile quiet:true
			)
		
			
		),
		
		-- ajout asset dans la biblio --
		fn fichier = (
			
			debug "ajouterAssetFichier"
			
			fichierAImporter = getOpenFileName  caption:"Fichier à integrer dans la bibliotheque" \
											types:"model (*.max)|*.max|All Files (*.*)|*.*|"	
			
			if 	fichierAImporter != undefined  do ( 
				
					holdMaxFile() 
					
					debug ( "Importer " + fichierAImporter )
				
					selectionTV = biblio.m_rollPrincipal.getListeSelection()
					if selectionTV !=undefined do (
					
						noeudParent = biblio.arbo.getParNomUnique 	selectionTV.name
						ajouterAsset	fichierAImporter noeudParent
						
						-- actualiser le treeview ---
						biblio.m_rollPrincipal.remplirTreeView 	biblio.arbo.root
						
						
					)
	-- 					show 	( selectionTV )
					
					fetchMaxFile quiet:true
					
				)
			
		),
		fn selec = (
			
		)
		
)