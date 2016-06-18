

fileIn "$userScripts\bibliotheque\Bibliotheque_conversions_corona.ms"

---------------------------------------
------ La structure convertion ------
-- gère la convertion
---------------------------------------
struct Conversions (
	public
		fn toCorona  	_listeObjets = (
			CoronaConverter.convertNodeArray 	_listeObjets  ErrorReport:false
		)
		
) -- fin struct Convertion --

