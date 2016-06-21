


struct Import (

		biblio ,
		m_rollout, 
		skipCamerasEtLum = true,
	
	private
		m_espacement = 30,
		
		
	
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
		
		fn lierPoint 	_nodes nom:(  "Asset" )= (
			
			biblio.apercu.calculerBB 	_nodes
			
			taillePt = biblio.apercu.longueurMax_import
			posPt = biblio.apercu.centre_import
			
			pt = point 	name:(uniqueName ( "GrpBib - " + nom  + " " ) ) \
							size:taillePt \
							centermarker:false \
							axistripod:false \
							cross:false	\
							box:true	\
							constantscreensize:false	\
							drawontop:false	\
							pos:posPt
			
			for obj in _nodes do (
				if obj.parent == undefined do obj.parent = pt
					
			)
			return pt
		),
		
		fn renommerObjects  _nodes 	_nomElem	=(
			for obj in _nodes do 
				obj.name = "bib - " + _nomElem + " - " + obj.name
		),
		
		fn filtrerNodes 	_nodes = (
			for obj in _nodes do try (		
				if  superclassof obj == light		or 	superclassof obj == camera	
					do delete obj 
			)	catch()
		),
		
		
		
		
		
		
	public
		fn fichier  elemSelect	applatir:false  = (
			
			m_rollout.setProgress "Import dans la scene ..." 0
			i=1.
			decalPointSuivant = [0,0,0]
			ptsResult = #()
			
			for elem in elemSelect do (
				
				if m_rollout.cancelled do continue
				pourcent = ( ( i - 1.) / elemSelect.count * 100. )
				m_rollout.setProgress ("Import dans la scene " + ( i as integer )  as string + "/" + elemSelect.count as string  ) 	pourcent
				
				if doesfileexist elem.fichier then (
					
					elem.dateDernierImport = getLocalTime()
					elem.nbrImports += 1
					
					deLockSelection ()
					mergeMAXFile  	elem.fichier		#select  #autoRenameDups 	#renameMtlDups #neverReparent
					
					if 	biblio.m_convertToCoronaMats do
						biblio.conversion.matsToCorona  (selection as array )
					
					local newMesh 
					if applatir 	then 	newMesh = #( biblio.outils.applatir  (selection as array )  )
									else 		newMesh =  (selection as array )
					
					pt = lierPoint  newMesh	 nom:elem.nom
					
					append ptsResult pt
					move pt 	decalPointSuivant
					decalPointSuivant += [ m_espacement + pt.size , 0 , 0 ]
					
					
				)	else format "ERREUR : % n'as pas de fichier valide : %\n" elem.nom elem.fichier
				i+=1
				
			)
			
			i-=1
			
			if m_rollout.cancelled then 
				m_rollout.setProgress ("Import dans la scene : " + ( i as integer )  as string + "/" + elemSelect.count as string  + " éléments. *Annulé*") 100
			else 
				m_rollout.setProgress ("Import dans la scene : " + ( i as integer )  as string + "/" + elemSelect.count as string  + " éléments.") 100				
			
			biblio.arbo.ecrireFichier()
			m_rollout.cancelled = false
			m_rollout.AfficherElements 	m_rollout.noeudSelect
			select ptsResult
		),

		
		fn proxy  elemSelect  =(
			
					
			m_rollout.setProgress "Import dans la scene ..." 0
			i=1.
			decalPointSuivant = [0,0,0]
			ptsResult = #()
			for elem in elemSelect do (
				
				if doesfileexist elem.fichier then (
					elem.dateDernierImport = getLocalTime()
					elem.nbrImports += 1
					if m_rollout.cancelled do continue
					pourcent = ( ( i - 1.) / elemSelect.count * 100. )
					m_rollout.setProgress ("Import dans la scene " + ( i as integer )  as string + "/" + elemSelect.count as string  ) 	pourcent
					
					if doesFileExist elem.proxy then  (
						mergeMAXFile  	elem.proxy		#select  #autoRenameDups 	#renameMtlDups #neverReparent
					) else (
						m_rollout.setProgress (	"Création du proxy ..."  ) 	pourcent
						mergeMAXFile  	elem.fichier		#select  #autoRenameDups 	#renameMtlDups #neverReparent
						biblio.conversion.objsToProxy 	(selection as array ) 	elem
						biblio.conversion.matsToCorona  (selection as array )
					)	
					
					pt = lierPoint  (selection as array ) nom:elem.nom
					append ptsResult pt
					move pt 	decalPointSuivant
					decalPointSuivant += [ m_espacement + pt.size , 0 , 0 ]
				)
				i+=1
			)
			i-=1
			
			if m_rollout.cancelled then 
				m_rollout.setProgress ("Import dans la scene : " + ( i as integer )  as string + "/" + elemSelect.count as string  + " éléments. *Annulé*") 100
			else 
				m_rollout.setProgress ("Import dans la scene : " + ( i as integer )  as string + "/" + elemSelect.count as string  + " éléments.") 100				
			
			m_rollout.cancelled = false			
			m_rollout.AfficherElements 	m_rollout.noeudSelect
			biblio.arbo.ecrireFichier()
			select ptsResult
			
		)
		
		
) --- fin STRUCT -------------





struct Ajout (

		biblio ,
	
	private
		fn ajouterAsset	fichierMax  noeudParent = (
			
			
			holdMaxFile() 
			if classOf noeudParent == Element do		noeudParent = noeudParent.parent
			biblio.outils.viderScene()
			
			-- le nom --
			_nom = getFilenameFile  fichierMax
			
			-- apercu --
			_apercu = biblio.apercu.creer 	fichierMax
			
			-- creation de l'element dans l'arbo ---
			nouvelAsset = biblio.arbo.creerElement 	nom:_nom  type:#model	fichier:fichierMax  apercu:_apercu	parent:noeudParent
			
			nouvelAsset.nbrVertex = biblio.outils.compterVertex  (objects as array )
			
			debug ( " 	# objects as array : " + ( objects as array ) as string  )
			debug ( " 	# creation element : " + nouvelAsset.nomUnique + " / " + nouvelAsset.nom )
			debug ( " 	# noeudParent : " + noeudParent.nomUnique + " / " + noeudParent.nom )
			debug ( " 	# nbrVertex : " + nouvelAsset.nbrVertex  as string )
			
			
			
			biblio.arbo.ecrireFichier()
			
			fetchMaxFile quiet:true
			
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
				
				biblio.m_rollPrincipal.setProgress "Ajout à la bilbiothèque  ..." 0
				
				
				debug "ajouterAssetFichier"
				fichiersDossier = getFiles ( _dossier+  "\\*.max") 
				debug (" fichiersDossier ::::::::::::::::::: " + fichiersDossier as string )
				fichiersAImporter = 	for fichier in fichiersDossier /*where getFilenameType fichier =="max" */	collect fichier
				i = 1.
				for fichierAImporter in fichiersDossier do
				(
					
					if biblio.m_rollPrincipal.cancelled do continue
					
					pourcent = ( ( i - 1.) / fichiersDossier.count * 100. )
					
					biblio.m_rollPrincipal.setProgress ("Ajout à la bilbiothèque " + ( i as integer )  as string + "/" + fichiersDossier.count as string  + " fichiers" ) 	pourcent
					
					
					debug ( "-----------------Importer " + fichierAImporter + "   -------------------------- pourcent : " + pourcent as string )
					debug ( "----------------- i  : " + i  as string )
					debug ( "----------------- ichiersDossier.count  : " + fichiersDossier.count  as string )
					
					noeudParent = biblio.arbo.getParNomUnique 	selectionTV.name
					ajouterAsset	fichierAImporter noeudParent
					
					biblio.m_rollPrincipal.AfficherElements 	biblio.m_rollPrincipal.noeudSelect
					
					i +=1.
				)
			
				i-=1
				
				if biblio.m_rollPrincipal.cancelled then 
					biblio.m_rollPrincipal.setProgress ("Ajout à la bilbiothèque : " + ( i as integer )  as string + "/" + fichiersDossier.count as string  + " *Annulé*") 100
				else 
					biblio.m_rollPrincipal.setProgress ("Ajout à la bilbiothèque : " + ( i as integer )  as string + "/" + fichiersDossier.count as string  + " nouveaux éléments.") 100				
				biblio.m_rollPrincipal.cancelled = false
			
				
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
				
				biblio.m_rollPrincipal.setProgress "Ajout à la bilbiothèque  ..." 0
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
					biblio.m_rollPrincipal.setProgress ("Ajout à la bilbiothèque : 1 nouvel élément.") 100
					
				)
			
		),
		fn selec = (
			
		)
		
)