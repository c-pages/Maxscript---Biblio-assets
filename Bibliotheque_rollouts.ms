


---------------------------------------------------------------------------------------------------------------------------------------------------------
----------	Le rollout d'edition des tags  ---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
rollout m_rollChoisirDossier "Dossiers de la bibliothèque" width:500 height:500
(
	--- declarations locales -----
	local UItaille_ecart			= [5,5]
	
	---- ui  ----
	dotNetControl 	ui_arborescence 		"TreeView" pos:UItaille_ecart width:(m_rollChoisirDossier.width - 2*UItaille_ecart.x ) height:(m_rollChoisirDossier.height - 2*UItaille_ecart.y ) enabled:true	
	
	-- methodes -----
	
	
	--- evenements -----
	on m_rollChoisirDossier resized size do (
		ui_arborescence.width 	= m_rollChoisirDossier.width - 2*UItaille_ecart.x 
		ui_arborescence.height = m_rollChoisirDossier.height - 2*UItaille_ecart.y 
	)
	
)



---------------------------------------------------------------------------------------------------------------------------------------------------------
----------	Le rollout d'edition des tags  ---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
rollout m_rollEditerTags "Bibliothèque" width:411 height:355
(
	local biblio
	
	
	GroupBox grp1 "Editer l'élément" pos:[9,5] width:392 height:339
	
	label lbl1 "Mots clés : ( Séparer chaque tags par un ';' )" pos:[16,118] width:217 height:19
	edittext ui_editTags "" pos:[16,136] width:375 height:22
	
	label lbl3 "Notes :" pos:[16,167] width:217 height:19	
	
	
	edittext ui_editNotes "" pos:[16,185] width:375 height:122
	
	button ui_btnValider "Valider" pos:[16,316] width:100 height:19
	button ui_btnAnnuler "Annuler" pos:[292,316] width:100 height:19
	
	
	label lbl6 "Nom: " pos:[17,23] width:36 height:19
	edittext ui_editNom "" pos:[59,23] width:333 height:22
	label lbl7 "Fichier: " pos:[17,50] width:44 height:19
	edittext edt7 "" pos:[59,50] width:303 height:22
	button btnOuvrirFichierMax "..." pos:[366,51] width:25 height:22
	label lbl12 "Apperçu:" pos:[17,78] width:44 height:19
	edittext edt12 "" pos:[59,78] width:303 height:22
	button btn10 "..." pos:[366,79] width:25 height:22
	
	
	
	-- eveneemnts ------
	on ui_btnValider pressed do
		try (	DestroyDialog m_rollEditerTags ) catch ( format  ("rien à destroy\n") )
	on ui_btnAnnuler pressed do
		try (	DestroyDialog m_rollEditerTags ) catch ( format  ("rien à destroy\n") )
	
	on m_rollEditerTags	 moved 	posRollOut	 do (
		
		biblio.setPosRolloutEdition 	posRollOut
		
		dist 						= 10
		posRollPrincipal 		= GetDialogPos 	biblio.m_rollPrincipal
		bordureDialogBox 	= [22,5]
		coinAccroche 		= [ posRollPrincipal.x + biblio.m_rollPrincipal.width , posRollPrincipal.y ]
		coinAccroche 		+= bordureDialogBox
		
		format "----------------------\n" posRollOut
		format "posRollOut : %\n" posRollOut
		format "posRollPrincipal : %\n" posRollPrincipal
		format "coinAccroche : %\n" coinAccroche
		
		if  ( 	  	posRollOut.x > coinAccroche.x - dist 		\
			and 	posRollOut.x < coinAccroche.x + dist 	\
			and 	posRollOut.y > coinAccroche.y - dist 		\
			and 	posRollOut.y < coinAccroche.y + dist  ) 
		then (
			format "ACCROCHE\n"
			SetDialogPos 	biblio.m_rollEditerTags 	coinAccroche
			biblio.setEditionAccroche true
		)
		else 	(
			format "ACCROCHE pas ...\n"
			biblio.setEditionAccroche false
		)
			
	)
	
)

---------------------------------------------------------------------------------------------------------------------------------------------------------
----------	Le rollout principale ---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
rollout m_rollPrincipal "Bibliothèque" width:1272 height:575 (
	
--------------------------------
--- declarations locales -----
--------------------------------
	local m_rollEditerTags
	
	
	local biblio ---- le struct principal de la bibliotheque ----
	local appercuVide = "C:\\Users\\kris\\AppData\\Local\\Autodesk\\3dsMax\\2014 - 64bit\\ENU\\scripts\\Bibliotheque\\appercus\\app_vide.jpg"
	local	EcouteurChangeSelection 	--- ecouteur de changement de selection de la scene ---
	
	-- dimensionnement --
	local UItaille_fenetre		= [850,600]
	local UItaille_fenetreMin	= [850,600]
	local UItaille_btns			= [41,41]
	local UItaille_petitsBtns	= [16,16]
	local UItaille_marge			= [10,10]
	local UItaille_ecart			= [5,5]
	local UIpos_barreEdition 	= [UItaille_marge.x, 9]
	local UIpos_exploration  	= [UItaille_marge.x, UIpos_barreEdition.y + UItaille_btns.y + UItaille_ecart.y]
	
	
	-- icones --
	local ico_BtnAjouterAsset					= "$userScripts\\bibliotheque\\ico\\NouvelAsset.bmp"
	local ico_BtnAjouterDossier				= "$userScripts\\bibliotheque\\ico\\NouvelAssetsDossier.bmp"
	local ico_BtnAjouterAssetFromScene	= "$userScripts\\bibliotheque\\ico\\NouvelAssetFromScene.bmp"
	local ico_BtnImporter						= "$userScripts\\bibliotheque\\ico\\importerDansScene.bmp"
	
	
	-- Element selectionné ---
	local elemSelect = #()
	local elemIDVueSelect = #()
	local elemNodesVueSelect = #()
	local noeudSelect
	local noeudVueSelect 
	
	-- drag end drop du dotNet ---
	local dragDropEffect = dotNetClass "System.Windows.Forms.DragDropEffects"
	
	
--------------------------------------
---------- L'INTERFACE ----------
--------------------------------------	


	---- Edition de la biblio ----
	button 				ui_btnCreerAssetFichier		"" pos:UIpos_barreEdition 		width:UItaille_btns.x 		height:UItaille_btns.y \
															toolTip:"Nouvel asset depuis un fichier"		border:false \
															images:#( ico_BtnAjouterAsset , undefined, 1, 1,1,1,1)
															
	button 				ui_btnCreerAssetDossier		"" pos:[ui_btnCreerAssetFichier.pos.x + UItaille_btns.x +UItaille_ecart.x,  UIpos_barreEdition.y ] \
															width:UItaille_btns.x 		height:UItaille_btns.y \
															toolTip:"Nouveaux assets depuis un dossier"		border:false \
															images:#( ico_BtnAjouterDossier , undefined, 1, 1,1,1,1)

	button 				ui_btnCreerAssetSelection		"" pos:[ui_btnCreerAssetDossier.pos.x + UItaille_btns.x +UItaille_ecart.x,  UIpos_barreEdition.y ] \
															width:UItaille_btns.x 		height:UItaille_btns.y \
															toolTip:"Nouvel asset depuis la selection"		border:false \
															images:#( ico_BtnAjouterAssetFromScene , undefined, 2, 	1,1,2,2)
															
	button 				ui_btnImporterAssetDansScene			"" pos:[ui_btnCreerAssetSelection.pos.x + 2* UItaille_btns.x + 2*UItaille_ecart.x,  UIpos_barreEdition.y ] \
															width:UItaille_btns.x 		height:UItaille_btns.y \
															toolTip:"Ajouter l'asset sélectionné à la scène"			border:false	\
															images:#( ico_BtnImporter , undefined, 2, 	1,1,2,2)
	
	
	
	---- Navigation  ----
	dotNetControl 	ui_arborescence 		"TreeView" pos:UIpos_exploration width:200 height:150 	enabled:true																		---------- l'arborescence 
	MultiListBox 		ui_lstBoxTags			"Tags" 		pos:( UIpos_exploration + [0,150 + UItaille_ecart.x]) width:200 height:( 50 )
	edittext 				ui_editRecherche 	"" 		pos:[UIpos_exploration.x + ui_arborescence.width + UItaille_ecart.x ,  UIpos_exploration.y ] width:200 height:17		
	dotNetControl 	ui_listeVue 			"system.windows.forms.listView" pos:[UIpos_exploration.x + ui_arborescence.width + UItaille_ecart.x , UIpos_exploration.y + ui_editRecherche.height + UItaille_ecart.y ] width:200 height:200 border:false											---------- le contenu du dossier 	
		
		
	--- infos ---
	groupBox			ui_grpInfos				"Infos "	pos:[ui_listeVue.pos.x + ui_listeVue.width + UItaille_ecart.x , ui_editRecherche.pos.y] width:(256 + 2*UItaille_marge.x)  height:200 
		
	---- Edition des infos----	
	checkbutton 		ui_btnAfficherInfo		"I" pos:[ui_grpInfos.pos.x ,   ui_grpInfos.pos.y  + ui_grpInfos.height + UItaille_ecart.y ] \
															width:UItaille_petitsBtns.x 		height:UItaille_petitsBtns.y \
															toolTip:"Afficher/cacher les infos"			border:false
		
		
	label 		ui_lblNom 					"Nom: " pos:[17,23] width:36 height:19
	edittext 	ui_editNom 				"" 		pos:[59,23] width:200 height:17
		
	label 		ui_lblFichier				"Fichier: " pos:[17,50] width:44 height:19
	edittext 	ui_editFichier 				"" pos:[59,50] width:175 height:17
	button 		ui_btnOuvrirFichierMax "..." pos:[366,51] width:25 height:17
		
	label 		ui_lblAppercu				"Apperçu:" pos:[17,78] width:44 height:19
	edittext	 	ui_editAppercu 			"" pos:[59,78] width:135 height:17
	button 		ui_btnOurvirAppercu	"..." pos:[366,79] width:25 height:17
	button 		ui_btnCreerAppercu	"Créer" pos:[366,79] width:35 height:17
		
	label 		ui_lblDetail				"Détail:" pos:[17,78] width:44 height:19
	edittext	 	ui_editDetail			"" pos:[59,78] width:135 height:17
	button 		ui_btnOurvirDetail		"..." pos:[366,79] width:25 height:17
	button 		ui_btnCreerDetail		"Créer" pos:[366,79] width:35 height:17
	
	label 		ui_lblTags					"Mots clés:" pos:[16,118] width:217 height:19
	edittext		ui_editTags 				"" pos:[16,136] width:(ui_grpInfos.width - 3* UItaille_ecart.x )  height:17
		
	label 		ui_lblNotes 				"Notes:" pos:[16,167] width:217 height:19	
	edittext 	ui_editNotes 				"" pos:[16,185] width:(ui_grpInfos.width - 3* UItaille_ecart.x )	 height:122
		
	
	bitmap		ui_bmpDetail 		pos:[16 ,167] width:256 height:256	
	
	
----------------------------------------
---------- les Methodes  -------------
----------------------------------------
	--- les Mise a jour UI ------
	fn maj_UI	= (
		
		--- les ENABLED  ---
		ui_btnCreerAssetSelection.enabled  			= (selection as array ).count > 0 
		ui_btnImporterAssetDansScene.enabled 	=  ui_listeVue.SelectedItems.count > 0 
-- 		ui_arborescence.SelectedNode
-- 		
-- 		-- les selections --
-- 		for id in elemIDVueSelect do 
-- 			ui_listeVue.Items.item[id].selected = true
		if noeudVueSelect != undefined do 
			ui_arborescence.SelectedNode = noeudVueSelect
		
		ui_arborescence.ExpandAll()
		
-- 		ui_arborescence. noeudSelect
		--- les tags ---
		try (
			ui_lstBoxTags.items = #()
			listTagsTmp = #()
			tags = biblio.arbo.getToutTags 	node:noeudSelect
			debug (" TOUT LES TAGS : " + tags as string )
			for  tag in tags do(
				
				append listTagsTmp		tag
			)
			ui_lstBoxTags.items = listTagsTmp
		) catch ()
	)
	
	
	fn repositionnerElementsUI 	tailleRollOut	= (
		
		-- on redim et repositionne les elements ---
		hauteurExplorateur 			= tailleRollOut.y -  ( UIpos_exploration.y +  UItaille_marge.y )
		
-- 	edittext 			ui_editRecherche 	"" 		pos:[UIpos_exploration.x + ui_arborescence.width + UItaille_ecart.x ,  UIpos_exploration.y ] width:200 height:17		
-- 	dotNetControl 	ui_listeVue 			"system.windows.forms.listView" pos:[UIpos_exploration.x + ui_arborescence.width + UItaille_ecart.x , UIpos_exploration.y + ui_editRecherche.height + UItaille_ecart.y ]
-- 		ui_lstBoxTags			"Tags" 		pos:( UIpos_exploration + [0,150 + UItaille_ecart.x]) width:200 height:( 50 - UItaille_ecart.x)
		ui_lstBoxTags.height = 150
		ui_arborescence.height 	= hauteurExplorateur - ( ui_lstBoxTags.height + 4* UItaille_ecart.y  )
		ui_lstBoxTags.pos = ui_arborescence.pos + [0 , ui_arborescence.height  + 4*UItaille_ecart.y]
		b_afficheInfos 				= biblio.getInfosOuvert()
		
		ui_btnAfficherInfo.checked 	= b_afficheInfos
		
		
		
		
		-- quleque reperes ---
		
		ui_grpInfos.visible  					= b_afficheInfos
		ui_lblNom.visible  					= b_afficheInfos
		ui_editNom.visible  					= b_afficheInfos
		ui_lblFichier.visible  				= b_afficheInfos
		ui_editFichier.visible  				= b_afficheInfos
		ui_btnOuvrirFichierMax.visible  	= b_afficheInfos
		ui_lblAppercu.visible  				= b_afficheInfos
		ui_editAppercu.visible  			= b_afficheInfos
		ui_btnOurvirAppercu.visible  		= b_afficheInfos
		ui_btnCreerAppercu.visible  		= b_afficheInfos
		
		ui_lblDetail.visible  		= b_afficheInfos
		ui_editDetail.visible  		= b_afficheInfos
		ui_btnOurvirDetail.visible  		= b_afficheInfos
		ui_btnCreerDetail.visible  		= b_afficheInfos
		
		ui_lblTags.visible  					= b_afficheInfos
		ui_editTags.visible  				= b_afficheInfos
		ui_lblNotes.visible  					= b_afficheInfos
		ui_editNotes.visible  				= b_afficheInfos
		ui_bmpDetail.visible  				= b_afficheInfos 	
		
		if b_afficheInfos then (
			
			ui_grpInfos.pos.x 			= tailleRollOut.x - ( UItaille_marge.x + ui_grpInfos.width )
			ui_grpInfos.height			= hauteurExplorateur - ( UItaille_petitsBtns.y + UItaille_ecart.y ) 
			ui_listeVue.width			= tailleRollOut.x  - ( ui_arborescence.width + ui_grpInfos.width + 4* UItaille_ecart.x + UItaille_marge.x ) 
			ui_listeVue.height			= hauteurExplorateur - ( ui_editRecherche.height + UItaille_ecart.y )
			ui_btnAfficherInfo.pos 		= [ui_grpInfos.pos.x + ui_grpInfos.width - UItaille_petitsBtns.x  ,  ui_grpInfos.pos.y  + ui_grpInfos.height + UItaille_ecart.y ]   
			
			
			repere 			= ui_grpInfos.pos + UItaille_marge + [0,5]
			tabEdit_1 		= 	UItaille_ecart.x
			tabEdit_2 		= 	tabEdit_1 + 60
			hauteur 			= [0,25]
			petiteHauteur = [0,15]
			largeurTitre 	= [60,0]
			
			ui_lblNom.pos  					= repere
			ui_editNom.pos  					= repere + largeurTitre
			ui_lblFichier.pos					= repere + hauteur
			ui_editFichier.pos				= repere + hauteur + largeurTitre
			ui_btnOuvrirFichierMax.pos	= repere + hauteur + largeurTitre + [ui_editFichier.width,0] + [UItaille_ecart.x, 0]
			
			ui_lblAppercu.pos				= repere + 2 * hauteur
			ui_editAppercu.pos				= repere + 2 * hauteur + largeurTitre
			ui_btnCreerAppercu.pos		= repere + 2 * hauteur + largeurTitre +  [ui_editFichier.width - 38 ,0]+ [UItaille_ecart.x, 0] 
			ui_btnOurvirAppercu.pos		= repere + 2 * hauteur + largeurTitre +  [ui_editFichier.width,0]+ [UItaille_ecart.x, 0]
			
			
			
			
			ui_lblTags.pos					= repere + 3 * hauteur
			ui_editTags.pos					= repere + 3 * hauteur + petiteHauteur
			
			
			
			
			ui_bmpDetail.pos = [ui_grpInfos.pos.x + UItaille_marge.x ,ui_grpInfos.pos.y + ui_grpInfos.height - ( UItaille_ecart.y   + ui_bmpDetail.height ) ] 
			
			ui_lblDetail.pos				= ui_bmpDetail.pos -  hauteur
			ui_editDetail.pos				= ui_lblDetail.pos + largeurTitre
			ui_btnCreerDetail.pos		= ui_lblDetail.pos + largeurTitre +  [ui_editFichier.width - 38 ,0]+ [UItaille_ecart.x, 0] 
			ui_btnOurvirDetail.pos		= ui_lblDetail.pos + largeurTitre +  [ui_editFichier.width,0]+ [UItaille_ecart.x, 0]
			
			ui_lblNotes.pos				= repere + 4 * hauteur + petiteHauteur
			ui_editNotes.pos				= repere + 4 * hauteur + 2* petiteHauteur
			ui_editNotes.height			= ui_lblDetail.pos.y - ( ui_editNotes.pos.y + 2*UItaille_ecart.y   )
			
		) else (
			
			ui_listeVue.width			= tailleRollOut.x  - ( ui_arborescence.width + 5* UItaille_ecart.x + UItaille_petitsBtns.x  ) 
			ui_listeVue.height			= hauteurExplorateur - ( ui_editRecherche.height + UItaille_ecart.y )
			ui_btnAfficherInfo.pos 	= [ui_listeVue.pos.x + ui_listeVue.width + UItaille_ecart.x   ,  ui_listeVue.pos.y  + ui_listeVue.height - ( UItaille_petitsBtns.y ) ]     
			
		)
		
		ui_editRecherche.width  =  ui_listeVue.width - UItaille_ecart.x 
		
		
		
		/*
		if b_afficheInfos then 
			biblio.m_rollPrincipal.width = ( ui_grpInfos.pos.x + ui_grpInfos.width + 2*UItaille_marge.x )
		else
			biblio.m_rollPrincipal.width = ( ui_listeVue.pos.x + ui_listeVue.width + 2*UItaille_marge.x )
		*/
		
		
		/*
		if b_afficheInfos then (
			
			ui_grpInfos.pos.x 			= tailleRollOut.x - ( UItaille_marge.x + ui_grpInfos.width )
			ui_grpInfos.height			= hauteurExplorateur - ( UItaille_petitsBtns.y + UItaille_ecart.y ) 
-- 			ui_lblIinfos.pos 				= [ui_grpInfos.pos.x  + UItaille_ecart.x , ui_grpInfos.pos.y  + UItaille_ecart.y * 3]
-- 			ui_lblIinfos.height			= ui_grpInfos.height - 4*UItaille_ecart.y
			ui_listeVue.width			= tailleRollOut.x  - ( ui_arborescence.width + ui_grpInfos.width + 4* UItaille_ecart.x + UItaille_marge.x ) 
			ui_listeVue.height			= hauteurExplorateur
			ui_btnAfficherInfo.pos 		= [ui_grpInfos.pos.x ,  ui_grpInfos.pos.y  + ui_grpInfos.height + UItaille_ecart.y ]      
-- 			ui_btnEditerElement.pos 	= [ui_btnAfficherInfo.pos.x  + UItaille_petitsBtns.x + UItaille_ecart.x,  ui_btnAfficherInfo.pos.y ]        

		) else (
						
			ui_listeVue.width			= tailleRollOut.x  - ( ui_arborescence.width + 5* UItaille_ecart.x + UItaille_petitsBtns.x  ) 
			ui_listeVue.height			= hauteurExplorateur
			ui_btnAfficherInfo.pos 		= [ui_listeVue.pos.x + ui_listeVue.width + UItaille_ecart.x   ,  ui_listeVue.pos.y  + ui_listeVue.height - ( UItaille_petitsBtns.y ) ]     
			
		)
		*/
		
		
	/* 
	label 		ui_lblNom 					"Nom: " pos:[17,23] width:36 height:19
	edittext 	ui_editNom 				"" 		pos:[59,23] width:333 height:22
	
	label 		ui_lblFichier				"Fichier: " pos:[17,50] width:44 height:19
	edittext 	ui_editFichier 				"" pos:[59,50] width:303 height:22
	button 		 "..." pos:[366,51] width:25 height:22
	
	label 							"Mots clés : ( Séparer chaque tags par un ';' )" pos:[16,118] width:217 height:19
	edittext		 				"" pos:[16,136] width:375 height:22
	
	label 		 				"Notes :" pos:[16,167] width:217 height:19	
	edittext 	 				"" pos:[16,185] width:375 height:122
	
	label 						"Apperçu:" pos:[17,78] width:44 height:19
	edittext	 	 			"" pos:[59,78] width:303 height:22
	button 			"..." pos:[366,79] width:25 height:22 
	*/
		
		
		
		-- on limite la taille du rollout 
		thisRollout = biblio.m_rollPrincipal
		
		if tailleRollOut.x < UItaille_fenetreMin.x do thisRollout.width 	= UItaille_fenetreMin.x
		if tailleRollOut.y < UItaille_fenetreMin.y do thisRollout.height 	= UItaille_fenetreMin.y
		
		-- maj de la taille --
		UItaille_fenetre = [ thisRollout.width , thisRollout.height  ]
		
		
	)
	
	
	---- 	initialisation de l'interface  ----
	fn initialiser_interface  = (
		
-- 		-- la taille minimum de la fenetre ----
-- 		UItaille_fenetreMin.y =  UIpos_exploration.y
		
		---- la vue liste----
		ui_listeVue.borderstyle = (dotnetclass "System.Windows.Forms.BorderStyle").fixedsingle
		ui_listeVue.showitemtooltips = true
		ui_listeVue.gridlines = false
		ui_listeVue.checkboxes = false
		ui_listeVue.labeledit = false
		ui_listeVue.MultiSelect=true
		ui_listeVue.HideSelection = false
		ui_listeVue.Columns.add "Nom" 180
		ui_listeVue.allowdrop = true
		ui_listeVue.BackColor = (dotNetClass "System.Drawing.Color").fromARGB 86 86 86
		ui_listeVue.ForeColor = (dotNetClass "System.Drawing.Color").fromARGB 180 180 180
		
		---- l'arborescence----
		ui_arborescence.borderstyle = (dotnetclass "System.Windows.Forms.BorderStyle").fixedsingle
		ui_arborescence.LabelEdit = true --false--#tvwAutomatic
		ui_arborescence.allowdrop = true
		ui_arborescence.HideSelection = false
		ui_arborescence.BackColor = (dotNetClass "System.Drawing.Color").fromARGB 86 86 86
		ui_arborescence.ForeColor = (dotNetClass "System.Drawing.Color").fromARGB 180 180 180
		
		--- les ecouteurs ---
		fn ecouterChangeSelection		ev nd = 	maj_UI ()		
		EcouteurChangeSelection = NodeEventCallback mouseUp:true delay:1000 selectionChanged:ecouterChangeSelection 
		
		--- maj interface ---
		
		maj_UI ()
		
	)
	
	fn fermer_interface = (
		
		--- vider ecouteur ---
		EcouteurChangeSelection = undefined
		gc light:true
		
		-- fermer les rollout secondaires ---
		try (	DestroyDialog biblio.m_rollEditerTags ) catch ( format  ("rien à destroy\n") )
		
	)
	
	
	fn chercherNoeud  _noeud _nomAChercher = (
-- 		format " ? chercheDsNoeud : % ?\n"  _noeud.name
		result = undefined
		if _noeud.name == _nomAChercher then (
-- 			format " !! !! trouve  !! !!\n"
			result = _noeud
		)
		else (
-- 			format " ... pas trouve  ... \n"
-- 			format " ? enfants : % ?\n"  _noeud.nodes.count
			for i=0 to _noeud.nodes.count - 1 do (
				node = _noeud.nodes.item[i]
				result = chercherNoeud  node _nomAChercher
				if result != undefined do return result
			)
		)
		return result 
	)
	
	fn noeudParNom   _nomAChercher = (
		return chercherNoeud  ui_arborescence	 _nomAChercher
	)


	---- remplir le tree view avec l'arbo de la biblio ----
	fn ajouterEnfantTreeView		_noeudArbo	 _noeudTV 	     =	(
		nouveauNoeudTV = _noeudTV.Nodes.add 		_noeudArbo.nom
		nouveauNoeudTV.name = _noeudArbo.nomUnique
		for enfant in _noeudArbo.enfants where classof enfant == Noeud do
			ajouterEnfantTreeView 	enfant  	nouveauNoeudTV
	)
	
	fn remplirTreeView	 _arbo	=	(		
		-- on vide la liste --
		ui_arborescence.Nodes.Clear()
		
		-- ajout du premier element --		
		ajouterEnfantTreeView 	_arbo  	ui_arborescence
	)
	
	fn getListeSelection = (
		ui_arborescence.SelectedNode
	)
	
	-- afficher les elements --
	fn AfficherElements 	_noeud = (
		debug ("AfficherElements : " + _noeud.nom )
		noeudSelect = _noeud
		
		ui_listeVue.items.Clear()
		tailleImage = biblio.appercu.tailleAppercu
		appercusImages = dotNetObject "System.Windows.Forms.ImageList"
		appercusImages.imageSize = dotNetObject "System.Drawing.Size" 	tailleImage.x 	tailleImage.y
		appercusImages.ColorDepth = appercusImages.ColorDepth.Depth24Bit
		
		
		
		listeElementAAfficher =#()
		elemIDVueSelect=#()
		elemNodesVueSelect=#()
		i = 0
		for enfant in _noeud.enfants where classOf enfant == Element do (
			li=dotNetObject "System.Windows.Forms.ListViewItem" enfant.nomUnique
			li.imageIndex = i
			li.text = enfant.nom	--extrairenomDeAdresse (substitutestring ListeFichierMax[i] ".max"  "" )
			li.name = enfant.nomUnique
			append listeElementAAfficher li	
			
			img = dotNetClass "System.Drawing.Image" --create an image
			if doesfileexist enfant.appercu then (
				debug "	APPERCU" 
				appercusImages.images.add ( img.fromFile enfant.appercu )
			) else (
				appercusImages.images.add ( img.fromFile appercuVide )
			)
			i += 1
		)
		ui_listeVue.LargeImageList = appercusImages
		ui_listeVue.items.addRange listeElementAAfficher	
		
-- 		
-- 		--- les tags ---
-- 		ui_lstBoxTags.items = #()
-- 		listTagsTmp = #()
-- 		tags = biblio.arbo.getToutTags 	node:_noeud
-- 		debug (" TOUT LES TAGS : " + tags as string )
-- 		for  tag in tags do(
-- 			
-- 			append listTagsTmp		tag
-- 		)
-- 		ui_lstBoxTags.items = listTagsTmp
	)
	
	fn afficherInfos = (
		debug "afficher infos !!<<<<<<<<<<<<<<<"
		affNom 		=""
		affFichier 	=""
		affAppercu 	=""
		affDetail		=""
		affTags 		=""
		affNotes 	=""
		ui_bmpDetail.bitmap  = (bitmap 255 255 color:gray)
		for elem in elemSelect do (
			affNom 		=	elem.nom
			affFichier 	=	elem.fichier
			affAppercu 	=	elem.appercu
			affTags 		=	elem.tags as string
			affNotes 	=	elem.notes
			affDetail 	=	elem.detail
			ui_bmpDetail.fileName = elem.detail
		)
		ui_editNom.text			=	affNom
		ui_editFichier.text		=	affFichier
		ui_editAppercu.text		=	affAppercu
		ui_editTags.text			=	affTags
		ui_editNotes.text		=	affNotes
		ui_editDetail.text		=	affDetail
	)
	
	
	
	
	
	
	
	
	fn checkDragDropInsertionMarkStatus	 mousePos 	arg = (

		local testItem= ui_arborescence.GetNodeAt (dotNetObject "System.Drawing.Point" mousePos.x mousePos.y)
		if testItem != undefined then (
			arg.Effect=arg.AllowedEffect
			
		noeudSelect = biblio.arbo.getParNomUnique 	testItem.name
			
		noeudVueSelect  = testItem
-- 			adresseDossierDestinationDragAndDrop = substring testItem.FullPath 1  (testItem.FullPath).count
-- 			NoeudDestination =testItem
-- 			GLOBAL  NoeudBack = testItem
			
-- 			debug ( "node survol : " + testItem.name as string )
		) else (
			arg.Effect=dragDropEffect.none
			noeudSelect = undefined
				
			noeudVueSelect  = undefined
		)
		/* 
		local testItem= ui_arborescence.GetNodeAt (dotNetObject "System.Drawing.Point" mousePos.x mousePos.y)
		if testItem != undefined then (
			arg.Effect=arg.AllowedEffect
			
-- 			adresseDossierDestinationDragAndDrop = substring testItem.FullPath 1  (testItem.FullPath).count
-- 			NoeudDestination =testItem
-- 			GLOBAL  NoeudBack = testItem
			
			
		) else (
			arg.Effect=dragDropEffect.none
		) */
		
		
	)
		
	
	fn chercheTVNodeByNomUnique 	_node		_nomUnique  = (
		debug (" cherche node TV : " + _nomUnique )
		debug (" 	_node.name : " + _node.name )
		result = undefined
		if _node.name == _nomUnique then (
			debug (" 	TROUV2   : " + _node.name )
			result =  _node
		)
		else (
			for i = 0 to _node.nodes.count - 1  do (
				test = chercheTVNodeByNomUnique 	_node.nodes.item[i]		_nomUnique
				if test != undefined do result = test
			)
		)
		
		return result
	)
	
	fn getTreeViewNodeByNomUnique 		_nomUnique  = (
		return chercheTVNodeByNomUnique 		ui_arborescence   _nomUnique
	)
----------------------------------------
---------- les events      -------------
----------------------------------------
	on ui_btnImporter pressed do
		( debug "Importer dans la scene." )
	
	on ui_btnCreerAssetFichier pressed do biblio.ajouterAssetFichier() 
	
	
----- L'arborescence ------------------
	on ui_arborescence		 mouseUp arg do  (
		
		---- click droit ----
		if not (arg.Button.value__ == 1048576) then ( 
			debug "DROITE"
		
		---- click gauche ----
		) else (
			debug "GAUCHE"
			noeudClique = ui_arborescence.GetNodeAt (dotNetObject "System.Drawing.Point" arg.x arg.y)
			if noeudClique != undefined do (
-- 				debug ("noeudClique.text : " + noeudClique.text as string)
-- 				debug ("noeudClique.name : " + noeudClique.name as string)
				
				-- on se deplace dans l'arborescence ---
				_noeudArbo = biblio.arbo.getParNomUnique 	noeudClique.name 
				if _noeudArbo!=undefined then (
					AfficherElements 		_noeudArbo
					noeudSelect  = _noeudArbo
					noeudVueSelect = noeudClique
					elemSelect = #()
					elemIDVueSelect  = #()
					elemNodesVueSelect  = #()
				)	else noeudSelect = noeudVueSelect = undefined
				
			)
			
			--- maj interface ---
			maj_UI ()
			afficherInfos()
		)
		
	)
	on ui_arborescence 	ItemDrag 	arg do
	(
		debug " ------------- ItemDrag --------------"
		
		local sel = ui_listeVue.selectedItems

		local result = #()
		if sel.count != 0 then
		(
			local nCount = sel.count - 1 --.NET arrays are zero based
			debug ("drag : " + nCount as string )
		)
		else
		(
			result = #()
		)
		
		ui_listeVue.doDragDrop 		arg.item 		dragDropEffect.Copy 
		
	)
	
	on ui_arborescence DragOver arg do
	(
		local pos=ui_arborescence.PointToClient 	ui_arborescence.MousePosition
		
		checkDragDropInsertionMarkStatus pos arg
		
	)
	
	
	on ui_arborescence DragDrop arg do (
	
		debug (" --------- fin drag : " + arg as string  + " --------- " )
		debug (" 	arg.Empty : " +arg.Empty as string   )
		debug (" 	arg.Data : " +arg.Data as string   )
		debug ("	elemSelect : " + elemSelect as string )
		debug ("	elemIDVueSelect : " + elemIDVueSelect as string )
		debug ("	elemNodesVueSelect : " + elemNodesVueSelect as string )
		debug ("	noeudSelect : " + noeudSelect as string )
		debug ("	noeudVueSelect : " + noeudVueSelect as string )
		debug (" --------- ----------------------- --------- " )
		hitNodeDrop = ui_arborescence.GetNodeAt (dotNetObject "System.Drawing.Point" arg.x arg.y)	
-- 		if hitNodeDragDrop != undefined do
-- 			debug ("	NODE SURVOL  : " + hitNodeDragDrop.name as string )
-- 		debug (" --------- ----------------------- --------- " )
		
-- 		show  arg
-- 		if hitNodeDrop != undefined do (
			selectionElems_NomsUniques = for elemNodes in elemNodesVueSelect collect elemNodes.name
			noeudSelecBack = noeudSelect
			elemNodesSelecBack = elemNodesVueSelect
			biblio.arbo.bouger  elemSelect  noeudSelect
		
		
			debug ("	selectionElems_NomsUniques : " + selectionElems_NomsUniques as string )
			--- maj interface ---
			remplirTreeView 	biblio.arbo.root
			
			/* 
			_noeudArbo = biblio.arbo.getParNomUnique 	noeudClique.name 
					if _noeudArbo!=undefined then (
						AfficherElements 		_noeudArbo
						noeudSelect  = _noeudArbo
						noeudVueSelect = noeudClique
						elemSelect = #()
						elemIDVueSelect  = #()
					)	else noeudSelect = noeudVueSelect = undefined
					
					 */
					
-- 			ui_listeVue.SelectedItems 			= elemNodesVueSelect
			AfficherElements 	noeudSelect
			noeudSelecNomUnique = noeudSelect.nomUnique
			
			
			for nomUnique in selectionElems_NomsUniques do (
				i = 0
				for enfant in noeudSelect.enfants where classOf enfant == Element do (
					if enfant.nomUnique == nomUnique do (
						debug "PRESENT"
						ui_listeVue.items.item[i].selected = true
					)
					i += 1
				)
			)
			
			
			noeudSelectmp = getTreeViewNodeByNomUnique  	noeudSelecNomUnique
			debug ("	noeudSelectmp : " + noeudVueSelect.text as string )
			if noeudSelectmp != undefined do 
				ui_arborescence.SelectedNode  = noeudSelectmp
			
-- 			for  _node in elemNodesVueSelect do
-- 				_node.Selected = true
-- 			debug ("######################  "  + elemNodesVueSelect as string )
			
			maj_UI ()
			afficherInfos()
-- 		)
		--	print "FIN drag"
			--print ("fichier deplacés : " + 
		--	print ("Destination : " + adresseDossierDestinationDragAndDrop )
		--	print ("liste des elements : " + ListElementsSelectionNom as string)
-- 			showproperties  arg
		/*
		
			if ListElementsSelectionNom!= undefined do (
					
				--print ("hitNodeDragDrop.text : " + hitNodeDragDrop.text as string)
				fnDeplacerLISTEdotNET ListElementsSelectionNom adresseDossierDestinationDragAndDrop
				
				
				
			--	fnSelectNode hitNode
				
			)*/
		)
	/* 
	on ui_arborescence DragOver s e do
	(
		debug " ------------- DragOver  ARBO --------------"
		local pos=ui_arborescence.PointToClient		 ui_arborescence.MousePosition
		
		checkDragDropInsertionMarkStatus 	pos	 arg
-- 		debug ( "s : "  + s as string +  "e : "  + e as string ) 
-- 		debug ( "e.data.ContainsFileDropList()  : "  + e.data.ContainsFileDropList() as string  ) 
-- 		e.Effect = 	if e.data.ContainsFileDropList() 
-- 								then 	e.Effect.Move 
-- 								else 	e.Effect.None
	)
	
	 */
		
		
		
		
----- vue de la liste des elements   ------------------
	on ui_listeVue		 mouseUp arg do  (
		
		---- click droit ----
		if not (arg.Button.value__ == 1048576) then ( 
			debug "DROITE"
		
		---- click gauche ----
		) else (
			debug "GAUCHE"
			
			
			--- maj interface ---
			elemSelect = #()
			elemIDVueSelect = #()
			elemNodesVueSelect = #()
			for i = 0 to ui_listeVue.SelectedItems.count - 1 do (
				elem = 	biblio.arbo.getParNomUnique 	 ui_listeVue.SelectedItems.item[i].name
				if elem != undefined do (
					append 	elemSelect 			elem
					append 	elemNodesVueSelect		ui_listeVue.SelectedItems.item[i]
					append 	elemIDVueSelect		ui_listeVue.SelectedItems.item[i].index
					debug (" <<< elem : " + elem as string  + " >>>")
				)
			)
			
			afficherInfos()
			
			maj_UI ()
		)
	)
	
	on ui_listeVue		 mouseDown arg do  (
		
		---- click droit ----
		if not (arg.Button.value__ == 1048576) then ( 
			debug "mouseDown : DROITE"
		
		---- click gauche ----
		) else (
			debug "////////////// mouseDown : GAUCHE //////"
			
			show arg 
					debug ("	arg : " + arg as string )
-- 					debug ("	arg.data : " + arg.data as string )
			--- maj interface ---
-- 			elemSelect = #()
-- 			elemIDVueSelect = #()
-- 			elemNodesVueSelect = #()
			
			
			
			
-- 			if elemSelect.count == 0 do (
			
			hitNode = ui_listeVue.GetItemAt  arg.x 	arg.y
			
			if hitNode != undefined then (
				b_present = false
				for i = 0 to ui_listeVue.SelectedItems.count - 1 do 
					if ui_listeVue.SelectedItems.item[i] == hitNode then b_present = true
					
					if b_present	then (
-- 						for i = 0 to ui_listeVue.SelectedItems.count - 1 do (
-- 							elem = 	biblio.arbo.getParNomUnique 	 ui_listeVue.SelectedItems.item[i].name
-- 							if elem != undefined do (
-- 								append 	elemSelect 					elem
-- 								append 	elemIDVueSelect			ui_listeVue.SelectedItems.item[i].index
-- 								append 	elemNodesVueSelect		ui_listeVue.SelectedItems.item[i]
-- 								debug (" <<< elem : " + elem as string  + " >>>")
-- 							)
-- 						)
					) else (
						debug ( "hitNode : " + hitNode as string )
						debug ( "	nom : " + hitNode.name as string )
						
						debug ( "	txt : " + hitNode.text as string )
						
						elemIDVueSelect = #( hitNode.index )
						elemNodesVueSelect = #( hitNode )
						append elemSelect  ( biblio.arbo.getParNomUnique hitNode.name ) 
					)
-- 				)
			
				afficherInfos()
				
				maj_UI ()
			)
		)
	)
	
	
	on ui_listeVue 	ItemDrag 	arg do
	(
		debug " ------------- ItemDrag --------------"
		
		local sel = ui_listeVue.selectedItems
		
-- 		 elemIDVueSelect = #()
-- 		elemSelect = #()
-- 			
-- 		noeudSelect = undefined
-- 		noeudVueSelect  = undefined

		local result = #()
		if sel.count != 0 then
		(
			local nCount = sel.count - 1 --.NET arrays are zero based
			debug ("drag : " + nCount as string )
		)
		else
		(
			result = #()
		)
		
		ui_listeVue.doDragDrop 		arg.item 		dragDropEffect.Copy 
		
	)
	
	on ui_listeVue DragOver s e do
	(
-- 		debug " ------------- DragOver LISTEVUE  --------------"
-- 		debug ( "s : "  + s as string +  "e : "  + e as string ) 
-- 		debug ( "e.data.ContainsFileDropList()  : "  + e.data.ContainsFileDropList() as string  ) 
		e.Effect = 	if e.data.ContainsFileDropList() 
								then 	e.Effect.Move 
								else 	e.Effect.None
	)
	
/* )	
	on listviewElements click arg do		--	<----	FAIRE UN MOUSE UP EVENT ?!?!
	(
		fnGestionCheck ()
		fnAfficheApercu ()
	)
	on listviewElements enter arg do
	(
		--	print"enter"
		--		showproperties arg
			)
	on listviewElements SelectedIndexChanged do
	(
			fnAfficheApercu()
		)
	on listviewElements DoubleClick do
	(
			fnAfficheApercu()
			Roll_Bibliotheque.fnImporterDanslaScene()
		)
	on listviewElements mouseUp arg do
	(
		--SelectionListView()
	
	--	print "click"
	--	print arg.Button.value__ 
		if not (arg.Button.value__ == 1048576) then ( print "MouseButtons.Lefet"
			menuSys=menus()
			popUpMenu menuSys --rollout:presets_R
		)
		fnAfficheApercu()
	)
	on listviewElements mouseDown sender do
	(
	--	print"-listviewElements items-------"
	--	print listviewElements.items
		
		
		
		local sel = listviewElements.selectedItems
		--local selIndex = listviewElements.SelectedIndex
	
		local result = #()
	--	print"-sel.count-------"
	--	print sel.count
		if sel.count != 0 then
		(
			local nCount = sel.count - 1 --.NET arrays are zero based
			resultNom = for i = 0 to nCount collect( ( sel.item[i] ).text)
			resultItem = for i = 0 to nCount collect( ( sel.item[i] ))
			--resultIndex = for i = 0 to nCount collect( ( selIndex.item[i] ))
		)
		else
		(
			result = #()
		)
	--	print"--result---------"
	--	print (result as string)
		ListElementsSelectionItem = resultItem
		ListElementsSelectionNom = resultNom
		
		fnAfficheApercu()
		
		
		
	)
	on listviewElements ItemDrag arg do
	(
		"ItemDrag"
		--	print ("DEBUT drag : " + arg.item as string)
			
			local sel = listviewElements.selectedItems
			--local selIndex = listviewElements.SelectedIndex
	
			local result = #()
		--	print"-sel.count-------"
		--	print sel.count
			if sel.count != 0 then
			(
				local nCount = sel.count - 1 --.NET arrays are zero based
				resultNom = for i = 0 to nCount collect( ( sel.item[i] ).text)
				resultItem = for i = 0 to nCount collect( ( sel.item[i] ))
				--resultIndex = for i = 0 to nCount collect( ( selIndex.item[i] ))
			)
			else
			(
				result = #()
			)
		--	print"--result---------"
		--	print (result as string)
			ListElementsSelectionItem = resultItem
			ListElementsSelectionNom = resultNom
			
			
			
			
			--showproperties arg.item 
			--clickedItem=arg.item 
			listviewElements.doDragDrop arg.item dragDropEffect.Copy 
		)
	on listviewElements keyPress arg do
	(
		print"KeyPress"
	--	clearlistener()
		print arg.Handled
		showevents listviewElements
	--	print "DragOver"
		--e.Effect = if e.data.ContainsFileDropList() then e.Effect.Move else e.Effect.None
	)
	on listviewElements DragOver s e do
	(
	--	print "DragOver"
		e.Effect = if e.data.ContainsFileDropList() then e.Effect.Move else e.Effect.None
	)
	on listviewElements DragDrop s e do
	(
		if e.data.ContainsFileDropList() do
			(
				print "drag"
				data = e.data.GetFileDropList()
				files = for k=0 to data.count-1 collect data.item[k]
				format "files: %\n" files
				print files
				ListeGlisserColler = #()
				for i in files do (
					
					if (findstring i ".max")!=undefined do (
						append ListeGlisserColler i
					)
				)
				
				
				
				
				TypeDimportBiblio = 4
				--ListeGlisserColler = files
				fnImporterDanslaBibliotheque ()
				
				AfficherElements ()
				
			--	s.text = getfilenamefile files[1]
			)
	)
			
	
	 */
	

---- Edition/Infos  elements ----
	on ui_btnAfficherInfo changed state do	(
		biblio.setInfosOuvert 			state
		repositionnerElementsUI		UItaille_fenetre
	)
	
	
	on ui_editNom 	changed  txt 	do (
		if elemSelect.count == 1 do (
			elemSelect[1].nom = txt
			biblio.arbo.ecrireFichier()
			
			-- les selections --
			for id in elemIDVueSelect do 
				ui_listeVue.Items.item[id].text = txt
		)
	)
	
	on ui_editFichier 	changed  txt 	do (
		if elemSelect.count == 1 do 
			elemSelect[1].fichier = txt
		biblio.arbo.ecrireFichier()
	)

	on ui_lblAppercu 	changed  txt 	do (
		if elemSelect.count == 1 do 
			elemSelect[1].appercu = txt
		biblio.arbo.ecrireFichier()
	)
	on ui_editDetail 	changed  txt 	do (
		for elem in  elemSelect do 
			elem.detail = txt
		biblio.arbo.ecrireFichier()
		afficherInfos()
	)
	on ui_editTags 	changed  txt 	do (
		for elem in  elemSelect do 
			elem.tags = txt
		biblio.arbo.ecrireFichier()
		maj_UI()
	)
	on ui_editNotes 	changed  txt 	do (
		for elem in  elemSelect do 
			elem.notes = txt
		biblio.arbo.ecrireFichier()
	)
	
	
	
	on ui_editRecherche 	changed  txt 	do (
		
		biblio.arbo.chercherTags 	txt
		
		noeudSelect = biblio.arbo.getParNomUnique "RECHERCHE" 
		
		noeudVueSelect = noeudParNom "RECHERCHE"  
		
		maj_UI ()
		AfficherElements  noeudSelect
		
	)
	
	
	
	on ui_btnOuvrirFichierMax pressed do (
		
		if elemSelect.count == 1 do ( 
			fichierAImporter = 	getOpenFileName  caption:"Fichier à lier à l'élément de la bibliotheque" \
											types:"model (*.max)|*.max|All Files (*.*)|*.*|"	\
											filename:elemSelect[1].fichier
			
			if 	fichierAImporter != undefined  do (
				debug ( "Importer " + fichierAImporter )
				elemSelect[1].fichier = fichierAImporter
				biblio.arbo.ecrireFichier()
				afficherInfos()
			)
-- 					show 	( selectionTV )
		)
		
	)
		
	
	
	on ui_btnCreerAppercu pressed do (
		if querybox "voulez vous créer l'aperçu ?" do
			if elemSelect.count > 0 do ( 
				-- appercu --
				for elem in elemSelect do (
					if doesfileexist elem.fichier then
						elem.appercu = biblio.appercu.creer 	elem.fichier
					else format "elem : % n'as pas de fichier valide : %\n" elem.nom elem.fichier
				)
				
				AfficherElements noeudSelect
				
				biblio.arbo.ecrireFichier()
				afficherInfos()
			)
		
	)
	
	
	on ui_btnCreerDetail pressed do (
		if querybox "voulez vous créer un rendu détail ?" do
			if elemSelect.count > 0 do ( 
				-- appercu --
				for elem in elemSelect do (
					if doesfileexist elem.fichier then
						elem.detail = biblio.appercu.creer 	elem.fichier detail:true
					else format "elem : % n'as pas de fichier valide : %\n" elem.nom elem.fichier
				)
				
				AfficherElements noeudSelect
				
				biblio.arbo.ecrireFichier()
				afficherInfos()
			)
		
	)		
		
----- events rollout ------
	on m_rollPrincipal open do (
		initialiser_interface()
	)

	on m_rollPrincipal close do (
		fermer_interface()
	)
	
	
	on m_rollPrincipal resized 	tailleRollOut	 do (
		repositionnerElementsUI 			tailleRollOut
		biblio.setTailleRolloutPrincipal 	tailleRollOut
		
		posRollOut = GetDialogPos 	biblio.m_rollPrincipal
		-- si Edition est accroché on le deplace avec ---
		if biblio.getEditionAccroche() do (
			
			bordureDialogBox 	= [22,5]
			coinAccroche 			= [ posRollOut.x + biblio.m_rollPrincipal.width , posRollOut.y ]
			coinAccroche 			+= bordureDialogBox
			
			SetDialogPos 	biblio.m_rollEditerTags 	coinAccroche
			biblio.setPosRolloutEdition 					coinAccroche
		)
	)
	
	on m_rollPrincipal moved 	posRollOut	 do (
		
		biblio.setPosRolloutPrincipal 	posRollOut
		
		-- si Edition est accroché on le deplace avec ---
		if biblio.getEditionAccroche() do (
			
			bordureDialogBox 	= [22,5]
			coinAccroche 			= [ posRollOut.x + biblio.m_rollPrincipal.width , posRollOut.y ]
			coinAccroche 			+= bordureDialogBox
			
			SetDialogPos 	biblio.m_rollEditerTags 	coinAccroche
			biblio.setPosRolloutEdition 					coinAccroche
		)
	)
	
) -- fin rollout





