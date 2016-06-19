
--------------------------------------------------------------------------------------------------------------------
------- Les composites de l'arborescence ----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------
-- un élément  est une feuille (composite) 			--
-- peut representer une image, un fichier max ...	--
----------------------------------------------------------
struct Element (
	
	-- parametre de l'element --
	public
		nomUnique = "E",		------ NomUnique de l'élément, ne doit jamais y avoir 2 element avec le mm nomUnique !!! ---
		nom 			= "nom",	------ le nom affiché de l'élément ---
		type			= #vide,
		fichier		= "",
		apercu		= "",
		proxy			= "",
		detail			= "",
		tags			="",
		notes 		= "",
	
	-- le composite --
	public
		parent 			= undefined,
		enfants 			= #(),		
		
	public
		fn compteElements = (
			i=0
			if classof this == Element do  i+=1
			return i
		),
		fn ajouterEnfant 	_enfant 	= (),
		fn definirParent 	_parent 	= ( parent = _parent ),
		fn retirer  			 = (
			if parent != undefined then (
				
				deleteFile apercu
				deleteFile detail
				deleteFile proxy
				deleteFile ( getFilenamePath  proxy + getFilenameFile  proxy + ".cgeo" )
				
				_index  = findItem parent.enfants this
				if _index != 0 do deleteItem   parent.enfants 	_index
				parent = undefined
				
				
				return this
			) else return undefined
		),
		fn getNbrEnfants = ( return 0),
		fn getIndexUnique = ( substring nomUnique 2 -1 as integer ) 
)	-- fin Struct Element




----------------------------------------------------------
-- un Noeud est une branche (composite) 			--
-- permettant de classer les differents elements 	--
----------------------------------------------------------
struct Noeud (
	
	-- parametre du noeud --
	public
		nomUnique 		= "N",
		nom 				= "nom du noeud",
		
		
	-- le composite --
	public
		parent  			= undefined ,
		enfants 			= #(),
		
		fn compteElements = (
			i=0
			for enfant in enfants do 
					i+=enfant.compteElements ()
			return i
		),
		
	public
		fn ajouterEnfant 		_enfant 	= (
			append enfants 	_enfant 
			_enfant.retirer()
			_enfant.definirParent ( this )
		),
		
		fn definirParent 	_parent 	= ( parent = _parent ),
		
		fn retirer  			 = (
			if parent != undefined then (
				for enfant in enfants do 
					enfant.retirer()
				
				_index  = findItem parent.enfants this
				if _index != 0 do deleteItem   parent.enfants 	_index
				parent = undefined
				return this
			) else return undefined
		),
		
		fn getNbrEnfants = ( return compteElements () ),
		fn getIndexUnique = ( substring nomUnique 2 -1 as integer ) 
	
)	-- fin Struct noeud



--------------------------------------------------------------------------------------------------------------------
-------  l'arborescence ------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-- permet de gerer les noeuds et elements 			--
-- de lire ou ecrire l'arbo dans un fichier INI		--
--------------------------------------------------------------
struct Arborescence (
	
	biblio,
	
	---- les parametres ----
	public
		root,
		fichierArbo = "$userScripts\bibliotheque\Bibliotheque_arbo.ini",
		noeudRecherche,
	
	private
		indexUnique 	= 0,
		m_separateur = ", -/.;",
		m_tags = #(),
	
	---  outils debug -------------------
	private
		indent = 0,
		tab = "    ",
		decallage ="",
		
	public
		fn afficherNoeud 	_noeud = (
			decallage =""
			for i = 0 to indent do
				decallage += tab
			
			format "%> nom: %\n" 			decallage	_noeud.nom
			format "%  nomUnique: %\n" 	decallage	_noeud.nomUnique		
			format "%  parent: %\n" 			decallage	(_noeud.parent as string)	
			format "%  enfants: %\n" 		decallage	(_noeud.enfants as string)			
			
			for enfant in _noeud.enfants do (
				indent += 1
				afficherNoeud 	enfant
				indent -= 1
			)
		),
		
		fn afficher = (
			format "\n----- Arborescence --------------\n"
			afficherNoeud root
			format "----- Arborescence --------------\n\n"
		),
	
		---- Creation des nouveaux élements ----
		fn creerNoeud  nom: 	parent: 	nomUnique:		= ( 
			
			_nouveauNoeud = Noeud()
			indexUnique += 1
			_nouveauNoeud.nomUnique += indexUnique as string
			if nom != unsupplied 			do  	_nouveauNoeud.nom 			= nom
			if parent != unsupplied and  parent != undefined 		
													do  parent.ajouterEnfant 	 _nouveauNoeud
			if nomUnique != unsupplied 	do _nouveauNoeud.nomUnique	= nomUnique
			
			
			return _nouveauNoeud
		),
		fn creerElement nom:  parent:  type:		fichier:	apercu:  	nomUnique:		= ( 
			_nouvelElement = Element()
			
			indexUnique += 1
			_nouvelElement.nomUnique += indexUnique as string
			if nom != unsupplied 			do  	_nouvelElement.nom 			= nom
			if parent != unsupplied  and  parent != undefined	
													do parent.ajouterEnfant 			_nouvelElement
			if type != unsupplied 			do  	_nouvelElement.type 			= type
			if fichier != unsupplied 		do  	_nouvelElement.fichier			= fichier
			if apercu != unsupplied 		do  	_nouvelElement.apercu		= apercu
			if nomUnique != unsupplied 	then _nouvelElement.nomUnique		= nomUnique
			
			return _nouvelElement
		),
		
		
		
		
		fn vider = (
			root 					= Noeud()
			root.nom 			= "ROOT"
			root.nomUnique 	= "ROOT"
			
			noeudRecherche					= Noeud()
			noeudRecherche.nom 			= "RECHERCHE"
			noeudRecherche.nomUnique 	= "RECHERCHE"
			
			nbrElements 		= 0
			nbrNoeuds 			= 0
			indexUnique 		= 0
		),
		
		---- Ecriture du fichier INI ----
		fn ecrireNoeud  _noeud 	= (
			-- param communs --
			setINISetting   fichierArbo	_noeud.nomUnique   "nom"  _noeud.nom
			setINISetting   fichierArbo	_noeud.nomUnique   "parent"  ( if _noeud.parent ==undefined then "undefined" else _noeud.parent.nom)
			
			case classOf _noeud  of (
				noeud: (
					setINISetting   fichierArbo	_noeud.nomUnique   "composite"  #branche
					
					-- les enfants --
					_enfants = ""
					for enfant in _noeud.enfants do
						_enfants += enfant.nomUnique + ";"
					setINISetting   fichierArbo	_noeud.nomUnique   "enfants"  _enfants
					
					-- recusrcivité --
					for enfant in _noeud.enfants do ecrireNoeud  enfant 
				)
				element: (
					setINISetting   fichierArbo	_noeud.nomUnique   "composite"  #feuille
					
					setINISetting   fichierArbo	_noeud.nomUnique   "type"  		_noeud.type
					setINISetting   fichierArbo	_noeud.nomUnique   "fichier"  	_noeud.fichier
					setINISetting   fichierArbo	_noeud.nomUnique   "apercu"  	_noeud.apercu
					setINISetting   fichierArbo	_noeud.nomUnique   "detail"  	_noeud.detail
					setINISetting   fichierArbo	_noeud.nomUnique   "notes"  	_noeud.notes
					setINISetting   fichierArbo	_noeud.nomUnique   "tags"  	_noeud.tags
					setINISetting   fichierArbo	_noeud.nomUnique   "proxy"  	_noeud.proxy
				)
			)
			
		),
		fn ecrireFichier = (
			ecrireNoeud Root
		),
		
		
		---- lecture du fichier INI ----
		fn lireNoeud 	_nomUnique 	_parent = (
			
			local _nouveauNoeud
			
			if hasINISetting fichierArbo 	_nomUnique 	then (
				
				_composite = getINISetting   fichierArbo	_nomUnique   "composite"
				case _composite of (
					"feuille":( 
						_type 			= getINISetting   fichierArbo	_nomUnique   "type"  
						_nom 			= getINISetting   fichierArbo	_nomUnique   "nom"  
						_fichier 			= getINISetting   fichierArbo	_nomUnique   "fichier"  
						_apercu 		= getINISetting   fichierArbo	_nomUnique   "apercu"				
						
						_nouveauNoeud = creerElement 	nom:_nom  type:_type	fichier:_fichier  apercu:_apercu	nomUnique:_nomUnique parent:_parent
							
						_nouveauNoeud.notes = getINISetting   fichierArbo	_nomUnique   "notes"
						_nouveauNoeud.tags = getINISetting   fichierArbo	_nomUnique   "tags"
						_nouveauNoeud.detail = getINISetting   fichierArbo	_nomUnique   "detail"
						_nouveauNoeud.proxy = getINISetting   fichierArbo	_nomUnique   "proxy"
					)
					"branche":(
						
						_nom 			= getINISetting   fichierArbo	_nomUnique   "nom"  
						_enfants 		= filterString 		(getINISetting   fichierArbo	_nomUnique   "enfants" )  ";"	
						
						_nouveauNoeud 	= creerNoeud 	nom:_nom   nomUnique:_nomUnique  parent:_parent
						
					
						for _enfant in _enfants do (
							lireNoeud   _enfant 		_nouveauNoeud
						)
						
					)
				) -- fin case
				
				return _nouveauNoeud
				
			) else format "		le noeud: '%' n'est pas dans le fichier INI (%)\n" _nom fichierArbo
		),
		
		fn lireFichier = (
			vider()			
			root = lireNoeud   "ROOT" 	undefined 		
			
			return _root
		),
		
		
		
	-- Recheerche de noeud
	result,
	private
		fn chercheParNomUnique 	_nom		_noeud = (
-- 			result = undefined
			if _noeud.nomUnique == _nom	 then result =  _noeud
												else	for enfant in _noeud.enfants do chercheParNomUnique 	_nom		enfant 
			
		),
		fn chercheParNom 	_nom		_noeud = (
-- 			result = undefined
			if _noeud.nom == _nom	 then result =  _noeud
												else	for enfant in _noeud.enfants do chercheParNom 	_nom		enfant 
			
		),
		
	public
		fn getParNomUnique _nom = (
			if _nom == "RECHERCHE" do return noeudRecherche
			result = undefined
			chercheParNomUnique 	_nom		root 
			return result
		),
		fn getParNom _nom = (
			if _nom == "RECHERCHE" do return noeudRecherche
			result = undefined
			chercheParNom 	_nom		root 
			return result
		),
		
		fn getNoeudRecherche = return noeudRecherche ,
		
		
		
		-- recuperer tout les elements ----
		elements,
		fn addElements	_parent	=(
			if _parent.nomUnique != "RECHERCHE"  do 
				for elem in _parent.enfants do 
					case classOf elem of (
						Element:	append elements 	elem
						Noeud:		addElements 		elem
					)
			
		),
		
		fn getElements = (
			elements = #()
			addElements root
			return elements
		),
		
		
	
	
	---- recherche de tags ---
	private
		fn tagsToArray txt = (
			return filterString  txt m_separateur
		),
		
		
		fn chercherTagDansNoeud 	_noeud 	_tag = (
			
			tagsDuNoeud = tagsToArray 	_noeud.tags
			result = undefined
			if ( findString _noeud.tags	 _tag ) != undefined then (
				result = _noeud 
			) else 
			if ( findString _noeud.nom  _tag ) != undefined then (
				result = _noeud 
			)
							
			return result
			
		),
		
		
	public
		fn chercherTags 	txt  =	(
			elemsResult = #()
			tagsRecherche = filterString	txt 	m_separateur
			elementsTotal = getElements()
			
			for tagRecherche in tagsRecherche do
				for elem in elementsTotal do (
					result = chercherTagDansNoeud 	elem 	tagRecherche
					if result!= undefined do appendifunique elemsResult	 result
				)
			return elemsResult
		),
			
	private
		fn getTags  _noeud = ( 
			case classof _noeud of (
				Element:(
					listTags = filterString 	_noeud.tags 	m_separateur
					for tag in listTags do
						appendifunique m_tags 	tag
				)
				Noeud:(
					for enfant in _noeud.enfants do
						getTags enfant
				)
			)
			
		),
		
	public
		fn getToutTags  node:root = ( 
			m_tags = #()
			getTags 	node
			return m_tags
		),
		
		fn nettoyer  = (
			
			debug "supprimerOrphelins"
			listeFichiers = getFiles ( biblio.apercu.dossierApercus + "\\*.jpg" )
			debug ("listeFichiers : " + listeFichiers.count as string ) 
			listeElements = getElements()
			for fichier in listeFichiers do ( 	
				debug ("fichier : " + fichier as string ) 
				present = false
				if getFilenameFile fichier != nomApercuVide do (
					for elem in listeElements do (
						if getFilenameFile fichier == getFilenameFile elem.apercu  do 
							present = true
						if getFilenameFile fichier == getFilenameFile elem.detail  do 
							present = true
					)
					if not present do (
						format " DELETE :%\n"  fichier
						deleteFile fichier
					)
				)
			)
			
			listeFichiers = getFiles ( biblio.conversion.dossierProxy + "\\*.max" )
			debug ("listeFichiers : " + listeFichiers.count as string ) 

			for fichier in listeFichiers do ( 	
				debug ("fichier : " + fichier as string ) 
				present = false
				for elem in listeElements do (
					if getFilenameFile fichier == getFilenameFile elem.proxy  do 
						present = true
					if getFilenameFile fichier == ( "_" + getFilenameFile elem.detail ) do 
						present = true
				)
				if not present do (
					format " DELETE :%\n"  fichier
					deleteFile fichier
				)
			)
			
		
		),
		
	---- manipulations ----	
	public
		fn bouger 	_elements	_noeudDest = (
			for element in _elements do(
				_noeudDest.ajouterEnfant 	element
			)
			ecrireFichier()
		),
		
	---- Initialisation  ----
	private
		on create do (
			vider ()
			
			-- on verifie qu'il existe sinon on creer un vierge ------
			if not doesfileexist fichierArbo then (
				debug "INI EXISTE PAS ON CREER NOUVEAU"
				vider()			
				ecrireFichier()
			) 		
			
			lireFichier()
		)
)	-- fin Struct Arborescence








