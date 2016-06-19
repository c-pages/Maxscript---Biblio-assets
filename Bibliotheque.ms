


global debug, b_DEBUG = true
fn debug _txt = 	if b_DEBUG do format "debug:	%\n" _txt

try (	DestroyDialog bibliotheque.m_rollPrincipal ) catch ( format  ("rien à destroy\n") )



global bibliotheque

------------------------------------------------------------------------------
------ include des sous structures ----------------------------------------
-- les sous structures composent la structure parincipale 			--
------------------------------------------------------------------------------
fileIn "$userScripts\bibliotheque\Bibliotheque_menus.ms"
fileIn "$userScripts\bibliotheque\Bibliotheque_arbo.ms"
fileIn "$userScripts\bibliotheque\Bibliotheque_apercus.ms"
fileIn "$userScripts\bibliotheque\Bibliotheque_conversions.ms"


------------------------------------------------------------------------------
------ La structure principale ---------------------------------------------
-- composée des sous structures spécialisées							--
------------------------------------------------------------------------------
struct BibliothequeAsset (
	
	--- quelques variables privées  de fonctionnement ---
	private
		m_tailleRolloutPrincipal 		= [850,600],
		m_posRolloutPrincipal 		= [50,50],
		
		b_rolloutEditionOuvert		=	false,
		b_rolloutEditionAccroche	=	false,
		m_posRolloutEdition 			= [50,50],
		
		b_infosOuvert					=	true,
		
		
	public 
	-- quelques fonctions pour y acceder --------------
		fn setTailleRolloutPrincipal 		tailleRollOut  		= ( m_tailleRolloutPrincipal 	= tailleRollOut 	),
		fn setPosRolloutPrincipal 			posRollOut  	= ( m_posRolloutPrincipal 	= posRollOut 		),
		fn setEditionOuvert 				bool					= ( b_rolloutEditionOuvert 	= bool 				),
		fn setEditionAccroche 				bool				= ( b_rolloutEditionAccroche = bool 				),
		fn getEditionAccroche 									= ( return b_rolloutEditionAccroche 				),
		fn setPosRolloutEdition 			posRollOut  		= ( m_posRolloutEdition 		= posRollOut 		),
		fn getPosRolloutEdition 							  		= ( return	m_posRolloutEdition 					),
		fn setInfosOuvert 					bool				= ( b_infosOuvert 				= bool 				),
		fn getInfosOuvert 										= ( return b_infosOuvert 							),
		
		
	-- les rollouts de la bibliotheque	----------------------------------
-- 	private
	public
		m_rollPrincipal,				------- le roultout principale ---
		m_rollEditerTags,			------- le roultout pour editer les tags des elements selectionnés ---
		m_rollChoisirDossier,		------- Un explorateur pour choisir une destination dans la biblio ---
		
		
	-- les differentes structures de la bibliotheque ---------------------
-- 	private
	public
		arbo			= Arborescence (),
		apercu 	= Apercus (),
		conversion 	= Conversions (),
		menu 		= Menus(), 
		
		
	-- les methodes  publics ------------------------------------------------
	public
		
		-- debug --
		fn afficherArbo = arbo.afficher(),
		
		-- la fenetre --	
		fn ouvrirFenetre 		= (
			
			debug "ouvrir fenetre ..."
			
			try (	DestroyDialog m_rollPrincipal ) catch ( format  ("rien à destroy\n") )
			createDialog m_rollPrincipal pos:m_posRolloutPrincipal  width:m_tailleRolloutPrincipal.x  height:m_tailleRolloutPrincipal.y   lockHeight:false  style:#(#style_resizing,#style_toolwindow, #style_sysmenu )
			
			debug " ... ouvrir fenetre 1 ..."
			m_rollPrincipal.biblio = this
			debug " ... ouvrir fenetre 2 ..."
			m_rollPrincipal.remplirTreeView 	arbo.root
			debug " ... ouvrir fenetre 3 ..."
			m_rollPrincipal.repositionnerElementsUI 	m_tailleRolloutPrincipal
			m_rollPrincipal.ui_arborescence.expandAll()
			m_rollPrincipal.ui_arborescence.SelectedNode = m_rollPrincipal.ui_arborescence.nodes.item[0]	--.nodes.item[0]
			m_rollPrincipal.AfficherElements 	arbo.root 	--.enfants[1]
			m_rollPrincipal.maj_UI()
			
			debug "...fenetre ouverte."
		),
		
		
		-- ajout asset dans la biblio --
		fn ajouterAssetDossier _dossier = (
			
			local nomApercu
			local sceneCourante = ""
			
			
		
			selectionTV = m_rollPrincipal.getListeSelection()
			
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
					
					resetMaxFile #noPrompt
					
					
					-- noeud dans lequel l'integrer --
					noeudParent = arbo.getParNom 	selectionTV.text
					if classOf noeudParent == Element do
						noeudParent = noeudParent.parent
					
					-- le nom --
					_nom = getFilenameFile  fichierAImporter
					
					-- apercu --
					_apercu = apercu.creer 	fichierAImporter
					
					-- creation de l'element dans l'arbo ---
					nouvelAsset = arbo.creerElement 	nom:_nom  type:#model	fichier:fichierAImporter  apercu:_apercu	parent:noeudParent
					arbo.ecrireFichier()
					
					
					
				)
			
				-- actualiser le treeview ---
				m_rollPrincipal.remplirTreeView 	arbo.root
				
				fetchMaxFile quiet:true
			)
		
			
		),
		
		
		
		-- ajout asset dans la biblio --
		fn ajouterAssetFichier = (
			
			debug "ajouterAssetFichier"
			
			fichierAImporter = getOpenFileName  caption:"Fichier à integrer dans la bibliotheque" \
											types:"model (*.max)|*.max|All Files (*.*)|*.*|"	
			
			if 	fichierAImporter != undefined  do ( 
				
					holdMaxFile() 
					
					resetMaxFile #noPrompt
				
					debug ( "Importer " + fichierAImporter )
					selectionTV = m_rollPrincipal.getListeSelection()
					if selectionTV !=undefined do (
						
						-- noeud dans lequel l'integrer --
						noeudParent = arbo.getParNom 	selectionTV.text
						if classOf noeudParent == Element do
							noeudParent = noeudParent.parent
						
						-- le nom --
						_nom = getFilenameFile  fichierAImporter
						
						-- apercu --
						_apercu = apercu.creer 	fichierAImporter
						
						-- creation de l'element dans l'arbo ---
						nouvelAsset = arbo.creerElement 	nom:_nom  type:#model	fichier:fichierAImporter  apercu:_apercu	parent:noeudParent
						arbo.ecrireFichier()
						
						-- actualiser le treeview ---
						m_rollPrincipal.remplirTreeView 	arbo.root
						
						
					)
-- 					show 	( selectionTV )
					
					fetchMaxFile quiet:true
					
				)
			
		),
		
		
	-- les methodes  privées -----------------------------------------------
	private
		
		-- l'initialisation globale --
		fn initialiser = (
			debug "#### BIBLIO INITIALISATION  ####"
			-- inclusion des rollouts --
			include  "$userScripts\bibliotheque\Bibliotheque_rollouts.ms" 
			
			debug "	BIBLIO INITIALISATION : 1  "
			
			--- initialiser les structs ---
			apercu.arbo = arbo
			debug "	BIBLIO INITIALISATION : 2"
			apercu.biblio = this
			menu.biblio = this
			
			debug "	BIBLIO INITIALISATION : 3"
			--- nettoyer le dossier des apercus (supprime les apercus non utilisé par l'arbo ) ---
			apercu.supprimerOrphelins()
			
			debug "	BIBLIO INITIALISATION : 4"
		),
		
		
		
	-- les events -------------------------------------------------------
	private
		on create do initialiser()
	
		
	
) -- fin struct Bibliotheque --




--------------------------------------------------------------------------------------------------------
-------- MANIPULATIONS -------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

 
-- clearListener()

bibliotheque = BibliothequeAsset()

bibliotheque.ouvrirFenetre()
roll = bibliotheque.m_rollPrincipal

-- bib.arbo.afficher()


/*

fn chercherNoeud  _noeud _nomAChercher = (
	format " ? chercheDsNoeud : % ?\n"  _noeud.name
	if _noeud.name == _nomAChercher then (
		format " !! !! trouve  !! !!\n"
		return _noeud
	)
	else (
		format " ... pas trouve  ... \n"
		format " ? enfants : % ?\n"  _noeud.nodes.count
		for i=0 to _noeud.nodes.count - 1 do (
			node = _noeud.nodes.item[i]
			chercherNoeud  node _nomAChercher
		)
	)
)


chercherNoeud roll.ui_arborescence "RECHERCHE"

nd = roll.getTreeViewNodeByNomUnique	"N1"
roll.ui_arborescence.SelectedNode = roll.getTreeViewNodeByNomUnique	"N1"



GetItemAt

show	 roll.ui_arborescence.nodes.item[0]

show	 roll.ui_arborescence.SelectedNode.nodes.count
showproperties roll.ui_listeVue
showmethods roll.ui_arborescence
show roll.ui_listeVue.items.item[0]
show roll.ui_listeVue
.Nodes.item[0]

roll.ui_arborescence.AllowDrop

roll.ui_arborescence.Nodes.item[0].IsSelected

show roll.ui_arborescence
show roll.ui_listeVue.AllowDrop
showmethods roll.ui_listeVue


roll.ui_arborescence.SelectedNode.text

roll.ui_arborescence.Nodes.item[0].Nodes.count
createDialog bib. m_rollEditerTags   lockHeight:false  style:#(#style_toolwindow, #style_sysmenu )
bib.afficherArbo()

roll.ui_listeVue.Items.item[1].selected = true
bitmap

show roll.ui_listeVue.Top
popo = roll.ui_listeVue.SelectedItems.item
popo
show roll.ui_listeVue.SelectedItems.item[0]

roll.ui_listeVue.SelectedItems.item = popo

 roll.ui_arborescence.ContainsFocus
 show roll.ui_arborescence.SelectedNode

 roll.ui_arborescence.SelectedNode.Name
bib.arbo.ecrireFichier()


roll = bib. m_rollChoisirDossier
createDialog bib. m_rollChoisirDossier   lockHeight:false  style:#(#style_resizing,#style_toolwindow, #style_sysmenu )

show roll.ui_arborescence



*/

-- bib.arbo.root.enfants.count
-- bib.apercu.creerNomApercu()
-- bib.apercu.creer "F:\\Bibeul 3D\\00 - MA BIBLIO MAX\\Biblio\\Batiments\\immeuble - 17 etages (Maromme).max"
-- bib.apercu.creer "F:\\Bibeul 3D\\ARCHMODELS\\Archmodels Vol 52 - Realistic plants\\Archmodels Vol 52 - Realistic plants\\Vray\\006.max"
-- bib.apercu.creer "F:\\Bibeul 3D\\ARCHMODELS\\Archmodels Vol 52 - Realistic plants\\Archmodels Vol 52 - Realistic plants\\Vray\\007.max"
-- bib.apercu.creer "F:\\Bibeul 3D\\ARCHMODELS\\Archmodels Vol 52 - Realistic plants\\Archmodels Vol 52 - Realistic plants\\Vray\\008.max"

-- bib.apercu.remettreRenduInitial()


