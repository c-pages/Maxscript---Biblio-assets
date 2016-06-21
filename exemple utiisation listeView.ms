
/*
fn compterVertexScene = (
	nbrVertex = 0
	for obj in objects do nbrVertex += getNumVerts obj
	format "nbrVertex :%\n" nbrVertex
)
compterVertexScene ()

*/


-- Stat man

-- A handy tool for scene organisation, group renaming, optimisation, viewing statistics of objects in the scene and bulk exporting
-- Easy to use, helps keep track of scene large or small
-- Batch exporter built in

-- A JamTools production
-- BenAndrewHearn@gmail.com
-- BenHearnDesigns.webs.com

macroscript StatMan category:"#JamTools"
(	
	--variables for the script
	local mySelectedObjects = #() --Master array of objects in the scene
	local selectionArr = #() --The array of selected items from the list and scene
	local objArrIndex = #() --The indices of the objects selected
	local itemsSelected = #()
	
	local meshArray = #() --Array for mesh objects
	local nonMeshArray = #() --Array for non mesh objects
	local masterMatArray = #() --Material count array
	local faceArr = #() -- An array to keep the number of faces in the selection
	
	local itemsInSelection
	local allObjects = $* --good way of getting all objects in scene
	
	local previousSel = #() --Array that holds the selection you had before doing something in the list like renaming etc.
	local previousSelIndex = #() --Array that holds the index numbers of the previous selection
	
	local isCopied = false -- flag to say whether you have copied the object or not
	local gatheredMats = false
	
	--Bit flag to save memory and time
	-- 0 = Sort by name
	-- 1 = Sort by Type
	-- 2 = Sort by Verts
	-- 3 = Sort by Faces
	-- 4 = Sort by Materials
	local sortByCol = 0
	local matID
	local matNum
	
	local	fileNamePrefix = getfilenameFile maxfileName + "_" --gets the maxfilename and assigns it to a variable
	
	try (destroyDialog theRollout) catch() -- I the dialog is already open then it is detroyed and re-opened	
	--Create a rollout and specify the width
	rollout theRollout "Stat Man" width:750 height:1000
	(
		--Create the dotnet listview		
		--The forms class represents a window or dialog box for an applications UI (for list boxes this is ideal)
		dotNetControl lv "system.windows.forms.listView" pos:[13,7] width:725 height:850
		
		--Adds some buttons and text boxes to the rollout
		edittext suffix_txt "Object Name:  " pos:[10,895] width:300 height:15 fieldwidth:200
		edittext prefix_preTxt "Custom prefix:" pos:[10,925] width:300 height:15 fieldwidth:200
		
		button addFileNameButton "Add filename as prefix" pos:[10,960] width:120 height:25
		button selectFromScene "Select from scene" pos:[140,960] width:120 height:25
		button refreshButton "Refresh" pos:[270,960] width:120 height:25
		button Export "Export" pos:[400,960] width:120 height:25
		
		label numOfObj_lbl "" pos:[10,865] width:120 height:25
		label objectsSelected_lbl "Items selected: " pos:[150,865] width:120 height:25
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		-- initialises the litview and sets up the properties inside it
		fn	initLv lv =
		(
			--Set up the forms view
			lv.view = (dotNetClass "system.windows.forms.view").details
			lv.FullRowSelect = true --Set so the fullw idth of the listview is selected and not just the first column
			lv.GridLines = true --Show lines between items
			lv.MultiSelect = true -- Allow for multiple selections
			lv.backcolor = (dotNetClass "System.Drawing.Color").fromARGB 198 226 255 --Sets thwe background colour of the listview to slategrey
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
				
		--Adds columns to the listview
		fn addColumns lv columnsAr =
		(
			lv.columns.add columnsAr[1] 375
			lv.columns.add columnsAr[2] 120
			lv.columns.add columnsAr[3] 70
			lv.columns.add columnsAr[4] 70
			lv.columns.add columnsAr[5] 69
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------

		--Function that compares string names from objects passed into it
		fn compareNames str1 str2 = 
		(
			stricmp str1.name str2.name --does a string comparison on the two objects passed into it using their names
		)
		
		fn compareType str1 str2 =
		(
			str1 = classof str1 as string
			str2 = classof str2 as string
			stricmp str1 str2
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		-- Organises by vert count
		fn compareVerts v1 v2 =
		(			
			local d  = v1.verts.count - v2.verts.count
			
			case of
			(
				(d < 0.): 1
				(d > 0.): -1
				default: 0
			)
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		-- Organises by face count
		fn compareFaces f1 f2 =
		(
			local d = f1.faces.count - f2.faces.count
			
			case of
			(
				(d < 0.): 1
				(d > 0.): -1
				default: 0
			)
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		-- Organises by material count
		fn compareMaterials m1 m2 =
		(			
			local d = getUserProp m1 "IDcount" - getUserProp m2 "IDcount"
			
			case of
			(
				(d < 0.): 1
				(d > 0.): -1
				default: 0
			)
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		fn createMaterialArray  =
		(			
			-- this function gets the objects and count the number of faces per each object, runs through them and gets the face material id
			-- If the face material ID is unique then it will append the array and the array is then counted
			-- This will be used to store the material counts of the objects in the scene
			
			matID =1
			matNum = 0
			local matArr = #()			
			local copyOfObj

			masterMatArray = #() --Clear the array for resetting
			
			for i in mySelectedObjects do
			(
				mat = i.material
				--If the object is neither editable poly, mesh or patch then the number oif materials assigned cannot be counted
				--Therefore it must be either 0 or 1
				if(classof i !=  Editable_Poly and classof i != Editable_Mesh and classof  i != Editable_Patch and classof i != PolyMeshObject) then
				(
					if(mat != undefined) then
					(
						setuserprop i "IDcount" 1
					)
					else
					(
						setuserprop i "IDcount" 0
					)
				)
				else
				(
					if(classof mat != MultiMaterial) then
					(
						if(mat != undefined) then
						(
							setuserprop i "IDcount" 1
						)
						else
						(
							setUserProp i "IDcount" 0
						)
					)
					else
					(
						--Checking that the object is a mesh or patch, if so then it makes a copy and converts it to a poly
						-- The copied flag is set to true so that later the pobject copied can be deleted
						if(classOf i == Editable_Mesh or classOf i == Editable_Patch or classof i == PolyMeshObject) then
						(
							originalObj = i --store i in a variable
							copyOfObj = copy i --make a copy
							convertToPoly copyOfObj --convert the copy to poly object
							isCopied = true --Sets the copied flag
						)
						
						local numberOfSubs = mat.numsubs
						if(isCopied == false) then
						(
							for j = 1 to numberOfSubs do
							(
								i.selectbymaterial matID --Select faces on the object based on the material ID given
								
								faceArr = getFaceSelection i -- gets the faces selected at the time
								
								if(faceArr.numberset != 0) then --If there is something in the face array 
								(
									matNum += 1 --Increase the number corresponding to the number of materials on the object
								)
								matID += 1 --Increase the material ID that the faces are selected by
							)
							deselect i.faces
							append masterMatArray matNum
							setuserprop i "IDcount" matNum
						)
						else
						(
							for j = 1 to numberOfSubs do
							(
								copyOfObj.selectbymaterial matID --Select faces on the object based on the material ID given
								
								faceArr = getFaceSelection copyOfObj -- gets the faces selected at the time
								
								if(faceArr.numberset != 0) then --If there is something in the face array 
								(
									matNum += 1 --Increase the number corresponding to the number of materials on the object
								)
								matID += 1 --Increase the material ID that the faces are selected by
							)
							deselect copyOfObj.faces
							setuserprop i "IDcount" matNum
							delete copyOfObj
							isCopied = false
						)
						
						matNum = 0
						matID = 1
					)
				)	
			)
		)	
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		--Function to separate and sort the obejcts in the scene based on their vert counts, face counts etc.
		fn separateAndSort =
		(
			meshArray = #()
			nonMeshArray = #()
			allObjects = $*
			
			--separates the objects in the original array into two separate arrays of meshes and non meshes
			for i in allObjects do
			(
				if(sortByCol != 4) then --sort by regular mesh vs nonmesh properties
				(
					if(classof i !=  Editable_Poly and classof i != Editable_Mesh and classof  i != Editable_patch and classof i != PolyMeshObject)then
					(
						append nonMeshArray i
					)
					else
					(
						append meshArray i
					)
				)
			)
			
			--after sorting between the non-meshes, meshes and  valid materials the qsort runs through the valid arrays
			case of
			(
				(sortByCol == 2): qsort meshArray compareVerts
				(sortByCol == 3): qsort meshArray compareFaces
				(sortByCol == 4): qsort mySelectedObjects compareMaterials
				default: print("sort has failed")
			)
			
			
			--Takes the 2 mesh and non-mesh arrays and stitches them together
			--Then it runs through the newly stitched mesh array and adds them to the original mySelectedObjects
			if(sortByCol != 4) then
			(
				mySelectedObjects = #()
				--Stitches the two arrays together then adds them to the mySelectObjects array
				for i in nonMeshArray do
				(
					append meshArray i
				)
				for j in meshArray do
				(
					append mySelectedObjects j
				)
			)
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		--Function to populate the list, passed in lv as a parameter
		fn populateList lv =
		(
			fileNamePrefix = getfilenameFile maxfileName + "_" --gets the maxfilename and assigns it to a variable
			local listObjects = dotNetObject "System.Windows.Forms.listViewItem"
			lv.items.clear() --clears the list view items
			local	prefixNum = #() --sets up empty arrays
			mySelectedObjects = #() --clears array
			numOfObj_lbl.text = ("Items in scene: " + allObjects.count as string) -- assigning the number of objects in the scene to the label
			
			--Collects the objects in the scene and puts them in the array, the qSort function is then called and they are sorted alphabetically
			for i in allObjects do
			(
				append mySelectedObjects i
			)
			
			if(gatheredMats == false)then
			(
				createMaterialArray()
			)
			
			--Re populates the list based on what column has been clicked, by default it sorts it by name
			case of
			(
				(sortByCol == 1): qsort mySelectedObjects compareType --type
				(sortByCol == 2): separateAndSort() --verts
				(sortByCol == 3): separateAndSort() --faces
				(sortByCol == 4): separateAndSort() --material
				default: qSort mySelectedObjects compareNames --alphabetically
			)
			
			a = 0 --Debugging
			
			--Iterates through the now alphabetised list and turns them into DotNet objects
			for k in mySelectedObjects do
			(
				mat = k.material --assign the material to a variable
					
				a +=1
				
				listObjects = dotNetObject "System.Windows.Forms.listViewItem" k.name --assigns the prefix variable to another DotNet object
				
				if k == undefined then
				(
					format "the %th index was undefined\n" a
				)
				else 
				(
					listObjects.subItems.add (classof k as string)	--assigns a name to the list object sub items
					
					--the following IF statement check whether your object is editable poly or mesh,
					-- if it is neither then it will return blank
					if(classof k != editable_poly and classof k != editable_mesh and classof k != Editable_Patch and classof k != PolyMeshObject) then
					(
						listObjects.subItems.add ("--")
						listObjects.subItems.add ("--")
					)
					else
					(
						listObjects.subItems.add (k.verts.count as string) --counts the number of verts in the object
						listObjects.subItems.add (k.faces.count as string) -- counts the number of faces in the object
					)
					
					if(getuserprop k "IDcount" != 0) then
					(
						listObjects.subItems.add(getuserprop k "IDcount" as string)
					)
					else
					(
						listObjects.subItems.add ("--")
					)
					
					append prefixNum listObjects --adds the DotNet listobjects into an array and then adds them to the list
				)
			)
				
			lv.items.addRange prefixNum
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		--Selects items from the listView
		fn selectFromList =
		(
			 --sets up an empty array with the selection in it
			selectionArr = #()
			objArrIndex = #()
			itemsSelected = #()
			previousSel = #()
			itemsInSelection = lv.selectedItems.count --stores the number of objects selected
			
			--Returns the listview indices of the listView items selected
			for x=0 to itemsInSelection-1 do
			(
				append objArrIndex lv.selectedIndices.item[x]
				append itemsSelected lv.selecteditems.item[x] 
			)
			
			--Stores the objects selected based on their index from the listView array (objArrIndex) and then selects them
			for o in objArrIndex do
			(
				append selectionArr mySelectedObjects [o + 1] -- uses the index to select the objects from mySelectedObjects
				append previousSel mySelectedObjects [o + 1]
			)
			
			for s in selectionArr do
			(
				if(isDeleted s == true) then
				(
					messagebox("Object has been deleted, Refreshing list")
					populateList lv
					selectFromList()
				)
			)
			select selectionArr
			
			objectsSelected_lbl.text = ("Items selected: " + selectionArr.count as string)
			
			lv.hideselection = false
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		--Function to change the text colour of the objects selected in the list
		fn changeForecolor = 
		(
			for i in previousSel do
			(
				-- Checks whether the previous selection was deleted if so it repopulates the list and emptys the previous selection array
				if(isdeleted i != true) then
				(
					index = findItem mySelectedObjects i-1
					lv.items.item[index].selected = true
				)
				else
				(
					messagebox("You have deleted scene node. Refreshing list...")
					populateList lv
					previousSel = #()
					return false
				)
			)
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		--Function to reset the list text colour back to black
		fn clearForecolor =
		(
			for i in previousSel do
			(
				index = findItem mySelectedObjects i-1
				lv.items.item[index].selected = false
				clearselection()
			)
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------

		fn clearArrays =
		(
			selectionArr = #()
			objArrIndex = #()
			itemsSelected = #()
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		--function to select items from the list that are selected in the scene
		fn selectFromSceneFunc =
		(
			itemsInScene = selection.count
			lv.selectedIndices.clear()
			
			for i in selection do
			(
				index = finditem mySelectedObjects i
				lv.items.item[index - 1].selected = true
			)
			selectFromList()
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
				
		fn exportSelectedObj =
		(
			try (destroyDialog exportObjects) catch()
			rollout exportObjects "Export objects" width: 500 height: 500
			(
				local tempName = #()
				local listBoxObjArr = #() -- array to hold the items in the listbox
				local pickedFromList = #()
				local fileFormat -- Variable to save the file format
				local fileLocation --Variable to hold the file location
				local listBoxIndex
				
				label formatToExport "Format selected: None " pos:[270,13] width:200 height:13
				
				multilistbox objectsForExport "Items for export:" pos:[13,7] width:250 height:35
				
				--All the buttons
				button format_FBX "FBX" pos:[270,44] width:110 height:25
				button format_3DS "3DS" pos:[270,74] width:110 height:25
				button format_AI "AI" pos:[270,104] width:110 height:25
				button format_ASE "ASE" pos:[270,134] width:110 height:25
				button format_ATR "ATR" pos:[270,164] width:110 height:25
				button format_BLK "BLK" pos:[270,194] width:110 height:25
				button format_DAE "DAE" pos:[270,224] width:110 height:25
				button format_DF "DF" pos:[270,254] width:110 height:25
				button format_DWF "DWF" pos:[270,284] width:110 height:25
				button format_DXF "DXF" pos:[385,44] width:110 height:25
				button format_FLT "FLT" pos:[385,74] width:110 height:25
				button format_LAY "LAY" pos:[385,104] width:110 height:25
				button format_LP "LP" pos:[385,134] width:110 height:25
				button format_M3G "M3G" pos:[385,164] width:110 height:25
				button format_OBJ "OBJ" pos:[385,194] width:110 height:25
				button format_RPF "RPF" pos:[385,224] width:110 height:25
				button format_VW "VW" pos:[385,254] width:110 height:25
				button format_W3D "W3D" pos:[385,284] width:110 height:25
				
				button removeSelected "Remove Selected" pos:[270,420] width:110 height:25
				button updateList "Update List" pos:[385,420] width:110 height:25	
				button exportObjectsButton "Export" pos:[325,460] width:110 height:25
								
				edittext custom_Format "Custom Format: " pos:[270,320] width:220 height:15
				
				checkbox exportToOrigin "Export to origin" pos:[270,350] width:100 height:15
				checkbox noPrompt "No prompt on export" pos:[370,350] width:150 height:15
				
				button pickFileLocation "Pick File Location" pos:[325,382] width:110 height:15
				label fileLocationLabel "" pos:[270,400] width:500 height:15		
				
				--Updates the listbox based on what you have selected in the scene
				fn updateListbox =
				(
					local objSelected = getCurrentSelection() --gets the current selection
					tempName = #()
					listBoxObjArr = #()
					
					for obj in objSelected do
					(
						append listBoxObjArr obj --Adds the obejcts you have selected to the array
					)
					
					qsort listBoxObjArr compareNames --sorts the list by name
					
					for i in listBoxObjArr do
					(
						--Adds the objects to an array that holds just the names
						append tempName i.name
					)
					
					objectsForExport.items = tempName --Adds the items to the listbox
				)
				
				------------------------------------------------------------------------------------------------------------------------------------
				------------------------------------------------------------------------------------------------------------------------------------
				
				on format_FBX pressed do
				(
					fileFormat = ".FBX"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_3DS pressed do
				(
					fileFormat = ".3DS"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_AI pressed do
				(
					fileFormat = ".AI"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_ASE pressed do
				(
					fileFormat = ".ASE"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_ATR pressed do
				(
					fileFormat = ".ATR"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_BLK pressed do
				(
					fileFormat = ".BLK"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_DAE pressed do
				(
					fileFormat = ".DAE"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_DF pressed do
				(
					fileFormat = ".DF"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_DWF pressed do
				(
					fileFormat = ".DWF"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_DXF pressed do
				(
					fileFormat = ".DXF"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_FLT pressed do
				(
					fileFormat = ".FLT"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_LAY pressed do
				(
					fileFormat = ".LAY"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_LP pressed do
				(
					fileFormat = ".LP"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_M3G pressed do
				(
					fileFormat = ".M3G"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_OBJ pressed do
				(
					fileFormat = ".OBJ"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_RPF pressed do
				(
					fileFormat = ".RPF"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_VW pressed do
				(
					fileFormat = ".VW"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				on format_W3D pressed do
				(
					fileFormat = ".W3D"
					formatToExport.text = "Format selected: " + fileFormat as string
				)
				
				------------------------------------------------------------------------------------------------------------------------------------
				------------------------------------------------------------------------------------------------------------------------------------
				
				--When you select objects in the listview
				on objectsForExport selected val  do
				(
					local index
					listBoxIndex = objectsForExport.selection
					pickedFromList = #() --clears the array firstly when the user picks objects
					
					--Checks to see if the user has defined an export location for the items selected in 
					if(listBoxIndex.numberset == 1) then
					(
						for i in listBoxIndex do
						(
							index = i --sets the index number of the selected object
							append pickedFromList  listBoxObjArr[i]
						)
						
						--If there is no app data to read
						if(getappdata listBoxObjArr[index] 2 == undefined) then
						(
							fileLocationLabel.text = "No export location specified"
						)
						else
						(
							--Gets the file location from the object
							fileLocationLabel.text = getappdata listBoxObjArr[index] 2
						)
					)
					else
					(
						fileLocationLabel.text = "More than one object selected"
						
						for i in listBoxIndex do
						(
							index = i --sets the index number of the selected object
							append pickedFromList  listBoxObjArr[i]
						)
					)
				)
				
				------------------------------------------------------------------------------------------------------------------------------------
				------------------------------------------------------------------------------------------------------------------------------------
				
				on pickFileLocation pressed do
				(
					fileLocation = getSavePath()
					
					for i in pickedFromList do
					(
						setappdata i 2 (filelocation as string)
					)
				)
				
				------------------------------------------------------------------------------------------------------------------------------------
				------------------------------------------------------------------------------------------------------------------------------------
				
				on updateList pressed do
				(
					updateListbox()
				)
				
				-----------------------------------------------------------------------------------------------------------------------------------
				-----------------------------------------------------------------------------------------------------------------------------------
				
				on removeSelected pressed do
				(
					listBoxIndex = objectsForExport.selection --holds the selected objects in the list		
					
					for i in listBoxIndex do
					(
						if(listBoxObjArr[i] == undefined) then
						(
							messagebox("Something went wrong there, please try again")
							return false
						)
						deselect listBoxObjArr[i]
					)
					updateListBox()
					
					objectsForExport.selection = #{}
				)
				
				------------------------------------------------------------------------------------------------------------------------------------
				------------------------------------------------------------------------------------------------------------------------------------
				
				on exportObjectsButton pressed do
				(
					local originPos = [0, 0, 0]
					local currentPos
					local exportFolder
					local exportPath
					local noFileLocationArray = #()
					local noFileLocation = false
					
					if(fileFormat == undefined) then
					(
						messagebox("Please select a format to export in")
						return false
					)
					
					--Check to see if some objects do not have correct export folders
					for i in listBoxObjArr do
					(
						--Gets the export folder from the object (Stored in app data)
						exportFolder = getappdata i 2 as string
						if(doesfileexist exportFolder == false) then
						(
							noFileLocation = true
							append noFileLocationArray i
						)
					)
					
					--If the file location is available then proceed
					if(noFileLocation == false) then
					(
						--Asks the user to save before export
						local result = yesnocancelbox "Would you like to save your scene before export?"
						if(result == #yes)then
						(
							savemaxfile (maxfilepath + maxfilename) --saves the max file
						)
						else if(result == #cancel)then
						(
							messagebox("Export cancelled")
							return false
						)
					)
					else if(noFileLocation == true) then
					(
						ss = stringStream ""
						for j in noFileLocationArray do
						(
							format "%" j.name to:ss
							format "%" "\n" to:ss
						)
						messagebox ("Some of your objects do not have an export location\nPlease check export location.\n" + ss as string)
						return false
					)
					
					--Iterates through the objects in the listbox that you have selected
					for j in listBoxObjArr do
					(
						exportFolder = getappdata j 2 + "\\" as string --adds the folder location as appdata on the object
						exportPath = exportFolder + j.name + (fileFormat as string) --The export path is the folder and the name under which the object is saved as
						
						if(noFileLocation == false) then
						(
							print(exportPath as string)
							
							currentPos = j.position
							
							if(exportToOrigin.checked == true)then
							(
								select j -- You need to select the objects indivually to get them to export separately
								j.position = originPos --object position is set to origin
								
								if(noPrompt.checked == true) then
								(
									exportFile exportPath #noprompt  selectedOnly:true --exports the file to the specified location
								)
								else
								(
									exportFile exportPath selectedOnly:true --exports the file to the specified location
								)
								
								j.position = currentPos
							)
							else
							(
								select j
								if(noPrompt.checked == true) then
								(
									exportFile exportPath #noprompt  selectedOnly:true --exports the file to the specified location
								)
								else
								(
									exportFile exportPath selectedOnly:true
								)
							)
						)
					)
					select listBoxObjArr
					
					messagebox("Operation successful")
				)
				
				------------------------------------------------------------------------------------------------------------------------------------
				------------------------------------------------------------------------------------------------------------------------------------	
				
				on custom_Format entered custom_Txt do
				(
					fileFormat = custom_Txt
					custom_Format.text = ""
					formatToExport.text = "Format selected: " + fileFormat as string
					updateListBox()
				)
				
				------------------------------------------------------------------------------------------------------------------------------------
				------------------------------------------------------------------------------------------------------------------------------------	
				
				on exportObjects open do
				(
					updateListbox()
					if(listBoxObjArr.count != 0)then
					(
						--Gets the first obejct of your selected objects and shows the file location
						if(getappdata listBoxObjArr[1] 2 == undefined) then
						(
							fileLocationLabel.text = "No export location specified"
						)
						else
						(
							fileLocationLabel.text = getappdata listBoxObjArr[1] 2
						)
					)
				)
				
			)createdialog exportObjects style: #(#style_titlebar, #style_Resizing, #style_sysmenu)
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------		
		
		on lv columnClick arg do
		(
			cols = #("Object Name", "Type", "Verts", "Faces", "Materials")
			
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
			changeForecolor()
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		on lv mouseUp arg do
		(			
			selectFromList()				
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		on lv DoubleClick arg do
		(
			clearArrays()
			clearForecolor()
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		on suffix_txt entered txt do
		(
			for i in selectionArr do
			(
				if(selectionArr.count > 1) then
				(
					i.name = uniquename txt
				)
				else
				(
					i.name = txt
				)
			)
		
			populateList lv
			changeForecolor()
			suffix_txt.text = ""
			
			print(txt)
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		on prefix_preTxt entered preTxt do
		(
			for i in selectionArr do
			(
				i.name = preTxt + "_" + i.name
			)
			prefix_preTxt.text = ""
			populateList lv
			changeForecolor()
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		-- Adds the filename as a prefix when pressed
		on addFileNameButton pressed do
		(
			for i in selectionArr do
			(
				--looks for the filename in the object name and adds it if it does not already exisit
				if(not matchpattern i.name pattern:(fileNamePrefix + "*")) then
				(
					--Checks to see if you have saved the file with a decent name
					if(getfilenamefile maxfilename != "") then
					(
						i.name = fileNamePrefix + i.name
					)
					else
					(
						Messagebox("Your scene does not have a name, please save and give file a name")
						return false
					)
				)
			)
			prefix_preTxt.text = ""
			populateList lv
			changeForecolor()
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		--When pressed, selects items in the list based on what you have selected in the scene
		on selectFromScene pressed do
		(
			clearArrays()
			selectFromSceneFunc()
			changeForecolor()
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		--Refreshes/repopulates the list
		on refreshButton pressed do
		(
			gatheredMats = false
			populateList lv
			gatheredMats = true
			clearArrays()
			previousSel = #()
		)
		
		------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------
		
		--Activates the export tool
		on Export pressed do
		(
			exportSelectedObj()
		)
		
		--Controls the rollout risizing on the  Y axis so the user can shrink the dialog
		on theRollout resized arg do
		(
			local controls = #(suffix_txt, prefix_preTxt, addFileNameButton, selectFromScene, refreshButton,  Export, numOfObj_lbl, objectsSelected_lbl)
			
			controlposY = #(895, 925, 960, 960, 960, 960, 865, 865)
			
			originalRolloutHeight = 1000
			
			heightChange = originalRolloutHeight - arg.y
			lv.height = 850 - heightChange
			
			for i = 1 to controls.count do
			(
				controls[i].pos.y = controlposY[i] - heightChange
			)
		)
		
		--Initialises the tool when the rollout is opened
		on theRollout open do
		(
			initLv lv
			addColumns lv #("Object Name", "Type", "Verts", "Faces", "Materials") --passing in two items into the columnsAr
			gatheredMats = false
			populateList lv
			gatheredMats = true
			objectsSelected_lbl.text = ("Items selected: " + selectionArr.count as string)
		)
	)
	createDialog theRollout style: #(#style_titlebar, #style_Resizing, #style_sysmenu)
)