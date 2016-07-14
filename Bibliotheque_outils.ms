/* #######################################################################################################################

	2017 Christophe Pages (http://www.c-pages.fr) 

##########################################################################################################################
	
	Bibiotheque d'assets 
	
##########################################################################################################################

	Struct regroupant differentes fonctions de manipulations de node et de materiaux.
	
######################################################################################################################## */ 


struct boiteOutils  (
	private
	
		-- supprime tout les groupes, helpers, cameras, lumieres ....
		fn collapseNodes 		_nodes = (
			
			explodeGroup _nodes 
			
			local GroupAsupprimer = #()
			local newMesh
	
			for i=1 to _nodes.count do (
-- 				debug ("collapse : " + i as string + "/" + _nodes.count as string + " objects")
-- 				format "collapse : %/% objects\n"  i  _nodes.count  
				BoolDeleteObjet = false
				ObjetTemp = _nodes[i]
				
				if IsValidNode ObjetTemp do (				
					
					if not canConvertTo ObjetTemp Editable_Poly 	then 	
						append GroupAsupprimer 	ObjetTemp
					
					else	if ObjetTemp.isHidden 				then   delete ObjetTemp
					else (
						
						if ObjetTemp.modifiers.count != 0 do collapseStack ObjetTemp
						
						if superclassof ObjetTemp == shape do 
							if ObjetTemp.render_renderable do 
								ObjetTemp.displayRenderMesh = true
						
						if classof ObjetTemp != Editable_Poly do convertToPoly ObjetTemp
						
						if i != 1 then 
							polyop.attach newMesh 	_nodes[i]
						else newMesh = _nodes[1]
					)
						
					
				)
				
			)
			
			clearselection()
			for i=1 to GroupAsupprimer.count do
				selectmore GroupAsupprimer[i]
			delete selection
			
			newMesh
			
		),

		
		
		
		fn nettoyerMultimat 	ObjetCible = (
			
			local SubMatNouveau, Mat_a_nettoyer, IdMAtEnDouble, SubMatOrigine, MateriauRemplacant, aListeDesSubMatRemplacant, bPremierPassage
			Mat_a_nettoyer = ObjetCible.material
			
			if classof Mat_a_nettoyer == Multimaterial then (
				
				MateriauRemplacant = Multimaterial numsubs:0 name:(ObjetCible.name + "_Mat_multi")
				MateriauRemplacant[1] = undefined
				aListeDesSubMatRemplacant = #()
				aListe_ID_SubMatRemplacant = #()
				append aListeDesSubMatRemplacant Mat_a_nettoyer[1]
				NombreUndefined = 0

				for i=1 to Mat_a_nettoyer.count do (
					
					SubMatOrigine = Mat_a_nettoyer[i]
					
					if SubMatOrigine != undefined then 	(					
						TestDejaPresent = false
						IDOrigine = Mat_a_nettoyer.materialIDList[i-NombreUndefined]						
						for j = 1 to aListeDesSubMatRemplacant.count do (
							SubMatNouveau = aListeDesSubMatRemplacant[j]
							if SubMatNouveau.name == SubMatOrigine.name then (
								TestDejaPresent = true
								IdMAtEnDouble = J
							) 
						)
						
						if TestDejaPresent  == false then (
							append aListeDesSubMatRemplacant SubMatOrigine
							IDDestination = aListeDesSubMatRemplacant.count 
							ObjetCible.EditablePoly.selectByMaterial IDOrigine
							ObjetCible.EditablePoly.setMaterialIndex IDDestination 1
						)	else (
							if classof ObjetCible != Editable_Poly do convertToPoly ObjetCible
							
							IDDestination = IdMAtEnDouble 
							ObjetCible.EditablePoly.selectByMaterial IDOrigine
							ObjetCible.EditablePoly.setMaterialIndex IDDestination 1
						)
						
					)  else  NombreUndefined = NombreUndefined + 1
				)
				MateriauRemplacant.count = aListeDesSubMatRemplacant.count 
				for i=1 to aListeDesSubMatRemplacant.count do (
					MateriauRemplacant[i] = aListeDesSubMatRemplacant[i]
				)
				ObjetCible.material = MateriauRemplacant
			)
			
		) ,	-- FIN fnNettoitMultimat
		
/* 
		fn collapseNodes 	Group_ANettoyer = (
			
			-- on suppreime tout les groupes ----
			GroupTemp = nettoieGroups	 Group_ANettoyer
					
			
			--	COLLAPSER TOUT-------------------------------------------------			
			for i=2 to GroupTemp.count do (
				ObjetTemp = GroupTemp[i]
				if IsValidNode  ObjetTemp  do (
					if ObjetTemp.modifiers.count != 0 do collapseStack ObjetTemp
					
					if superclassof ObjetTemp == shape do 
						if ObjetTemp.render_renderable do 
							ObjetTemp.displayRenderMesh = true
					
					if classof ObjetTemp != Editable_Poly do convertToPoly ObjetTemp
					
					polyop.attach ObjetTemp GroupTemp[i-1]
				)
			)
			
			
			groupTemp = #(groupTemp[groupTemp.count])
			
			dummyTemp = point pos:[0,0,0] size:2
			CenterPivot  groupTemp[1]
			BoundingTemp = nodeGetBoundingBox   groupTemp[1] dummyTemp.transform
			groupTemp[1].pivot.z = BoundingTemp[1].z
			groupTemp[1].pos = [0,0,0]
			delete dummyTemp
			
			aListe_ObjetsImport = groupTemp
			
			groupTemp[1]
			
		),	-- FIN fnCollapseGroup */
		
	public
	
	
		fn viderScene = (
			
			-- on se place sur le calque 0 ----
			calque_0 =  LayerManager.getLayerFromName "0"
			calque_0.current  = true
			calque_0.on = true
			
			---- o vide les calques de leurs objects ----
			calquesASupprimer = #()
			for i = 0 to LayerManager.count  - 1 do (				
 				calque =  LayerManager.getLayer i  
				
				clearSelection()
				calque.select   true
				selec = ( selection as array )
				for nd in selec do
					try delete nd catch ()
				
				if calque.name != "0" then
					append calquesASupprimer 	calque
				
			)
			
			---- o supprimer les calques ----
			while calquesASupprimer.count != 0 do (
				calque = calquesASupprimer[calquesASupprimer.count]
				LayerManager.deleteLayerByName calque.name
				deleteItem calquesASupprimer ( calquesASupprimer.count )
			)
			
			--- les xrefs ---
			xrefs.deleteAllXRefs()
			
			---- les populates ---
			actionMan.executeAction 2061898532 "3"
			
		),
		fn applatir  _nodes =(
			
			grpnodes = _nodes 
			
-- 			grpnodes = nettoieGroups  		grpnodes
			newMesh  = collapseNodes		grpnodes			
-- 			nettoyerMultimat						newMesh
			
			newMesh
		)
		,		
		
		fn compterVertex 	_nodes = (
			nbrVertex = 0
			for obj in _nodes do 
				try nbrVertex += obj.verts.count catch ()
			debug (" NOMBRE DE VERTEX : " + nbrVertex as string )
			return nbrVertex
		)
-- 		compterVertex (selection as array )

		
		
		
		
	) --- fin struct -----------------
	
	
	
	
	
	
	
	