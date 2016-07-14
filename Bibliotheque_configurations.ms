/* #######################################################################################################################

	2017 Christophe Pages (http://www.c-pages.fr) 

##########################################################################################################################
	
	Bibiotheque d'assets 
	
##########################################################################################################################

	A VIRER, JE CROIS QUE CA SERT A RIEN....
	
######################################################################################################################## */ 




-- structure GOF composite pour organiser les assets --



struct Element (
	
	-- parametre de l'element --
	public
		type		= undefined,
		fichier	= "",
		appercu	= ""
	
	
	-- le composite --
	public
		nom 		= "nom de l'élément",
		parent 	= undefined,
		enfants 	= #(),
		
	public
		fn ajouterEnfant 	_enfant 	= (),
		fn definirParent 	_parent 	= ( parent = _parent ),
		fn retirer  			 = (
			if parent != undefined then (
				_index  = findItem parent.enfants this
				if _index != 0 do deleteItem   parent.enfants 	_index
				parent = undefined
				return this
			) else return undefined
		)
	
)	-- fin Struct Element


struct Noeud (
	
	public
		nom 		= "nom du noeud",
		parent  	= undefined ,
		enfants 	= #(),
		
	public
		fn ajouterEnfant 		_enfant 	= (
			append enfants 	_enfant 
			_enfant.definirParent ( this )
		),
		fn retirer  			 = (
			if parent != undefined then (
				_index  = findItem parent.enfants this
				if _index != 0 do deleteItem   parent.enfants 	_index
				parent = undefined
				return this
			) else return undefined
		),
		fn definirParent 	_parent 	= ( parent = _parent )
	
)	-- fin Struct noeud



-----------------------------------------------------------------------
struct Arbo (
	
	arboRoot,
	fichierArbo = "$userScripts\bibliotheque\Bibliotheque_arbo.ini",
		
	fn creerNoeud  nom: parent: = ( 
		_nouveauNoeud = Noeud()
		if nom != unsupplied 		do  _nouveauNoeud.nom 		= nom
		if parent != unsupplied 	do  parent.ajouterEnfant 	 _nouveauNoeud
		_nouveauNoeud
	),

	fn creerElement nom:  parent:  type:	fichier:	appercu: = ( 
		_nouvelElement = Element()
		if nom != unsupplied 		do  _nouvelElement.nom 		= nom
		if parent != unsupplied 	then  parent.ajouterEnfant 	_nouvelElement
											else	arboRoot.ajouterEnfant _nouvelElement
		if type != unsupplied 		do  _nouvelElement.type 		= type
		if fichier != unsupplied 		do  _nouvelElement.fichier		= fichier
		if appercu != unsupplied 	do  _nouvelElement.appercu	= appercu
		_nouvelElement
	),

	fn ecrireNoeud  _noeud 	= (
		-- le parent --
		setINISetting   fichierArbo	_noeud.nom   "parent"  ( if _noeud.parent ==undefined then "undefined" else _noeud.parent.nom)
		
		case classOf _noeud  of (
			noeud: (
				setINISetting   fichierArbo	_noeud.nom   "composite"  #branche
				
				-- les enfants --
				_enfants = ""
				for enfant in _noeud.enfants do
					_enfants += enfant.nom + ";"
				setINISetting   fichierArbo	_noeud.nom   "enfants"  _enfants
				
				-- recusrcivité --
				for enfant in _noeud.enfants do ecrireNoeud  enfant 
			)
			element: (
				setINISetting   fichierArbo	_noeud.nom   "composite"  #feuille
				
				setINISetting   fichierArbo	_noeud.nom   "type"  	_noeud.type
				setINISetting   fichierArbo	_noeud.nom   "fichier"  _noeud.fichier			
			)
		)
		
	),


	fn ecrireArbo = (
		ecrireNoeud Root
	),



	fn lireNoeud 	_nom = (
		local _nouveauNoeud
		if hasINISetting fichierArbo _nom then (
			
			_composite = getINISetting   fichierArbo	_nom   "composite"
			case _composite of (
				"feuille":( 
					_type 		= getINISetting   fichierArbo	_nom   "type"  
					_fichier 		= getINISetting   fichierArbo	_nom   "fichier"  
					
					_nouveauNoeud = creerElement nom:_nom  type:_type	fichier:_fichier
				)
				"branche":(
					_nouveauNoeud = creerNoeud 	nom:_nom  
				
					_enfantsTxt 	= getINISetting   fichierArbo	_nom   "enfants" 
					_enfants 		= filterString _enfantsTxt  ";"
				format "		_enfants: %\n" _enfants
					for _enfant in _enfants do (
						_noeudEnfant = lireNoeud  _enfant
						_nouveauNoeud.ajouterEnfant 	(_noeudEnfant)
					)
				)
			)
			
			_nouveauNoeud
			
		) else format "		le noeud: '%' n'est pas dans le fichier INI (%)\n" _nom fichierArbo
	),



	fn lireArbo = (
		format "LIRE ARBO --------------------\n"
		_root = lireNoeud "ROOT"
		_root
	)

	
)





---------------------- MANIPS ---------------


clearListener ()


N1 = creerNoeud  	nom:"N1" 	parent:Root
N2 = creerNoeud  	nom:"N2" 	parent:Root
N2_2 = creerNoeud  nom:"N2_2" parent:N2

E1 = creerElement	nom:"E1"	parent:N1 		type:#image	fichier:"chemin/dossier/fichier 1.popo"
E2 = creerElement	nom:"E2"	parent:N2 		type:#image	fichier:"chemin/dossier/fichier 2.popo"
E3 = creerElement	nom:"E3"	parent:N2_2	type:#model	fichier:"chemin/dossier/fichier 3.popo"
E4 = creerElement	nom:"E4"	parent:N2_2	type:#model	fichier:"chemin/dossier/fichier 4.popo"


ecrireArbo () 

Root = undefined

RootLu =  lireArbo ()

RootLu.enfants.count
RootLu.enfants[1].nom

/* 

---------------------------------------
------ La structure Configurations ------
-- gère les preferences, le fichier de la liste des elements ...
---------------------------------------
struct Configurations (
	
	-- les methodes  publics -----------------------------------------------
	public
		-- l'initialisation global --
		fn ouvrirINI = (
			format "Configurations -> ouvrir fichier INI\n"
			
			
			
			setINISetting  "$userScripts\bibliotheque\Bibliotheque.ini" 	"section"   "cle"  "valeur"
			
		),
		
		
	-- les methodes  privées -----------------------------------------------
	private
		-- l'initialisation global --
		fn initialiser = (
			format "Configurations -> initialiser \n"
			ouvrirINI()
		),
		
		
		
	-- les events -------------------------------------------------------
	private
		on create do initialiser()
		
) -- fin struct Configurations --
 */













