

/* 
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

 */

---------------------------------------------------------------------------------------------------------------------------------------------------------
----------	Le rollout d'edition des tags  ---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
rollout m_rollPreferences "Préférences de la bibliothèque" width:500 height:114
(
	
	local biblio
	local cheminApercusBack
	local cheminProxiesBack
	
	groupBox 	grp_dossiers 	"Dossiers" 	pos:[14,12] width:472 height:66
	
	editText 	edt_apercus 	"" 				pos:[112,32] width:344 height:17
	button 		btn_apercus 	"..." 			pos:[463,32] width:17 height:17
	label 		lbl_apercus 	"Aperçus:" 	pos:[23,33] width:90 height:16	
	
	editText 	edt_proxy 		"" 				pos:[112,53] width:344 height:17
	button 		btn_proxy 		"..." 			pos:[463,53] width:17 height:17
	label 		lbl_proxy 		"Proxies:" 	pos:[23,54] width:90 height:16
	
	button 		btn_appliquer 	"Appliquer" 	pos:[14,82] width:99 height:18
	button 		btn_annuler 	"Annuler" 	pos:[387,82] width:99 height:18
	
	on edt_apercus entered txt do (
		if not doesFileExist txt then
		/* 	biblio.apercu.dossierApercus	= txt
		else */
			edt_apercus.text 	=	cheminApercusBack -- biblio.apercu.dossierApercus
	)
	
	on btn_apercus pressed do (
		nouveauChemin = getSavePath "Dossier pour les apérçus"	 initialDir:edt_apercus.text
		if nouveauChemin != undefined do
			edt_apercus.text 	=	nouveauChemin
		
	)
	
	on edt_proxy entered txt do (
		if not doesFileExist txt then
			/* biblio.apercu.dossierApercus 			= txt
		else  */
			edt_proxy.text	= cheminProxiesBack  --biblio.conversion.dossierProxy	
	)
	
	on btn_proxy pressed do (
		nouveauChemin = getSavePath "Dossier pour les proxies"	 initialDir:edt_proxy.text
		if nouveauChemin != undefined do
			edt_apercus.text 	=	nouveauChemin
	
	)
	
	
	
	
	on btn_appliquer pressed do (
		m_rollPreferences.edt_apercus.text 	= biblio.apercu.dossierApercus
		m_rollPreferences.edt_proxy.text 		= biblio.conversion.dossierProxy
		try (	DestroyDialog biblio.m_rollPreferences ) catch ( format  ("rien à destroy\n") )
	)
	on btn_annuler pressed do (
		try (	DestroyDialog biblio.m_rollPreferences ) catch ( format  ("rien à destroy\n") )
	)
	
	
	
	on m_rollPreferences open do (
		cheminApercusBack	= bibliotheque.conversion.dossierProxy
		cheminProxiesBack	= bibliotheque.apercu.dossierApercus
	)
	
/* 	on m_rollPreferences close do (
		cheminApercusBack	= biblio.conversion.dossierProxy
		cheminProxiesBack	= biblio.apercu.dossierApercus
	) */
	
)



---------------------------------------------------------------------------------------------------------------------------------------------------------
----------	Le rollout d'edition des tags  ---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
rollout m_rollEditerTags "Bibliothèque" width:411 height:454
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
	label lbl12 "Aperçu:" pos:[17,78] width:44 height:19
	edittext edt12 "" pos:[59,78] width:303 height:22
	button btn10 "..." pos:[366,79] width:25 height:22
	
	
	
	-- eveneemnts ------
	
	
	on m_rollEditerTags moved posRollOut	 do
	(
			
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
	on ui_btnValider pressed do
		try (	DestroyDialog m_rollEditerTags ) catch ( format  ("rien à destroy\n") )
	on ui_btnAnnuler pressed do
		try (	DestroyDialog m_rollEditerTags ) catch ( format  ("rien à destroy\n") )
)

---------------------------------------------------------------------------------------------------------------------------------------------------------
----------	Le rollout principale ---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
rollout m_rollPrincipal "Bibliothèque" width:1272 height:575 (
	
--------------------------------
--- declarations locales -----
--------------------------------
	
	local m_rollEditerTags
	local colorFondVue = color 98 126 155  -- 96 96 96
	local colorTextes = color 220 220 220
	local colorImage = color 36 36 36
	
	local biblio ---- le struct principal de la bibliotheque ----
	local apercuVide = "C:\Users\kris\AppData\Local\Autodesk\3dsMax\2017 - 64bit\ENU\scripts\biblio\apercus\apVide.jpg"
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
	local ico_BtnAjouterAsset					= "$userScripts\\biblio\\ico\\NouvelAsset.bmp"
	local ico_BtnAjouterDossier				= "$userScripts\\biblio\\ico\\NouvelAssetsDossier.bmp"
	local ico_BtnAjouterAssetFromScene	= "$userScripts\\biblio\\ico\\NouvelAssetFromScene.bmp"
	local ico_BtnImporter						= "$userScripts\\biblio\\ico\\importerDansScene.bmp"
	local ico_BtnImporterProxy				= "$userScripts\\biblio\\ico\\importerDansSceneProxy.bmp"
	local ico_BtnImporterCorona				= "$userScripts\\biblio\\ico\\importerDansSceneCorona.bmp"
	
	
	-- Element selectionné ---
	local elemSelect = #()
	local elemIDVueSelect = #()
	local elemNodesVueSelect = #()
	local noeudSelect
	local noeudVueSelect 
	local noeudDrag
	
	local noeudRecherche
	-- drag end drop du dotNet ---
	local dragDropEffect = dotNetClass "System.Windows.Forms.DragDropEffects"
	
	local ui_listBtns_infos=#()
	local b_dragDossier = false
	local b_autoExpendArbo = true
	
	local cancelled = false
	local listeVueDisplay	= #images   	--  #images  ou #liste
	
	local caseVide = " - - "
	local m_ordreInverse = true  -- pour inverser les ordres de classement dans la liste vue ---
--------------------------------------
---------- L'INTERFACE ----------
--------------------------------------	

	---- Edition de la biblio ----
	button 				ui_btnCreerAssetFichier		"" pos:UIpos_barreEdition 		width:UItaille_btns.x 		height:UItaille_btns.y \
															toolTip:"Nouvel asset depuis un fichier."		border:false \
															images:#( ico_BtnAjouterAsset , undefined, 1, 1,1,1,1)
															
	button 				ui_btnCreerAssetDossier		"" pos:[ui_btnCreerAssetFichier.pos.x + UItaille_btns.x +UItaille_ecart.x,  UIpos_barreEdition.y ] \
															width:UItaille_btns.x 		height:UItaille_btns.y \
															toolTip:"Nouveaux assets depuis un dossier."		border:false \
															images:#( ico_BtnAjouterDossier , undefined, 1, 1,1,1,1)

	button 				ui_btnCreerAssetSelection		"" pos:[ui_btnCreerAssetDossier.pos.x + UItaille_btns.x +UItaille_ecart.x,  UIpos_barreEdition.y ] \
															width:UItaille_btns.x 		height:UItaille_btns.y \
															toolTip:"Nouvel asset depuis la selection."		border:false \
															images:#( ico_BtnAjouterAssetFromScene , undefined, 2, 	1,1,2,2)
															
															
															
															
	button 				ui_btnImporterAssetDansScene			"" pos:[ui_btnCreerAssetSelection.pos.x + 2* UItaille_btns.x + 2*UItaille_ecart.x,  UIpos_barreEdition.y ] \
															width:UItaille_btns.x 		height:UItaille_btns.y \
															toolTip:"Importe le ou les assets sélectionnés."			border:false	\
															images:#( ico_BtnImporter , undefined, 2, 	1,1,2,2)
	
-- 	button 				ui_btnImporterAssetDansSceneCorona			"" pos:[ui_btnImporterAssetDansScene.pos.x  + UItaille_btns.x +UItaille_ecart.x,  UIpos_barreEdition.y ] \
-- 															width:UItaille_btns.x 		height:UItaille_btns.y \
-- 															toolTip:"Importe le ou les assets sélectionnés en les convertissant en Corona."			border:false	\
-- 															images:#( ico_BtnImporterCorona , undefined, 2, 	1,1,2,2)
	
	button 				ui_btnImporterAssetDansSceneProxy			"" pos:[ui_btnImporterAssetDansScene.pos.x  + UItaille_btns.x +UItaille_ecart.x,  UIpos_barreEdition.y ] \
															width:UItaille_btns.x 		height:UItaille_btns.y \
															toolTip:"Importe le ou les assets sélectionnés à la scène en proxy Corona."			border:false	\
															images:#( ico_BtnImporterProxy , undefined, 2, 	1,1,2,2)
	
	---- Navigation  ----
	dotNetControl 	ui_arborescence 			"TreeView" pos:UIpos_exploration width:200 height:150 	enabled:true																		---------- l'arborescence 
	MultiListBox 		ui_lstBoxTags				"Mots clés:" 		pos:( UIpos_exploration + [0,150 + UItaille_ecart.x]) width:200 height:( 50 )
	edittext 			ui_editRecherche 		"" 		pos:[UIpos_exploration.x + ui_arborescence.width + UItaille_ecart.x ,  UIpos_exploration.y ] width:200 height:17		
	
	button				ui_btnToogleStyleVue	"Im" pos:(ui_editRecherche.pos + [ui_editRecherche.width + UItaille_ecart.x, 0 ]) width:UItaille_petitsBtns.x height:UItaille_petitsBtns.y \
															tooltip:"Basculer affichage Images / Liste"
	
	dotNetControl 	ui_listeVue 					"system.windows.forms.listView" pos:[UIpos_exploration.x + ui_arborescence.width + UItaille_ecart.x , UIpos_exploration.y + ui_editRecherche.height + UItaille_ecart.y ] width:200 height:200 border:false											---------- le contenu du dossier 	
	
	label 				ui_LabelProgress			 "" pos:[16,118] width:200 height:16
	progressBar 		ui_progressBar				"ProgressBar" pos:[25,351] width:175 height:19 color:(color 50 150 246) tooltip:"action: \ntempsRestant:\n"
	
	button				ui_progressCancel		"X"	pos:[16,118] width:UItaille_petitsBtns.x height:UItaille_petitsBtns.y
	--- infos ---
	groupBox			ui_grpInfos				""	pos:[ui_listeVue.pos.x + ui_listeVue.width + UItaille_ecart.x , ui_editRecherche.pos.y] width:(256 + 2*UItaille_marge.x)  height:200 	
		
	---- Edition des infos----	
	checkbutton 		ui_btnAfficherInfo		"I" pos:[ui_grpInfos.pos.x ,   ui_grpInfos.pos.y  + ui_grpInfos.height + UItaille_ecart.y ] \
															width:UItaille_petitsBtns.x 		height:UItaille_petitsBtns.y \
															toolTip:"Afficher/cacher les infos"			border:false
		
		
	label 		ui_lblNom 					"Nom: " pos:[17,23] width:36 height:19
	edittext 	ui_editNom 				"" 		pos:[59,23] width:200 height:17
		
	label 		ui_lblFichier				"Fichier: " pos:[17,50] width:44 height:19
	edittext 	ui_editFichier 				"" pos:[59,50] width:175 height:17
	button 		ui_btnOuvrirFichierMax "..." pos:[366,51] width:25 height:17 toolTip:"Choisir le fichier .max de référence de cet asset."
		
	label 		ui_lblApercu				"Aperçu:" pos:[17,78] width:44 height:19
	edittext	 	ui_editApercu 			"" pos:[59,78] width:135 height:17
	button 		ui_btnOurvirApercu	"..." pos:[366,79] width:25 height:17 toolTip:"Choisir l'image servant d'aperçu à cet asset (200px X 200px)."
-- 	button 		ui_btnOurvirSceneApercu	"..." pos:[366,79] width:25 height:17 toolTip:"Choisir l'image servant d'aperçu à cet asset (200px X 200px)."
	button 		ui_btnCreerApercu	"Créer" pos:[366,79] width:35 height:17	toolTip:"Création automatique de l'aperçu de cet asset."
		
	label 		ui_lblDetail				"Détail:" pos:[17,78] width:44 height:19
	edittext	 	ui_editDetail			"" pos:[59,78] width:135 height:17
	button 		ui_btnOurvirDetail		"..." pos:[366,79] width:25 height:17	toolTip:"Choisir l'image servant d'aperçu détail à cet asset (200px X 200px)."
	button 		ui_btnCreerDetail		"Créer" pos:[366,79] width:35 height:17 toolTip:"Création automatique de l'aperçu détail de cet asset."
	
	label 		ui_lblTags					"Mots clés:" pos:[16,118] width:217 height:19
	edittext		ui_editTags 				"" pos:[16,136] width:(ui_grpInfos.width - 3* UItaille_ecart.x )  height:17
		
	label 		ui_lblNotes 				"Notes:" pos:[16,167] width:217 height:19	
	edittext 	ui_editNotes 				"" pos:[16,185] width:(ui_grpInfos.width - 3* UItaille_ecart.x )	 height:122
		
	
	bitmap		ui_bmpDetail 		pos:[16 ,167] width:256 height:256	
	
	
----------------------------------------
---------- les Methodes  -------------
----------------------------------------
	
	fn setProgress _text  _val =(
		debug ( " ##### setProgress : " + _text + " val: " + _val  as string + "  ####" )
		ui_LabelProgress.text = _text
		ui_progressBar.value = _val
	)
	
	
	
	fn selectElems 	_elems 	= (
		
		for elem in _elems do (
			nomUnique = elem.nomUnique
			i = 0
			for enfant in noeudSelect.enfants where classOf enfant == Element do (
				if enfant.nomUnique == nomUnique do (
					debug "PRESENT"
					ui_listeVue.items.item[i].selected = true
				)
				i += 1
			)
		)
		
		
	)
	

	fn repositionnerElementsUI 	tailleRollOut	= (
		
		b_afficheInfos 				= biblio.getInfosOuvert()
		
		-- on redim et repositionne les elements ---
		hauteurExplorateur 			= tailleRollOut.y -  ( UIpos_exploration.y +  UItaille_marge.y )
		
		ui_lstBoxTags.height = 150
		ui_arborescence.height 	= hauteurExplorateur - ( ui_lstBoxTags.height + 6+ UItaille_ecart.y  + 3*UItaille_petitsBtns.y )
		ui_lstBoxTags.pos 			= ui_arborescence.pos + [0 , ui_arborescence.height  + 4*UItaille_ecart.y]
		
		ui_LabelProgress.pos 		=  ui_lstBoxTags.pos + [ 0 , ui_lstBoxTags.height  + UItaille_ecart.y ]
		ui_progressBar.pos 			=  ui_LabelProgress.pos + [ 0 , 3* UItaille_ecart.y ]
		ui_progressCancel.pos		= ui_progressBar.pos + [175 + UItaille_ecart.y , 0]
		
		ui_btnAfficherInfo.checked 	= b_afficheInfos
		
		
		b_afficheInfos 				= biblio.getInfosOuvert()
		
		
		-- quleque reperes ---
		
		ui_grpInfos.visible  					= b_afficheInfos
		ui_lblNom.visible  					= b_afficheInfos
		ui_editNom.visible  					= b_afficheInfos
		ui_lblFichier.visible  				= b_afficheInfos
		ui_editFichier.visible  				= b_afficheInfos
		ui_btnOuvrirFichierMax.visible  	= b_afficheInfos
		ui_lblApercu.visible  				= b_afficheInfos
		ui_editApercu.visible  			= b_afficheInfos
		ui_btnOurvirApercu.visible  		= b_afficheInfos
		ui_btnCreerApercu.visible  		= b_afficheInfos
		
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
			ui_grpInfos.height			= hauteurExplorateur - ( UItaille_petitsBtns.y + 2* UItaille_ecart.y  ) 
			ui_listeVue.width			= tailleRollOut.x  - ( ui_arborescence.width + ui_grpInfos.width + 4* UItaille_ecart.x + UItaille_marge.x ) 
			ui_listeVue.height			= hauteurExplorateur - ( ui_editRecherche.height + UItaille_ecart.y )
			ui_btnAfficherInfo.pos 		= [ui_grpInfos.pos.x + ui_grpInfos.width - UItaille_petitsBtns.x  ,  ui_grpInfos.pos.y  + ui_grpInfos.height + UItaille_ecart.y ]   

-- 			ui_progressBar.width = ui_listeVue.width
			
			
			repere 			= ui_grpInfos.pos + UItaille_marge + [0,5]
			tabEdit_1 		= 	UItaille_ecart.x
			tabEdit_2 		= 	tabEdit_1 + 60
			hauteur 			= [0,25]
			petiteHauteur = [0,18]
			largeurTitre 	= [60,0]
			
			ui_lblNom.pos  					= repere
			ui_editNom.pos  					= repere + largeurTitre
			ui_lblFichier.pos					= repere + hauteur
			ui_editFichier.pos				= repere + hauteur + largeurTitre
			ui_btnOuvrirFichierMax.pos	= repere + hauteur + largeurTitre + [ui_editFichier.width,0] + [UItaille_ecart.x, 0]
			
			ui_lblApercu.pos				= repere + 2 * hauteur
			ui_editApercu.pos				= repere + 2 * hauteur + largeurTitre
			ui_btnCreerApercu.pos		= repere + 2 * hauteur + largeurTitre +  [ui_editFichier.width - 38 ,0]+ [UItaille_ecart.x, 0] 
			ui_btnOurvirApercu.pos		= repere + 2 * hauteur + largeurTitre +  [ui_editFichier.width,0]+ [UItaille_ecart.x, 0]
			
			
			
			
			ui_lblTags.pos					= repere + 3 * hauteur
			ui_editTags.pos					= repere + 3 * hauteur + petiteHauteur
			
			
			
			
			ui_bmpDetail.pos = [ui_grpInfos.pos.x + UItaille_marge.x ,ui_grpInfos.pos.y + ui_grpInfos.height - ( UItaille_ecart.y   + ui_bmpDetail.height ) ] 
			
			ui_lblDetail.pos				= ui_bmpDetail.pos -  hauteur
			ui_editDetail.pos				= ui_lblDetail.pos + largeurTitre
			ui_btnCreerDetail.pos		= ui_lblDetail.pos + largeurTitre +  [ui_editFichier.width - 41 ,0]+ [UItaille_ecart.x, 0] 
			ui_btnOurvirDetail.pos		= ui_lblDetail.pos + largeurTitre +  [ui_editFichier.width,0]+ [UItaille_ecart.x, 0]
			
			ui_lblNotes.pos				= repere + 4 * hauteur + petiteHauteur
			ui_editNotes.pos				= repere + 4 * hauteur + 2* petiteHauteur
			ui_editNotes.height			= ui_lblDetail.pos.y - ( ui_editNotes.pos.y + 2*UItaille_ecart.y   )
			
		) else (
			
			ui_listeVue.width			= tailleRollOut.x  - ( ui_arborescence.width + 5* UItaille_ecart.x + UItaille_petitsBtns.x  ) 
			ui_listeVue.height			= hauteurExplorateur - ( ui_editRecherche.height + UItaille_ecart.y )
			ui_btnAfficherInfo.pos 	= [ui_listeVue.pos.x + ui_listeVue.width + UItaille_ecart.x   ,  ui_listeVue.pos.y  + ui_listeVue.height - ( UItaille_petitsBtns.y ) ]     
			
		)
		
		ui_editRecherche.width  =  ui_listeVue.width - ( 2*UItaille_ecart.x  + UItaille_petitsBtns.x )
		
		ui_btnToogleStyleVue.pos =ui_editRecherche.pos + [ui_editRecherche.width + UItaille_ecart.x, 0 ]
		
		
		-- on limite la taille du rollout 
		thisRollout = biblio.m_rollPrincipal
		
		if tailleRollOut.x < UItaille_fenetreMin.x do thisRollout.width 	= UItaille_fenetreMin.x
		if tailleRollOut.y < UItaille_fenetreMin.y do thisRollout.height 	= UItaille_fenetreMin.y
		
		-- maj de la taille --
		UItaille_fenetre = [ thisRollout.width , thisRollout.height  ]
		
		
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
		--if _noeudArbo.nomUnique !="RECHERCHE" do (
			
			nouveauNoeudTV = _noeudTV.Nodes.add 		( _noeudArbo.nom + " (" + _noeudArbo.getNbrEnfants() as string + ")")
			nouveauNoeudTV.name = _noeudArbo.nomUnique
			for enfant in _noeudArbo.enfants where classof enfant == Noeud do
				ajouterEnfantTreeView 	enfant  	nouveauNoeudTV
		--)
	)


	fn remplirTreeView	 _arbo	=	(		
		-- on vide la liste --
		ui_arborescence.Nodes.Clear()
		
		-- ajout du premier element --		
		ajouterEnfantTreeView 	_arbo  	ui_arborescence
		
		-- ajout de la recherche --
		nmRech = "RECHERCHE"
		noeudTVRech = ui_arborescence.Nodes.add 		nmRech
		noeudTVRech.name = nmRech
		noeudRecherche = biblio.arbo.getNoeudRecherche ()
		
		if nouedRecherche != undefined do 
			for enfant in nouedRecherche.enfants where classof enfant == Noeud do
				ajouterEnfantTreeView 	enfant  	noeudTVRech
		
	)


	fn getListeSelection = (
		ui_arborescence.SelectedNode
	)

	fn dateToString 	_date = (
		local result
		zeroJour = if _date[4] <10 then  "0"  else ""
		zeroMois = if _date[2] <10 then  "0"  else ""
		zeroH = if _date[5] <10 then  "0"  else ""
		zeroM = if _date[6] <10 then  "0"  else ""
		zeroS = if _date[7] <10 then  "0"  else ""
		if _date[4] != 0 then 
			result = zeroJour + _date[4] as string + "/"  + zeroMois + _date[2] as string+ "/"  + _date[1] as string + "  "  + zeroH + _date[5] as string + ":"  + zeroM  + _date[6] as string + ":"  +zeroS + _date[7] as string 
		else 
			result = caseVide
		result
	)

	-- afficher les elements --
	fn AfficherElements 	_noeud = (
		if _noeud != undefined do (
			
			debug ("AfficherElements : " + _noeud.nom )
			noeudSelect = _noeud
			
			ui_listeVue.items.Clear()
			tailleImage = biblio.prefs.apercus.taille
			apercusImages = dotNetObject "System.Windows.Forms.ImageList"
			apercusImages.imageSize = dotNetObject "System.Drawing.Size" 	biblio.prefs.fenetre.tailleApercus.x 	biblio.prefs.fenetre.tailleApercus.y
			apercusImages.ColorDepth = apercusImages.ColorDepth.Depth24Bit
			
			
			
			listeElementAAfficher =#()
			elemIDVueSelect=#()
			elemNodesVueSelect=#()
			i = 0
			for enfant in _noeud.enfants where classOf enfant == Element do (
				li=dotNetObject "System.Windows.Forms.ListViewItem" enfant.nomUnique
				li.imageIndex = i
				li.text = enfant.nom	--extrairenomDeAdresse (substitutestring ListeFichierMax[i] ".max"  "" )
				li.name = enfant.nomUnique
				
				li.subItems.add 	( enfant.nbrVertex  as string )
				li.subItems.add 	( dateToString 	enfant.dateDernierImport   )
				li.subItems.add 	( if ( enfant.nbrImports  >0) then  enfant.nbrImports as string else caseVide )
				li.subItems.add 	( if ( doesfileExist enfant.proxy ) then "true" else caseVide  )
				li.subItems.add 	( if ( doesfileExist enfant.detail )  then "true" else caseVide  )
				li.subItems.add 	( dateToString 	enfant.dateCreation   )
				
				append listeElementAAfficher li	
				
				img = dotNetClass "System.Drawing.Image" --create an image
				if doesfileexist enfant.apercu then (
	-- 				debug "	APPERCU" 
					apercusImages.images.add ( img.fromFile enfant.apercu )
				) else (
					apercusImages.images.add ( img.fromFile apercuVide )
				)
				i += 1
			)
			ui_listeVue.LargeImageList = apercusImages
			ui_listeVue.items.addRange listeElementAAfficher	
		)
		
		selectElems elemSelect
		
	)
	
	fn afficherInfos = (
		debug "afficher infos !!<<<<<<<<<<<<<<<"
		affNom 		=""
		affFichier 	=""
		affApercu 	=""
		affDetail		=""
		affTags 		=""
		affNotes 	=""
		ui_bmpDetail.bitmap  = (bitmap 255 255 color:(colorImage) )
		
		b_solo = elemSelect.count == 1
		for btn in ui_listBtns_infos do
			btn.enabled = b_solo
		if elemSelect.count>0 do (
			ui_editTags.enabled =true
			ui_lblTags.enabled =true
			ui_editNotes.enabled =true
			ui_lblNotes.enabled =true
					
			ui_btnCreerApercu.enabled =true
			ui_btnCreerDetail.enabled =true
		)
		
		if b_solo then (
			
			elem = elemSelect[1]
			affTags 		=	elem.tags as string
			affNom 		=	elem.nom
			affFichier 		=	elem.fichier
			affApercu 	=	elem.apercu
			affTags 		=	elem.tags as string
			affNotes 	=	elem.notes
			affDetail 	=	elem.detail
			ui_bmpDetail.fileName = elem.detail
			
		) else (
			listTags = #()
			b_notesPresente = true
			for elem in elemSelect do (
				-- les notes -
				if affNotes == "" then affNotes = elem.notes
				else if not affNotes == elem.notes do b_notesPresente = false
					
				
				-- les tags ---
				listTagsElem = biblio.arbo.getToutTags 	node:elem
				for tag in listTagsElem do (
					appendIfUnique listTags tag
				)
			)
			
			
			if not b_notesPresente then affNotes = ""
				
			
			listTags_2 = #()
			for tag in listTags do (
				b_present = true
				for elem in elemSelect do (
					listTagsElem = biblio.arbo.getToutTags 	node:elem
					if findItem listTagsElem tag == 0 do b_present = false
				)
				if b_present do append listTags_2  tag
			)
		
			txtTags = ""
			for tag in listTags_2 do txtTags += tag + " "
			affTags 		=	txtTags
				
				
-- 				affNom 		=	elem.nom
-- 				affFichier 		=	elem.fichier
-- 				affApercu 	=	elem.apercu
		)
		ui_editNom.text			=	affNom
		ui_editFichier.text		=	affFichier
		ui_editApercu.text		=	affApercu
		ui_editTags.text			=	affTags
		ui_editNotes.text		=	affNotes
		ui_editDetail.text		=	affDetail
	)
	
	
	
		--- les Mise a jour UI ------
	fn maj_UI	= (
	
		--- les ENABLED  ---
		ui_btnCreerAssetSelection.enabled  			= (selection as array ).count > 0 
		ui_btnImporterAssetDansScene.enabled 	=  ui_listeVue.SelectedItems.count > 0 
-- 		ui_btnImporterAssetDansSceneCorona.enabled 	=  ui_listeVue.SelectedItems.count > 0 
		ui_btnImporterAssetDansSceneProxy.enabled 	=  ui_listeVue.SelectedItems.count > 0 
-- 		ui_arborescence.SelectedNode
-- 		
-- 		-- les selections --
-- 		for id in elemIDVueSelect do 
-- 			ui_listeVue.Items.item[id].selected = true
		if noeudVueSelect != undefined do 
			ui_arborescence.SelectedNode = noeudVueSelect
		
		if b_autoExpendArbo do 
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
			sort  listTagsTmp
			ui_lstBoxTags.items = listTagsTmp
		) catch ()
		
		
		
		
		afficherInfos()
	)
	
	
	
	fn majTotal = (
		maj_UI ()
		AfficherElements noeudSelect
		
	)
	
	
	---- 	initialisation de l'interface  ----
	fn initialiser_interface  = (
		
		ui_listBtns_infos = #( ui_lblNom, ui_editNom, ui_lblFichier,	ui_editFichier ,	ui_btnOuvrirFichierMax ,	ui_lblApercu	,	\
									ui_editApercu 		,	ui_btnOurvirApercu	,	ui_btnCreerApercu	,	ui_lblDetail			,	ui_editDetail		, \	
									ui_btnOurvirDetail	,	ui_btnCreerDetail	,	ui_lblTags	,	ui_editTags 		,	ui_lblNotes 	,	ui_editNotes 	,		ui_bmpDetail  )
										
-- 		-- la taille minimum de la fenetre ----
		ui_listeVue.Clear()
		case listeVueDisplay of (
			#images: (
				ui_listeVue.view = (dotNetClass "system.windows.forms.view").LargeIcon
				ui_listeVue.Columns.add "Nom" 180
				ui_listeVue.FullRowSelect = false
			)
			#liste: (
				ui_listeVue.view = (dotNetClass "system.windows.forms.view").details
				ui_listeVue.columns.add "Nom" 200
				ui_listeVue.columns.add "Verts" 70
				ui_listeVue.columns.add "Dernier import" 130
				ui_listeVue.columns.add "Nbre d'imports" 70
				ui_listeVue.columns.add "Proxy" 70
				ui_listeVue.columns.add "Détail" 70
				ui_listeVue.columns.add "Création" 130
				
				ui_listeVue.FullRowSelect = true
			)
		)
		
										
										
		---- la vue liste----
		ui_listeVue.borderstyle = (dotnetclass "System.Windows.Forms.BorderStyle").fixedsingle
		ui_listeVue.showitemtooltips = true
		ui_listeVue.gridlines = true
		ui_listeVue.checkboxes = false
		ui_listeVue.labeledit = false
		ui_listeVue.MultiSelect=true
		ui_listeVue.HideSelection = false
		ui_listeVue.allowdrop = true
		ui_listeVue.BackColor = (dotNetClass "System.Drawing.Color").fromARGB colorFondVue.r colorFondVue.g colorFondVue .b
-- 		ui_listeVue.BackColor = (dotNetClass "System.Drawing.Color").fromARGB 86 86 86
		ui_listeVue.ForeColor = (dotNetClass "System.Drawing.Color").fromARGB colorTextes.r colorTextes.g colorTextes.b
		
		---- l'arborescence----
		ui_arborescence.borderstyle = (dotnetclass "System.Windows.Forms.BorderStyle").fixedsingle
		ui_arborescence.LabelEdit = true --false--#tvwAutomatic
		ui_arborescence.allowdrop = true
		ui_arborescence.HideSelection = false
-- 		ui_arborescence.BackColor = (dotNetClass "System.Drawing.Color").fromARGB 86 86 86
		ui_arborescence.BackColor = (dotNetClass "System.Drawing.Color").fromARGB  colorFondVue.r colorFondVue.g colorFondVue .b
		ui_arborescence.ForeColor = (dotNetClass "System.Drawing.Color").fromARGB  colorTextes.r colorTextes.g colorTextes.b
		
		--- les ecouteurs ---
		fn ecouterChangeSelection		ev nd = 	maj_UI ()		
		EcouteurChangeSelection = NodeEventCallback mouseUp:true delay:1000 selectionChanged:ecouterChangeSelection 
		
		--- maj interface ---
		
		maj_UI ()
		
	)
	
	
	
	fn checkDragDropInsertionMarkStatus	 mousePos 	arg = (

		local testItem= ui_arborescence.GetNodeAt (dotNetObject "System.Drawing.Point" mousePos.x mousePos.y)
		if testItem != undefined then (
			
-- 			noeudTest = biblio.arbo.getParNomUnique 	testItem.name
				
			if testItem.name != "RECHERCHE" then (
				arg.Effect=arg.AllowedEffect
				noeudSelect = biblio.arbo.getParNomUnique 	testItem.name
				noeudVueSelect  = testItem
				
			) else (
				noeudSelect = undefined
				
			arg.Effect=dragDropEffect.none
			noeudVueSelect  = undefined
			)
			
		) else (
			noeudSelect = undefined
				
			arg.Effect=dragDropEffect.none
			noeudVueSelect  = undefined
		)
	
		
		
	)
		
	
	fn chercheTVNodeByNomUnique 	_node		_nomUnique  = (
-- 		debug (" cherche node TV : " + _nomUnique )
-- 		debug (" 	_node.name : " + _node.name )
		result = undefined
		if _node.name == _nomUnique then (
-- 			debug (" 	TROUV2   : " + _node.name )
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------- les events      -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	
	
	on ui_btnCreerAssetFichier pressed do (
		if (getListeSelection() !=undefined ) do  (
			fichierAImporter = 	getOpenFileName  caption:"Fichier à integrer dans la bibliotheque" 	\
											types:"model (*.max)|*.max|All Files (*.*)|*.*|"							\
											filename:( biblio.prefs.apercus.dossierImport + "\\")
			
			if 	fichierAImporter != undefined  do 
				biblio.ajouter.fichier  fichierAImporter
		)
	)
	
	
	on ui_btnCreerAssetDossier pressed do (
		dossier = getSavePath ""	 initialDir:biblio.prefs.apercus.dossierImport
		if dossier!=undefined do (
			biblio.ajouter.dossier 	dossier 
			biblio.prefs.apercus.dossierImport =  dossier
			biblio.prefs.enregistrer()
		)
	)
	
----- L'arborescence ------------------
	
	on ui_arborescence	 afterLabelEdit arg do
		(
			
			--print arg.label
			if arg.label!=undefined do (
				debug ("RENAME" )
				
				
				if noeudSelect != undefined do (
					noeudSelect.nom = arg.label
					biblio.arbo.ecrirefichier()
				)
				
				--- maj interface ---
				maj_UI ()
				afficherInfos()
				
			)

		)
	on ui_arborescence		 mouseUp arg do  (
		
		--else (
-- 			debug "->>>>>>>>>>>>>------------->>>>>>>>>>>>----------->GAUCHE"
			noeudClique = ui_arborescence.GetNodeAt (dotNetObject "System.Drawing.Point" arg.x arg.y)
			if noeudClique != undefined then (
				
				-- on se deplace dans l'arborescence ---
				_noeudArbo = biblio.arbo.getParNomUnique 	noeudClique.name 
				
				if _noeudArbo!=undefined then (
					
					
					if _noeudArbo.nomUnique != "RECHERCHE" /*and _noeudArbo.nomUnique != "ROOT" */ then (
						---- click droit ----
						if not (arg.Button.value__ == 1048576) then ( 
							debug "DROITE"
							biblio.menu.creerMenuArbo()
							
							
						---- click gauche ----
						) 
					)	
					AfficherElements 		_noeudArbo
					noeudSelect  = 		_noeudArbo
					noeudVueSelect = 	noeudClique
					elemSelect = #()
					elemIDVueSelect  = #()
					elemNodesVueSelect  = #()
					--else noeudSelect = noeudVueSelect = undefined
					
				)
				
			--)
			
			--- maj interface ---
			maj_UI ()
			afficherInfos()
		)	else noeudSelect = noeudVueSelect = undefined
		
	)
	on ui_arborescence 	ItemDrag 	arg do
	(
		debug " ------------- ItemDrag ARBO --------------"
		b_dragDossier = true
-- 		noeudVueSelectBack = noeudVueSelect
		
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
		noeudDrag = noeudSelect
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
-- 		
-- 		if noeudSelect.nomUnique !="RECHERCHE" then (
		
		selectionElems_NomsUniques = for elemNodes in elemNodesVueSelect collect elemNodes.name
		noeudSelecBack = noeudSelect
		elemNodesSelecBack = elemNodesVueSelect
			
		if b_dragDossier then (
			
			debug "DRAG DE DOSSIER"
			
			biblio.arbo.bouger  #( noeudDrag	)	noeudSelect  
			
		) else (
			
			debug "DRAG DE ELEMENTS"
			
			biblio.arbo.bouger  elemSelect  noeudSelect
		
		
		)
		debug ("	selectionElems_NomsUniques : " + selectionElems_NomsUniques as string )
		--- maj interface ---
		remplirTreeView 	biblio.arbo.root
		
		AfficherElements 	noeudSelect
		noeudSelecNomUnique = noeudSelect.nomUnique
		
		noeudSelect.enfants
		 
		elemeAReselect = for nomUnique in selectionElems_NomsUniques collect biblio.arbo.getParNomUnique nomUnique
			
		selectElems elemeAReselect
		
		
		
		noeudSelectmp = getTreeViewNodeByNomUnique  	noeudSelecNomUnique
		debug ("	noeudSelectmp : " + noeudVueSelect.text as string )
		if noeudSelectmp != undefined do 
			ui_arborescence.SelectedNode  = noeudSelectmp
		
		maj_UI ()
		afficherInfos()
			
		
		b_dragDossier = false
		noeudDrag 	=undefined
	)

		
		
		
----- vue de la liste des elements   ------------------
	on ui_listeVue columnClick arg do
		(
			cols = #("Nom", "Verts", "Dernier import", "Nbre d'import", "Proxy", "Détail", "Création" )
			indexColonne = arg.Column+1
			colClicked = cols[arg.Column+1]
			debug ( "indexColonne : " +indexColonne as string)
			
			case indexColonne of (
				1:	biblio.arbo.classerNoms			noeudSelect	ordreInverse:m_ordreInverse
				2:	biblio.arbo.classerVertex		noeudSelect	ordreInverse:m_ordreInverse
				3:	biblio.arbo.classerNoms			noeudSelect	ordreInverse:m_ordreInverse
				4:	biblio.arbo.classerNbrImports	noeudSelect	ordreInverse:m_ordreInverse
				5:	biblio.arbo.classerNoms			noeudSelect	ordreInverse:m_ordreInverse
				6:	biblio.arbo.classerNoms			noeudSelect	ordreInverse:m_ordreInverse
				7:	biblio.arbo.classerCreation		noeudSelect	ordreInverse:m_ordreInverse
			)
			m_ordreInverse = not m_ordreInverse
			remplirTreeView  	biblio.arbo.root
			AfficherElements 	noeudSelect
-- 			noeudSelecNomUnique = noeudSelect.nomUnique
			
			/* 
			fn classerNbrImports 	ordreInverse:false	 = (
			qsort root 	sortParNbrImports
		),
		fn classerVertex 	ordreInverse:false	 = (
			qsort root 	sortParVertex
		),
		fn classerNoms 
			
			
			
			
			
			
			
			
			colClicked = cols[arg.Column+1]
			
			case of
			(
				(colClicked == "Object Name"): sortByCol = 0
				(colClicked == "Type"): sortByCol = 1
				(colClicked == "Verts"):  sortByCol = 2
				(colClicked == "Faces"):  sortByCol = 3
				(colClicked == "Materials"):  sortByCol = 4
			)
			populateList lv
			changeForecolor() */
		)
		
		
	on ui_listeVue		 mouseUp arg do  (
		
		---- click droit ----
		if not (arg.Button.value__ == 1048576) then ( 
			debug "  ui_listeVue  DROITE"
			biblio.menu.creerMenuElements()
		---- click gauche ----
		) --else (
			debug "   ui_listeVue     GAUCHE"
			
			
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
-- 					debug (" <<< elem : " + elem as string  + " >>>")
				)
			)
			
			afficherInfos()
			
			maj_UI ()
			
	)
	
	on ui_listeVue		 mouseDown arg do  (
		
		---- click droit ----
		if not (arg.Button.value__ == 1048576) then ( 
			debug "mouseDown : DROITE"
		
		---- click gauche ----
		) else (
			debug "////////////// mouseDown : GAUCHE //////"
			
-- 			show arg 
				debug ("	arg : " + arg as string )

						
			hitNode = ui_listeVue.GetItemAt  arg.x 	arg.y
			
			if hitNode != undefined then (
				b_present = false
				for i = 0 to ui_listeVue.SelectedItems.count - 1 do 
					if ui_listeVue.SelectedItems.item[i] == hitNode then b_present = true
					
					if b_present	then (
						
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
		e.Effect = 	if e.data.ContainsFileDropList() 
								then 	e.Effect.Move 
								else 	e.Effect.None
	)
	
	

---- Edition/Infos  elements ----
	on ui_btnAfficherInfo changed state do	(
		biblio.setInfosOuvert 			state
		repositionnerElementsUI		UItaille_fenetre
	)
	
	
	on ui_editNom 	entered  txt 	do (
		if elemSelect.count == 1 do (
			elemSelect[1].nom = txt
			biblio.arbo.ecrireFichier()
			
			-- les selections --
			for id in elemIDVueSelect do 
				ui_listeVue.Items.item[id].text = txt
		)
	)
	
	on ui_editFichier 	entered  txt 	do (
		if elemSelect.count == 1 do 
			elemSelect[1].fichier = txt
		biblio.arbo.ecrireFichier()
	)

	on ui_lblApercu 	entered  txt 	do (
		if elemSelect.count == 1 do 
			elemSelect[1].apercu = txt
		biblio.arbo.ecrireFichier()
	)
	on ui_editDetail 	entered  txt 	do (
		for elem in  elemSelect do 
			elem.detail = txt
		biblio.arbo.ecrireFichier()
		afficherInfos()
	)
	on ui_editTags 	entered  txt 	do (
		for elem in  elemSelect do 
			elem.tags = txt
		biblio.arbo.ecrireFichier()
		maj_UI()
	)
	on ui_editNotes 	entered  txt 	do (
		for elem in  elemSelect do 
			elem.notes = txt
		biblio.arbo.ecrireFichier()
	)
	
	
	
	on ui_editRecherche 	entered  txt 	do (
		
		rechercheNoeud = biblio.arbo.getParNomUnique "RECHERCHE" 
		rechercheNoeud.enfants = #()
					
-- 		
		rechercheNoeud.enfants = biblio.arbo.chercherTags 	txt
		biblio.arbo.ecrireFichier ()
		
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
	
	
	
	
	
	----- Creer apercus ---------
	on ui_btnCreerApercu pressed do 
		biblio.creerApercu ()
	
	----- Creer Détails ---------
	on ui_btnCreerDetail pressed do 
		biblio.creerDetail ()
		
	
	----- import dans scene ---------
	on ui_btnImporterAssetDansScene  pressed do 
		biblio.importer.fichier elemSelect
	----- import dans scene corona mats---------
		
	on ui_btnImporterAssetDansSceneCorona  pressed do 
		biblio.importer.corona elemSelect
		
	----- import dans scene Proxy corona ---------
	on ui_btnImporterAssetDansSceneProxy  pressed do 
		biblio.importer.proxy elemSelect
		
	
	
	----- import dans scene Proxy corona ---------
	on ui_btnOurvirAperc  pressed do (
-- 		biblio.importer.proxy elemSelect
-- 		ui_btnOurvirAperc
		apercu = selectBitMap caption:"Choisir le nouvel aperçu"
		if apercu!= undefined do (
			display apercu
		)
	)
	
	
	
	
	
	--- les tags ----
	on ui_lstBoxTags selected val do  (
		
		listElems = #()
		for tag in ui_lstBoxTags.selection as array  do ( 
			join  listElems	( biblio.arbo.chercherTags 	ui_lstBoxTags.items[tag] )
		)
		
		noeudSelect = biblio.arbo.getParNomUnique "RECHERCHE" 
		noeudSelect.enfants = listElems
		noeudVueSelect = noeudParNom "RECHERCHE"  
		
		maj_UI ()
		AfficherElements  noeudSelect
	)
	
	
	
	
	on ui_progressCancel pressed do (
		cancelled = true
		setProgress ("*Annulé*") 100
	)
	
	
	
	
	on ui_btnToogleStyleVue pressed do (
		case listeVueDisplay of (
			#images: (	listeVueDisplay = #liste
							ui_btnToogleStyleVue.text = "Im"
						)
			#liste: 	(	listeVueDisplay = #images
							ui_btnToogleStyleVue.text = "Li"
						)
		)
		initialiser_interface ()
		
		AfficherElements noeudSelect
		
	)
	
	
	
	
	
	
	
	
----- events rollout ------
	on m_rollPrincipal open do (
		initialiser_interface()
	)

	on m_rollPrincipal close do (
		debug "Fermer Fenetre"
		fermer_interface()
		biblio.prefs.fenetre.isOpen = false
		updateToolbarButtons()
		biblio.prefs.enregistrer()
	)
	
	
	on m_rollPrincipal resized 	tailleRollOut	 do (
		
		repositionnerElementsUI	tailleRollOut
		biblio.prefs.fenetre.taille 	= 	tailleRollOut
		
		
		posRollOut = GetDialogPos 	biblio.m_rollPrincipal
		
		-- si Edition est accroché on le deplace avec ---
		if biblio.prefs.fenetre.accroche do (
			
			bordureDialogBox 	= 		[22,5]
			coinAccroche 			= 		[ posRollOut.x + biblio.m_rollPrincipal.width, posRollOut.y ]
			coinAccroche 			+= 	bordureDialogBox
			
			SetDialogPos 	biblio.m_rollEditerTags 	coinAccroche
			-- 	biblio.setPosRolloutEdition 					coinAccroche
			
		)
		
-- 		biblio.prefs.enregistrer()
		
	)
	
	on m_rollPrincipal moved 	posRollOut	 do (
		
		biblio.setPosRolloutPrincipal 	posRollOut
		biblio.prefs.fenetre.pos 	= 	posRollOut
		
		-- si Edition est accroché on le deplace avec ---
		if biblio.getEditionAccroche() do (
			
			bordureDialogBox 	= [22,5]
			coinAccroche 			= [ posRollOut.x + biblio.m_rollPrincipal.width , posRollOut.y ]
			coinAccroche 			+= bordureDialogBox
			
			SetDialogPos 	biblio.m_rollEditerTags 	coinAccroche
			biblio.setPosRolloutEdition 					coinAccroche
			
		)
		
-- 		biblio.prefs.enregistrer()
		
	)
	
) -- fin rollout





