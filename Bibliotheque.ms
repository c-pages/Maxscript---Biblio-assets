

clearListener()


/* #######################################################################################################################

	2017 Christophe Pages (http://www.c-pages.fr) 	

##########################################################################################################################

	changelog:
	*v0.0 - [2016/04/11] -----------------------------------------------------------------------------
	- Mise en place globale

######################################################################################################################## */ 



------------------------------------------------------------------------------
------ DEclaration de la bibioltheque en global -------------------------
------------------------------------------------------------------------------
GLOBAL bibliotheque


------------------------------------------------------------------------------
------ DEBUG						 -----------------------------------------
------------------------------------------------------------------------------
---- output ----
global debug, b_DEBUG = true
fn debug _txt = 	if b_DEBUG do format "debug:	%\n" ( _txt as string )

---- le fenetre -----
try (	DestroyDialog bibliotheque.m_rollPrincipal ) catch ( format  ("rien à destroy\n") )



------------------------------------------------------------------------------
------ INCLUDE des sous structures ------------------------------------
-- les sous structures composent la structure parincipale 			--
------------------------------------------------------------------------------
fileIn "$userScripts\biblio\Bibliotheque_menus.ms"
fileIn "$userScripts\biblio\Bibliotheque_arbo.ms"
fileIn "$userScripts\biblio\Bibliotheque_apercus.ms"
fileIn "$userScripts\biblio\Bibliotheque_conversions.ms"
fileIn "$userScripts\biblio\Bibliotheque_ajout&import.ms"
fileIn "$userScripts\biblio\Bibliotheque_outils.ms"
fileIn "$userScripts\biblio\Bibliotheque_preference.ms"


------------------------------------------------------------------------------
------ La structure principale ---------------------------------------------
-- composée des sous structures spécialisées							--
------------------------------------------------------------------------------
struct BibliothequeAsset (
	
-- 	private
	public
		prefs				= preference (),
	
-- 	private
	public
		arbo				= Arborescence (),
		apercu 			= Apercus (),
		conversion 	= Conversions (),
		menu 			= Menus (), 
		importer		= Import (),
		ajouter			= Ajout (),
		outils         	= boiteOutils (),
		
		
	public 
	
	-- quelques fonctions accesseurs ( voir si on garde ... ) --------------
		fn setTailleRolloutPrincipal 		tailleRollOut  	= ( prefs.fenetre.taille 	= tailleRollOut 	),
		fn setPosRolloutPrincipal 		posRollOut  	= ( prefs.fenetre.pos 	= posRollOut 		),
		fn setEditionOuvert 				bool				= ( prefs.fenetre.infos 	= bool 				),
		fn setEditionAccroche 			bool				= ( prefs.fenetre.edition = bool 				),
		fn getEditionAccroche 								= ( return prefs.fenetre.edition 				),
-- 		fn setPosRolloutEdition 			posRollOut  		= ( m_posRolloutEdition 		= posRollOut 		),
-- 		fn getPosRolloutEdition 							  		= ( return	m_posRolloutEdition 					),
		fn setInfosOuvert 					bool				= ( prefs.fenetre.infos 				= bool 				),
		fn getInfosOuvert 										= ( return prefs.fenetre.infos 							),
		
		
		
	-- les rollouts de la bibliotheque	----------------------------------
-- 	private
	public
		m_rollPrincipal,			------- le roultout principale ---
		m_rollPreferences,		------- le roultout  des differentes otpions, chemins... ---
		m_rollInfos,				------- le rollout des infos ---
		
		
		
	-- les methodes  publics ------------------------------------------------
	public
	---- Suppression ----
		fn  suprimerElems = (
			if querybox "Etes-vous sûr de vouloir supprimer le ou les élément de la bibliothèque?" do (
			
				debug "supprimer" 
				elemSelect = m_rollPrincipal.elemSelect
				nbreASuprimer = elemSelect.count
				if elemSelect.count>0 do (
					for elem in elemSelect do 
						elem.retirer()
					
					arbo.ecrireFichier()
									--- maj interface ---
					m_rollPrincipal.remplirTreeView 	arbo.root
					m_rollPrincipal.majTotal ()
					m_rollPrincipal.setProgress ( nbreASuprimer as string  + " élément(s) suprimé(s)") 0
				)
			)
		),
		fn  suprimerNoeud = (
			if querybox "Etes-vous sûr de vouloir supprimer ce dossier et son contenu de la bibliothèque?" do (
				debug "supprimer" 
				noeudSelect = m_rollPrincipal.noeudSelect
				if noeudSelect.nomUnique != "ROOT" do (
					debug ("supprimer : noeudSelect : " + noeudSelect.nom )
					noeudSelect.retirer()
					arbo.ecrireFichier()
					
					--- maj interface ---
					m_rollPrincipal.remplirTreeView 	arbo.root
					m_rollPrincipal.majTotal ()
				)
				m_rollPrincipal.setProgress "Dossier suprimé" 0
			)
		),
		
	----  Nouveau Dossier ----
		fn nouveauNoeud = (
			
			debug "nouveauDossier" 
			noeudSelect = m_rollPrincipal.noeudSelect
			if noeudSelect != undefined do (
				arbo.creerNoeud  nom:"NouveauDossier" 	parent:noeudSelect 
				
				arbo.ecrireFichier()
				--- maj interface ---				
				m_rollPrincipal.remplirTreeView 	arbo.root
				m_rollPrincipal.majTotal ()
				m_rollPrincipal.setProgress "Nouveau dossier" 0
			)
			
		),
		
	
		
		
	--- apercus ----		
		fn creerApercu = (
			elemSelect = m_rollPrincipal.elemSelect
			if elemSelect.count > 0 do 
				if querybox "voulez vous créer l'aperçu ?" do (
					m_rollPrincipal.setProgress "Rendu aperçu ..." 0	
					m_rollPrincipal.cancelled = false
					
					holdMaxFile() 
					
					i = 1.
					for elem in elemSelect do (
						
						if m_rollPrincipal.cancelled do continue
						
						pourcent = ( ( i - 1.) / elemSelect.count * 100. )
						m_rollPrincipal.setProgress ("Rendu aperçu " + ( i as integer )  as string + "/" + elemSelect.count as string  ) 	pourcent
						
						if doesfileexist elem.fichier then( 
							outils.viderScene()
							elem.apercu = apercu.creer 	elem.fichier
							arbo.ecrireFichier()
							m_rollPrincipal.AfficherElements m_rollPrincipal.noeudSelect					
							m_rollPrincipal.afficherInfos()
						)	else format "elem : % n'as pas de fichier valide : %\n" elem.nom elem.fichier
						i+=1
					)
					
					
					if m_rollPrincipal.cancelled then 
						m_rollPrincipal.setProgress ("Rendu détail : " + ( i as integer )  as string + "/" + elemSelect.count as string  + " aperçus. *Annulé*") 100
					else 
						m_rollPrincipal.setProgress ("Rendu détail : " + ( i as integer )  as string + "/" + elemSelect.count as string  + " aperçus.") 100				
					m_rollPrincipal.cancelled = false
					
					m_rollPrincipal.AfficherElements 	noeudSelect					
					m_rollPrincipal.afficherInfos()

					fetchMaxFile quiet:true
					
				
				)
		),
	
		fn creerDetail  = (
		
			elemSelect = m_rollPrincipal.elemSelect
			if elemSelect.count > 0 do 
				if querybox "voulez vous créer l'aperçu Détail?" do (
					m_rollPrincipal.setProgress "Rendu détail ..." 0	
					m_rollPrincipal.cancelled = false
					
					holdMaxFile() 
					i=1.
					for elem in elemSelect do (
						
						if m_rollPrincipal.cancelled do continue
						
						pourcent = ( ( i - 1.) / elemSelect.count * 100. )
						m_rollPrincipal.setProgress ("Rendu détail " + ( i as integer )  as string + "/" + elemSelect.count as string  ) 	pourcent
						if doesfileexist elem.fichier then( 
							outils.viderScene()
							elem.detail = apercu.creer 	elem.fichier detail:true
							arbo.ecrireFichier()
							m_rollPrincipal.AfficherElements m_rollPrincipal.noeudSelect					
							m_rollPrincipal.afficherInfos()
						)	else format "elem : % n'as pas de fichier valide : %\n" elem.nom elem.fichier
						i+=1
					)
					
					if m_rollPrincipal.cancelled then 
						m_rollPrincipal.setProgress ("Rendu détail : " + elemSelect.count   as string + " aperçus. *Annulé*") 100
					else 
						m_rollPrincipal.setProgress ("Rendu détail : " + elemSelect.count   as string + " aperçus.") 100				
					m_rollPrincipal.cancelled = false
			
					m_rollPrincipal.AfficherElements 	m_rollPrincipal.noeudSelect					
					m_rollPrincipal.afficherInfos()
					fetchMaxFile quiet:true
					
					
				)
				
		)	,
		
		
		
	-- les methodes  publics ------------------------------------------------
	public
		
		-- debug --
		fn afficherArbo = arbo.afficher(),
		
		-- la fenetre --	
		fn ouvrirFenetre 		= (
			
			
			
			debug "ouvrir fenetre ..."
			
			try (	DestroyDialog m_rollPrincipal ) catch ( format  ("rien à destroy\n") )
			
			createDialog m_rollPrincipal pos:prefs.fenetre.pos  width:prefs.fenetre.taille.x  height:prefs.fenetre.taille.y  \
						lockHeight:false  style:#(#style_resizing,#style_titlebar , /*#style_toolwindow, */#style_sysmenu, #style_minimizebox, #style_maximizebox/* , #style_sunkenedge */, #style_sysmenu )	\
						menu:(menu.getMenuRolloutPrincipal()	 )	-- bgcolor:m_couleurFond
			
			debug " ... ouvrir fenetre 1 ..."
			m_rollPrincipal.biblio = this
			debug " ... ouvrir fenetre 2 ..."
			m_rollPrincipal.remplirTreeView 	arbo.root
			debug " ... ouvrir fenetre 3 ..."
			m_rollPrincipal.repositionnerElementsUI 	prefs.fenetre.taille
			m_rollPrincipal.ui_arborescence.expandAll()
			m_rollPrincipal.ui_arborescence.SelectedNode = m_rollPrincipal.ui_arborescence.nodes.item[0]	--.nodes.item[0]
			m_rollPrincipal.AfficherElements 	arbo.root 	--.enfants[1]
			m_rollPrincipal.maj_UI()
			
			debug "...fenetre ouverte."
			
		),
		
		fn fermerFenetre = (
			try (	DestroyDialog m_rollPrincipal ) catch ( format  ("rien à destroy\n") )
		),
		
		fn ouvrirPreferences = (
			
			try (	DestroyDialog m_rollPreferences ) catch ( format  ("rien à destroy\n") )
			createDialog m_rollPreferences 	 \ --pos:prefs.fenetre.pos  width:prefs.fenetre.taille.x  height:prefs.fenetre.taille.y  \
						lockHeight:false  style:#(/*#style_resizing,#style_titlebar , */#style_toolwindow/*, #style_sysmenu*//*, #style_minimizebox, #style_maximizebox , #style_sunkenedge , #style_sysmenu */)	\
						--menu:(menu.getMenuRolloutPrincipal()	 )
			m_rollPreferences.biblio 					= this
			m_rollPreferences.edt_apercus.text 	= apercu.dossierApercus
			m_rollPreferences.edt_proxy.text 		= conversion.dossierProxy
			
		),
		
	--  creation ASSETS  ------------------------------------------------
private
	
		
		
		
		-- l'initialisation globale --
		fn initialiser = (
			
			debug "#### BIBLIO INITIALISATION  ####"
			-- inclusion des rollouts --
			include  "$userScripts\biblio\Bibliotheque_rollouts.ms" 
			
			debug "	BIBLIO INITIALISATION : 1  "
			
			--- initialiser les structs ---
			apercu.arbo = arbo
			debug "	BIBLIO INITIALISATION : 2"
			apercu.biblio = this
			arbo.biblio = this
			ajouter.biblio = this
			importer.biblio = this
			importer.m_rollout = m_rollPrincipal
			conversion.biblio = this
			
			debug "	BIBLIO INITIALISATION : 3"
			
			--- nettoyer le dossier des apercus (supprime les apercus non utilisé par l'arbo )  peut etre long ---
-- 			arbo.nettoyer()
			
			prefs.charger()
			
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
-- bibliotheque.arbo.afficher()

/*

		bibliotheque.apercu.calculerBB ( selection as array )

display "$userScripts\\Biblio\\apercus\\apVide.jpg"

showmethods roll.ui_listeVue


roll.ui_progressBar.value = 50
roll.ui_progressBar.color = color 50 150 246
bibliotheque.arbo.nettoyer()
bibliotheque.apercu.viderScene()

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

roll.setProgress "Rendu aperçu 1/50"  30

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


