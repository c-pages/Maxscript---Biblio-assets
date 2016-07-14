/* #######################################################################################################################

	2017 Christophe Pages (http://www.c-pages.fr) 

##########################################################################################################################
	
	Bibiotheque d'assets 
	
##########################################################################################################################

	Struct gerant les conversions vers Corona. 
	Utilise "Bibliotheque_conversions_corona.ms" (customisation du converter fournis poar Corona) pour faire les conversions.
	
######################################################################################################################## */ 



fileIn "$userScripts\biblio\Bibliotheque_conversions_corona.ms"

---------------------------------------
------ La structure convertion ------
-- gère la convertion
---------------------------------------
struct Conversions (
	biblio, 
	
	public 
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

