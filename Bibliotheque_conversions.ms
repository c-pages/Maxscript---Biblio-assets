

fileIn "$userScripts\bibliotheque\Bibliotheque_conversions_corona.ms"

---------------------------------------
------ La structure convertion ------
-- gère la convertion
---------------------------------------
struct Conversions (
	biblio, 
	public 
		dossierProxy 	= "C:\\Users\\kris\\AppData\\Local\\Autodesk\\3dsMax\\2014 - 64bit\\ENU\\scripts\\Bibliotheque\\proxy" ,
		prefixProxy 		= "prox_",
	/* 
		fn creerNomProxy			= (
			_prefix = prefixProxy
			
			local nouveauNom =""
			listeApercus = getFiles ( dossierProxy + "\\*.cgeo" )
			
			trouveNouveauNom = false
			i = 0
			while not trouveNouveauNom do (
				present = false
				nouveauNom = _prefix + i as string 
				for app in listeApercus do (
					if getFilenameFile app == nouveauNom
						do present = true
				)
				if present == false then trouveNouveauNom = true
				else		i += 1
			)
			debug ("nouveau nom apercu : " + nouveauNom )
			nouveauNom  
		), */
	public
		fn matsToCorona  	_listeObjets = (
			CoronaConverter.convertNodeArray 	_listeObjets  ErrorReport:false
		),
		fn objsToProxy 	_listeObjets 	_element = (
			
			CoronaConverter.convertNodeArray 	_listeObjets  ErrorReport:false
			
			clearSelection ()
			select _listeObjets
			
			-- quelques params ----
			nom = "_" + prefixProxy + _element.getIndexUnique() as string 
			CoronaProxyExporter.settings.exportToSingle 			= true
			CoronaProxyExporter.settings.outputPath					=	dossierProxy						
			CoronaProxyExporter.settings.exportToSingleName	 	= nom
			
			--- conversion ---
			CoronaProxyExporter.runExport	 silent:false 
			_proxy = selection[1]
			_proxy.name = _element.nom
			
			_element.proxy = dossierProxy + "\\" + nom   + ".max"
			
			saveNodes  #(_proxy)  _element.proxy quiet:true
			
			biblio.arbo.ecrireFichier()
			biblio.m_rollPrincipal.afficherInfos()

		)
		
		
) -- fin struct Convertion --

