


----------------------------------------
------ La structure Appercu --------
-- gère la creation des appercu  ---
----------------------------------------
struct Appercus (
	
	public
		biblio,
		arbo,
		
	-- parametres de rendu --
	public
		tailleAppercu 			= [256,256],
		
	private
		noiseLevel 				= 7,
		noiseLevelDetail		= 11,
		denoiseAmount 		= .4,
		exposition 				= -5,
-- 		fichierRendu 			= "C:\\Users\\kris\\AppData\\Local\\Autodesk\\3dsMax\\2014 - 64bit\\ENU\\scripts\\Bibliotheque\\appercus\\appercu.jpg",
		nomAppercu 			= "app_",
		nomDetail 				= "det_",
		dossierAppercus 		= "C:\\Users\\kris\\AppData\\Local\\Autodesk\\3dsMax\\2014 - 64bit\\ENU\\scripts\\Bibliotheque\\appercus",
		cameraAngleVue 		= 40,
		cameraAngleVueDetail 		= 9,
		temperatureRendu 	= 5000,
		
		-- la camera --
		cameraAppercu,
		
		-- gestion calques pour isolation --
		nomCalqueImport 		= "ImportTemp",
		a_calquesScene 			=#(),
		a_calquesScene_etats 	=#(),
		calqueActif,
		calqueImport,
		
		-- pour import dans scene --
		a_objetsScene 	= #(),
		a_objetsImport 	= #(),
		a_calquesImport = #(),
		a_lumieresEtats	= #(),
		BB_import,
		centre_import,
		longueurMax_import,
		
		-- stockage de l'ancien moteur de rendu et ses parametres -
		moteurRenduPrecedant,
		
-- 	private
	public
		
		fn creerNomRendu	_prefix= (
			local nouveauNom =""
			listeAppercus = getFiles ( dossierAppercus + "\\*.jpg" )
			
			trouveNouveauNom = false
			i = 0
			while not trouveNouveauNom do (
				present = false
				nouveauNom = _prefix + i as string 
				for app in listeAppercus do (
					if getFilenameFile app == nouveauNom
						do present = true
				)
				if present == false then trouveNouveauNom = true
				else		i += 1
			)
			nouveauNom  
		),
		
		
		
		
		fn creerCalqueImport = (
			-- on creer le calque dans lequel on va faire l'import  et on l'initialise --
			calqueImport 				= LayerManager.newLayerFromName nomCalqueImport
			calqueImport.on 			= true
			calqueImport.lock  		= false
			calqueImport.current 	= true
		),
		fn isoler  = (
			debug "appercu->isoler"
			-- on vide les tableau --
			a_calquesScene 			=#()
			a_calquesScene_etats 	=#()
			
			-- on enrigistre l'état des calques de la scene initiale et on les cache --
			for i=0 to (LayerManager.count-1) do (
				calqueTmp = LayerManager.getlayer i
				append a_calquesScene			calqueTmp
				append a_calquesScene_etats 	calqueTmp.on
				if calqueTmp.current do calqueActif = calqueTmp
				calqueTmp.on = false
			)
			
			
		), -- FIN isoler
		fn desIsoler  = (
			
			debug "appercu->desIsoler"
			
			-- on remet les calques dans leur état d'origine -- 
			for i=1 to a_calquesScene.count do (
				layerTemp = a_calquesScene[i]
				layerTemp.on = a_calquesScene_etats[i]
			)
			calqueActif.current = true
			
			-- on supprime le calque d'import --
			LayerManager.deleteLayerByName  nomCalqueImport
			
		),	-- FIN 	desIsoler
		
		
		fn Importer		_fichier = (
			
			debug ( "appercu->Importer : " + _fichier )
			
			-- on vide les tableau --
			a_objetsImport = #()
			a_calquesImport = #()
			
			-- on liste les objets de la scene avant import --
			a_objetsScene = for i in objects collect i
			
			-- on merge le fichier --
			mergeMaxFile _fichier #select #autoRenameDups #renameMtlDups #neverReparent
			
			-- on liste les objets importés --
			for obj in Objects do (
				bpresent = false
				for objInitial in a_objetsScene do 
					if obj == objInitial do bpresent =true
				if not bpresent do append a_objetsImport obj
			)
			
			-- on les mets les objets importés dans le calque d'import --
			for objImport in a_objetsImport do 
				if objImport != undefined do (
					append a_calquesImport	objImport.layer
					(LayerManager.getLayerFromName nomCalqueImport ).addnode objImport
				)
			
		),	--FIN Importer_Fichier_Pour_Edition
		fn retirerImport = (
			
			debug "appercu->retirerIzmport"
			
			-- on supprime les objets --
			for objImport in a_objetsImport do try delete objImport catch ()
			
			-- on supprime les claques --
			for calqueImport in a_calquesImport do (
				b_present = false
				for calqueScene in a_calquesScene do 
					if calqueImport == calqueScene do b_present = true
				try (
					if not b_present do LayerManager.deleteLayerByName  calqueImport.name
				) catch ( 
					debug ("ERREUR suppression calque : " /*+ calqueImport.name*/ ) 
				)
			)
			
		),
		
		
		fn calculerBB 	_objets	=	(
			
			-- on calcul le bounding box de l'ensemble des objets --
			BB_result = nodeLocalBoundingBox  _objets[1]
			for obj in _objets where ( superclassof obj != light  	and	superclassof obj != camera 	and 	superclassof obj != helper	and 	superclassof obj != shape and classOf obj != Targetobject and not obj.ishidden )	do (
				
				-- XForm pour eviter probleme de taille des fois, à vois si ca fout pas le bordel --
-- 				ResetXForm  obj
				
				BoundingTemp = nodeLocalBoundingBox  obj
				
				if BoundingTemp[1].x < BB_result[1].x 	do 	BB_result[1].x = BoundingTemp[1].x 
				if BoundingTemp[1].y < BB_result[1].y 	do 	BB_result[1].y = BoundingTemp[1].y 
				if BoundingTemp[1].z < BB_result[1].z 	do 	BB_result[1].z = BoundingTemp[1].z 
					
				if BoundingTemp[2].x > BB_result[2].x 	do 	BB_result[2].x = BoundingTemp[2].x 
				if BoundingTemp[2].y > BB_result[2].y 	do 	BB_result[2].y = BoundingTemp[2].y
				if BoundingTemp[2].z > BB_result[2].z 	do 	BB_result[2].z = BoundingTemp[2].z 					
				
			)
			
			-- no calcul quelques données util pour la mise en place de la scene de rendu --
			centre_import = [ ( BB_result[2].x - BB_result[1].x )/2 + BB_result[1].x, ( BB_result[2].y - BB_result[1].y )/2 +BB_result[1].y, ( BB_result[2].z - BB_result[1].z  )/2 + BB_result[1].z ]
			BB_import = BB_result
			
			BBLargeur	=	BB_import[2].x - BB_import[1].x
			BBLongeur	=	BB_import[2].y - BB_import[1].y
			BBHauteur	=	BB_import[2].z - BB_import[1].z
-- 			longueurMax_import = amax BBLargeur  BBLongeur  BBHauteur
			hypot_1  = sqrt   ( BBLargeur*BBLargeur   + BBLongeur*BBLongeur)   
			longueurMax_import = sqrt ( hypot_1*hypot_1 + BBHauteur*BBHauteur)
			
			
			-- debug --
			pt = point name:"CENTRE" pos:centre_import size:longueurMax_import
			
			return BB_result
		),
		
		fn poserCamera 	detail:	 = (
			local CameraPosX
			
			marge = longueurMax_import * 0
			distCam = tan ( cameraAngleVue/2) * ( longueurMax_import + marge )  *3
			
			debug  ( "distCam : " + distCam as string )
			
			if detail then 
				CameraPosX = centre_import.x  + distCam * .5
			else
				CameraPosX = centre_import.x  - distCam * .5
			
			CameraPosY = centre_import.y - distCam
			CameraPosZ = centre_import.z + distCam  * .4
			
			TargetX =  centre_import.x
			TargetY =  centre_import.y
			TargetZ =  centre_import.z
			if ( not detail ) then
				Capture_FOV = cameraAngleVue
			else 
				Capture_FOV = cameraAngleVueDetail
			
			cameraAppercu =  Targetcamera fov:Capture_FOV pos:[CameraPosX,CameraPosY,CameraPosZ] name:"Camera_appercu" orthoProjection:false target:(Targetobject transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] [TargetX,TargetY, TargetZ] ) name:"TargetCapture") 
			viewport.setCamera cameraAppercu
			
			(LayerManager.getLayerFromName nomCalqueImport ).addnode cameraAppercu
			
			-- on l'ajoute à la liste import pour le suppr à la fin --
			append a_objetsImport cameraAppercu
			
			cameraAppercu
			
		),
		fn poserSol 		 = (
			
			
			TailleSol = longueurMax_import * 100
			Extrusion = longueurMax_import * 20
			
			sol = Plane length:TailleSol width:TailleSol pos:[centre_import.x,centre_import.y,BB_import[1].z + Extrusion ] isSelected:off   lengthsegs:2 widthsegs:2
			
			converttopoly Sol
			sol.EditablePoly.SetSelection #Face #{1..16}
			sol.extrudeFaces -Extrusion
			addModifier sol (TurboSmooth ())
			sol.modifiers[1].iterations = 3
			
			(LayerManager.getLayerFromName 	nomCalqueImport ).addnode Sol

			matSol = CoronaMtl ()
-- 			matSol.diff_color = (execute (CaptureCouleurSol as string) ) 
-- 			matSol.refl_weight = CapturesolReflexion
-- 			matSol.opts_ao_distance = ( BBLargeur +	BBLongeur + BBHauteur) / 3 / 2
			
			sol.material = matSol
			
			-- on l'ajoute à la liste import pour le suppr à la fin --
			append a_objetsImport sol
			sol
		),		
		fn preparerLumieres		 =	(
			
			-- l'état des lumieres avant appercu --
			a_lumieresEtats = #()
			for L in Lights do (
					append a_lumieresEtats L.on
					L.on = false
			)
			
			posLum = longueurMax_import * 2
			
			debug ("posLum = " + posLum as string )
			
			-- creation de la lumiere pour l'appercu --
			soleilCorona = CoronaSun targeted:on name:"Soleil_appercu" pos:[centre_import.x + .5*posLum ,centre_import.y - 2*posLum, centre_import.z + 2*posLum] isSelected:off  target:(Targetobject transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] [centre_import.x,centre_import.y, centre_import.z] ) name:"TargetLumiereCapture") 
			append a_objetsImport 	soleilCorona
			
			(LayerManager.getLayerFromName 	nomCalqueImport ).addnode soleilCorona
		),
		fn preparerRendu 		detail:  =(
			
			debug "appercu->preparerRendu"
			
			-- calcul du BB et du centre de l'import --
			calculerBB  a_objetsImport
-- 			
-- 			-- le calque des element du rendu ---
-- 			creerCalqueImport()
			
			-- conversion des materiaux  --
			biblio.conversion.toCorona  a_objetsImport
			
			-- on s'occupe des lumieres -- 
			preparerLumieres()
			
			-- la camera --
			poserCamera detail:detail
			
			-- le sol --
			poserSol()
			
			-- le moteur de rendu
			nomMoteur = classof renderers.current as string
			if ( findString nomMoteur "Corona" != 0 ) do (
				moteurRenduPrecedant = renderers.current
				renderers.current = Corona_1_4()
				renderers.current.adaptivity_targetError 		= if detail then noiseLevelDetail else noiseLevel
				renderers.current.denoise_blendAmount		= denoiseAmount
				renderers.current.colorMap_simpleExposure 	= exposition
				renderers.current.vfb_type							= 2	-- 0:pour cacher le VFB corona --
				renderers.current.bg_texmap						= CoronaSky()
				renderers.current.bg_source						= 1
				renderers.current.denoise_filterType			= 2
				renderers.current.colorMap_colorTemp			= temperatureRendu
			)
			
		),
		
		
		
		fn rendre detail: =(
			debug "appercu->rendre"
			local nomRendu
			if not detail then 
				nomRendu = dossierAppercus + "\\" + ( creerNomRendu nomAppercu ) + ".jpg"
			else			
				nomRendu = dossierAppercus + "\\" + ( creerNomRendu nomDetail ) + ".jpg"
			
			Rendu = 	render cameraAppercu 			outputSize:tailleAppercu   \
							outputfile:nomRendu 			vfb:false 			quiet:false	\
							cancelled:&TestCancelled	 	missingExtFilesAction:#logmsg
			
-- 			display  Rendu
			nomRendu
		),
		fn remettreRenduInitial = (
			renderers.current = moteurRenduPrecedant
		),
		
		
		
		
		
		fn nettoyerAppercusOrphelins = (
			listeFichiers = getFiles ( dossierAppercus + "\\*.jpg" )
			listeElements = arbo.getElements()
			for fichier in listeFichiers do ( 	
				present = false
				if getFilenameFile fichier != "app_vide" do (
					for elem in listeElements do (
						if getFilenameFile fichier == getFilenameFile elem.appercu  do 
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
-- 			for element in arbo.root
		),
		
		
	public
		fn creer		_fichier 	detail:false	= (
			
			local nomAppercu
			local sceneCourante = ""
			holdMaxFile() 
-- 			if maxFileName != "" do
-- 				sceneCourante = maxFilePath + maxFileName
-- 			if checkForSave() do (
				
				resetMaxFile #noPrompt
				
				creerCalqueImport()
				Importer 	_fichier
				preparerRendu 	detail:detail
				nomAppercu = rendre  detail:detail
				debug ( "--------------> NOM APPERCU = " + nomAppercu )
				
-- 			)
			fetchMaxFile quiet:true
-- 			if sceneCourante != "" do		loadMaxFile  	sceneCourante 	quiet:true
			nomAppercu
			
		)
-- 		,
-- 		fn creer	_fichier = (
-- 			local sceneCourante = ""
-- 			if maxFileName != "" do
-- 				sceneCourante = maxFilePath + maxFileName
-- 			if checkForSave() do (
-- 				loadMaxFile  	_fichier 	quiet:true
-- 				a_objetsImport = objects as array
-- 				preparerRendu()
-- 				rendre()
-- 			)
-- 			if sceneCourante != "" do		loadMaxFile  	sceneCourante 	quiet:true
-- 			
-- 		)
) -- fin struct Appercu --


