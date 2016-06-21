

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

	public
		fn matsToCorona  	_listeObjets = (
			CoronaMatConverterPerso.convertNodeArray 	_listeObjets  ErrorReport:false
		),
		
		fn objsToProxy 	_listeObjets 	_element = (
			
			CoronaMatConverterPerso.convertNodeArray 	_listeObjets  ErrorReport:false
			
			clearSelection ()
			select _listeObjets
			
			-- quelques params ----
			nom = "_" + prefixProxy + _element.getIndexUnique() as string 
			CoronaProxyExporterPerso.settings.exportToSingle 			= true
			CoronaProxyExporterPerso.settings.outputPath					=	dossierProxy						
			CoronaProxyExporterPerso.settings.exportToSingleName	 	= nom
			
			--- conversion ---
			CoronaProxyExporterPerso.runExport	 silent:false 
			_proxy = selection[1]
			_proxy.name = _element.nom
			
			_element.proxy = dossierProxy + "\\" + nom   + ".max"
			
			saveNodes  #(_proxy)  _element.proxy quiet:true
			
			biblio.arbo.ecrireFichier()
			biblio.m_rollPrincipal.afficherInfos()

		)
		
		
) -- fin struct Convertion --

