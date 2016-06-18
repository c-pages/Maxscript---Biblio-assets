
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
		appercu		= "",
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
				_index  = findItem parent.enfants this
				if _index != 0 do deleteItem   parent.enfants 	_index
				parent = undefined
				return this
			) else return undefined
		),
		fn getNbrEnfants = ( return 0)
	
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
				_index  = findItem parent.enfants this
				if _index != 0 do deleteItem   parent.enfants 	_index
				parent = undefined
				return this
			) else return undefined
		),
		fn getNbrEnfants = ( return compteElements () )
	
)	-- fin Struct noeud



--------------------------------------------------------------------------------------------------------------------
-------  l'arborescence ------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-- permet de gerer les noeuds et elements 			--
-- de lire ou ecrire l'arbo dans un fichier INI		--
--------------------------------------------------------------
struct Arborescence (
	
	---- les parametres ----
	public
		root,
		fichierArbo = "$userScripts\bibliotheque\Bibliotheque_arbo.ini",
		
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
		fn creerElement nom:  parent:  type:		fichier:	appercu:  	nomUnique:		= ( 
			_nouvelElement = Element()
			
			indexUnique += 1
			_nouvelElement.nomUnique += indexUnique as string
			if nom != unsupplied 			do  	_nouvelElement.nom 			= nom
			if parent != unsupplied  and  parent != undefined	
													do parent.ajouterEnfant 			_nouvelElement
			if type != unsupplied 			do  	_nouvelElement.type 			= type
			if fichier != unsupplied 		do  	_nouvelElement.fichier			= fichier
			if appercu != unsupplied 		do  	_nouvelElement.appercu		= appercu
			if nomUnique != unsupplied 	then _nouvelElement.nomUnique		= nomUnique
			
			return _nouvelElement
		),
		
		
		
		
		fn vider = (
			root 					= Noeud()
			root.nom 			= "ROOT"
			root.nomUnique 	= "ROOT"
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
					setINISetting   fichierArbo	_noeud.nomUnique   "appercu"  	_noeud.appercu
					setINISetting   fichierArbo	_noeud.nomUnique   "detail"  	_noeud.detail
					setINISetting   fichierArbo	_noeud.nomUnique   "notes"  	_noeud.notes
					setINISetting   fichierArbo	_noeud.nomUnique   "tags"  	_noeud.tags
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
						_appercu 		= getINISetting   fichierArbo	_nomUnique   "appercu"				
						
						_nouveauNoeud = creerElement 	nom:_nom  type:_type	fichier:_fichier  appercu:_appercu	nomUnique:_nomUnique parent:_parent
							
						_nouveauNoeud.notes = getINISetting   fichierArbo	_nomUnique   "notes"
						_nouveauNoeud.tags = getINISetting   fichierArbo	_nomUnique   "tags"
						_nouveauNoeud.detail = getINISetting   fichierArbo	_nomUnique   "detail"
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
			
-- 			creerNoeud   nom:"Recherche" 	parent:root 	nomUnique:"Recherche"	
			
			return  _root
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
			result = undefined
			chercheParNomUnique 	_nom		root 
			return result
		),
		fn getParNom _nom = (
			result = undefined
			chercheParNom 	_nom		root 
			return result
		),
		
		
		
		
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
				
				
			/* 
-- 			debug ("tag a chercher (  _tag : " + _tag  +" )") 
			
			for tagDuNoeud in tagsDuNoeud do (
-- 				debug ("tag a chercher ( tagDuNoeud : " + tagDuNoeud + " _tag : " + _tag  +" )") 
				if ( findString tagDuNoeud  _tag	 ) != undefined do (
					result = _noeud 
-- 					debug ("tag TROUVE :"  )
				)
			)
			 */
			
			return result
			
		),
		
		
	public
		fn chercherTags 	txt  =	(
-- 			debug ( "recherche de tag : " + txt )
			
-- 			rechercheNoeud = getParNomUnique "RECHERCHE" 
			elemsResult = #()
-- 			rechercheNoeud.enfants = #()
			tagsRecherche = filterString	txt 	m_separateur
			elementsTotal = getElements()
-- 			debug ( "	elementsTotal : " + elementsTotal as string)
			
			for tagRecherche in tagsRecherche do
				for elem in elementsTotal do (
					result = chercherTagDansNoeud 	elem 	tagRecherche
					if result!= undefined do appendifunique elemsResult	 result
				)
			return elemsResult
-- 			rechercheNoeud.enfants = elemsResult
-- 			ecrireFichier ()
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
			lireFichier()
		)
)	-- fin Struct Arborescence








