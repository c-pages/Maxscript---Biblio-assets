



/* #######################################################################################################################

Copyright (C) 2015 Martin Geupel (http://www.racoon-artworks.de) , All Rights Reserved
Permission is hereby granted, free of charge, to any person obtaining a copy of this software (the "Software"), to use, 
copy, and/or distribute the software, subject to the following conditions:

- The above copyright notice and this permission notice shall be included in all copies of the Software.
- You may not misrepresent the name of the Original Author or the name of the Software.
- You can distribute the Software only free of charge, you may not sell and/or rent the Software.
- You may add functionality and/or modify existent functionaly if it is then clearly marked and noted in this Header.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

##########################################################################################################################

supported materials:
- StandardMaterial
- VRayMtl
- VRayBlendMtl
- VRayLightMtl
- VRay2SidedMtl
- VRayCarPaintMtl
- VrayOverrideMtl
- VrayMtlWrapper
- VRayFastSSS (basic)
- VRayFastSSS2
- Arch___Design__mi
- Car_Paint_Material__mi
- fR_Advanced
- fR_Architectural
- Shellac
- Autodesk_Material
- Architectural
- RaytraceMaterial (basic)
- fR_Metal (basic)
- fR_Glass (basic)

supported maps:
- VrayColor
- VrayDirt
- VrayNormalMap
- VraySky
- VRayCompTex
- VRayEdgesTex
- VRayGLSLTex
- VRaySoftbox
- VRayHDRI
- Normal_Bump
- Autodesk_Map
- Multi_Sub_Map
- Ambient/Reflective_Occlusion

supported lights:
- VRayLight
- VRayIES
- VRaySun
- mr_Sun
- mr_Sky_Portal
- miAreaLight
- miAreaLightomni
- fR RectLight
- Free_Light
- Target_Light
- TargetDirectionallight
- freeSpot
- Directionallight
- Omnilight
- targetSpot
- Daylight assemblies

other:
- VrayProxy
- VrayDisplacementMod


changelog:
*v1.25 - [2016/01/21] -----------------------------------------------------------------------------
- added: Vray 3.3 additional bump map in VrayNormalMap conversion
- added: Vray 3.3 VrayBlendMtl enable checkbox conversion
- added: VrayHDRI conversion (enabled by default) to prevent crashes using recent Vray 3.x versions
*v1.24 - [2015/12/09] -----------------------------------------------------------------------------
- added check for invalid Vray refraction glossiness values
- fixed glossiness map conversion in VRayCarPaintMtl, VRayFastSSS2
- added better proxy converter error log (maxscript listener)
- fixed proxy converter crash with missing vrmesh files
*v1.23 - [2015/11/24] -----------------------------------------------------------------------------
- added VrayDisplacementMod conversion tool
- improved VrayLight units conversion, luminance and radiance still inaccurate due to limitations
- improved VrayMtl anisotropy conversion: 50 percent decresed intensity, orientation in local z preserved
*v1.22 - [2015/11/13] -----------------------------------------------------------------------------
- fixed conversion issue with fog texmap (affecting older Vray builds prior 2.5)
- adjusted bump conversion for Arch___Design__mi, Standard
- added additional check to prevent crashes with 0 face objects and ProxyConverter
*v1.21 - [2015/11/04] -----------------------------------------------------------------------------
- ProxyConverter now takes VrayProxy scale setting into account and translates it to transforms scale
- ProxyConverter "pick path" button now displays picked path
*v1.20 - [2015/11/02] -----------------------------------------------------------------------------
- VrayNormalMap / CoronaNormal / Normal_Bump maps will not be affected by bump conversion multipler
- ProxyExporter: fixed animation range bug
*v1.19 - [2015/11/02] -----------------------------------------------------------------------------
- new Vray Blinn to Corona (clamped) GGX conversion method
- new Vray GGX to Corona (clamped) GGX conversion method
- new VrayLight Directionality conversion
- new Bump strength conversion, multiplier can be changed in converterSettings struct
- added a proxy converter from scratch including animated VrayProxy support
- added VrayMtl fog texmap -> CoronaMtl absorption texmap
*v1.18 - [2015/09/09] -----------------------------------------------------------------------------
- changed round corners conversion for Arch___Design__mi, fR_Architectural to new CoronaRoundEdges texturemap 
- added support for additional bump mapping in NormalBump -> CoronaNormal texture conversion
*v1.17 - [2015/08/07] -----------------------------------------------------------------------------
- added CoronaLightMtl to legacy mode Tool
- added support for VrayBlend conversion to new CoronaLayeredMtl
- added VrayMtl anisotropy map channel conversion
- VrayMtl glossiness values are now clamped to 2 decimals
*v1.16 - [2015/07/23] -----------------------------------------------------------------------------
- fixed VrayLight disc conversion
- fixed Photometric Light Shadows conversion
*v1.15 - [2015/07/22] -----------------------------------------------------------------------------
- changed light conversions due to the new CoronaSun
- added CoronaNormal gamma fixing tool
- added CoronaBitmap to Bitmaptexture conversion tool
*v1.14 - [2015/07/03] -----------------------------------------------------------------------------
- Internal structural changes, should now be better accessable via MAXScript
- Maxscript documentation got IMPORTANT updates, have a look if you're using it 
- possible fix for "Unable to convert: undefined to type: FileName" errors
- fixed script crash with Daylight Assemblies
*v1.13 - [2015/06/18] -----------------------------------------------------------------------------
- fixed CoronaBitmap conversion errors when referenced bitmaptexture bitmap is not existing (missing map)
- fixed CoronaBitmap conversion crashing the script when map paths were empty or hit unsupported file type 
- added ".jpeg" to supported file types in CoronaBitmap conversion
*v1.12 - [2015/06/15] -----------------------------------------------------------------------------
- fixed: additional CoronaSun on DaylightAssembly conversion
- fixed: autodesk map Width/Height scale parameters are now converted properly to Bitmap worldunits
- fixed: VrayIES lights did not convert when the file path was undefined
- CoronaBitmap: updated realWorldScale conversion
- CoronaBitmap: added gamma conversion
*v1.11 - [2015/06/12] -----------------------------------------------------------------------------
- [BETA] CoronaBitmap: added .hdr format
- [BETA] CoronaBitmap: added mono channel output, rgb channel output, crop and placement 
- added minimize button to converter dialog
*v1.10 - [2015/06/07] -----------------------------------------------------------------------------
- [BETA] CoronaBitmap: added real world scale mapping, W rotation, alpha source
- removed the "on" button for legacy mode switching, this functionality is obsolete
*v1.09 - [2015/05/29] -----------------------------------------------------------------------------
- updated VrayLight directionality conversion using a logit curve
- fixed: missing VrayLight double sided conversion
- fixed: legacy mode conversion stopped working due to renamed property
- added Bitmaptexture -> CoronaBitmap conversion (WIP)
*v1.08 - [2015/05/04] -----------------------------------------------------------------------------
- fixed selected mode for "show maps in viewport" tool
*v1.07 - [2015/05/01] -----------------------------------------------------------------------------
- added "only selected objects" mode for show maps in viewport tool
- fixed renderer assignment (due to new Corona class naming scheme)
- fixed: vray light in mesh mode throwing error when mesh is not present in the scene (=> light is now ignored)
*v1.06 - [2015/04/10] -----------------------------------------------------------------------------
- fixed: "switch renderer to Corona" was overwriting settings even if Corona was already assigned
- added installed Vray version info to Error report
*v1.05 - [2015/03/23] -----------------------------------------------------------------------------
- added support for Ambient/Reflective Occlusion map
- added support for Multi_Sub_Map
- fixed: VrayMtl conversion did not properly convert the SelfIllumination multiplier in some occasions
- fixed: Autodesk_Map printed error report when source file did not exist
- fixed: link colors for light max ui
*v1.04 - [2015/03/06] -----------------------------------------------------------------------------
- fixed VrayFastSSS2, conversion now respects older Vray versions (pre 3.10.01)
*v1.03 - [2015/03/05] -----------------------------------------------------------------------------
- updated VrayFastSSS2 material (diffuse, refl, opacity, bump, displacement)
- updated Architectural material (diffuse, bump, opacity)
- state of ui elements and dialog position will now be saved and recalled on each usage
*v1.02 - [2015/03/03] -----------------------------------------------------------------------------
- VrayMtls without reflection or refraction will now convert to default CoronaMtl refl/refr settings instead of black
- removed bitmap blur clamping
- added "only scene lights" conversion selection 
- updated info section
*v1.01 - [2015/02/24] -----------------------------------------------------------------------------
- added a tool for fixing opacity maps (after conversion) that are using embedded alphas (e.g. tif and leafs)
*v1.00 - [2015/02/16] -----------------------------------------------------------------------------
- first version for Corona 1.0 release

######################################################################################################################## */ 

global CoronaMatConverterPerso

/* 
* struct CoronaProxyConverterStrPerso (
* 	vrayMeshReader,
* 	proxyInfoArray = #(),
* 	proxyFileArray = #(),
* 	
* 	VrayProxyInfo =(
* 		struct VrayProxyInfo (
* 			maxobj,
* 			proxyFile,
* 			displayType,
* 			playbackOffset,
* 			playbackSpeed,
* 			proxyScale
* 		)
* 	),
* 	
* 	VrayProxyFile =(
* 		struct VrayProxyFile (
* 			filename,
* 			doesExist = true,
* 			owner,
* 			frameCount = 1,
* 			coronaProxyFilename = undefined,
* 			
* 			on create do (
* 				if (doesFileExist filename) then(
* 					frameCount = owner.vrayMeshReader.GetNumberOfFrames filename
* 				)else(
* 					doesExist = false
* 				)
* 				append owner.proxyFileArray this
* 			)
* 		)
* 	),
* 	
* 	fn combineToPath stringArray =(
* 		local outPath = ""
* 		for pth in stringArray do (
* 			outPath = pathConfig.appendPath outPath pth
* 		)
* 		outPath
* 	),
* 	
* 	fn maxAnimRange =(
* 		local proxyLengthArray = for i in proxyFileArray collect i.frameCount
* 		if proxyLengthArray.count != 0 then(
* 			sort proxyLengthArray
* 			proxyLengthArray[proxyLengthArray.count]
* 		)else(
* 			1
* 		)
* 	),
* 	
* 	fn isProxyFileDefined filename =(
* 		local found = false
* 		local out = undefined
* 		
* 		for prx in proxyFileArray while not found do(
* 			if prx.filename == filename then(
* 				out = prx
* 				found = true
* 			)
* 		)
* 		out
* 	),
* 	
* 	fn VrayMeshReaderAssembly =(
* 		-- file:///C:/Program%20Files/Chaos%20Group/V-Ray/3dsmax%202016%20for%20x64/docs/vrmesh_format.html
* 		source = ""
* 		source += "using System;\n"
* 		source += "using System.IO;\n"
* 		source += "\n"
* 		source += "public class vrMeshReader\n"
* 		source += "{\n"
* 		source += "	public int GetNumberOfFrames(string filePath)\n"
* 		source += "	{\n"
* 		source += "		byte[] buffer = null;\n"
* 		source += "		int FrameCount = 0;\n"
* 		source += "		\n"
* 		source += "		FileStream vrM = new FileStream(filePath, FileMode.Open);\n"
* 		source += "		try\n"
* 		source += "		{\n"
* 		source += "	    	vrM.Seek(11, SeekOrigin.Begin); // skipping fileversion and description\n"
* 		source += "			\n"
* 		source += "	    	UInt64 lutOffset;\n"
* 		source += "	    	buffer = new byte[8];\n"
* 		source += "	    	vrM.Read(buffer, 0, buffer.Length);\n"
* 		source += "	    	lutOffset = BitConverter.ToUInt64(buffer, 0);\n"
* 		source += "			\n"
* 		source += "	    	vrM.Seek((long)lutOffset, SeekOrigin.Begin);\n"
* 		source += "			\n"
* 		source += "	    	buffer = new byte[4];\n"
* 		source += "	     	vrM.Read(buffer, 0, buffer.Length);\n"
* 		source += "	    	UInt32 numVoxels = (BitConverter.ToUInt32(buffer, 0));\n"
* 		source += "	     	vrM.Seek(36 * numVoxels, SeekOrigin.Current);\n"
* 		source += "	    	FrameCount = 1;\n"
* 		source += "			\n"
* 		source += "	    	while (numVoxels != 0)\n"
* 		source += "	    	{\n"
* 		source += "	       		buffer = new byte[4];\n"
* 		source += "	        	vrM.Read(buffer, 0, buffer.Length);\n"
* 		source += "	       		numVoxels = (BitConverter.ToUInt32(buffer, 0));\n"
* 		source += "	        	if (numVoxels == 0) { break; }\n"
* 		source += "	        	FrameCount++;\n"
* 		source += "	         	vrM.Seek(36 * numVoxels, SeekOrigin.Current);\n"
* 		source += "	    	}\n"
* 		source += "	    	vrM.Close();\n"
* 		source += "		}\n"
* 		source += "		catch (Exception)\n"
* 		source += "		{\n"
* 		source += "	    	vrM.Close();\n"
* 		source += "	    	throw;\n"
* 		source += "		}\n"
* 		source += "		return FrameCount;\n"
* 		source += "	}\n"
* 		source += "}\n"
* 		
* 		csharpProvider = dotnetobject "Microsoft.CSharp.CSharpCodeProvider"
* 		compilerParams = dotnetobject "System.CodeDom.Compiler.CompilerParameters"
* 		
* 		compilerParams.ReferencedAssemblies.Add "System.dll"
* 		
* 		compilerParams.GenerateInMemory = on
* 		compilerResults = csharpProvider.CompileAssemblyFromSource compilerParams #(source)
* 		
* 		(compilerResults.CompiledAssembly).CreateInstance "vrMeshReader"
* 	),
* 	
* 	fn collectSceneData =(
* 		for prx in (getClassInstances VrayProxy) do(
* 			local prxInfo = VrayProxyInfo()
* 			prxInfo.maxobj = prx
* 			
* 			local proxyFile = isProxyFileDefined prx.fileName
* 			prxInfo.proxyFile = if proxyFile != undefined then proxyFile else VrayProxyFile filename:prx.fileName owner:this
* 			prxInfo.displayType = prx.display
* 			prxInfo.playbackOffset = prx.anim_offset
* 			prxInfo.playbackSpeed = prx.anim_speed
* 			prxInfo.proxyScale = prx.proxy_scale
* 			
* 			append proxyInfoArray prxInfo
* 		)
* 	),
* 	
* 	fn generateCoronaProxies location: overwrite: =(
* 		local askForOverwrite = true
* 		local overwriteFiles = false
* 		
* 		if overwrite != unsupplied then(
* 			askForOverwrite = false
* 			overwriteFiles = overwrite
* 		)
* 		
* 		for prx in proxyFileArray do(
* 			
* 			local vrProxy = vrayProxy fileName:prx.Filename display:4 proxy_scale:1.0 -- whole mesh display
* 			local corProxy = CProxy()
* 			local outpath
* 			local skipFile = false
* 			
* 			if location == unsupplied then(
* 				outpath = combineToPath #((getFilenamePath prx.Filename), (getFilenameFile prx.Filename) + ".cgeo")
* 			)else(
* 				outpath = combineToPath #(location, (getFilenameFile prx.Filename) + ".cgeo")
* 			)
* 			prx.coronaProxyFilename = outpath
* 			
* 			if doesFileExist outpath then (
* 				if askForOverwrite then(
* 					overwriteFiles = queryBox "One or more CoronaProxy files do already exist on Disk, do you want to overwrite them?\n\n(If you press \"No\", the existing files will be used for the generated Proxies)" title:"Corona Proxy Export"
* 					askForOverwrite = false
* 				)
* 				
* 				if not overwriteFiles then skipFile = true
* 			)		
* 			
* 			if prx.doesExist then(
* 				if ((getPolygonCount vrProxy)[1] == 0 )then(  -- if facecount is 0 max crashes => corona bug
* 					skipFile = true 
* 					prx.coronaProxyFilename = undefined
* -- 					format ("Skipped [.vrmesh contains 0 faces]: " + prx.Filename + "\n")
* 				)
* 			)else(  -- if vrmesh file path is invalid
* 				skipFile = true 
* 				prx.coronaProxyFilename = undefined
* -- 				format ("Skipped [invalid .vrmesh filepath]: " + prx.Filename + "\n")
* 			)
* 			
* 			
* 			
* 			if not skipFile then(
* 				with redraw off (
* 					if prx.frameCount == 1 then(  -- singleFrame 
* 						CProxy.ProxyFp.fromScene corProxy vrProxy outpath
* 					)else(  -- animated
* 						CProxy.ProxyFp.fromSceneAnimated corProxy vrProxy outpath 0 (prx.frameCount - 1) 10000 1 
* 					)
* 				)
* -- 				format ("Generated CoronaProxy: " + outpath + "\n")
* 			)
* 			
* 			delete vrProxy
* 			delete corProxy
* 			gc light:true
* 		)
* 	),
* 	
* 	fn replaceVrayProxies =(
* 		for vrayPrx in proxyInfoArray where classof vrayPrx.maxobj == VRayProxy do(
* 			cProxFilename = vrayPrx.proxyFile.coronaProxyFilename
* 			if cProxFilename != undefined then(
* 				crnProxy = CProxy filename:cProxFilename animationOffset:vrayPrx.playbackOffset animationSpeedMultiplier:vrayPrx.playbackSpeed previzType:2 
* 				
* 				replaceInstances vrayPrx.maxobj crnProxy
* 				
* 				if vrayPrx.proxyScale != 1.0 then (
* 					local prxInstances
* 					InstanceMgr.GetInstances crnProxy &prxInstances
* 					for obj in prxInstances do obj.scale *= vrayPrx.proxyScale
* 				)
* 				delete crnProxy
* 			)
* 		)
* 		
* 		gc light:true
* 	),
* 	
* 	fn convertProxies location: overwrite: =(
* 		local saveStart = animationRange.start
* 		local saveEnd = animationRange.end
* 		
* 		collectSceneData()
* 		
* 		animationRange = (interval 0 (maxAnimRange() ))
* 		
* 		generateCoronaProxies location:location overwrite:overwrite
* 		replaceVrayProxies()
* 		
* 		proxyInfoArray = #()
* 		proxyFileArray = #()
* 		animationRange = (interval saveStart saveEnd)
* 	),
* 	
* 	CoronaProxyConverterRoll = rollout CoronaProxyConverterRoll "Corona Proxy conversion" width:230 height:170(
* 		local owner = if owner != undefined do owner
* 		local savePath = undefined
* 		
* 		group "Options" (
* 			label lbl "Location for created Corona Proxies" align:#left
* 			radiobuttons rdoMode "" labels:#("Same file path as original", "Pick new path") columns:1 align:#left
* 			button btnPick "Pick save path" width:200 enabled:false
* 		)
* 		group "Convert" (
* 			button btnConvertProxies "Convert Proxies" width:200 height:32 
* 		)
* 		
* 		on btnPick pressed do(
* 			
* 			savePath = getSavePath()
* 			if savePath != undefined do(
* 				btnPick.caption = savePath
* 				btnPick.tooltip = savePath
* 			)
* 		)
* 		
* 		on rdoMode changed state do(
* 			if state == 1 then btnPick.enabled = false else btnPick.enabled = true
* 		)
* 		
* 		on btnConvertProxies pressed do (
* 			if rdoMode.state == 1 then(
* 				owner.convertProxies()
* 			)
* 			else(
* 				if savePath != undefined then (
* 					owner.convertProxies location:savePath
* 				)else(
* 					messagebox "Invalid save Path!" title:"Error"
* 				)
* 			)
* 		)
* 	),
* 	
* 	fn openGui=(
* 		createDialog CoronaProxyConverterRoll style:#(#style_titlebar, #style_sysmenu, #style_minimizebox)
* 	),
* 	
* 	fn destroyGui=(
* 		try(destroyDialog CoronaProxyConverterRoll)catch()
* 	),
* 	
* 	on create do(
* 		CoronaProxyConverterRoll.owner = this
* 		vrayMeshReader = VrayMeshReaderAssembly()
* 	)
* 	
* )
*/



struct CoronaConverterStrPerso (
	CoronaConverterVersion = "1.25",
	
	-- miscellaneous functions
	converterSettings =(
		struct converterSettings 
		(
			standardMatSpecToRefl = true,
			vrayConvertGlossyValues = true,
			vrayConvertGlossyMaps = true,
			vrayblendToMultilayerdBlend = true, -- depreciated
			VrayHDRIToBitmaptexture = true,
			bitmapTextureToCoronaBitmap = false,
			addCoronaPrefix = false,
			userPrefixStr = "CRN.",
			clampDisp = false,
			clampDispAmount = 5.0,
			clampIor = false,
			clampIorAmount = 25.0,
			convertProxies = false,
			switchRenderEngine = false,
			miLightsToCrnLights = false,
			showMapsInVPselectedOnly = false,
			printInfo = false,
			silent = false,
			useTryCatchBugReporting = true,
			uiLinkColor = (if (colorMan.getColor #background).x < 0.5 then color 150 180 210 else color 0 80 200), -- colors for dark and light ui
			exposeDebugSettings = false,
			
			dialogPosX = 0,
			dialogPosY = 0,
			iniPath = "$plugcfg\\CoronaConverter.ini",
			requiredBuildDate = 20151026, --YearMonthDay
			
			vrayBumpMultiplier = 3.5,
			
			vrayBlinnToCoronaClampedGgxTable = #([1.0,1.0],[0.99,0.99],[0.98,0.98],[0.97,0.95],[0.96,0.9],[0.95,0.83],[0.94,0.77],[0.93,0.73],
				[0.92,0.68],[0.91,0.65],[0.9,0.62],[0.89,0.59],[0.88,0.57],[0.87,0.54],[0.86,0.52],[0.85,0.51],[0.84,0.49],[0.83,0.47],
				[0.82,0.46],[0.81,0.44],[0.8,0.43],[0.79,0.42],[0.78,0.41],[0.77,0.39],[0.76,0.38],[0.75,0.37],[0.74,0.36],[0.73,0.35],
				[0.72,0.34],[0.71,0.33],[0.7,0.32],[0.69,0.31],[0.68,0.3],[0.67,0.3],[0.66,0.29],[0.65,0.28],[0.64,0.27],[0.63,0.26],
				[0.62,0.25],[0.61,0.24],[0.6,0.23],[0.59,0.22],[0.58,0.21],[0.57,0.19],[0.56,0.18],[0.55,0.16],[0.54,0.14],[0.53,0.1],
				[0.52,0.01],[0.51,0.01],[0.5,0.01],[0.49,0.01],[0.48,0.01],[0.47,0.01],[0.46,0.01],[0.45,0.01],[0.44,0.01],[0.43,0.01],
				[0.42,0.01],[0.41,0.01],[0.4,0.01],[0.39,0.01],[0.38,0.01],[0.37,0.01],[0.36,0.01],[0.35,0.01],[0.34,0.01],[0.33,0.01],
				[0.32,0.01],[0.31,0.01],[0.3,0.01],[0.29,0.01],[0.28,0.01],[0.27,0.01],[0.26,0.01],[0.25,0.01],[0.24,0.01],[0.23,0.01],
				[0.22,0.01],[0.21,0.01],[0.2,0.01],[0.19,0.01],[0.18,0.01],[0.17,0.01],[0.16,0.01],[0.15,0.01],[0.14,0.01],[0.13,0.01],
				[0.12,0.01],[0.11,0.01],[0.1,0.01],[0.09,0.01],[0.08,0.01],[0.07,0.01],[0.06,0.01],[0.05,0.01],[0.04,0.01],[0.03,0.01],
				[0.02,0.01],[0.01,0.01],[0.0,0.01]),
				
			vrayGgxToCoronaClampedGgxTable = #([1.0,1.0],[0.99,0.99],[0.98,0.97],[0.97,0.95],[0.96,0.94],[0.95,0.91],[0.94,0.87],[0.93,0.83],
				[0.92,0.8],[0.91,0.77],[0.9,0.75],[0.89,0.72],[0.88,0.69],[0.87,0.67],[0.86,0.65],[0.85,0.62],[0.84,0.61],[0.83,0.59],
				[0.82,0.57],[0.81,0.55],[0.8,0.54],[0.79,0.53],[0.78,0.51],[0.77,0.5],[0.76,0.49],[0.75,0.47],[0.74,0.46],[0.73,0.45],
				[0.72,0.44],[0.71,0.43],[0.7,0.42],[0.69,0.41],[0.68,0.4],[0.67,0.39],[0.66,0.38],[0.65,0.38],[0.64,0.37],[0.63,0.36],
				[0.62,0.35],[0.61,0.34],[0.6,0.33],[0.59,0.33],[0.58,0.32],[0.57,0.31],[0.56,0.3],[0.55,0.3],[0.54,0.29],[0.53,0.28],
				[0.52,0.27],[0.51,0.26],[0.5,0.26],[0.49,0.25],[0.48,0.24],[0.47,0.23],[0.46,0.22],[0.45,0.21],[0.44,0.2],[0.43,0.19],
				[0.42,0.18],[0.41,0.16],[0.4,0.14],[0.39,0.12],[0.38,0.01],[0.37,0.01],[0.36,0.01],[0.35,0.01],[0.34,0.01],[0.33,0.01],
				[0.32,0.01],[0.31,0.01],[0.3,0.01],[0.29,0.01],[0.28,0.01],[0.27,0.01],[0.26,0.01],[0.25,0.01],[0.24,0.01],[0.23,0.01],
				[0.22,0.01],[0.21,0.01],[0.2,0.01],[0.19,0.01],[0.18,0.01],[0.17,0.01],[0.16,0.01],[0.15,0.01],[0.14,0.01],[0.13,0.01],
				[0.12,0.01],[0.11,0.01],[0.1,0.01],[0.09,0.01],[0.08,0.01],[0.07,0.01],[0.06,0.01],[0.05,0.01],[0.04,0.01],[0.03,0.01],
				[0.02,0.01],[0.01,0.01],[0.0,0.0]),
				
			vrayDirectionalityToCoronaDirectionality = #([1.0,1.0],[0.99,0.96],[0.98,0.88],[0.97,0.82],[0.96,0.78],[0.95,0.74],[0.94,0.72],
				[0.93,0.69],[0.92,0.68],[0.91,0.66],[0.9,0.65],[0.89,0.63],[0.88,0.62],[0.87,0.61],[0.86,0.6],[0.85,0.6],[0.84,0.59],
				[0.83,0.58],[0.82,0.57],[0.81,0.57],[0.8,0.56],[0.79,0.56],[0.78,0.55],[0.77,0.55],[0.76,0.54],[0.75,0.54],[0.74,0.53],
				[0.73,0.53],[0.72,0.52],[0.71,0.52],[0.7,0.51],[0.69,0.51],[0.68,0.51],[0.67,0.5],[0.66,0.5],[0.65,0.5],[0.64,0.49],
				[0.63,0.49],[0.62,0.49],[0.61,0.49],[0.6,0.48],[0.59,0.48],[0.58,0.48],[0.57,0.47],[0.56,0.47],[0.55,0.47],[0.54,0.47],
				[0.53,0.46],[0.52,0.46],[0.51,0.46],[0.5,0.46],[0.49,0.45],[0.48,0.45],[0.47,0.45],[0.46,0.45],[0.45,0.44],[0.44,0.44],
				[0.43,0.44],[0.42,0.44],[0.41,0.44],[0.4,0.43],[0.39,0.43],[0.38,0.43],[0.37,0.43],[0.36,0.42],[0.35,0.42],[0.34,0.42],
				[0.33,0.42],[0.32,0.41],[0.31,0.41],[0.3,0.41],[0.29,0.41],[0.28,0.41],[0.27,0.4],[0.26,0.4],[0.25,0.4],[0.24,0.4],
				[0.23,0.4],[0.22,0.39],[0.21,0.39],[0.2,0.39],[0.19,0.38],[0.18,0.38],[0.17,0.38],[0.16,0.38],[0.15,0.37],[0.14,0.37],
				[0.13,0.37],[0.12,0.36],[0.11,0.36],[0.1,0.36],[0.09,0.35],[0.08,0.35],[0.07,0.35],[0.06,0.34],[0.05,0.33],[0.04,0.33],
				[0.03,0.32],[0.02,0.31],[0.01,0.3],[0.0,0.0])
				
		)
		converterSettings()
	),
	
	fn getCoronaBuildTimeStamp =(
		try(
			vString = CoronaRenderer.getCoronaVersion()
			fstr = filterstring vString " "
			
			year = fstr[fstr.count - 1] as integer
			month = finditem #("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec") fstr[fstr.count - 3]
			day = fstr[fstr.count - 2] as integer
			tme = filterstring fstr[fstr.count] ":"
			tHours = tme[1] as integer
			tMins = tme[2] as integer
			tSecs = tme[3] as integer
			
			fn frm2d str = (
				formattedprint str format:".2d"
			)
			
			comparableDate = (year as string + frm2d month + frm2d day) as Integer 
			comparableTime = (tHours*3600 + tMins*60 + tSecs) 
			
			#(year, month, day, tHours, tMins, tSecs, comparableDate, comparableTime)
		)catch(
			#(0000, 00, 00, 00, 00, 00, 0, 0)
		)
	),
	
	converterTempData =(
		struct converterTempData 
		(
			owner,
			-- used to determine which classes will be converted, important
			supportedMtlClasses = #("StandardMaterial", "VRayMtl", "VRayBlendMtl", "VRayLightMtl", "VRay2SidedMtl", \
				"VRayCarPaintMtl", "VrayOverrideMtl", "VrayMtlWrapper", "Arch___Design__mi", "Car_Paint_Material__mi", \
				"fR_Advanced", "fR_Architectural" , "Shellac", "Autodesk_Material", "VRayFastSSS", \
				"VRayFastSSS2", "RaytraceMaterial", "Architectural", "fR_Metal", "fR_Glass"),
			supportedMapClasses = #("Bitmaptexture", "VrayColor", "VrayDirt", "Normal_Bump", "VrayNormalMap", "VraySky", \
				"VRayCompTex", "VRayEdgesTex", "VRayGLSLTex", "VRaySoftbox", "Autodesk_Map", "Ambient_Reflective_Occlusion__3dsmax", "Multi_Sub_Map", "VRayHDRI"),
			-- NOT used to determine which classes will be converted, just for information purposes
			supportedLightClasses = #("VRayLight", "VRaySun", "mrSun", "mr_Sky_Portal", "VRayIES", "miAreaLight", \
				"miAreaLightomni", "RectLight", "Free_Light", "Target_Light", "TargetDirectionallight", "freeSpot", \
				"Directionallight", "Omnilight", "targetSpot", "Daylight Assemblies"),
			
			--glossyConversionOutputMap = undefined,
			glossyConversionOutputMapVrayBlinnCoronaClGgx = undefined,
			glossyConversionOutputMapVrayGgxCoronaClGgx = undefined,
			AD_mats_found = false,
			foundPortals = false,
			
			orig_mtls=#(),
			new_mtls=#(),
			orig_maps=#(),
			new_maps=#(),
			orig_lights=#(),
			new_lights=#(),
			crnSkyPortalMtl,
			
			foundAdskMtls=#(),
			errorBuffer=#(),
			conversionTimeInfo = #(),
				
			coronaBuildTimestamp = owner.getCoronaBuildTimeStamp()
		)
		converterTempData owner:this
	),
	
	fn isCoronaVersionOfDateOrHigher dateInt =(  -- yyyymmdd
		instCorBuild = converterTempData.coronaBuildTimestamp  -- installed corona build
		reqCorBuild = dateInt  -- lowest corona build version accepted
		instCorBuild[7] >= reqCorBuild
	),
	
	converterTools =(
		struct converterTools (
			owner,
			
			private fn collectMaterialClasses =(
				myString = "" as stringstream 
				showclass "*:material*" to:myString
				
				rawClass = filterstring (myString as string) "\n"
				rawClass = for elem in rawClass collect (filterstring elem ": ")[1] 
				sort rawClass
				rawClass
			),
			
			private fn recursiveShowMaps orig_mtl mode =(
				local sub_count=getNumSubMtls orig_mtl
				if sub_count >= 1 then (
					for i=1 to sub_count do (
						submtl = getSubMtl orig_mtl i
						if submtl != undefined do (
							recursiveShowMaps submtl mode
						)
					)
				)
				else(
					if classof orig_mtl == CoronaMtl then(
						try(showTextureMap orig_mtl orig_mtl.texmapDiffuse mode)catch()
					)
				)
			),
			
			private fn convertFrom_VrayDisplacementMod orig =(
				crnMod = CoronaDisplacementMod()
				crnMod.mapSource = 1
				crnMod.texmap = orig.texmap
				
				local amount = orig.amount
				local shift = orig.shift
				local waterLvl = orig.waterLevelValue
				crnMod.levelMax = amount + shift
				crnMod.levelMin = shift
				
				if orig.waterLevelOn then(
					crnMod.useWaterLevel = true
					crnMod.waterLevel = (waterLvl - shift) / amount  -- ((amount + shift) - shift)
				)
				
				crnMod
			),
			
			public
			CoronaMtlConvStatsRoll = rollout CoronaMtlConvStatsRoll "Corona Mtl Statistics" width:210 height:176 (
				label lblNumCrnMat "number of CoronaMtls containing..." pos:[8,8] width:200 height:16
				label lblNumReflect "Reflections:" pos:[16,24] width:200 height:16
				label lblNumRefract "Refractions:" pos:[16,40] width:200 height:16
				label lblNumSelfIllu "Self illumination:" pos:[16,56] width:96 height:16
				label lblNumTransl "Translucency:" pos:[16,72] width:96 height:16
				label lblNumOpacity "Opacity:" pos:[16,88] width:96 height:16
				label lblNumDisplace "Displacement:" pos:[16,104] width:96 height:16
				label lblNumCrnLight "number of CoronaLightMtls..." pos:[8,128] width:176 height:16
				label lblNumEmitting "emitting Light (direct):" pos:[16,144] width:144 height:16
				
				on CoronaMtlConvStatsRoll open do(
					local CrnMats = getclassinstances CoronaMtl 
					local numReflectiveCrn = 0
					local numTwoSided = 0
					local numCaustics = 0
					local numRefractiveCrn = 0
					local numSelfIlluCrn = 0
					local numTranslucentCrn = 0
					local numOpacityCrn = 0
					local numDisplacementCrn = 0
					local CrnLightMat = getclassinstances CoronaLightMtl
					local numEmittingLightMat = 0
					
					for mat in CrnMats do(
						--count reflective 
						if mat.levelReflect != 0 then(
							if mat.colorReflect != black then numReflectiveCrn += 1 else(
								if mat.texmapReflect != undefined AND mat.texmapOnReflect == true then numReflectiveCrn += 1
							)
						)
						
						--count refractive 
						if mat.levelRefract != 0 then(
							if mat.colorRefract != black then( 
								numRefractiveCrn += 1
								if mat.thin then numTwoSided += 1
								if mat.caustics then numCaustics += 1
							)
							else(
								if mat.texmapRefract != undefined AND mat.texmapOnRefract == true then(
									numRefractiveCrn += 1
									if mat.thin then numTwoSided += 1
									if mat.caustics then numCaustics += 1
								)
							)
						)
						
						--count selfillum 
						if mat.levelSelfIllum != 0 then(
							if mat.colorSelfIllum != black then numSelfIlluCrn += 1 else(
								if mat.texmapSelfIllum != undefined AND mat.texmapOnSelfIllum == true then numSelfIlluCrn += 1
							)
						)
						
						--count translucent 
						if mat.levelTranslucency != 0 then(
							if mat.colorTranslucency != black then numTranslucentCrn += 1 else(
								if mat.texmapTranslucency != undefined AND mat.texmapOnTranslucency == true then numTranslucentCrn += 1
							)
						)
						
						--count opacity 
						if mat.levelOpacity != 1.0 then numOpacityCrn += 1
						else(
							if mat.colorOpacity != white then numOpacityCrn += 1 else(
								if mat.texmapOpacity != undefined AND mat.texmapOnOpacity == true then numOpacityCrn += 1
							)
						)
						
						--count displacement 
						if mat.levelTranslucency != 0 then(
							if mat.texmapDisplace != undefined AND mat.texmapOnDisplacement == true then numDisplacementCrn += 1
						)
					)
					
					for mat in CrnLightMat do if mat.emitLight then numEmittingLightMat += 1
					
					lblNumCrnMat.text = "number of CoronaMtls(" + CrnMats.count as string + ") containing..."
					lblNumReflect.text = "Reflections: " + numReflectiveCrn as string
					lblNumRefract.text = "Refractions: " + numRefractiveCrn as string  + "   Caustics(" + numCaustics as string + ") Thin(" + numTwoSided as string + ")"			
					lblNumSelfIllu.text = "Self illumination: " + numSelfIlluCrn as string 		
					lblNumTransl.text = "Translucency: " + numTranslucentCrn as string 	
					lblNumOpacity.text = "Opacity: " + numOpacityCrn as string 
					lblNumDisplace.text = "Displacement: " + numDisplacementCrn as string 
					lblNumCrnLight.text = "number of CoronaLightMtls(" + CrnLightMat.count as string + ") ..."
					lblNumEmitting.text = "emitting Light (direct): " + numEmittingLightMat as string 
				)
			),
			
			CoronaMtlConvClassRoll = rollout CoronaMtlConvClassRoll "Convert by class" width:180 height:480 (
				label lblDesc "Convert any material class to a default gray CoronaMtl. You can select several classes at once." pos:[4,4] width:170 height:60
				multilistbox mlb "" pos:[4,50] width:170 height:30 items:(collectMaterialClasses())
				button convertClasses  "Convert to Default CoronaMtl" pos:[4,450]width:170
					
				on convertClasses pressed do(
					for cls in mlb.selection do(
						for mtl in (getclassinstances (execute mlb.items[cls])) where classof mtl != CoronaMtl do(
							try(replaceInstances mtl (CoronaMtl name:mtl.name))catch("Unknown Error occured!")
						)
					)
				)
			),
			
			fn showMapsInVP mode selected:false =(
				if not selected then(
					for o in (getclassinstances CoronaMtl) do(
						try(showTextureMap o o.texmapDiffuse mode)catch()
					)
				)
				else(
					for o in selection do(
						if o.material != undefined do(
							recursiveShowMaps o.material mode
						)
					)
				)
			),
			
			fn SetMaxDisplacementLevel amnt =(
				for o in (getclassinstances CoronaMtl) do(
					o.displacementMaximum = amnt
				)
			),
			
			fn DisableDisplacementTex =(
				for o in (getclassinstances CoronaMtl) do(
					o.texmapOnDisplacement = false
				)
			),
			
			fn setLegacyMode state =(
				for mat in (getclassinstances CoronaMtl) do(
					if (hasproperty mat "legacyA7Mode") then(
						mat.legacyA7Mode = state  -- true = legacy, false = standard
					)
					if (hasproperty mat "legacyMode") then(
						mat.legacyMode = state  -- true = legacy, false = standard
					)
				)
				for mat in (getclassinstances CoronaLightMtl) do(
					if (hasproperty mat "legacyMode") then(
						mat.legacyMode = state  -- true = legacy, false = standard
					)
				)
			),
			
			fn convertClass =(
				createDialog CoronaMtlConvClassRoll
			),
			
			fn CoronaMtlStats =(
				createDialog CoronaMtlConvStatsRoll
			),
			
			fn resetMtlEdit =(
				for i = 1 to 24 do(
					meditmaterials[i] = CoronaMtl name:((formattedPrint i format:".2d") + " - CoronaMtl")
				)
			),
			
			fn fixOpacityMapsUsingMonoChannel =(
				crnMtls = getClassInstances CoronaMtl
				
				for mtl in crnMtls do(
					if mtl.texmapOpacity != undefined and classof mtl.texmapOpacity == Bitmaptexture then(
						if mtl.texmapOpacity.monoOutput == 1 then(
							opcMap = mtl.texmapOpacity
							
							mtl.texmapOpacity = CoronaMix texmapMix:opcMap
						)
					)
				)
			),
			
			fn convertBitmapToCoronaBitmap =(
				for map in getclassinstances Bitmaptexture do(
					newMap = owner.mapConvMethods.convertFrom_BitmapTexture map
					if newMap != #NoReplacement do(
						replaceInstances map newMap
					)
				)
			),
			
			fn convertCoronaBitmapToBitmap =(
				for map in getclassinstances CoronaBitmap do(
					newMap = owner.mapConvMethods.convertFrom_CoronaBitmap map
					if newMap != #NoReplacement do(
						replaceInstances map newMap
					)
				)
			),
			
			fn convertVrayDisplacementMods =(
				local allMods = (getclassinstances VRayDisplacementMod)
				for dsplMod in allMods where (classof dsplMod == VRayDisplacementMod) do(
					replaceInstances dsplMod (convertFrom_VrayDisplacementMod dsplMod)
				)
			),
			
			fn fixCoronaNormalGamma =(
				for mp in (getClassInstances CoronaNormal) do(
					if mp.gammaWarning then mp.addGamma = not mp.addGamma
				)
			),
			
			fn getVersion =( 
				owner.CoronaConverterVersion 
			),
			
			fn checkForNewVersion =(
				if not owner.converterSettings.silent then (
					rollout CheckOnlineRoll "Online version check" width:210 height:124 (
						local publicVersion = undefined
						local dailyBuildsVersion = undefined
						local lastpos = [8,8]
						
						label lbl0 "This version: " pos:(lastpos += [20,0]) align:#left
						label lbl1 "Latest versions on " pos:(lastpos += [-20,20]) align:#left
						hyperlink hypDwnld "Converter website:" address:"http://www.racoon-artworks.de/CoronaConverter/CoronaConverter.html" pos:(lastpos += [92,0]) visitedColor:(color 150 180 210) color:(color 150 180 210)
						label lbl2 "public version: error" pos:(lastpos += [-72,20]) align:#left
						label lbl3 "daily builds version: error" pos:(lastpos += [0,20]) align:#left
						button btnClose "Close" pos:(lastpos += [39,24]) width:80
						
						on btnClose pressed do destroyDialog CheckOnlineRoll
						
						on CheckOnlineRoll open do (
							try(
								publicVersion = ((dotNetObject "System.Net.WebClient").downloadString "http://www.racoon-artworks.de/CoronaConverter/version.txt")
								dailyBuildsVersion = ((dotNetObject "System.Net.WebClient").downloadString "http://www.racoon-artworks.de/CoronaConverter/version_dailyBuilds.txt")
								lbl0.text = ("This version: v" + owner.converterTools.getVersion())
								lbl2.text = ("public version: v" + publicVersion)
								lbl3.text = ("daily builds version: v" + dailyBuildsVersion)
							)catch()
						)
					)
					createDialog CheckOnlineRoll
					#(#("public", CheckOnlineRoll.publicVersion), #("daily", CheckOnlineRoll.dailyBuildsVersion))
				)
				else(
					try(
						publicVersion = ((dotNetObject "System.Net.WebClient").downloadString "http://www.racoon-artworks.de/CoronaConverter/version.txt")
						dailyBuildsVersion = ((dotNetObject "System.Net.WebClient").downloadString "http://www.racoon-artworks.de/CoronaConverter/version_dailyBuilds.txt")
						#(#("public", publicVersion), #("daily", dailyBuildsVersion))
					)catch(undefined)
				)
			)
		)
		converterTools owner:this
	),
	
	fn scenematerialsUpdateHack =(
		-- DIRTY HACK to force max to save something and re-evaluate the scenematerials tree, so no "dead" classes will remain somewhere.
		-- if not done, e.g. Autodesk_Material warnings will pop up all the time if there was a Adsk mtl because it's still referenced somehwere.
		start = timeStamp()
		tempFile = GetDir #temp + "/_tempSceneMaterialsHack.max" 
		saveNodes #() tempFile
		deleteFile tempFile
		end = timeStamp()
		if converterSettings.printInfo do format "INFO: UpdateFix took % seconds to complete\n" ((end - start) / 1000.0)
	),
	
	fn createErrorReports =(
		rollout ErrorReportRollout "Error Report" width:400 height:500 (
			local owner = if owner != undefined do owner
			local report
			label lbl1 "Conversion finished but one or more errors occured!"
			label lbl2 " Please save the ErrorReport.txt below and post it in this thread:"
			hyperLink lnk "https://corona-renderer.com/forum/index.php/topic,126" address:"https://corona-renderer.com/forum/index.php/topic,126" color:owner.converterSettings.uiLinkColor visitedColor:owner.converterSettings.uiLinkColor offset:[50,0]
			dotNetControl edxErr "System.Windows.Forms.TextBox" pos:[0,60] width:400 height:400 
			button btnCopy "Save ErrorReport.txt" height:30
			
			on ErrorReportRollout open do(
				edxErr.Multiline = true
				edxErr.ReadOnly = true
				edxErr.backcolor = edxErr.backcolor.FromArgb 60 60 60  
				edxErr.foreColor = edxErr.foreColor.FromArgb 255 120 0  
				
				if not converterSettings.silent do(
					report = ""
					report += ">>> SCENE Info: <<<\r\n"
					report += "Corona version: " + CoronaRenderer.getCoronaVersion() + "\r\n"
					report += "Converter version: " + owner.converterTools.getVersion() + "\r\n"
					report += "Installed Vray plugins: "
					for i in RendererClass.classes where substring (i as string) 1 5 == "V_Ray" do report += i as string + "  "							
					report += "\r\n"
					for i in converterTempData.conversionTimeInfo do report += ("# " + i + "\r\n")
					report += "\r\n"
					
					for i in converterTempData.errorBuffer do report += (i + "\r\n\r\n")
					
					ErrorReportRollout.edxErr.text = report
				)
			)
			
			on btnCopy pressed do (
				loc = getSavePath "Location to store ErrorReport.txt"
				if loc != undefined do (
					file = createFile (pathConfig.appendPath loc "ErrorReport.txt")
					if file != undefined do format report to:file  --edxErr.text
					close file
				)
			)
		)
		
		ErrorReportRollout.owner = this
		
		if converterTempData.errorBuffer.count != 0 do (
			createDialog ErrorReportRollout
		)
		converterTempData.errorBuffer=#()
		converterTempData.conversionTimeInfo=#()
	),
	
	fn errorCatching functionName orig =(
		errcls = classof orig
		if converterSettings.useTryCatchBugReporting then(
			try(
				out = functionName orig
			)catch(
				append converterTempData.errorBuffer ("Error occured in " + errcls as string + " : " + orig as string + "\r\n" + getCurrentException() ) 
				out = orig
			)
		)else(
			out = functionName orig
		)
		out
	),
	
	fn getGlossyConversionOutputMap type =(
		/*  
			Most of the code in this function is taken from the cg-talk thread 
			"Is it possible To Create and Edit Output Map Curve?"
			http://forums.cgsociety.org/showthread.php?f=98&t=993502  
			Thanks goes to denisT for sharing these great tech tips.
		*/
		outputmap = undefined
		backupMtl = undefined
		selectedSlot = undefined
		isEditOpen = undefined
		
		try(destroydialog easyCCurve) catch()
		rollout easyCCurve "Easy CCurve" width:208 height:215
		(
			fn mouseWindowMove hwnd x y sx sy =
			(
				fn makeParam LoWord HiWord =
				(
					bit.or (bit.shift HiWord 16) (bit.and LoWord 0xFFFF)
				)
				WM_LBUTTONDOWN 	= 0x0201
				WM_LBUTTONUP 	= 0x0202
				WM_MOUSEMOVE	= 0x0200
				MK_LBUTTON	  = 0x0001
				
				p0 = makeParam x y
				p1 = makeParam (x+sx) (y+sy)
				
				uiaccessor.sendmessage hwnd WM_LBUTTONDOWN 0 p0 
				uiaccessor.sendmessage hwnd WM_MOUSEMOVE MK_LBUTTON p1 
				uiaccessor.sendmessage hwnd WM_LBUTTONUP 0 p1 
			)
			curveControl cc numcurves:1 width:200 height:200 pos:[4,4] \
				zoomvalues:[200,100] scrollvalues:[4,2] uiFlags:#() rcmFlags:#()
		)
		createdialog easyCCurve style:#() pos:[-1000,300]
		
		with redraw off
		(
			d_hwnd = (windows.getChildHWND 0 easyCCurve.title)[1]
			c_hwnd = for w in (windows.getChildrenHWND d_hwnd) where w[4] == "DefCurveWindow" do exit with w[1]
			
			cc = easyCCurve.cc.curves[1]
			cc.color = black
			cc.numpoints = 4
			
			pp = easyCCurve.cc.curves[1].points
			pp.selected = on
			
			case type of ( 
				#VrayGgxToClampedGgx: (
					pp[1].value = [0,0.017]	
					
					pp[2].value = [0.38,0.01]	
					pp[2].outtangent = [0.01,0.135]
					
					pp[3].value = [0.65,0.375]	
					pp[3].intangent = [-0.25,-0.175]
					pp[3].outtangent = [0.25,0.175]
					
					pp[4].value = [1.0,1.0]
					pp[4].intangent = [-0.06,-0.06]
				)
				default: (
					pp[1].value = [0,0.01]	
					
					pp[2].value = [0.52,0.01]	
					pp[2].outtangent = [0.01,0.135]
					
					pp[3].value = [0.765,0.39]	
					pp[3].intangent = [-0.2,-0.17]
					pp[3].outtangent = [0.2,0.17]
					
					pp[4].value = [1.0,1.0]
					pp[4].intangent = [-0.06,-0.05]
				)
				
			)
			
			
			-- make backups
			backupMtl = meditmaterials[1]
			selectedSlot = medit.GetActiveMtlSlot()
			isEditOpen = MatEditor.isOpen()
			matEditorMode = MatEditor.mode 
			--mateditor.close()
			
			if matEditorMode == #advanced then (
				MatEditor.mode = #basic
			)
			
			-- Make Output Map
			outputmap = output name:"GlossyConversion"
			medit.PutMtlToMtlEditor outputmap 1
			medit.SetActiveMtlSlot 1 on
				
			-- Init Mono_Color_Map 
			
			mateditor.open()
			c = windows.getchildhwnd (windows.getchildhwnd 0 ("Material Editor - " + outputmap.name))[1] "Enable Color Map"
				
			BM_SETCHECKED = 0x00F1
			UIAccessor.SendMessage c[1] BM_SETCHECKED 1 0
			UIAccessor.PressButton c[1]
				
			-- Replace Curve
			replaceinstances outputmap.output.Mono_Color_Map.curve_1 easyCCurve.cc.curves[1][1].parent
			--medit.SetActiveMtlSlot 1 on
				
			-- restore backups
			medit.PutMtlToMtlEditor backupMtl 1
			medit.SetActiveMtlSlot selectedSlot on
			if not isEditOpen do MatEditor.Close()
			MatEditor.mode = matEditorMode
		)
		destroydialog easyCCurve
		free easyCCurve
		
		outputmap
	),
	
	
	-- structs containing conversion methods for mtl, map, light classes
	matConvMethods =(
		struct matConvMethods 
		(
			owner,
			
			-- ############## Standard Material ################
			fn convertFrom_Standard origMtl =(
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				origMtl.shaderType = 1 -- make sure standard mat shader type is set to default blinn
				
				--Diffuse
				r.levelDiffuse=1.0 
				r.colorDiffuse=origMtl.diffuse 
				r.texmapDiffuse=origMtl.diffuseMap 
				if r.texmapDiffuse != undefined then(
					r.texmapOnDiffuse=origMtl.diffuseMapEnable 
					r.mapamountDiffuse=origMtl.diffuseMapAmount --/ 100.0 
				)
				
				--Reflection
				if owner.converterSettings.standardMatSpecToRefl then(
					r.levelReflect = (if origMtl.specularLevel > 100.0 then 1.0 else origMtl.specularLevel / 100.0)
					r.colorReflect = origMtl.specular
					r.reflectGlossiness = sqrt (origMtl.glossiness / 100.0)
					
					r.texmapReflect = origMtl.specularLevelMap  -- default: uses specular level for reflection..
					if r.texmapReflect != undefined then(
						r.texmapOnReflect = origMtl.specularLevelMapEnable 
						r.mapamountReflect = origMtl.specularLevelMapAmount --/ 100.0 
					)
					
					if origMtl.reflectionMap != undefined do (  -- but will override if reflection map is supplied
						r.texmapReflect = origMtl.reflectionMap 
						if r.texmapReflect != undefined then(
							r.texmapOnReflect = origMtl.reflectionMapEnable 
							r.mapamountReflect = origMtl.reflectionMapAmount --/ 100.0 
						)
					)
					r.texmapReflectGlossiness = origMtl.glossinessMap 
					if r.texmapReflectGlossiness != undefined then(
						r.texmapOnReflectGlossiness = origMtl.glossinessMapEnable 
						r.mapamountReflectGlossiness = origMtl.glossinessMapAmount --/ 100.0 
					)
					
					if r.texmapReflectGlossiness == undefined and r.texmapReflect == undefined and r.levelReflect == 0.0 and abs(origMtl.glossiness - 10.0) < 0.01 then(
						r.reflectGlossiness = 1.0
					)
				)
				
				--Refraction
				r.texmapRefract = origMtl.refractionMap 
				if r.texmapRefract != undefined then(
					r.levelRefract = 1.0 
					r.colorRefract = color 0 0 0
					r.texmapOnRefract = origMtl.refractionMapEnable 
					r.mapamountRefract = origMtl.refractionMapAmount --/ 100.0 
				)
				r.ior = if origMtl.ior < 1.0 then 1.0 else origMtl.ior
				
				--Bumpmap
				r.texmapBump=origMtl.bumpMap 
				if r.texmapBump != undefined then(
					r.texmapOnBump=origMtl.bumpMapEnable 
					r.mapamountBump= (origMtl.bumpMapAmount / 100.0) * 3.5
				)
				
				--Opacity
				r.levelOpacity= origMtl.opacity / 100.0 
				r.colorOpacity=(color 255 255 255) 
				r.texmapOpacity=origMtl.opacityMap 
				if r.texmapOpacity != undefined then(
					r.texmapOnOpacity=origMtl.opacityMapEnable 
					r.mapamountOpacity=origMtl.opacityMapAmount --/ 100.0 
				)
				
				--Emission
				r.levelSelfIllum = if origMtl.useSelfIllumColor then 1.0 else (origMtl.selfIllumAmount /100.0) 
				r.colorSelfIllum =  if origMtl.useSelfIllumColor then origMtl.selfIllumColor else r.colorDiffuse 
				r.texmapSelfIllum = origMtl.selfillumMap 
				if r.texmapSelfIllum != undefined then(
					r.texmapOnSelfIllum = origMtl.selfillumMapEnable 
					r.mapamountSelfIllum = origMtl.selfillumMapAmount --/ 100.0 
				)
				else(
					if origMtl.useSelfIllumColor == false AND origMtl.selfIllumAmount != 0 then(
						r.colorSelfIllum = r.colorDiffuse
						if r.texmapOnDiffuse then(r.texmapSelfIllum = r.texmapDiffuse; r.texmapOnSelfIllum = true)
					)
				)
				
				--Displacement
				r.texmapDisplace=origMtl.displacementMap 
				if r.texmapDisplace != undefined then(
					r.texmapOnDisplacement=origMtl.displacementMapEnable 
				)
				
				r
				
			),
			
			
			-- ############## Create Default Corona Material ################
			fn CreateDefaultCoronaMtl origMtl =(
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				r
			),
			
			
			-- ############## Vray Material ################
			fn convertFrom_VrayMtl origMtl =(
				fn getMaxIOR =(
					if owner.converterSettings.clampIor then(
						owner.converterSettings.clampIorAmount
					)else( 999.0 )		
				)
				
				fn getCoronaGlossiness vrGlossVal curve =(
					local out
					local run = true
					local closest = 100.0
					
					if vrGlossVal < 0.0 then( out = 0.0; run = false)
					if vrGlossVal > 1.0 then( out = 1.0; run = false)
					
					for dataPoint in curve while run do(
						local diff = (abs (vrGlossVal - dataPoint.x))
						if diff > closest then(
							run = false
						)else(
							closest = diff
							out = dataPoint.y
						)
					)
					out
				)
				
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				--Diffuse
				r.levelDiffuse = 1.0 
				r.colorDiffuse = origMtl.diffuse 
				r.texmapDiffuse = origMtl.texmap_diffuse 
				if r.texmapDiffuse != undefined then(
					r.texmapOnDiffuse = origMtl.texmap_diffuse_on 
					r.mapamountDiffuse = origMtl.texmap_diffuse_multiplier --/ 100.0 
				)
				
				--Reflection
				if origMtl.reflection == black and origMtl.texmap_reflection == undefined then(  -- to preserve CoronaMtl defaults, if no map is used and color is black -> default coronaMtl
					r.levelReflect = 0.0
					r.colorReflect = white
				)else( -- for all other cases, set reflection level to 1.0
					r.levelReflect = 1.0
					r.colorReflect = origMtl.reflection 
				)
				r.texmapReflect = origMtl.texmap_reflection 
				if r.texmapReflect != undefined then(
					r.texmapOnReflect = origMtl.texmap_reflection_on 
					r.mapamountReflect = origMtl.texmap_reflection_multiplier --/ 100.0 
				)
				
				if origMtl.reflection_lockIOR then(
					r.fresnelIor = if origMtl.refraction_ior < 1.0 then 1.0 else origMtl.refraction_ior
				)
				else(
					r.fresnelIor = if origMtl.reflection_ior < 1.0 then 1.0 else origMtl.reflection_ior
				)
				if origMtl.reflection_fresnel == false then(
					r.fresnelIor = getMaxIOR() -- normally 999.0 for non-fresnel-activated mats --can be overridden by user
				)
				r.texmapFresnelIor = origMtl.texmap_reflectionIOR 
				if r.texmapFresnelIor != undefined then(
					r.texmapOnFresnelIor = origMtl.texmap_reflectionIOR_on 
					r.mapamountFresnelIor = origMtl.texmap_reflectionIOR_multiplier 
				)
				
				--Reflection Glossiness
				if origMtl.brdf_type == 4 then( -- Vray GGX
					if owner.converterSettings.vrayConvertGlossyValues then( 
						r.reflectGlossiness = getCoronaGlossiness origMtl.reflection_glossiness owner.converterSettings.vrayGgxToCoronaClampedGgxTable 
					)else(
						r.reflectGlossiness = origMtl.reflection_glossiness
					)
				)else( -- all others -> default Blinn
					if owner.converterSettings.vrayConvertGlossyValues then( 
						r.reflectGlossiness = getCoronaGlossiness origMtl.reflection_glossiness owner.converterSettings.vrayBlinnToCoronaClampedGgxTable 
					)else(
						r.reflectGlossiness = origMtl.reflection_glossiness
					) 
				)
				
				r.reflectGlossiness = (r.reflectGlossiness * 100) as integer / 100.0 -- clamps to 2 decimals
				r.texmapReflectGlossiness = origMtl.texmap_reflectionGlossiness 
				if r.texmapReflectGlossiness != undefined then(
					if owner.converterSettings.vrayConvertGlossyMaps do (
						outmp
						
						if origMtl.brdf_type == 4 then( -- Vray GGX
							if owner.converterTempData.glossyConversionOutputMapVrayGgxCoronaClGgx == undefined do(
								owner.converterTempData.glossyConversionOutputMapVrayGgxCoronaClGgx = owner.getGlossyConversionOutputMap #VrayGgxToClampedGgx
							)
							outmp = copy owner.converterTempData.glossyConversionOutputMapVrayGgxCoronaClGgx
						)else( -- all others using default Blinn
							if owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx == undefined do(
								owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx = owner.getGlossyConversionOutputMap #VrayBlinnToClampedGgx
							)
							outmp = copy owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx
						)
						
						outmp.map1 = r.texmapReflectGlossiness
						r.texmapReflectGlossiness = outmp
					)
					
					r.texmapOnReflectGlossiness = origMtl.texmap_reflectionGlossiness_on 
					r.mapamountReflectGlossiness = origMtl.texmap_reflectionGlossiness_multiplier --/ 100.0 
				)
				
				--Refraction
				if origMtl.refraction == black and origMtl.texmap_refraction == undefined then( -- to preserve CoronaMtl defaults, if no map is used and color is black -> default coronaMtl
					r.levelRefract = 0.0
					r.colorRefract = white
				)else( -- for all other cases, set refraction level to 1.0
					r.levelRefract = 1.0 
					r.colorRefract = origMtl.refraction 
				)
				r.texmapRefract = origMtl.texmap_refraction 
				if r.texmapRefract != undefined then(
					r.texmapOnRefract = origMtl.texmap_refraction_on 
					r.mapamountRefract = origMtl.texmap_refraction_multiplier --/ 100.0 
				)
				r.ior = if origMtl.refraction_ior < 1.0 then 1.0 else(if origMtl.refraction_ior > 10.0 then 10.0 else origMtl.refraction_ior)
				
				r.texmapIor = origMtl.texmap_refractionIOR      
				if r.texmapIor != undefined then(
					r.texmapOnIor = origMtl.texmap_refractionIOR_on 
					r.mapamountIor = origMtl.texmap_refractionIOR_multiplier 
				)
				
				
				-- Refraction Glossiness
				if origMtl.brdf_type == 4 then( -- Vray GGX
					r.refractGlossiness = (if owner.converterSettings.vrayConvertGlossyValues then( 
						getCoronaGlossiness origMtl.refraction_glossiness owner.converterSettings.vrayGgxToCoronaClampedGgxTable 
					) else(origMtl.refraction_glossiness) )
				)else( -- all others -> default Blinn
					r.refractGlossiness = (if owner.converterSettings.vrayConvertGlossyValues then( 
						getCoronaGlossiness origMtl.refraction_glossiness owner.converterSettings.vrayBlinnToCoronaClampedGgxTable 
					) else(
						origMtl.refraction_glossiness) )
				)
				
				
				r.refractGlossiness = (r.refractGlossiness * 100) as integer / 100.0 -- clamps to 2 decimals
				r.texmapRefractGlossiness = origMtl.texmap_refractionGlossiness 
				if r.texmapRefractGlossiness != undefined then(
					if owner.converterSettings.vrayConvertGlossyMaps do (
						outmp
						
						if origMtl.brdf_type == 4 then( -- Vray GGX
							if owner.converterTempData.glossyConversionOutputMapVrayGgxCoronaClGgx == undefined do(
								owner.converterTempData.glossyConversionOutputMapVrayGgxCoronaClGgx = owner.getGlossyConversionOutputMap #VrayGgxToClampedGgx
							)
							outmp = copy owner.converterTempData.glossyConversionOutputMapVrayGgxCoronaClGgx
						)else( -- all others using default Blinn
							if owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx == undefined do(
								owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx = owner.getGlossyConversionOutputMap #VrayBlinnToClampedGgx
							)
							outmp = copy owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx
						)
						outmp.map1 = r.texmapRefractGlossiness
						r.texmapRefractGlossiness = outmp
					)
					
					r.texmapOnRefractGlossiness = origMtl.texmap_refractionGlossiness_on 
					r.mapamountRefractGlossiness = origMtl.texmap_refractionGlossiness_multiplier --/ 100.0 
				)
				
				--Opacity
				r.levelOpacity = 1.0 
				r.colorOpacity = (color 255 255 255) 
				r.texmapOpacity = origMtl.texmap_opacity 
				if r.texmapOpacity != undefined then(
					r.texmapOnOpacity = origMtl.texmap_opacity_on 
					r.mapamountOpacity = origMtl.texmap_opacity_multiplier --/ 100.0 
				)
				
				--Bumpmap
				r.texmapBump = origMtl.texmap_bump 
				if r.texmapBump != undefined then(
					local texmapClass = classof r.texmapBump
					local isNormalMap = (texmapClass == VrayNormalMap or texmapClass == CoronaNormal or texmapClass == Normal_Bump)
					r.texmapOnBump = origMtl.texmap_bump_on 
					r.mapamountBump = (origMtl.texmap_bump_multiplier / 100.0) * (if isNormalMap then 1.0 else owner.converterSettings.vrayBumpMultiplier)
				)					
				
				--Absorption
				if origMtl.refraction_fogColor != white then(
					r.absorptionDistance = 1.0/origMtl.refraction_fogMult 
					r.absorptionColor = origMtl.refraction_fogColor 
				)
				if (hasProperty origMtl "texmap_refraction_fog") then(  -- vray < 2.5
					r.texmapAbsorption = origMtl.texmap_refraction_fog
					if r.texmapAbsorption != undefined then(
						r.absorptionDistance = 1.0/origMtl.refraction_fogMult 
						r.texmapOnAbsorption = origMtl.texmap_refraction_fog_on 
						r.mapamountAbsorption = origMtl.texmap_refraction_fog_multiplier --/ 100.0 
					)
				)
				
				--Translucency
				/*
				if origMtl.translucency_on > 0 then(
					r.scatterDirectionality = ((origMtl.translucency_fbCoeff - 0.5)*2) * -1
					r.scatterColor = origMtl.translucency_color
					r.texmapScatterColor = origMtl.texmap_translucent
					r.mapamountScatterColor = origMtl.texmap_translucent_multiplier
					r.texmapOnScatterColor = origMtl.texmap_translucent_on
				)
				*/
				
				--Anisotropy
				r.anisotropy = origMtl.anisotropy / 2.0 
				if origMtl.anisotropy_derivation == 0 and origMtl.anisotropy_axis == 2 then r.anisotropy = -r.anisotropy  -- flips the orientation
				
				if origMtl.texmap_anisotropy != undefined then(
					r.texmapReflectAnisotropy = output name:"CoronaAdaption" map1:origMtl.texmap_anisotropy rgb_offset:0.5 output_amount:0.5
					if origMtl.anisotropy_derivation == 0 and origMtl.anisotropy_axis == 2 then r.texmapReflectAnisotropy.output.invert = true  -- flips the orientation
				)
				if r.texmapReflectAnisotropy != undefined then(
					r.texmapOnAnisotropy = origMtl.texmap_anisotropy_on 
					r.mapamountAnisotropy = origMtl.texmap_anisotropy_multiplier --/ 100.0 
				)
				r.anisotropyRotation = origMtl.anisotropy_rotation 
				r.texmapReflectAnisotropyRotation = origMtl.texmap_anisotropy_rotation 
				if r.texmapReflectAnisotropyRotation != undefined then(
					r.texmapOnAnisotropyRotation = origMtl.texmap_anisotropy_rotation_on 
					r.mapamountAnisotropyRotation = origMtl.texmap_anisotropy_rotation_multiplier --/ 100.0 
				)
				r.anisotropyOrientationMode = origMtl.anisotropy_derivation
				r.anisotropyOrientationUvwChannel = origMtl.anisotropy_channel
				
				--Displacement
				r.texmapDisplace = origMtl.texmap_displacement 
				if r.texmapDisplace != undefined then(
					r.texmapOnDisplacement = origMtl.texmap_displacement_on
					if owner.converterSettings.clampDisp then r.displacementMaximum = owner.converterSettings.clampDispAmount
				)
				
				--SelfIllumination
				if hasProperty origMtl #selfIllumination then(
					if origMtl.selfIllumination == black and origMtl.texmap_self_illumination == undefined and origMtl.selfIllumination_multiplier == 1.0 then() else(
						r.levelSelfIllum = origMtl.selfIllumination_multiplier 
						r.colorSelfIllum = origMtl.selfIllumination
						r.texmapSelfIllum = origMtl.texmap_self_illumination 
						if r.texmapSelfIllum != undefined then(
							r.texmapOnSelfIllum = origMtl.texmap_self_illumination_on 
							r.mapamountSelfIllum = origMtl.texmap_self_illumination_multiplier --/ 100.0 
						)
					)
				)
				
				r
			),
			
			
			-- ############## VRay Carpaint Material ################
			fn convertFrom_VRayCarPaintMtl origMtl =(
				cpbaseMtl=CoronaMtl()
				cpbaseMtl.name = (if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				if origMtl.coat_strength > 0.0 then(
					cpbaseMtl.name = (if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + (origMtl.name + "_Base")
					cpCoatMtl=CoronaMtl()
					cpCoatMtl.name = (if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + (origMtl.name + "_Coat")
					cpBlendMtl=Blend()
					cpBlendMtl.name = (if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				)
				
				--Base Diffuse
				cpbaseMtl.levelDiffuse = 1.0 
				cpbaseMtl.colorDiffuse = origMtl.base_color 
				cpbaseMtl.texmapDiffuse = origMtl.texmap_base_color
				if cpbaseMtl.texmapDiffuse != undefined then(
					cpbaseMtl.texmapOnDiffuse = origMtl.texmap_base_color_on 
					cpbaseMtl.mapamountDiffuse = origMtl.texmap_base_color_multiplier --/ 100.0 
				)
				--Base Reflection
				cpbaseMtl.levelReflect = origMtl.base_reflection 
				cpbaseMtl.colorReflect = origMtl.base_color 
				cpbaseMtl.texmapReflect = origMtl.texmap_base_reflection 
				if cpbaseMtl.texmapReflect != undefined then(
					cpbaseMtl.texmapOnReflect = origMtl.texmap_base_reflection_on 
					cpbaseMtl.mapamountReflect = origMtl.texmap_base_reflection_multiplier --/ 100.0 
				)
				cpbaseMtl.fresnelIor = 50.0 
				cpbaseMtl.reflectGlossiness = (if owner.converterSettings.vrayConvertGlossyValues then(1.0 - sqrt(1.0 - origMtl.base_glossiness)) else(origMtl.base_glossiness) ) 
				cpbaseMtl.texmapReflectGlossiness = origMtl.texmap_base_glossiness 
				if cpbaseMtl.texmapReflectGlossiness != undefined then(
					if owner.converterSettings.vrayConvertGlossyMaps do (
						if owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx == undefined do(
							owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx = owner.getGlossyConversionOutputMap #VrayBlinnToClampedGgx
						)
						outmp = copy owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx
						outmp.map1 = cpbaseMtl.texmapReflectGlossiness
						cpbaseMtl.texmapReflectGlossiness = outmp
					)
					
					cpbaseMtl.texmapOnReflectGlossiness = origMtl.texmap_base_glossiness_on 
					cpbaseMtl.mapamountReflectGlossiness = origMtl.texmap_base_glossiness_multiplier --/ 100.0 
				)
				--Base Bumpmap
				cpbaseMtl.texmapBump = origMtl.texmap_base_bump 
				if cpbaseMtl.texmapBump != undefined then(
					cpbaseMtl.texmapOnBump = origMtl.texmap_base_bump_on 
					cpbaseMtl.mapamountBump = (origMtl.texmap_base_bump_multiplier / 100.0) * owner.converterSettings.vrayBumpMultiplier 
				)
				
				
				if cpBlendMtl != undefined then(
					--Coat Diffuse
					cpCoatMtl.levelDiffuse = 1.0 
					cpCoatMtl.colorDiffuse = (color 0 0 0)  
					--Coat Reflection
					cpCoatMtl.levelReflect = 1.0 
					cpCoatMtl.colorReflect = origMtl.coat_color 
					cpCoatMtl.texmapReflect = origMtl.texmap_coat_color 
					if cpCoatMtl.texmapReflect != undefined then(
						cpCoatMtl.texmapOnReflect = origMtl.texmap_coat_color_on 
						cpCoatMtl.mapamountReflect = origMtl.texmap_coat_color_multiplier --/ 100.0 
					)
					cpCoatMtl.fresnelIor = 25.0 
					cpCoatMtl.reflectGlossiness = (if owner.converterSettings.vrayConvertGlossyValues then(1.0 - sqrt(1.0 - origMtl.coat_glossiness)) else(origMtl.coat_glossiness) ) 
					cpCoatMtl.texmapReflectGlossiness = origMtl.texmap_coat_glossiness 
					if cpCoatMtl.texmapReflectGlossiness != undefined then(
						if owner.converterSettings.vrayConvertGlossyMaps do (
							if owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx == undefined do(
								owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx = owner.getGlossyConversionOutputMap #VrayBlinnToClampedGgx
							)
							outmp = copy owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx
							outmp.map1 = cpCoatMtl.texmapReflectGlossiness
							cpCoatMtl.texmapReflectGlossiness = outmp
						)
						
						cpCoatMtl.texmapOnReflectGlossiness = origMtl.texmap_coat_glossiness_on 
						cpCoatMtl.mapamountReflectGlossiness = origMtl.texmap_coat_glossiness_multiplier --/ 100.0 
					)
					--Coat Bumpmap
					cpCoatMtl.texmapBump = origMtl.texmap_coat_bump 
					if cpCoatMtl.texmapBump != undefined then(
						cpCoatMtl.texmapOnBump = origMtl.texmap_coat_bump_on 
						cpCoatMtl.mapamountBump = origMtl.texmap_coat_bump_multiplier / 100.0 
					)
					
					cpBlendMtl.MAP1 = cpbaseMtl
					cpBlendMtl.MAP2 = cpCoatMtl
					cpBlendMtl.mixAmount = origMtl.coat_strength*100.0
					if origMtl.texmap_coat_strength != undefined then(
						cpBlendMtl.maskEnabled = origMtl.texmap_coat_strength_on 
						cpBlendMtl.Mask = origMtl.texmap_coat_strength
					)
					
					cpBlendMtl
				)
				else(
					cpbaseMtl
				)
			),
			
			
			-- ############## MR Car_Paint_Material ################ 
			fn convertFrom_MRCarPaintMaterial origMtl =(
				cpbaseMtl=CoronaMtl()
				cpbaseMtl.name = (if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + (origMtl.name + "_Base")
				cpCoatMtl=CoronaMtl()
				cpCoatMtl.name = (if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + (origMtl.name + "_Coat")
				cpBlendMtl=Blend()
				cpBlendMtl.name = (if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				--Base Diffuse
				cpbaseMtl.levelDiffuse = 1.0 
				cpbaseMtl.colorDiffuse = (color 0 0 0)
				cpbaseMtl.texmapDiffuse = falloff() 
				cpbaseMtl.texmapOnDiffuse = true
				cpbaseMtl.texmapDiffuse.color1 = origMtl.base_color
				cpbaseMtl.texmapDiffuse.color2 = origMtl.edge_color
				cpbaseMtl.texmapDiffuse.MAP1 = origMtl.base_color_shader
				cpbaseMtl.texmapDiffuse.MAP2 = origMtl.edge_color_shader
				
				--Base Reflection
				cpbaseMtl.levelReflect = 1.0 
				cpbaseMtl.texmapReflect = cpbaseMtl.texmapDiffuse
				cpbaseMtl.fresnelIor = 2.5 
				cpbaseMtl.reflectGlossiness = 0.3
				
				--Coat Diffuse
				cpCoatMtl.levelDiffuse = 1.0 
				cpCoatMtl.colorDiffuse = (color 0 0 0) 
				--Coat Reflection
				cpCoatMtl.levelReflect = 1.0 
				cpCoatMtl.colorReflect = origMtl.reflection_color 
				cpCoatMtl.fresnelIor = 2.5 
				
				cpBlendMtl.MAP1 = cpbaseMtl
				cpBlendMtl.MAP2 = cpCoatMtl
				cpBlendMtl.mixAmount = 20.0
				
				cpBlendMtl
			),
			
			
			-- ############## MR_ArchAndDesign Material ################
			fn convertFrom_ArchAndDesign origMtl =(
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				--Diffuse
				r.levelDiffuse = origMtl.diff_weight 
				r.colorDiffuse = (color origMtl.diff_color.r origMtl.diff_color.g origMtl.diff_color.b)  -- is not converting rgba colors, therefore r,g,b seperation 
				r.texmapDiffuse = origMtl.diff_color_map 
				if r.texmapDiffuse != undefined then(
					r.texmapOnDiffuse = origMtl.diff_color_map_on 
				)
				
				--Reflection
				r.levelReflect = origMtl.refl_weight 
				r.colorReflect = (color origMtl.refl_color.r origMtl.refl_color.g origMtl.refl_color.b) 
				r.texmapReflect = origMtl.refl_color_map 
				if r.texmapReflect != undefined then(
					r.texmapOnReflect = origMtl.refl_color_map_on  
				)
				r.fresnelIor = if origMtl.refr_ior < 1.0 then 1.0 else origMtl.refr_ior  -- must use refraction ior since there is no seperate ior setting for reflection, maybe i'll add some "conversion" later 
				r.texmapFresnelIor = origMtl.refr_ior_map 
				if r.texmapFresnelIor != undefined then(
					r.texmapOnFresnelIor = (origMtl.refr_ior_map_on AND origMtl.refl_func_fresnel)  -- only active when global ior map on AND brdf radiobutton set to "by IOR"  
				)
				r.reflectGlossiness = origMtl.refl_gloss   
				r.texmapReflectGlossiness = origMtl.refl_gloss_map 
				if r.texmapReflectGlossiness != undefined then(
					r.texmapOnReflectGlossiness = origMtl.refl_gloss_map_on 
				)
				
				--Refraction
				r.levelRefract = origMtl.refr_weight 
				r.colorRefract = (color origMtl.refr_color.r origMtl.refr_color.g origMtl.refr_color.b) 
				r.texmapRefract = origMtl.refr_color_map 
				if r.texmapRefract != undefined then(
					r.texmapOnRefract = origMtl.refr_color_map_on  
				)
				r.ior = if origMtl.refr_ior < 1.0 then 1.0 else(if origMtl.refr_ior > 10.0 then 10.0 else origMtl.refr_ior) 
				r.texmapIor = origMtl.refr_ior_map 
				if r.texmapIor != undefined then(
					r.texmapOnIor = origMtl.refr_color_map_on 
				)
				r.refractGlossiness = origMtl.refr_gloss 
				r.texmapRefractGlossiness = origMtl.refr_gloss_map 
				if r.texmapRefractGlossiness != undefined then(
					r.texmapOnRefractGlossiness = origMtl.refr_gloss_map_on 
				)
				
				-- Glassmode
				if origMtl.opts_1sided == off then() else r.thin = true
				
				--Translucency
				if origMtl.refr_trans_on == false then(
					r.levelTranslucency = 0.0
				)
				else(
					--r.levelTranslucency = origMtl.refr_transw
					r.levelTranslucency = origMtl.refr_weight
					r.levelRefract = (1- origMtl.refr_transw)
				)
				r.colorTranslucency = (color origMtl.refr_transc.r origMtl.refr_transc.g origMtl.refr_transc.b) 
				r.texmapTranslucency = origMtl.refr_transc_map 
				if r.texmapTranslucency != undefined then(
					r.texmapOnTranslucency = origMtl.refr_transc_map_on 
				)
				
				--Opacity
				r.levelOpacity = 1.0 
				r.colorOpacity = (color 255 255 255) 
				r.texmapOpacity = origMtl.cutout_map 
				if r.texmapOpacity != undefined then(
					r.texmapOnOpacity = origMtl.cutout_map_on 
				)
				
				--Emission
				if origMtl.self_illum_on then r.levelSelfIllum = origMtl.self_illum_int_arbitrary 
				r.colorSelfIllum = (color origMtl.self_illum_color_filter.r origMtl.self_illum_color_filter.g origMtl.self_illum_color_filter.b)
				r.texmapSelfIllum = origMtl.self_illum_map 
				if r.texmapSelfIllum != undefined then(
					r.texmapOnSelfIllum = origMtl.self_illum_map_on 
				)
				
				--Bumpmap
				r.texmapBump = origMtl.bump_map 
				if r.texmapBump != undefined then(
					r.texmapOnBump = origMtl.bump_map_on 
					r.mapamountBump = origMtl.bump_map_amt * 3.5
				)
				
				--RoundedCorners
				if origMtl.opts_round_corners_on then(
					local rcmap = CoronaRoundEdges()
					rcmap.radius = origMtl.opts_round_corners_radius
					rcmap.mapAdditionalBump = r.texmapBump
					rcmap.mapOnAdditional = r.texmapOnBump
					r.texmapBump = rcmap
				)
				
				--Anisotropy
				r.anisotropy = if origMtl.anisotropy >= 1.0 then((origMtl.anisotropy-1.0)/9.0)else(origMtl.anisotropy-1.0)   
				r.texmapReflectAnisotropy = origMtl.anisotropy_map 
				if r.texmapReflectAnisotropy != undefined then(
					r.texmapOnAnisotropy = origMtl.anisotropy_map_on 
				)
				r.anisotropyRotation = origMtl.anisoangle 
				r.texmapReflectAnisotropyRotation = origMtl.anisoangle_map 
				if r.texmapReflectAnisotropyRotation != undefined then(
					r.texmapOnAnisotropyRotation = origMtl.anisoangle_map_on 
				)
				--Displacement
				r.texmapDisplace = origMtl.displacement_map 
				if r.texmapDisplace != undefined then(
					r.texmapOnDisplacement = origMtl.displacement_map_on 
					if owner.converterSettings.clampDisp then r.displacementMaximum = owner.converterSettings.clampDispAmount
				)
				
				r
			),
			
			
			-- ############## fR Advanced Material ################
			fn convertFrom_fR_Advanced origMtl =(
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				--Diffuse
				r.levelDiffuse = if origMtl.diffuseMultiplier > 100.0 then(1.0) else (origMtl.diffuseMultiplier / 100.0) 
				r.colorDiffuse = origMtl.diffuseColor 
				r.texmapDiffuse = origMtl.diffuseMap 
				if r.texmapDiffuse != undefined then(
					r.texmapOnDiffuse = origMtl.useDiffuseMap
					r.mapamountDiffuse = origMtl.diffuseMapAmount --/100.0 
				)
				
				--Reflection
				r.levelReflect = 1.0 
				r.colorReflect = origMtl.reflectFilter 
				r.texmapReflect = origMtl.reflectMap 
				if r.texmapReflect != undefined then(
					r.texmapOnReflect = origMtl.useReflectMap 
					r.mapamountReflect = origMtl.reflectMapAmount --/ 100.0 
				)
				r.fresnelIor = if origMtl.reflectIOR < 1.0 then 1.0 else origMtl.reflectIOR 
				r.texmapFresnelIor = origMtl.reflectIORMap 
				if r.texmapFresnelIor != undefined then(
					r.texmapOnFresnelIor = origMtl.useReflectIORMap 
					r.mapamountFresnelIor = origMtl.reflectIORMapAmount --/ 100.0 
				)
				r.reflectGlossiness = (1.0-(origMtl.reflectGlossy /100.0)) 
				r.texmapReflectGlossiness = origMtl.reflectBlurryMap 		-- !! Might want to add a invert map here to match others engines 1-0 range !!
				if r.texmapReflectGlossiness != undefined then(
					r.texmapOnReflectGlossiness = origMtl.useReflectBlurryMap 
					r.mapamountReflectGlossiness = origMtl.reflectBlurryMapAmount --/ 100.0 
				)
				
				--Refraction
				r.levelRefract = 1.0 
				r.colorRefract = origMtl.refractFilter 
				r.texmapRefract = origMtl.refractMap 
				if r.texmapRefract != undefined then(
					r.texmapOnRefract = origMtl.useRefractMap 
					r.mapamountRefract = origMtl.refractMapAmount --/ 100.0
				)
				r.ior = if origMtl.refractIOR < 1.0 then 1.0 else(if origMtl.refractIOR > 10.0 then 10.0 else origMtl.refractIOR) 
				r.texmapIor = origMtl.refractIORMap 
				if r.texmapIor != undefined then(
					r.texmapOnIor = origMtl.useRefractIORMap 
					r.mapamountIor = origMtl.refractIORMapAmount --/ 100.0 
				)
				r.refractGlossiness = (1.0-(origMtl.refractGlossy /100.0))
				r.texmapRefractGlossiness = origMtl.refractBlurryMap 
				if r.texmapRefractGlossiness != undefined then(
					r.texmapOnRefractGlossiness = origMtl.useRefractBlurryMap 
					r.mapamountRefractGlossiness = origMtl.refractBlurryMapAmount --/ 100.0 
				)
				
				--Opacity
				r.levelOpacity = 1.0 
				r.colorOpacity = (color 255 255 255) 
				r.texmapOpacity = origMtl.opacityMap
				if r.texmapOpacity != undefined then(
					r.texmapOnOpacity = origMtl.useOpacityMap 
					r.mapamountOpacity = origMtl.opacityMapAmount --/ 100.0 
				)
				
				--Emission
				r.levelSelfIllum = origMtl.selfIllumMultiplier/100.0 
				r.colorSelfIllum = origMtl.selfIllum 
				r.texmapSelfIllum = origMtl.selfillumMap 
				if r.texmapSelfIllum != undefined then(
					r.texmapOnSelfIllum = origMtl.useSelfIllumMap 
					r.mapamountSelfIllum = origMtl.selfillumMapAmount --/100.0 
				)
				
				--Bumpmap
				r.texmapBump = origMtl.bumpMap 
				if r.texmapBump != undefined then(
					r.texmapOnBump = origMtl.useBumpMap 
					r.mapamountBump = origMtl.bumpMapAmount/100.0 
				)
				
				--Absorption
				if origMtl.useRefrAbsorption == true then(
					r.absorptionDistance = origMtl.refrAbsorption 
					r.absorptionColor = origMtl.refrAbsorpColor 
				)
				
				--Anisotropy
				r.anisotropy = origMtl.Anisotropic/100.0
				r.texmapReflectAnisotropy = origMtl.anisoAmountReflectionMap 
				if r.texmapReflectAnisotropy != undefined then(
					r.texmapOnAnisotropy = origMtl.useAnisoAmountReflectionMap 
					r.mapamountAnisotropy = origMtl.anisoAmountReflectionMapAmount --/100.0 
				)
				r.anisotropyRotation = origMtl.orientation 
				r.texmapReflectAnisotropyRotation = origMtl.anisoOrientationReflectionMap 
				if r.texmapReflectAnisotropyRotation != undefined then(
					r.texmapOnAnisotropyRotation = origMtl.useAnisoOrientationReflectionMap 
					r.mapamountAnisotropyRotation = origMtl.anisoOrientationReflectionMapAmount --/100.0 
				)
				--Displacement
				r.texmapDisplace = origMtl.MTDMap 
				if r.texmapDisplace != undefined then(
					r.texmapOnDisplacement = origMtl.useMTDMap 
					if owner.converterSettings.clampDisp then r.displacementMaximum = owner.converterSettings.clampDispAmount
				)
				
				r
			),
			
			
			-- ############## fR Architectural Material ################
			fn convertFrom_fR_Architectural origMtl =(
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				--Diffuse
				r.levelDiffuse = if origMtl.diffuse_weight > 1.0 then(1.0) else(origMtl.diffuse_weight)
				r.colorDiffuse = origMtl.diffuse_color 
				r.texmapDiffuse = origMtl.diffcolor_map 
				if r.texmapDiffuse != undefined then(
					r.texmapOnDiffuse = origMtl.use_diffcolor_map 
				)
				
				--Reflection
				r.levelReflect = origMtl.reflectivity 
				r.colorReflect = (color origMtl.refl_color.r origMtl.refl_color.g origMtl.refl_color.b)
				r.texmapReflect = origMtl.reflcolor_map 
				if r.texmapReflect != undefined then(
					r.texmapOnReflect = origMtl.use_reflcolor_map 
				)
				r.fresnelIor = if origMtl.refr_ior < 1.0 then 1.0 else origMtl.refr_ior -- must use refraction ior since there is no seperate ior setting for reflection, maybe i'll add some "conversion" later 
				r.texmapFresnelIor = origMtl.ior_map 
				if r.texmapFresnelIor != undefined then(
					r.texmapOnFresnelIor = (origMtl.use_ior_map AND origMtl.brdf_fresnel)  -- only active when global ior map on AND brdf radiobutton set to "by IOR" 
				)
				r.reflectGlossiness = origMtl.refl_gloss   
				r.texmapReflectGlossiness = origMtl.reflgloss_map 
				if r.texmapReflectGlossiness != undefined then(
					r.texmapOnReflectGlossiness = origMtl.use_reflgloss_map 
				)
				
				--Refraction
				r.levelRefract = origMtl.transparency 
				r.colorRefract = (color origMtl.refr_color.r origMtl.refr_color.g origMtl.refr_color.b) 
				r.texmapRefract = origMtl.refrcolor_map 
				if r.texmapRefract != undefined then(
					r.texmapOnRefract = origMtl.use_refrcolor_map  
				)
				r.ior = if origMtl.refr_ior < 1.0 then 1.0 else(if origMtl.refr_ior > 10.0 then 10.0 else origMtl.refr_ior) 
				r.texmapIor = origMtl.ior_map 
				if r.texmapIor != undefined then(
					r.texmapOnIor = origMtl.use_ior_map 
				)
				r.refractGlossiness = origMtl.refr_gloss 
				r.texmapRefractGlossiness = origMtl.refrgloss_map 
				if r.texmapRefractGlossiness != undefined then(
					r.texmapOnRefractGlossiness = origMtl.use_refrgloss_map 
				)
				
				-- Glassmode
				r.thin = if origMtl.thin_walled == 0 then false else true
				
				--Translucency
				if origMtl.refr_translucency == false then(
					r.levelTranslucency = 0.0
				)
				else(
					--r.levelTranslucency = origMtl.refr_transw
					r.levelTranslucency = origMtl.transparency
					r.levelRefract = (1- origMtl.refr_trans_weight)
				)
				r.colorTranslucency = (color origMtl.refr_trans_color.r origMtl.refr_trans_color.g origMtl.refr_trans_color.b)
				r.texmapTranslucency = origMtl.transcolor_map
				if r.texmapTranslucency != undefined then(
					r.texmapOnTranslucency = origMtl.use_transcolor_map 
				)
				
				--Opacity
				r.levelOpacity = 1.0 
				r.colorOpacity = (color 255 255 255) 
				r.texmapOpacity = origMtl.cutout_map
				if r.texmapOpacity != undefined then(
					r.texmapOnOpacity = origMtl.use_cutout_map 
				)
				
				--Emission
				if origMtl.self_illumination_on then r.levelSelfIllum = origMtl.self_illum_intensity 
				r.colorSelfIllum = (color origMtl.self_illum_filter.r origMtl.self_illum_filter.g origMtl.self_illum_filter.b) 
				r.texmapSelfIllum = origMtl.selfillum_map 
				if r.texmapSelfIllum != undefined then(
					r.texmapOnSelfIllum = origMtl.use_selfillum_map 
				)
				
				--Bumpmap
				r.texmapBump = origMtl.bump_map 
				if r.texmapBump != undefined then(
					r.texmapOnBump = origMtl.use_bump_map 
					r.mapamountBump = origMtl.bump_map_amount 
				)
				
				--RoundedCorners
				if origMtl.roundcorners_on then(
					local rcmap = CoronaRoundEdges()
					rcmap.radius = origMtl.roundcorners_radius
					rcmap.mapAdditionalBump = r.texmapBump
					rcmap.mapOnAdditional = r.texmapOnBump
					r.texmapBump = rcmap
				)
				
				--Anisotropy
				r.anisotropy = if origMtl.anisotropy > 1.0 then((origMtl.anisotropy-1.0)/9.0)else(origMtl.anisotropy-1.0) 
				r.texmapReflectAnisotropy = origMtl.anisotropy_map 
				if r.texmapReflectAnisotropy != undefined then(
					r.texmapOnAnisotropy = origMtl.use_anisotropy_map 
				)
				r.anisotropyRotation = origMtl.anisotropy_rotation 
				r.texmapReflectAnisotropyRotation = origMtl.anisorot_map 
				if r.texmapReflectAnisotropyRotation != undefined then(
					r.texmapOnAnisotropyRotation = origMtl.use_anisorot_map 
				)
				
				--Displacement
				r.texmapDisplace = origMtl.displacement_map 
				if r.texmapDisplace != undefined then(
					r.texmapOnDisplacement = origMtl.use_displacement_map 
					if owner.converterSettings.clampDisp then r.displacementMaximum = owner.converterSettings.clampDispAmount
				)
				
				r
			),
			
			
			-- ############## Autodesk Materials ################
			fn convertFrom_AutodeskMtl origMtl =(
				owner.converterTempData.AD_mats_found = true
				for elem in (refs.dependentNodes origMtl) do appendIfUnique owner.converterTempData.foundAdskMtls elem
				
				matName = origMtl.name
				if origMtl.definitionID != "Generic" then(
					origMtl = origMtl.ConvertToGeneric 
				)
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + matName
				
				--Diffuse
				r.colorDiffuse = origMtl.Generic_Color as color  
				r.texmapDiffuse = origMtl.Generic_Image 
				
				if r.texmapDiffuse != undefined then (
					r.texmapOnDiffuse = true
					r.mapamountDiffuse = origMtl.Generic_Image_Fade --/ 100.0
				)
				
				--Reflection
				if origMtl.Reflectivity_Enable then(
					r.levelReflect = (origMtl.Reflectivity_Direct / 100.0)
					if origMtl.Reflectivity_Direct_Option == 1 then r.texmapReflect = origMtl.Reflectivity_Direct_Map 
					if r.texmapReflect != undefined then(
						r.texmapOnReflect = true   
					)
					r.fresnelIor = 20.0
				)
				r.reflectGlossiness = origMtl.Generic_Glossiness -- / 100.0 
				
				--Refraction
				if origMtl.Transparency_Enable then(
					r.levelRefract = origMtl.Transparency_Amount / 100.0 
					r.colorRefract = white  
					r.texmapRefract = origMtl.Transparency_Image 
					if r.texmapRefract != undefined then(
						r.texmapOnRefract = true  
						r.mapamountRefract = origMtl.Transparency_Image_Fade --/ 100.0
					)
					r.ior = origMtl.Transparency_Refraction
				)
				
				--Opacity
				if origMtl.Cutouts_Enable then(
					r.levelOpacity = 1.0 
					r.colorOpacity = (color 255 255 255) 
					r.texmapOpacity = origMtl.Cutouts_Image 
					if r.texmapOpacity != undefined then(
						r.texmapOnOpacity = origMtl.Cutouts_Enable
					)
				)
				
				--Emission
				if origMtl.Self_Illumination_Enable then(
					r.levelSelfIllum = (origMtl.Self_Illumination_Luminance / 100.0)
					r.colorSelfIllum = origMtl.Self_Illumination_Filter_Color
					if origMtl.Self_Illumination_Filter_Color_Option == 1 then r.texmapSelfIllum = origMtl.Self_Illumination_Filter_Color_Map 
					if r.texmapSelfIllum != undefined then(
						r.texmapOnSelfIllum = true
					)
				)
				
				--Bumpmap
				if origMtl.Bump_Enable then(
					r.texmapBump = origMtl.Bump_Image
					if r.texmapBump != undefined then(
						r.texmapOnBump = true
						r.mapamountBump = (if origMtl.bump_amount / 100.0 > 0.3 then 0.3 else origMtl.bump_amount / 100.0) 
					)
				)
				
				r
			),
			
			
			-- ############## VrayBlend Material ################
			fn convertFrom_VrayBlendMtl origMtl =(
				/*
				if owner.converterSettings.vrayblendToMultilayerdBlend then(
					r = blend()
					r.map1 = origMtl.baseMtl
					tmpNum = 1
					for i = 1 to origMtl.coatMtl.count do(
						if origMtl.coatMtl[i] != undefined then(
							tmpNum +=1
							if tmpNum > 2 then(
								r = blend map1:r map2:origMtl.coatMtl[i]
								r.mixAmount = origMtl.Blend[i].r/2.55
								if origMtl.texmap_blend[i] != undefined AND origMtl.texmap_blend_multiplier[i] != 0 then(
									r.Mask = origMtl.texmap_blend[i]
								)
							)
							else(
								r.map2 = origMtl.coatMtl[i]
								r.mixAmount = origMtl.Blend[i].r/2.55
								if origMtl.texmap_blend[i] != undefined AND origMtl.texmap_blend_multiplier[i] != 0 then(
									r.Mask = origMtl.texmap_blend[i]
								)
							)
						)
					)
				)
				else(
					r=(getSubMtl origMtl 1)
				)
				*/
				
				r=CoronaLayeredMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				r.baseMtl = origMtl.baseMtl
				for layerID = 1 to origMtl.coatMtl.count do(
					r.layers[layerID] = origMtl.coatMtl[layerID]
					r.mixmaps[layerID] = origMtl.texmap_blend[layerID]
					r.amounts[layerID] = origMtl.blend[layerID].value / 255.0 * 100.0
				)
				
				if hasProperty origMtl #coatMtl_enable then(  -- Vray 3.3
					for layerID = 1 to origMtl.coatMtl_enable.count do(
						if origMtl.coatMtl_enable[layerID] == false then r.amounts[layerID] = 0.0
					)
				)
				
				
				r
			),
			
			
			-- ############## VrayLight Material ################
			fn convertFrom_VrayLightMtl origMtl = (
				r=CoronaLightMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				r.color = origMtl.color 
				r.intensity = origMtl.multiplier
				r.emitLight = origMtl.directLight_on
				if origMtl.texmap != undefined then(
					r.texmapOn = origMtl.texmap_on
					r.texmap = origMtl.texmap
				)
				if origMtl.opacity_texmap != undefined then(
					r.opacityTexmapOn = origMtl.opacity_texmap_on
					r.opacityTexmap = origMtl.opacity_texmap
				)
				
				r
			),
			
			
			-- ############## Vray2Sided Material ################
			fn convertFrom_Vray2sidedMtl origMtl = (
				-- currently just taking 2sided mats slot 1 and setting translucency in material from 2sided options
				r=origMtl.frontMtl	
				if r != undefined and classof r == CoronaMtl do (
					r.thin = true
					r.levelTranslucency = (origMtl.Translucency.r + origMtl.Translucency.g + origMtl.Translucency.b)/3.0/255
					
					if origMtl.texmap_translucency != undefined then(
						r.colorTranslucency = origMtl.Translucency  -- translucency color from 2sided transl.
						r.texmapTranslucency = origMtl.texmap_translucency
						r.texmapOnTranslucency = true
					)
					else(
						r.colorTranslucency = r.colorDiffuse  -- translucency color from diffuse
						
						if r.texmapDiffuse != undefined then(
							r.texmapTranslucency = r.texmapDiffuse 
							r.texmapOnTranslucency = true
						)
					)
					
				)
				if origMtl.frontMtl	== undefined then r = origMtl
				
				r
			),
			
			
			-- ############## VRayFastSSS Material ################
			fn convertFrom_VRayFastSSS origMtl = (
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				r.colorDiffuse = origMtl.shallow_color
				
				r
			),
			
			
			-- ############## VRayFastSSS2 Material ################
			fn convertFrom_VRayFastSSS2 origMtl = (
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				
				--Diffuse
				r.levelDiffuse = 1.0 
				r.colorDiffuse = origMtl.diffuse_color 
				r.texmapDiffuse = origMtl.texmap_diffuse_color 
				if r.texmapDiffuse != undefined then(
					r.texmapOnDiffuse = origMtl.texmap_diffuse_color_on 
					r.mapamountDiffuse = origMtl.texmap_diffuse_color_multiplier 
				)
				
				--Reflection
				r.levelReflect = 1.0
				r.colorReflect = origMtl.specular_color 
				
				r.texmapReflect = origMtl.texmap_specular_color 
				if r.texmapReflect != undefined then(
					r.texmapOnReflect = origMtl.texmap_specular_color_on 
					r.mapamountReflect = origMtl.texmap_specular_color_multiplier
				)
				
				r.fresnelIor = origMtl.ior
				
				r.reflectGlossiness = (if owner.converterSettings.vrayConvertGlossyValues then(1.0 - sqrt(1.0 - origMtl.specular_glossiness)) else(origMtl.specular_glossiness) ) 
				r.texmapReflectGlossiness = origMtl.texmap_specular_glossiness 
				if r.texmapReflectGlossiness != undefined then(
					if owner.converterSettings.vrayConvertGlossyMaps do (
						if owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx == undefined do(
							owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx = owner.getGlossyConversionOutputMap #VrayBlinnToClampedGgx
						)
						outmp = copy owner.converterTempData.glossyConversionOutputMapVrayBlinnCoronaClGgx
						outmp.map1 = r.texmapReflectGlossiness
						r.texmapReflectGlossiness = outmp
					)
					
					r.texmapOnReflectGlossiness = origMtl.texmap_specular_glossiness_on
					r.mapamountReflectGlossiness = origMtl.texmap_specular_glossiness_multiplier 
				)
				
				--Refraction
				r.ior = origMtl.ior
				
				--Opacity
				if hasProperty origMtl #texmap_opacity then (  -- NEW in Vray 3.10.01
					r.levelOpacity = 1.0 
					r.colorOpacity = (color 255 255 255) 
					r.texmapOpacity = origMtl.texmap_opacity 
					if r.texmapOpacity != undefined then(
						r.texmapOnOpacity = origMtl.texmap_opacity_on 
						r.mapamountOpacity = origMtl.texmap_opacity_multiplier --/ 100.0 
					)
				)
				
				--Bumpmap
				r.texmapBump = origMtl.texmap_bump 
				if r.texmapBump != undefined then(
					r.texmapOnBump = origMtl.texmap_bump_on 
					r.mapamountBump = (origMtl.texmap_bump_multiplier / 100.0) * owner.converterSettings.vrayBumpMultiplier 
				)
				
				--Displacement
				r.texmapDisplace = origMtl.texmap_displacement 
				if r.texmapDisplace != undefined then(
					r.texmapOnDisplacement = origMtl.texmap_displacement_on
					if owner.converterSettings.clampDisp then r.displacementMaximum = owner.converterSettings.clampDispAmount
				)
				
				r
			),
			
			
			-- ############## VrayOverrideMtl Material ################
			fn convertFrom_VrayOverrideMtl origMtl = (
				r=CoronaRaySwitchMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				r.directMtl = origMtl.baseMtl
				if origMtl.giMtl != undefined then r.giMtl = origMtl.giMtl else r.giMtl = r.directMtl
				if origMtl.reflectMtl != undefined then r.reflectMtl = origMtl.reflectMtl else r.reflectMtl = r.directMtl
				if origMtl.refractMtl != undefined then r.refractMtl = origMtl.refractMtl else r.refractMtl = r.directMtl
				
				r
			),
			
			
			-- ############## VrayMtlWrapper Material ################
			fn convertFrom_VrayMtlWrapper origMtl = (
				r
				if origMtl.baseMtl != undefined then(
					r=origMtl.baseMtl
				)else(
					r=CoronaMtl()
					r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				)
				
				r
			),
			
			-- ############## Architectural Material ################
			fn convertFrom_Architectural origMtl = (
				r=CoronaMtl()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origMtl.name
				
				--Diffuse
				r.levelDiffuse = 1.0 
				r.colorDiffuse = origMtl.Diffuse 
				r.texmapDiffuse = origMtl.diffuseMap 
				if r.texmapDiffuse != undefined then(
					r.texmapOnDiffuse = origMtl.diffuseMapEnable 
					r.mapamountDiffuse = origMtl.diffuseMapAmount 
				)
				
				--Bumpmap
				r.texmapBump = origMtl.bumpMap 
				if r.texmapBump != undefined then(
					r.texmapOnBump = origMtl.bumpMapEnable 
					r.mapamountBump = origMtl.bumpMapAmount / 100.0 
				)
				
				--Opacity
				r.levelOpacity = 1.0 
				r.colorOpacity = (color 255 255 255) 
				r.texmapOpacity = origMtl.cutoutMap 
				if r.texmapOpacity != undefined then(
					r.texmapOnOpacity = origMtl.cutoutMapEnable 
					r.mapamountOpacity = origMtl.cutoutMapAmount --/ 100.0 
				)
				
				r
			),
			
			
			-- ############## Shellac Material ################
			fn convertFrom_Shellac origMtl = (
				r=Blend()
				r.name=origMtl.name
				
				r.map1 = origMtl.shellacMtl1
				r.map2 = origMtl.shellacMtl2
				
				r
			)
		)
		matConvMethods owner:this
	),
	
	mapConvMethods =(
		struct mapConvMethods 
		(
			owner,
			
			-- ############## Bitmaptexture ################
			fn convertFrom_BitmapTexture origMap =(
				r = CoronaBitmap()
				r.name = origMap.name
				doNotConvert = false
				
				-- filename, output
				if origMap.fileName != "" and origMap.fileName != undefined then( 
					type = getFilenameType origMap.fileName
					if (findItem #(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".exr", ".tif", ".tiff", ".tga", ".hdr") (toLower type)) != 0 then(
						r.filename = origMap.fileName
						
						-- gamma handling, ONLY max 2014+
						local isValidMap = true
						try(origMap.bitmap)catch(isValidMap = false)
						if (maxVersion())[1] >= 16000 and isValidMap then (
							local gammaOrig = origMap.bitmap.inputGamma
							if classof gammaOrig == Float do(
								r.gamma = gammaOrig
							)
						)	
					)
					else(
						doNotConvert = true
					)
				)else(
					doNotConvert = true
				)
				r.output = origMap.output
				
				
				-- uv channel, environment mode
				r.uvwChannel = origMap.coords.mapChannel
				if origMap.coords.mappingType == 0 and origMap.coords.mapping == 1 then r.uvwChannel = 0
				
				if origMap.coords.mappingType == 1 then (
					case origMap.coords.mapping of (
						0: r.enviroMapping = 0
						1: r.enviroMapping = 0
						2: r.enviroMapping = 0
						3: r.enviroMapping = 1
					)
				)else(
					r.enviroMapping = 0
				)
				
				-- blur
				r.filteringBlur = origMap.coords.blur
				
				-- alpha source, mono channel out, rgb channel out
				r.alphaSource = origMap.alphaSource
				r.monoChannelOutput = origMap.monoOutput
				r.rgbChannelOutput = origMap.rgbOutput
				
				-- offset, tiling/scale, rotation, rw mapscale
				r.realWorldScale = origMap.coords.realWorldScale
				r.uvwOffset = [origMap.coords.U_Offset, origMap.coords.V_Offset, 0]
				if r.realWorldScale then (
					r.uvwScale = [origMap.coords.realWorldWidth, origMap.coords.realWorldHeight, 1]
				)else(
					r.uvwScale = [origMap.coords.U_Tiling, origMap.coords.V_Tiling, 1]
				)
				
				uM = origMap.coords.U_Mirror
				uT = origMap.coords.U_Tile
				case tileChkU of (
					(uM == false and uT == false): r.tilingU = 0
					(uM == true and uT == false): r.tilingU = 2
					(uM == false and uT == true): r.tilingU = 1
				)
				vM = origMap.coords.V_Mirror
				vT = origMap.coords.V_Tile
				case tileChkV of (
					(vM == false and vT == false): r.tilingV = 0
					(vM == true and vT == false): r.tilingV = 2
					(vM == false and vT == true): r.tilingV = 1
				)
				r.uvwAngle = [0,0,origMap.coords.W_angle]
				
				-- crop/place
				r.clippingOn = origMap.apply
				r.clippingMode = origMap.cropPlace
				r.clippingU = origMap.clipu
				r.clippingV = origMap.clipv
				r.clippingWidth = origMap.clipw
				r.clippingHeight = origMap.cliph
				
				
				if doNotConvert then r = #NoReplacement
				
				r
			),	
			
			-- ############## VrayHDRI ################
			fn convertFrom_VrayHDRI origMap =(
				r = BitmapTexture()
				r.name = origMap.name
				doNotConvert = false
				
				-- filename, output
				if origMap.HDRIMapName == "" then(
					doNotConvert = true
				)
				r.fileName = origMap.HDRIMapName
				r.output = origMap.Output
				r.coords = origMap.coords
				
				-- Gamma handling
				if (maxversion())[1] >= 16000 and origMap.gamma != 1 then(
					r.bitmap = openBitmap r.bitmap.filename gamma:(1.0/origMap.gamma)
				)
				
				if origMap.mapType == 2 then(   -- spherical mode
					r.coords.mapping = 0 -- spherical
					r.coords.mappingType = 1 -- Environ
					r.coords.U_Offset = 0.25 + origMap.horizontalRotation / 360.0
					r.coords.V_Offset = origMap.verticalRotation / 180.0
					
					if origMap.horizontalFlip then(
						r.coords.U_Offset = 0.25 - origMap.horizontalRotation / 360.0
						r.coords.U_Tiling = -r.coords.U_Tiling
					)
					if origMap.verticalFlip then r.coords.V_Tiling = -r.coords.V_Tiling
				)
				
				-- alpha source, mono channel out, rgb channel out
				r.alphaSource = origMap.alphaSource
				r.monoOutput = origMap.monoOutput
				r.rgbOutput = if origMap.rgbOutput > 1 then 0 else origMap.rgbOutput
				
				-- crop/place
				r.apply = origMap.cropplace_on
				r.cropPlace = origMap.cropplace_mode
				r.clipu = origMap.cropplace_u
				r.clipv = origMap.cropplace_v
				r.clipw = origMap.cropplace_width
				r.cliph = origMap.cropplace_height
				
				r.output.output_amount *= origMap.multiplier * origMap.renderMultiplier
				
				if doNotConvert then r = #NoReplacement
				
				r
			),	
			
			-- ############## CoronaBitmap ################
			fn convertFrom_CoronaBitmap origMap =(
				r = Bitmaptexture()
				r.name = origMap.name
				doNotConvert = false
				
				-- filename, output
				if origMap.filename != "" and origMap.filename != undefined then(
					r.fileName = origMap.filename
					
					-- gamma handling, ONLY max 2014+
					if (maxVersion())[1] >= 16000 then (
						local gammaOrig = origMap.gamma
						if gammaOrig != -1.0 do(
							r.bitmap = openBitmap origMap.filename gamma:gammaOrig
						)
					)	
				)else(
					doNotConvert = true
				)
				r.output = origMap.output
				
				-- uv channel, environment mode
				if origMap.uvwChannel == 0 then (
					r.coords.mapping = 1
				)else(
					r.coords.mapChannel = origMap.uvwChannel
				)
				
				-- blur
				r.coords.blur = origMap.filteringBlur
				
				-- alpha source, mono channel out, rgb channel out
				r.alphaSource = origMap.alphaSource
				r.monoOutput = origMap.monoChannelOutput
				r.rgbOutput = origMap.rgbChannelOutput
				
				-- offset, tiling/scale, rotation, rw mapscale
				r.coords.realWorldScale = origMap.realWorldScale
				
				r.coords.U_Offset = origMap.uvwOffset[1]
				r.coords.V_Offset = origMap.uvwOffset[2]
				
				if origMap.realWorldScale then (
					r.coords.realWorldWidth = origMap.uvwScale[1]
					r.coords.realWorldHeight = origMap.uvwScale[2]
				)else(
					r.coords.U_Tiling = origMap.uvwScale[1]
					r.coords.V_Tiling = origMap.uvwScale[2]
				)
				
				case origMap.tilingU of (
					0: (r.coords.U_Mirror = false; r.coords.U_Tile = false)
					2: (r.coords.U_Mirror = true; r.coords.U_Tile = false)
					1: (r.coords.U_Mirror = false; r.coords.U_Tile = true)
				)
				case origMap.tilingV of (
					0: (r.coords.V_Mirror = false; r.coords.V_Tile = false)
					2: (r.coords.V_Mirror = true; r.coords.V_Tile = false)
					1: (r.coords.V_Mirror = false; r.coords.V_Tile = true)
				)
				r.coords.W_angle = origMap.uvwAngle[3]
				
				-- crop/place
				r.apply = origMap.clippingOn
				r.cropPlace = origMap.clippingMode
				r.clipu = origMap.clippingU
				r.clipv = origMap.clippingV
				r.clipw = origMap.clippingWidth
				r.cliph = origMap.clippingHeight
				
				if doNotConvert then r = #NoReplacement
				
				r
			),	
			
			-- ############## VrayColor ################
			fn convertFrom_VrayColor origMap = (
				r = CoronaColor()
				r.name = origMap.name
				
				r.color = origMap.color 
				r.name = origMap.name 
				r.multiplier = origMap.rgb_multiplier
				
				r
			),
			
			-- ############## Vray Dirt ################
			fn convertFrom_VrayDirt origMap =(
				r = CoronaAo()
				r.name = origMap.name
				
				r.colorOccluded = origMap.occluded_color 
				r.colorUnoccluded = origMap.unoccluded_color 
				r.maxDistance = origMap.radius 
				r.invert = origMap.invert_normal 
				r.texmapDistance = origMap.texmap_radius 
				r.texmapOccluded = origMap.texmap_occluded_color 
				r.texmapUnoccluded = origMap.texmap_unoccluded_color 
				r.excludeMode = 0
					
				if origMap.includeList != undefined and origMap.includeList.count != 0 then(
					r.includeMod = true
					r.excludeList = origMap.includeList
					r.excludeMode = 1
				)
				if origMap.excludeList != undefined and origMap.excludeList.count != 0 then(
					r.includeMod = false
					r.excludeList = origMap.excludeList
					r.excludeMode = 1
				)
				if origMap.consider_same_object_only then r.excludeMode = 3
					
				r
			),
			
			-- ############## Ambient_Reflective_Occlusion__3dsmax ################
			fn convertFrom_Ambient_Reflective_Occlusion__3dsmax origMap =(
				r = CoronaAo()
				r.name = origMap.name
				
				r.colorOccluded = origMap.dark 
				r.colorUnoccluded = origMap.bright 
				r.maxDistance = origMap.max_distance 
				r.invert = if origMap.output_mode == 5 then true else false
				r.texmapDistance = origMap.max_distance_shader 
				r.texmapOccluded = origMap.dark_shader
				r.texmapUnoccluded = origMap.bright_shader
					
				r
			),
			
			-- ############## Normal_Bump ################
			fn convertFrom_Normal_Bump origMap = (
				r = CoronaNormal()
				r.name = origMap.name
				
				r.multiplier = origMap.mult_spin 
				r.normalMap = origMap.normal_map
				
				r.flipRed = origMap.flipRed
				r.flipGreen = origMap.flipGreen
				r.swapRedGreen = origMap.swap_rg
				
				r.additionalBump = origMap.bump_map
				r.additionalBumpOn = origMap.map2on
				r.additionalBumpStrength = origMap.bump_spin
				
				r
			),
			
			-- ############## VrayNormalMap ################
			fn convertFrom_VrayNormalMap origMap = (
				r = CoronaNormal()
				r.name = origMap.name
				
				r.multiplier = 1.0
				r.normalMap = origMap.normal_map
				
				if hasProperty origMap #bump_map then(  -- Vray 3.3
					r.additionalBump = origMap.bump_map
					if r.additionalBump != undefined do(
						r.additionalBumpOn = origMap.bump_map_on
						r.additionalBumpStrength = origMap.bump_map_multiplier * owner.converterSettings.vrayBumpMultiplier
					)
				)
				
				r
			),
			
			-- ############## VraySky ################
			fn convertFrom_VraySky origMap = (
				r = CoronaSky()
				r.name = origMap.name
				
				r
			),
			
			-- ############## VRayCompTex ################ 
			fn convertFrom_VRayCompTex origMap = (
				r = CoronaMix()
				r.name = origMap.name
				
				r.texmapBottom = origMap.sourceA
				r.texmapTop = origMap.sourceB
				r.mixOperation = case origMap.operator of(
					0: 0 -- Add
					1: 1 -- subtract
					2: 8 -- difference
					3: 2 -- multiply
					4: 3 -- divide
					5: 4 -- minimum
					6: 5 -- maximum
					default:0
				)
				
				r
			),
			
			-- ############## VRayEdgesTex ################
			fn convertFrom_VRayEdgesTex origMap = (
				r = CoronaWire()
				r.name = origMap.name
				
				r.edgeColor = origMap.edgesColor 
				r.widthMode = (abs (origMap.widthType-1))
				r.edgeWidthWorld = origMap.thickness 
				r.edgeWidthPixels = origMap.pixelWidth 
				
				r
			),
			
			-- ############## VRayGLSLTex ################
			fn convertFrom_VRayGLSLTex origMap = (
				r = CoronaColor()
				r.name = origMap.name
				
				r.color = (color 127 127 127)
				
				r
			),
			
			-- ############## VRaySoftbox ################
			fn convertFrom_VRaySoftbox origMap = (
				r = CoronaColor()
				r.name = origMap.name
				
				r.color = (color 255 255 255)
				
				r
			),
			
			-- ############## Autodesk_Map ################
			fn convertFrom_Autodesk_Map origMap = (
				r 
				if hasProperty origMap "Parameters_Source" then(
					r = Bitmaptexture()
					r.name = origMap.name
					
					try(  -- Whacky, need bug testscene to solve further issues
						r.bitmap = origMap.Parameters_Source
					)
					catch()
					r.coords.realWorldScale = true
					r.coords.realWorldWidth = origMap.Scale_Width --/ 100
					r.coords.realWorldHeight  = origMap.Scale_Height --/ 100
					--r.coords.U_Offset = origMap.Position_X  -- broken in AD maps, thanks autodesk!
					--r.coords.V_Offset = origMap.Position_Y  -- broken in AD maps, thanks autodesk!
					
					r.coords.U_Tile = origMap.Repeat_Horizontal
					r.coords.V_Tile = origMap.Repeat_Vertical
					r.coords.mapChannel = origMap.Advanced_Parameters_Map_Channel
				)else(
					r = CoronaColor()
					r.name = origMap.name
					r.color = (color 127 127 127)
				)
				
				r
			),
			
			-- ############## Multi_Sub_Map ################
			fn convertFrom_Multi_Sub_Map origMap = (
				r = CoronaMultiMap()
				r.name = origMap.name
				
				case of (
					(origMap.num_colors < 2): r.items = 2
					(origMap.num_colors > 15): r.items = 15
					default: r.items = origMap.num_colors
				)
				r.mode = case origMap.mode of(
					0: 5 -- ObjectID
					1: 3 -- Material ID
					2: 5 -- smoothing group does not exist in corona -> ObjectID
					3: 2 -- random -> Instance
					default: 5
				)
				
				r.texmaps[1] = origMap.id_out_of_range_color_shader
				r.colors[1] = origMap.id_out_of_range_color
				for i = 1 to 13 do(
					r.texmaps[i+1] = getProperty origMap ("id_" + i as string + "_color_shader")
					r.colors[i+1] = getProperty origMap ("id_" + i as string + "_color")
				)
				
				r
			)
		)
		mapConvMethods owner:this
	),
	
	lightConvMethods =(
		struct lightConvMethods 
		(
			owner,
			
			-- ############## VrayLight ################
			fn convertFrom_VrayLight origLight = (
				r=CoronaLight intensityUnits:0
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origLight.name
				doNotConvert = false
				
				-- OnOff, Include/exclude
				r.on = origLight.on
				r.targeted = origLight.targeted
				case of (
					(origLight.includeList != undefined and origLight.includeList.count != 0): (
						r.excludeIncludeMod = true
						r.excludeList = origLight.includeList
					)
					(origLight.excludeList != undefined and origLight.excludeList.count != 0): (
						r.excludeIncludeMod = false
						r.excludeList = origLight.excludeList
					)
					default: ()
				)
				
				/*
				Corona: 0: Default W/(sr .m^2), 1: Lumen(lm), 2: candela (cd), 3:Lux (lx)
				Vray:   0: Default (image), 1 : luminous (lm), 2: lumincance (lm/m^2/sr), 3: radiant power (w), 4: radiance (w/m^2/sr)
				*/
				
				case origLight.normalizeColor of (
					0: ( -- default (image)
						r.intensity = origLight.multiplier
					)
					1: ( -- luminous (lm)
						r.intensityUnits = 1 -- corona lumen
						r.intensity = origLight.multiplier
					)
					2: ( -- luminance (lm/m^2/sr)
						r.intensityUnits = 0 -- corona default
						r.intensity = origLight.multiplier / 477.465 -- TEMPORARY, NOT ACCURATE
					)
					3: ( -- radiant power (w)
						r.intensityUnits = 1 -- corona lumen
						r.intensity = origLight.multiplier * 683.0
					)
					4: ( -- radiance (w/m^2/sr)
						r.intensityUnits = 0 -- corona default
						r.intensity = origLight.multiplier / 0.699 -- TEMPORARY, NOT ACCURATE
					)
				)
				
				
				r.colorMode = origLight.color_mode -- 0: direct color, 1: kelvin temp, 2: texmap
				r.color = origLight.color
				if r.colorMode == 1 do r.blackbodyTemp = origLight.color_temperature -- kelvin
				if origLight.texmap_on and origLight.texmap != undefined do(
					r.colorMode = 2
					r.texmap = origLight.texmap
				)
				
				fn getCoronaDirectionality vrVal curve =(
					local out
					local vrInt = ((vrVal * 100) as integer)
					
					local run = true
					for dataPoint in curve while run do(
						if ((dataPoint.x * 100) as integer) == vrInt then(
							out = dataPoint.y
							run = false
						)
					)
					out
				)
				
				--r.directionality = logit origLight.lightDistribution 10
				r.directionality = getCoronaDirectionality origLight.lightDistribution owner.converterSettings.vrayDirectionalityToCoronaDirectionality
				
				-- visibility
				r.twosidedEmission = origLight.DoubleSided
				r.visibleDirectly = not origLight.invisible
				r.visibleRefl = origLight.affect_reflections
				r.occludeOtherLights = origLight.castShadows
				
				-- shape   -- 0: plane, 1: dome, 2: sphere, 3: mesh, 4: disc
				case origLight.type of (
					0: ( r.shape = 1  -- Plane
						r.width = origLight.size0 * 2.0 
						r.height = origLight.size1 * 2.0
						
						if origLight.skylightPortal then(
							delete r
							if owner.converterTempData.crnSkyPortalMtl == undefined do(
								owner.converterTempData.crnSkyPortalMtl = CoronaPortalMtl()
							)
							owner.converterTempData.foundPortals = true
							
							r = Plane()
							r.width = origLight.size0 * 2
							r.length = origLight.size1 * 2
							r.lengthsegs = 1
							r.widthsegs = 1
							
							InstanceMgr.GetInstances origLight &rptInstances
							trueInstances = for n in rptInstances where (areNodesInstances origLight n) collect n
							for i in trueInstances do instanceReplace i r
							trueInstances.material = owner.converterTempData.crnSkyPortalMtl
							doNotConvert = true
						)
					)							
					1: doNotConvert = true -- dome
					2: ( r.shape = 0-- Sphere
						r.width = origLight.size0 
					)
					3:( -- mesh
						if hasproperty origLight #Shape_mesh do(
							delete r
							r = copy origLight
							mtl
							
							if origLight.skylightPortal then(
								if owner.converterTempData.crnSkyPortalMtl == undefined do(
									owner.converterTempData.crnSkyPortalMtl = CoronaPortalMtl()
								)
								owner.converterTempData.foundPortals = true
								mtl = owner.converterTempData.crnSkyPortalMtl
							)
							else(
								mtl = CoronaLightMtl()
								mtl.color = origLight.color
								mtl.intensity = origLight.multiplier
								mtl.emitLight = true
							)
							
							r.baseobject = r.Shape_mesh
							InstanceMgr.GetInstances origLight &rptInstances
							trueInstances = for n in rptInstances where (areNodesInstances origLight n) collect n
							for i in trueInstances do instanceReplace i r
							trueInstances.material = mtl
						)
						doNotConvert = true
					)
					4:(
						r.shape = 2  -- Disc
						r.width = origLight.size0  
					)
				)
				
				
				if doNotConvert then(
					delete r
					r = #NoReplacement
				)
				
				r
			),
			
			
			-- ############## StandardLights ################
			fn convertFrom_StandardLights origLight = (
				crnShd = CoronaShadows()
				useAS 
				asRad
				
				if (classof origLight.shadowgenerator) == VRayShadow do (
					useAS = origLight.AreaShadow
					asRad = origLight.usize
				)
				
				origLight.shadowgenerator = crnShd
				if useAS != undefined do origLight.areaShadows = useAS
				if asRad != undefined do origLight.areaRadius = asRad
				
				origLight
			),
			
			
			-- ############## MR Area lights ################
			fn convertFrom_miAreaLight origLight = (
				if owner.converterSettings.miLightsToCrnLights then(  -- converts to coronaLights
					r=CoronaLight()
					r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origLight.name
					
					r.on = origLight.on
					try(r.targeted = origLight.targeted)catch()
					case of (
						(origLight.includeList != undefined and origLight.includeList.count != 0): (
							r.excludeIncludeMod = true
							r.excludeList = origLight.includeList
						)
						(origLight.excludeList != undefined and origLight.excludeList.count != 0): (
							r.excludeIncludeMod = false
							r.excludeList = origLight.excludeList
						)
						default: ()
					)
					
					r.intensity = origLight.multiplier
					r.colorMode = 0
					r.color = origLight.rgb
					
					if origLight.Area_Enable then(
						case (classof origLight) of (
							miAreaLight:(
								case origLight.Area_Type of (
									1:( r.shape = 1  --Rectangle
										r.width = origLight.Rectangle_Width 
										r.height = origLight.Rectangle_Height 
									)
									2:( r.shape = 2  -- Disc
										r.width = origLight.Disc_Radius
									)
								)
							)
							miAreaLightomni:(
								case origLight.Area_Type of (
									1:( r.shape = 0  --Sphere
										r.width = origLight.Sphere_Radius
									)
									2:( r.shape = 3  -- Cylinder
										r.width = origLight.Sphere_Radius
										r.height = origLight.Cylinder_Height
									)
								)
							)
							default:()
						)
					)
					
					r
				)
				else(  -- converts to standard lights
					r 
					origLight.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origLight.name
					
					case of (
						(hasproperty origLight "Free_Spot") : r = origLight.Free_Spot
						(hasproperty origLight "Target_Spot") : r = origLight.Target_Spot
						(hasproperty origLight "Free_Directional_Light") : r = origLight.Free_Directional_Light
						(hasproperty origLight "Target_Directional_Light") : r = origLight.Target_Directional_Light
						(hasproperty origLight "Omni_Light") : r = origLight.Omni_Light
						default: ()
					)
					
					crnShd = CoronaShadows()
					crnShd.areaShadows = origLight.Area_Enable
					
					if origLight.Area_Enable then(
						case (classof origLight) of (
							miAreaLight:(
								case origLight.Area_Type of (
									1: crnShd.areaRadius = origLight.Rectangle_Width / 2.0 --Rectangle
									2: crnShd.areaRadius = origLight.Disc_Radius -- Disc
								)
							)
							miAreaLightomni:(
								case origLight.Area_Type of (
									1: crnShd.areaRadius = origLight.Sphere_Radius --Sphere	
									2: crnShd.areaRadius = origLight.Sphere_Radius  -- Cylinder
								)
							)
							default:()
						)
					)
					r.shadowgenerator = crnShd
					
					r
				)
				
			),
			
			-- ############## fR RectLight ################
			fn convertFrom_fRRectLight origLight = (
				r=CoronaLight()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origLight.name
				doNotConvert = false
				
				-- OnOff, Include/exclude
				r.on = origLight.on
				r.targeted = origLight.isTargeted
				-- include exclude is using some freaky fR Sh*t again... will support later
				
				if origLight.lightPortal != 0 do doNotConvert = true
				
				-- Intensitiy, Color, Texmap
				r.intensity = origLight.multiplier
				r.shape = 1 
				r.width = origLight.width
				r.height = origLight.length
				
				r.color = origLight.color
				
				-- visibility
				r.visibleDirectly = not origLight.renderIcon
				
				if doNotConvert then(
					delete r
					r = #NoReplacement
				)
				
				r
			),
			
			
			-- ############## VrayIES ################
			fn convertFrom_VrayIES origLight = (
				r=CoronaLight()
				r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origLight.name
				
				-- OnOff, Include/exclude
				r.on = origLight.enabled
				r.targeted = origLight.targeted
				case of (
					(origLight.includeList != undefined and origLight.includeList.count != 0): (
						r.excludeIncludeMod = true
						r.excludeList = origLight.includeList
					)
					(origLight.excludeList != undefined and origLight.excludeList.count != 0): (
						r.excludeIncludeMod = false
						r.excludeList = origLight.excludeList
					)
					default: ()
				)
				
				-- Intensitiy, Color, Texmap
				r.intensity = origLight.power
				r.intensityUnits = 1 -- luminous (lm)
				
				
				r.colorMode = origLight.color_mode -- 0: direct color, 1: kelvin temp
				r.color = origLight.color
				if r.colorMode == 1 do r.blackbodyTemp = origLight.color_temperature -- kelvin
				
				-- shape   -- 0: sphere, 1: Rectangle, 2: Disk, 3: Cylinder
				case origLight.shape of (
					0:( r.shape = 0 -- point
						r.iesSharpnessFake = true
						r.width = 5
						r.height = 5
					)
					1:( r.shape = 1 -- Rectangle
						r.width = if origLight.width != 0 then origLight.width else 5.0
						r.height = if origLight.length != 0 then origLight.length else 5.0
					)
					2:( r.shape = 2 -- circle
						r.width = if origLight.diameter != 0 then origLight.diameter / 2.0 else 5.0
					) 
					3:( r.shape = 0 -- sphere 
						r.width = if origLight.diameter != 0 then origLight.diameter / 2.0 else 5.0
					) 
					4:( r.shape = 2 -- vertical cylinder
						r.width = if origLight.diameter != 0 then origLight.diameter / 2.0 else 5.0
					) 
					default:(
						r.shape = 0 -- for everything else
						r.iesSharpnessFake = true
						r.width = 5
						r.height = 5
					)
				)
				
				-- visibility
				r.visibleDirectly = false
				r.occludeOtherLights = origLight.castShadows
				
				-- IES
				r.iesOn = true
				if origLight.ies_file != undefined do(
					r.iesFile = origLight.ies_file
				)
				
				r
			),
			
			
			-- ############## VraySun ################
			fn convertFrom_VraySun origLight = (
				r=CoronaSun()
				
				-- OnOff, Include/exclude
				r.on = origLight.enabled
				
				-- Intensitiy, Color, Texmap
				r.intensity = origLight.intensity_multiplier
				
				if hasProperty origLight "color_mode" then(
					if origLight.color_mode == 1 do ( -- 0:filter 1:direct 2:override
						r.colorDirect = origLight.filter_Color
						r.colorMode = 0
					)
				)
				
				-- visibility
				r.visibleDirectly = not origLight.invisible
				
				r 
			),
			
			-- ############## mrSun (Daylight assemblies only) ################
			fn convertFrom_mrSun origLight = (
				r=CoronaSun()
				
				r.on = origLight.on
				r.intensity = origLight.skymult
				
				r 
			),
			
			-- ############## mr_Sky_Portal ################
			fn convertFrom_mrSkyPortal origLight = (
				if origLight.mode == 1 then( -- if custom color source is defined convert to CoronaLight
					r=CoronaLight()
					r.name=(if owner.converterSettings.addCoronaPrefix then owner.converterSettings.userPrefixStr else "") + origLight.name
					
					r.on = origLight.on
					r.intensity = origLight.multiplier
					r.color = origLight.rgbFilter
					r.shape = 1  -- Plane
					r.width = origLight.light_Width 
					r.height = origLight.light_length 
					r.visibleDirectly = origLight.Area_Visible
					
					r
				)
				else(  -- if it's a normal portal without custom color source
					if owner.converterTempData.crnSkyPortalMtl == undefined do(
						owner.converterTempData.crnSkyPortalMtl = CoronaPortalMtl()
					)
					owner.converterTempData.foundPortals = true				
					
					r = Plane()
					r.width = origLight.light_Width
					r.length = origLight.light_length
					r.lengthsegs = 1
					r.widthsegs = 1
					
					InstanceMgr.GetInstances origLight &rptInstances
					trueInstances = for n in rptInstances where (areNodesInstances origLight n) collect n
					for i in trueInstances do instanceReplace i r
					trueInstances.material = owner.converterTempData.crnSkyPortalMtl
					delete r
					r = #NoReplacement
					
					r 
				)
			)
		)
		lightConvMethods owner:this
	),
	
	
	-- conversion core methods
	fn createCoronaMap orig_map =(
		if ((superclassof orig_map)!=textureMap) then return orig_map  -- check if this is a material; if not, just return the value
		
		local i=findItem converterTempData.orig_maps orig_map -- check if we have already converted this map
		if i>0 then return converterTempData.new_maps[i]  --if yes, just return the already converted one	
		
		-- recurse into sub-maps, if any
		local sub_count=getNumSubTexmaps orig_map
		if sub_count >= 1 then (
			for i=1 to sub_count do (
				newMap = createCoronaMap (getSubTexmap orig_map i)
				if newMap != #NoReplacement then(
					setSubTexmap orig_map i newMap
				)
			)
		)
		
		cls=classof orig_map
		
		print cls
		
		local new_map=case cls of (
			VrayColor: errorCatching mapConvMethods.convertFrom_VrayColor orig_map
			VrayDirt: errorCatching mapConvMethods.convertFrom_VrayDirt orig_map
			VrayNormalMap: errorCatching mapConvMethods.convertFrom_VrayNormalMap orig_map
			VraySky: errorCatching mapConvMethods.convertFrom_VraySky orig_map
			VRayCompTex: errorCatching mapConvMethods.convertFrom_VRayCompTex orig_map
			VRayEdgesTex: errorCatching mapConvMethods.convertFrom_VRayEdgesTex orig_map 
			VRayGLSLTex: errorCatching mapConvMethods.convertFrom_VRayGLSLTex orig_map
			VRaySoftbox: errorCatching mapConvMethods.convertFrom_VRaySoftbox orig_map
			VRayHDRI: (if converterSettings.VrayHDRIToBitmaptexture then errorCatching mapConvMethods.convertFrom_VrayHDRI orig_map else orig_map)
			
			Bitmaptexture: (if converterSettings.bitmapTextureToCoronaBitmap then errorCatching mapConvMethods.convertFrom_BitmapTexture orig_map else orig_map)
			Normal_Bump: errorCatching mapConvMethods.convertFrom_Normal_Bump orig_map
			Autodesk_Map: errorCatching mapConvMethods.convertFrom_Autodesk_Map orig_map
			Ambient_Reflective_Occlusion__3dsmax: errorCatching mapConvMethods.convertFrom_Ambient_Reflective_Occlusion__3dsmax orig_map
			Multi_Sub_Map: errorCatching mapConvMethods.convertFrom_Multi_Sub_Map orig_map
			
			default: orig_map
		)
		
		if new_map!=orig_map then ( 		-- if converted, add to the list of converted materials
			append converterTempData.orig_maps orig_map
			append converterTempData.new_maps new_map
		)
		new_map
	),
	
	fn createCoronaMtl orig_mtl processMaps:true =(
		if ((superclassof orig_mtl)!=material) then return orig_mtl  -- check if this is a material; if not, just return the value
		
		local i=findItem converterTempData.orig_mtls orig_mtl -- check if we have already converted this material
		if i>0 then return converterTempData.new_mtls[i]  --if yes, just return the already converted one	
		
		-- recurse into sub-materials, if any
		local sub_count=getNumSubMtls orig_mtl
		if sub_count >= 1 then (
			for i=1 to sub_count do (
				setSubMtl orig_mtl i (createCoronaMtl (getSubMtl orig_mtl i) processMaps:processMaps )
			)
		)
		
		if processMaps do( -- check if there are maps in this material and recurse into all subtexmaps
			local sub_count=getNumSubTexmaps orig_mtl
			if sub_count >= 1 then (
				for i=1 to sub_count do (
					newMap = createCoronaMap (getSubTexmap orig_mtl i)
					if newMap != #NoReplacement then(
						setSubTexmap orig_mtl i newMap
					)
				)
			)
		)
		
		cls=classof orig_mtl
		local new_mtl=case cls of (
			StandardMaterial: errorCatching matConvMethods.convertFrom_Standard orig_mtl
			VRayMtl: errorCatching matConvMethods.convertFrom_VrayMtl orig_mtl
			VRayBlendMtl: errorCatching matConvMethods.convertFrom_VrayBlendMtl orig_mtl
			VRayLightMtl: errorCatching matConvMethods.convertFrom_VrayLightMtl orig_mtl 
			VRay2SidedMtl: errorCatching matConvMethods.convertFrom_Vray2sidedMtl orig_mtl 
			VRayCarPaintMtl: errorCatching matConvMethods.convertFrom_VRayCarPaintMtl orig_mtl 
			VrayOverrideMtl: errorCatching matConvMethods.convertFrom_VrayOverrideMtl orig_mtl 
			VrayMtlWrapper: errorCatching matConvMethods.convertFrom_VrayMtlWrapper orig_mtl 
			VRayFastSSS2: errorCatching matConvMethods.convertFrom_VRayFastSSS2 orig_mtl 
			Arch___Design__mi: errorCatching matConvMethods.convertFrom_ArchAndDesign orig_mtl 
			Car_Paint_Material__mi: errorCatching matConvMethods.convertFrom_MRCarPaintMaterial orig_mtl 
			fR_Advanced: errorCatching matConvMethods.convertFrom_fR_Advanced orig_mtl 
			fR_Architectural: errorCatching matConvMethods.convertFrom_fR_Architectural orig_mtl 
			Shellac: errorCatching matConvMethods.convertFrom_Shellac orig_mtl 
			Autodesk_Material: errorCatching matConvMethods.convertFrom_AutodeskMtl orig_mtl 
			Architectural: errorCatching matConvMethods.convertFrom_Architectural orig_mtl
			
			--following materials will be replaced with default gray corona mat, will be supported later
			VRayFastSSS: errorCatching matConvMethods.convertFrom_VRayFastSSS orig_mtl 
			RaytraceMaterial: errorCatching matConvMethods.CreateDefaultCoronaMtl orig_mtl 
			fR_Metal: errorCatching matConvMethods.CreateDefaultCoronaMtl orig_mtl 
			fR_Glass: errorCatching matConvMethods.CreateDefaultCoronaMtl orig_mtl 
			
			default: orig_mtl
		)
		
		if new_mtl!=orig_mtl then ( 		-- if converted, add to the list of converted materials
			append converterTempData.orig_mtls orig_mtl
			append converterTempData.new_mtls new_mtl
		)
		
		new_mtl
	),
	
	fn createCoronaLights orig_light =(
		if ((superclassof orig_light)!=light) then return orig_light  -- check if this is a light; if not, just return the value
		
		local i=findItem converterTempData.orig_lights orig_light -- check if we have already converted this light
		if i>0 then return converterTempData.new_lights[i]  --if yes, just return the already converted one	
		
		cls=classof orig_light
		local new_light=case cls of (
			Free_Light: errorCatching lightConvMethods.convertFrom_StandardLights orig_light
			Free_Linear: errorCatching lightConvMethods.convertFrom_StandardLights orig_light
			Free_Area: errorCatching lightConvMethods.convertFrom_StandardLights orig_light
			Free_Disc: errorCatching lightConvMethods.convertFrom_StandardLights orig_light
			Free_Sphere: errorCatching lightConvMethods.convertFrom_StandardLights orig_light
			Free_Cylinder: errorCatching lightConvMethods.convertFrom_StandardLights orig_light
			Target_Light: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			Target_Linear: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			Target_Area: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			Target_Disc: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			Target_Sphere: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			Target_Cylinder: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			
			TargetDirectionallight: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			freeSpot: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			Directionallight: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			Omnilight: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			targetSpot: errorCatching lightConvMethods.convertFrom_StandardLights orig_light 
			
			VrayLight: errorCatching lightConvMethods.convertFrom_VrayLight orig_light 
			VRayIES: errorCatching lightConvMethods.convertFrom_VrayIES orig_light 
			VraySun: errorCatching lightConvMethods.convertFrom_VraySun orig_light 
			miAreaLight: errorCatching lightConvMethods.convertFrom_miAreaLight orig_light 
			miAreaLightomni: errorCatching lightConvMethods.convertFrom_miAreaLight orig_light 
			mr_Sky_Portal: errorCatching lightConvMethods.convertFrom_mrSkyPortal orig_light
			RectLight: errorCatching lightConvMethods.convertFrom_fRRectLight orig_light
			
			default: orig_light
		)
		
		if new_light != orig_light then ( 		-- if converted, add to the list of converted lights
			append converterTempData.orig_lights orig_light
			append converterTempData.new_lights new_light
		)
		
		new_light
	),
	
	fn cleanUpConversionData =(
		converterTempData.orig_mtls=#()
		converterTempData.new_mtls=#()
		converterTempData.orig_maps=#()
		converterTempData.new_maps=#()
		converterTempData.orig_lights=#()
		converterTempData.new_lights=#()
		
		if converterTempData.AD_mats_found then(
			selectionSets["converted_AD_mtls"] = converterTempData.foundAdskMtls 
			converterTempData.foundAdskMtls = #()
			scenematerialsUpdateHack()
			converterTempData.AD_mats_found = false
			
			warningMessage = "Autodesk Materials were used in this scene and have been converted, it is STRONGLY recommended to check all those materials before rendering! \nObjects using these Materials have been added to a \"converted_AD_mtls\" selection set"
			if not converterSettings.silent do messageBox warningMessage title:"Warning"
		)
		
		if converterTempData.foundPortals then(
			converterTempData.foundPortals = false
			warningMessage = "Portals (mr_sky_Portal or VrayLight) were found and have been converted to planes with CoronaPortal materials. For best results check the position and coverage of your portals."
			if not converterSettings.silent do messageBox warningMessage title:"Warning"
		)
		
		clearUndoBuffer()
		true
	),
	
	fn additionalSceneSetup =(
		if converterSettings.switchRenderEngine do (
			if substring (classof renderers.current as string) 1 6 != "Corona" then(
				renderers.current = CoronaRenderer()
				if not renderers.medit_locked do renderers.medit = CoronaRenderer()
			)
		)
	),
	
	
	-- High-level Converter functionality
	fn convertSceneLights ErrorReport:true =(
		start = timeStamp()
		if converterSettings.printInfo do format "INFO: Converting scene lights...\n"
		cntr = 0
		
		allLights = for o in objects where superclassof o == light collect o
		for i in allLights do(
			if isValidNode i do(
				if i.parent != undefined and classof i.parent == DaylightAssemblyHead then() else(
					newLight = createCoronaLights i
					if newLight != #NoReplacement do(
						replaceInstances i newLight
					)
					cntr += 1
				)
			)
		)
		for o in (getclassinstances DaylightAssemblyHead) do (
			cntr += 1
			orig_light = o.sun
			cls=classof orig_light
			local new_light=case cls of (
				VraySun: lightConvMethods.convertFrom_VraySun orig_light
				mr_Sun: lightConvMethods.convertFrom_mrSun orig_light 
				IES_Sun: (CoronaSun())
				Directionallight: (CoronaSun())
				default: orig_light
			)
			o.sun = new_light
			if new_light != orig_light do(delete new_light)
			o.sky=undefined
		)
		
		delete (for elem in converterTempData.new_lights where (superclassof elem == light) and isvalidnode elem collect elem) 
		end = timeStamp()
		cTime = ("Light conversion took " +  ((end - start) / 1000.0) as string + " seconds ")
		append converterTempData.conversionTimeInfo cTime
		if converterSettings.printInfo do format "INFO: %\n" cTime
			
		itLts = ("Iterations: " + cntr as string)
		append converterTempData.conversionTimeInfo itLts
		if converterSettings.printInfo do format "INFO: %\n" itLts
		
		additionalSceneSetup()
		cleanUpConversionData()
		if ErrorReport do createErrorReports()
	),
	
	fn convertSceneMtlsMaps ErrorReport:true =(
		-- material conversion
		start = timeStamp()
		if converterSettings.printInfo do format "INFO: Converting scene materials...\n"
		cntr = 0
		
		for c in converterTempData.supportedMtlClasses do( --where c.creatable 
			cls = execute c
			if classof cls == material do(
				clssInst = getclassinstances cls processAllAnimatables:false processChildren:false asTrackViewPick:false -- HUGE SLOW DOWN!!!!!!!!!!!!!
				for i in clssInst do(
					replaceInstances i (createCoronaMtl i processMaps:false)
					cntr += 1
				)
			)
		)
		
		end = timeStamp()
		cMtlTime = ("Material conversion took " +  ((end - start) / 1000.0) as string + " seconds ")
		append converterTempData.conversionTimeInfo cMtlTime
		if converterSettings.printInfo do format "INFO: %\n" cMtlTime
			
		itMtl = ("Iterations: " + cntr as string + ", converted: " + converterTempData.new_mtls.count as string)
		append converterTempData.conversionTimeInfo itMtl
		if converterSettings.printInfo do format "INFO: %\n" itMtl
		
		-- map conversion
		start = timeStamp()
		if converterSettings.printInfo do format "INFO: Converting scene maps...\n"
		cntr = 0
		
		for c in converterTempData.supportedMapClasses do(
			cls = execute c
			if classof cls == textureMap do(
				classInst = getclassinstances cls processAllAnimatables:false processChildren:false asTrackViewPick:false -- HUGE SLOW DOWN!!!!!!!!!!!!!
				for i in classInst do(
					newMap = createCoronaMap i
					if newMap != #NoReplacement then(
						replaceInstances i newMap
					)
					cntr += 1
				)
			)
		)
		
		end = timeStamp()
		cMapTime = ("Map conversion took " +  ((end - start) / 1000.0) as string + " seconds ")
		append converterTempData.conversionTimeInfo cMapTime
		if converterSettings.printInfo do format "INFO: %\n" cMapTime
		
		itMap = ("Iterations: " + cntr as string + ", converted: " + converterTempData.new_maps.count as string)
		append converterTempData.conversionTimeInfo itMap
		if converterSettings.printInfo do format "INFO: %\n" itMap			
		
		additionalSceneSetup()
		cleanUpConversionData()
		if ErrorReport do createErrorReports()
	),
	
	fn convertScene =(
		convertSceneMtlsMaps ErrorReport:false
		convertSceneLights ErrorReport:false
		createErrorReports()
	),
	
	fn convertNodeArray nodeArray ErrorReport:true =(
		start = timeStamp()
		if converterSettings.printInfo do format "INFO: Converting scene materials...\n"
		cntr = 0
		
		for obj in nodeArray do(
			mat = obj.material
			if mat != undefined do(
				replaceInstances mat (createCoronaMtl mat processMaps:true)
				cntr += 1
			)
		)
		
		end = timeStamp()
		cMtlTime = ("Material conversion took " +  ((end - start) / 1000.0) as string + " seconds ")
		append converterTempData.conversionTimeInfo cMtlTime
		if converterSettings.printInfo do format "INFO: %\n" cMtlTime
			
		itMtl = ("Iterations: " + cntr as string + ", converted: " + converterTempData.new_mtls.count as string)
		append converterTempData.conversionTimeInfo itMtl
		if converterSettings.printInfo do format "INFO: %\n" itMtl
		
		additionalSceneSetup()
		cleanUpConversionData()
		if ErrorReport do createErrorReports()
	),
	
	fn convertMaterialArray matArray ErrorReport:true =(
		start = timeStamp()
		if converterSettings.printInfo do format "INFO: Converting scene materials...\n"
		cntr = 0
		
		for mat in matArray do(
			replaceInstances mat (createCoronaMtl mat processMaps:true)
			cntr += 1
		)
		
		end = timeStamp()
		cMtlTime = ("Material conversion took " +  ((end - start) / 1000.0) as string + " seconds ")
		append converterTempData.conversionTimeInfo cMtlTime
		if converterSettings.printInfo do format "INFO: %\n" cMtlTime
			
		itMtl = ("Iterations: " + cntr as string + ", converted: " + converterTempData.new_mtls.count as string)
		append converterTempData.conversionTimeInfo itMtl
		if converterSettings.printInfo do format "INFO: %\n" itMtl
		
		additionalSceneSetup()
		cleanUpConversionData()
		if ErrorReport do createErrorReports()
	),
	
	
	-- Converter Dialog
	CoronaConverterRoll = rollout CoronaConverterRoll ("Corona Converter v" + converterTools.getVersion() ) width:466  height:457 (
		local owner = if owner != undefined do owner
		-- Conversion settings Group
		local lastPos = [8,8]
		groupBox grpStd "Standard" pos:(lastPos += [0,0]) width:186 height:40
		checkbox chkReflstandardMat "convert specular to reflection" pos:(lastPos += [8,18]) width:168 height:16 checked:owner.converterSettings.standardMatSpecToRefl tooltip:"Convert specular intensitiy and glossiness to reflection values in a CoronaMtl"
		
		groupBox grpVray "Vray" pos:(lastPos += [-8,26]) width:186 height:80
		checkbox chkConvVrayGloss "convert glossiness values" pos:(lastPos += [8,17]) width:168 height:16 checked:owner.converterSettings.vrayConvertGlossyValues tooltip:"Converts Vray refl/refr glossiness values to visually matching values in a CoronaMtl (does not affect mapped glossiness)"
		checkbox chkConvVrayGlossMaps "convert glossiness textures" pos:(lastPos += [0,20]) width:168 height:16 checked:owner.converterSettings.vrayConvertGlossyMaps tooltip:"Converts Vray refl/refr glossiness maps to visually matching results in a CoronaMtl "
		checkbox chkConvVrayHDRI "convert VrayHDRI" pos:(lastPos += [0,20]) width:168 height:16 checked:owner.converterSettings.VrayHDRIToBitmaptexture tooltip:"Converts VrayHDRI texture to standard BitmapTexture"
		
		groupBox grpOptions "Options" pos:(lastPos += [-8,26]) width:186 height:168
		checkbox chkCorPrefix "add prefix to converted mtls" pos:(lastPos += [8,18]) width:174 height:16 checked:owner.converterSettings.addCoronaPrefix tooltip:"converted materials will have the prefix added to their name" --pos:(lastPos += [0,52])
		edittext edtPrefix "" pos:(lastPos += [14,18]) width:144 height:17 tooltip:"converted materials will have the prefix added to their name"
		checkbox chkClampIOR "999 fresnel IOR to" pos:(lastPos += [-14,22]) width:106 height:16 checked:owner.converterSettings.clampIor tooltip:"Materials that would be converted to a 999.0 fresnel IOR (e.g. VrayMtls without fresnel reflections activated) can be clamped to a lower IOR with this setting."
		spinner spnClampedIOR "" pos:(lastPos + [112,0]) width:46 height:32 range:[1.0,999.0,owner.converterSettings.clampIorAmount] enabled:false type:#float tooltip:"Materials that would be converted to a 999.0 fresnel IOR (e.g. VrayMtls without fresnel reflections activated) can be clamped to a lower IOR with this setting."
		checkbox chkmiLightsToCrn "miAreaLight to CoronaLight" pos:(lastPos += [0,22]) width:168 height:16 checked:owner.converterSettings.miLightsToCrnLights tooltip:"Converts \"mr Area Omni\" and \"mr Area Spot\" to CoronaLights instead of leaving them standard lights"
		checkbox chkBitmapToCrnBitmap "Bitmap to CoronaBitmap" pos:(lastPos += [0,22]) width:168 height:16 checked:owner.converterSettings.bitmapTextureToCoronaBitmap tooltip:"Converts Bitmaptexture maps to CoronaBitmap"
		checkbox chkConvertProxies "convert Proxies (popup dialog)" pos:(lastPos += [0,22]) width:176  checked:owner.converterSettings.convertProxies tooltip:"Converts VrayProxy to CoronaProxy, opens a popup dialog"
		checkbox chkSwitchRen "switch renderer to Corona" pos:(lastPos += [0,22]) width:168 height:16 checked:owner.converterSettings.switchRenderEngine tooltip:"Assigns Corona as the current active renderer"
		
		groupBox grpConv "Conversion" pos:([8, grpOptions.pos.y + grpOptions.height + 4]) width:186 height:142
		radiobuttons rdoMode "" pos:(grpConv.pos + [8, 19]) width:82 height:48 labels:#("All (materials, maps, lights)", "only scene materials and maps", "only scene lights", "materials of selected objects", "selected material editor slot") columns:1 tooltip:"selection modes will convert materials and maps without breaking instancing, so be aware that other materials can be affected!"
		button btnStartConverting "START CONVERSION" pos:(grpConv.pos + [8,102]) width:170 height:32  -- pos:(lastPos += [0,24]) 
		
		
		-- Tools Group
		local lastPos = [202,8]
		groupBox grpTools "Tools" pos:(lastPos += [0,0]) width:256 height:255 -- +16
		button btnResetMtlEdit "Reset MatEdit to CoronaMtls" pos:(lastPos += [8,20]) width:160 height:20 tooltip:"Resets all Material editor materials to Standard Corona Mats"
		button btnStatistics "Statistics" pos:(lastPos += [165,0]) width:75 height:20 tooltip:"Show statistics about the current CoronaMtls in the scene"
		
		button btnDisableDisplace "disable Displacement maps" pos:(lastPos += [-165,24]) width:140 height:20 tooltip:"Disables Displacement maps in Corona materials"
		button btnConvertClass "convert by class" pos:(lastPos += [145,0]) width:95 height:20 tooltip:"Tool for converting specific unsupported material classes to default Corona Mtls (e.g. missing_mtl or Maxwell materials)"
		
		label lblShowMaps "Show maps in Viewport:" pos:(lastPos += [-140,28]) 
		button btnShowMapsInVP "On" pos:(lastPos += [115,4]) width:60 height:20 tooltip:"Workaround for displaying diffuse maps in the viewport - can be VERY SLOW!"
		button btnUnShowMapsInVP "Off" pos:(lastPos += [60,0]) width:60 height:20 tooltip:"Workaround for turning display of diffuse maps in the viewport off"
		checkbox chkShowMapsSelectedOnly "only selected objs" pos:(lastPos += [-175,10]) tooltip:"when checked, only selected objects will be considered for show maps functionality"
		
		label lblEnergyCons "Legacy mode:" pos:(lastPos += [0,24]) 
		button btnLegacyModeNrm "disable" pos:(lastPos += [115,-4]) width:120 height:20 tooltip:"Disables legacy mode in CoronaMtls and CoronaLightMtls"
		
		button btnFixOpacityMapsMono "Fix opacity maps w. \"Mono Channel Output\" on" pos:(lastPos += [-120,24]) width:240  height:20 tooltip:"Opacity bitmaps that are using the \"Mono Channel Output\" option are rendered using the RGB channels (not the alpha) in Corona. This tool tries to fix those issue where possible. \nPrimarily used in materials for leafs."
		button btnFixCoronaNormalGamma "Fix CoronaNormal gamma value" pos:(lastPos += [0,24]) width:240  height:20 tooltip:"Checks if the gamma warning is displayed and switches the \"Add gamma to input\" checkbox on or off. Only works if input gamma is either 1.0 or 2.2"
		button btnConvertVrayDisplacementMods "Convert VrayDisplacementMod modifiers" pos:(lastPos += [0,24]) width:240  height:20 tooltip:"Replaces VrayDisplacementMod modifiers with CoronaDisplacementMod modifiers"
		button btnConvBitmapToCoronaBitmap "Bitmap > CoronaBitmap" pos:(lastPos += [0,24]) width:120  height:20 tooltip:"Converts Bitmaptexture maps to CoronaBitmap"
		button btnConvCoronaBitmapToBitmap "CoronaBitmap > Bitmap" pos:(lastPos + [120,0]) width:120  height:20 tooltip:"Converts CoronaBitmap maps back to Bitmaptexture maps"
		button btnOnlineCheck "Check online for new converter versions" pos:(lastPos += [0,24]) width:240  height:20 tooltip:"Opens a window with info about available converter versions"
		
		
		-- Readme Group
		groupBox grpReaddMe "Things to check after conversion:" pos:[202,268] width:256 height:181
		label lblDesc "" pos:(grpReaddMe.pos + [10,20]) width:240 height:140
		hyperlink hlAlbedo "see the helpdesk article" address:"https://corona-renderer.com/link/4000" visitedColor:owner.converterSettings.uiLinkColor color:owner.converterSettings.uiLinkColor pos:[grpReaddMe.pos.x + 99, (lblDesc.pos.y + 13 * 0)] -- last num is linenumber
		hyperlink hlperfDebg "performance debugging FAQ" address:"https://corona-renderer.com/link/4002" visitedColor:owner.converterSettings.uiLinkColor color:owner.converterSettings.uiLinkColor pos:[grpReaddMe.pos.x + 64, (lblDesc.pos.y + 13 * 4)]
		hyperlink hlconvThread "Corona forum thread" address:"https://corona-renderer.com/link/4003" visitedColor:owner.converterSettings.uiLinkColor color:owner.converterSettings.uiLinkColor pos:[grpReaddMe.pos.x + 146, (lblDesc.pos.y + 13 * 5)]
		hyperlink hlmxsDoc "Maxscript Documentation" address:"https://corona-renderer.com/link/4004" visitedColor:owner.converterSettings.uiLinkColor color:owner.converterSettings.uiLinkColor pos:[grpReaddMe.pos.x + 95 ,(lblDesc.pos.y + 13 * 7)]
		
		-- DEBUG 
		checkBox chkErrorCatching "use try/catch bug reporting" offset:[0,80] checked:owner.converterSettings.useTryCatchBugReporting
		on chkErrorCatching changed state do(
			owner.converterSettings.useTryCatchBugReporting = state
		)
		
		
		-- Gui handler
		on chkReflstandardMat changed state do(
			owner.converterSettings.standardMatSpecToRefl = state
		)
		
		on chkConvVrayGloss changed state do(
			owner.converterSettings.vrayConvertGlossyValues = state
		)
		
		on chkConvVrayGlossMaps changed state do(
			owner.converterSettings.vrayConvertGlossyMaps = state
		)
		
		on chkConvVrayHDRI changed state do(
			owner.converterSettings.VrayHDRIToBitmaptexture = state
		)
		
		on chkVrBltoMLBl changed state do(
			owner.converterSettings.vrayblendToMultilayerdBlend = state
		)
		
		on chkCorPrefix changed state do(
			owner.converterSettings.addCoronaPrefix = state
		)
		
		on edtPrefix changed txt do(
			owner.converterSettings.userPrefixStr = txt
		)
		
		on chkClampIOR changed state do(
			spnClampedIOR.enabled = state
			owner.converterSettings.clampIor = state
		)
		
		on spnClampedIOR changed val do(
			owner.converterSettings.clampIorAmount = val
		)
		
		on chkmiLightsToCrn changed state do(
			owner.converterSettings.miLightsToCrnLights = state
		)
		
		on chkBitmapToCrnBitmap changed state do(
			owner.converterSettings.bitmapTextureToCoronaBitmap = state
		)
		
		on chkSwitchRen changed state do(
			owner.converterSettings.switchRenderEngine = state
		)
		
		
		-- Tools
		on btnResetMtlEdit pressed do(
			owner.converterTools.resetMtlEdit()
		)
		
		on btnStatistics pressed do(
			owner.converterTools.CoronaMtlStats()
		)
		
		on btnLegacyModeNrm pressed do(
			owner.converterTools.setLegacyMode false
		)
		
		on btnShowMapsInVP pressed do(
			owner.converterTools.showMapsInVP true selected:chkShowMapsSelectedOnly.checked
		)
		
		on btnUnShowMapsInVP pressed do(
			owner.converterTools.showMapsInVP false selected:chkShowMapsSelectedOnly.checked
		)
		
		on chkShowMapsSelectedOnly changed state do(
			owner.converterSettings.showMapsInVPselectedOnly = state
		) 
		
		on btnDisableDisplace pressed do(
			owner.converterTools.DisableDisplacementTex()
		)
		
		on btnConvertClass pressed do(
			owner.converterTools.convertClass()
		)
		
		on btnFixOpacityMapsMono pressed do(
			owner.converterTools.fixOpacityMapsUsingMonoChannel()
		)
		
		on btnFixCoronaNormalGamma pressed do(
			owner.converterTools.fixCoronaNormalGamma()
		)
		
		on btnConvertVrayDisplacementMods pressed do(
			owner.converterTools.convertVrayDisplacementMods()
		)
		
		on btnConvBitmapToCoronaBitmap pressed do(
			owner.converterTools.convertBitmapToCoronaBitmap()
		)
		
		on btnConvCoronaBitmapToBitmap pressed do(
			owner.converterTools.convertCoronaBitmapToBitmap()
		)
		
		on btnOnlineCheck pressed do(
			owner.converterTools.checkForNewVersion() 
		)
		
		-- start conversion button
		on btnStartConverting pressed do(
			max create mode
			
			case rdoMode.state of(
				1: owner.convertScene()
				2: owner.convertSceneMtlsMaps()
				3: owner.convertSceneLights()
				4: owner.convertNodeArray (selection as array)
				5: owner.convertMaterialArray #(meditmaterials[activeMeditSlot]) 
			)
			
			if chkConvertProxies.checked then(
				if (getClassInstances VrayProxy).count != 0 then(
-- 					CoronaProxyConverter.openGui() 
				)
			)
			format "Conversion done.\n"
		)
		
		on CoronaConverterRoll open do(
			
			fn getIniSet sectionStr keyStr default =(
				out = (getinisetting owner.converterSettings.iniPath sectionStr keyStr) as string
				if out == "" then out = default as string
				out
			)
			
			cc = owner.converterSettings
			
			chkReflstandardMat.checked = cc.standardMatSpecToRefl = if (getIniSet "Standard" "SpecToRefl_Checked" cc.standardMatSpecToRefl) == "true" then true else false
			chkConvVrayGloss.checked = cc.vrayConvertGlossyValues = if (getIniSet "Vray" "GlossyVal_Checked" cc.vrayConvertGlossyValues) == "true" then true else false
			chkConvVrayGlossMaps.checked = cc.vrayConvertGlossyMaps = if (getIniSet "Vray" "GlossyMap_Checked" cc.vrayConvertGlossyMaps) == "true" then true else false
			chkConvVrayHDRI.checked = cc.VrayHDRIToBitmaptexture = if (getIniSet "Vray" "VrayHDRI_Checked" cc.VrayHDRIToBitmaptexture) == "true" then true else false
			
			edtPrefix.text = cc.userPrefixStr = (getIniSet "Options" "userString_String" cc.userPrefixStr) as string
			chkCorPrefix.checked = cc.addCoronaPrefix = if (getIniSet "Options" "userString_Checked" cc.addCoronaPrefix) == "true" then true else false
			chkClampIOR.checked = cc.clampIor = if (getIniSet "Options" "ClampIor_Checked" cc.clampIor) == "true" then true else false
			spnClampedIOR.value = cc.clampIorAmount = (getIniSet "Options" "ClampIor_Value" cc.clampIorAmount) as float
			spnClampedIOR.enabled = chkClampIOR.checked
			chkmiLightsToCrn.checked = cc.miLightsToCrnLights = if (getIniSet "Options" "MiLightsToCrn_Checked" cc.miLightsToCrnLights) == "true" then true else false
			chkBitmapToCrnBitmap.checked = cc.bitmapTextureToCoronaBitmap = if (getIniSet "Options" "BitmapToCrnBitmap_Checked" cc.bitmapTextureToCoronaBitmap) == "true" then true else false
			chkConvertProxies.checked = cc.convertProxies = if (getIniSet "Options" "ConvertProxies_Checked" cc.convertProxies) == "true" then true else false
			chkSwitchRen.checked = cc.switchRenderEngine = if (getIniSet "Options" "SwitchEngine_Checked" cc.switchRenderEngine) == "true" then true else false
			chkShowMapsSelectedOnly.checked = cc.showMapsInVPselectedOnly = if (getIniSet "Options" "chkShowMapsSelectedOnly_Checked" cc.showMapsInVPselectedOnly) == "true" then true else false
			
			-- Corona plugin version depending overrides
			if not owner.isCoronaVersionOfDateOrHigher 20150614 then( -- check for CoronaBitmap
				cc.bitmapTextureToCoronaBitmap = false
				chkBitmapToCrnBitmap.checked = false
				chkBitmapToCrnBitmap.enabled = false
				btnConvBitmapToCoronaBitmap.enabled = false
			)
			
			cc.dialogPosX = (getIniSet "DialogPos" "pos_x" cc.dialogPosX) as float 
			cc.dialogPosY = (getIniSet "DialogPos" "pos_y" cc.dialogPosY) as float 
			if cc.dialogPosX != 0.0 and cc.dialogPosY != 0.0 then (
				if (cc.dialogPosX > 0 and cc.dialogPosX < sysInfo.desktopSize.x - 200) do(
					if (cc.dialogPosY > 0 and cc.dialogPosY < sysInfo.desktopSize.y - 100) do(
						SetDialogPos CoronaConverterRoll [cc.dialogPosX, cc.dialogPosY]
					)
				)
			)
			
			if cc.exposeDebugSettings then CoronaConverterRoll.height += 60
			
			lblDesc.text += "* Material albedo:\n"
			lblDesc.text += "* If plants look oddly colored and transparent, \n   try the \"Fix opacity maps\" tool\n"
			lblDesc.text += "* check gamma in CoronaNormalTex maps\n"
			lblDesc.text += "* read the \n"
			lblDesc.text += "* grab latest script version:\n"
			lblDesc.text += "* info about how to use the converter functions\n"
			lblDesc.text += "   with maxscript: \n"
			
		)
		
		on CoronaConverterRoll close do(
			ini = owner.converterSettings.iniPath
			
			setINISetting ini "Standard" "SpecToRefl_Checked" (chkReflstandardMat.checked as string)
			setINISetting ini "Vray" "GlossyVal_Checked" (chkConvVrayGloss.checked as string)
			setINISetting ini "Vray" "GlossyMap_Checked" (chkConvVrayGlossMaps.checked as string)
			setINISetting ini "Vray" "VrayHDRI_Checked" (chkConvVrayHDRI.checked as string)
			
			setINISetting ini "Options" "userString_String" edtPrefix.text
			setINISetting ini "Options" "userString_Checked" (chkCorPrefix.checked as string)
			setINISetting ini "Options" "ClampIor_Checked" (chkClampIOR.checked as string)
			setINISetting ini "Options" "ClampIor_Value" (spnClampedIOR.value as string)
			setINISetting ini "Options" "MiLightsToCrn_Checked" (chkmiLightsToCrn.checked as string)
			setINISetting ini "Options" "BitmapToCrnBitmap_Checked" (chkBitmapToCrnBitmap.checked as string)
			setINISetting ini "Options" "ConvertProxies_Checked" (chkConvertProxies.checked as string)
			setINISetting ini "Options" "SwitchEngine_Checked" (chkSwitchRen.checked as string)
			setINISetting ini "Options" "chkShowMapsSelectedOnly_Checked" (chkShowMapsSelectedOnly.checked as string)
			
			try(setINISetting ini "DialogPos" "pos_x" ((GetDialogPos owner.CoronaConverterRoll).x as string) )catch()
			try(setINISetting ini "DialogPos" "pos_y" ((GetDialogPos owner.CoronaConverterRoll).y as string) )catch()
		)
	),
	
	fn openGui =(
-- 		createDialog CoronaConverterRoll style:#(#style_titlebar, #style_sysmenu, #style_minimizebox)
	),
	
	fn destroyGui =(
		try(destroydialog CoronaConverterRoll)catch()
		try(destroydialog CoronaMtlConvStatsRoll)catch()
		try(destroydialog CoronaMtlConvClassRoll)catch()
	),
	
	on create do(
		CoronaConverterRoll.owner = this
		try(deleteItem selectionsets (selectionSets["converted_AD_mtls"]))catch()
	)
	
)



CoronaMatConverterPerso = CoronaConverterStrPerso()
-- CoronaProxyConverter = CoronaProxyConverterStr()

-- CoronaProxyConverter.openGui()




(
	/* #####################################################################################################
	
	Copyright (C) 2015 Martin Geupel (http://www.racoon-artworks.de) , All Rights Reserved
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software (the "Software"), to use, 
	copy, and/or distribute the software, subject to the following conditions:

	- The above copyright notice and this permission notice shall be included in all copies of the Software.
	- You may not misrepresent the name of the Original Author or the name of the Software.
	- You can distribute the Software only free of charge, you may not sell and/or rent the Software.
	- You may add functionality and/or modify existent functionaly if it is then clearly marked and noted in this Header.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
	OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	
	
	changelog:
	*v0.04 - [2015/11/02] -----------------------------------------------------------------------------
	- fix: proxies are always exported as animation
	- undo can be disabled for exporting hundreds of objects => tremendous speedup 
	- some other minor speed improvements 
	- changed .cproxy to .cgeo
	*v0.03 - [2015/09/10] -----------------------------------------------------------------------------
	- animated proxy support (requires build of 2015/09/10 yyyy/mm/dd or later)
	*v0.02 - [2015/07/22] -----------------------------------------------------------------------------
	- code documentation
	- fixed: output path cancel crashes the script
	- changed default path
	*v0.01 - [2015/06/28] -----------------------------------------------------------------------------
	- initial beta release of the rewritten exporter
	
	##################################################################################################### */
	
	global CoronaProxyExporterPerso
	
	struct CoronaProxyExporterStructPERSO (
		version = "0.04",
		
		settings =(
			struct settings (
				iniPath = "$plugcfg\\CoronaProxyExporter.ini",
				outputPath = (getDir #export),
				exportToSingle = false,
				exportToSingleName = "combinedObjectName",
				
				exportAnimated = false,
				animUseActiveTime = true,
				animStartFrame = 0,
				animEndFrame = 100,
				
				cacheInRam = false,
				replaceSourceObjects = true,
				promptWhenOverwrite = true,
				proxyObjPrefix = "crp_",
				visualizationMethod = 3,
				pointCloundPercentage = 9.0,
				dialogPosX = 0.0,
				dialogPosY = 0.0
			)
			settings()
		),
		
		tempConvData =(
			struct tempConvData (
				instanceGroups = #(),
				instanceProxies = #()
			)
			tempConvData()
		),
		
		fn splitInstanceGroups objArray =(
			local groupArr = #()
			local workingCopy = objArray
			local instances = #()
			
			for i = 1 to workingCopy.count do(
				if workingCopy[i] != undefined do(
					local grp
					local crnt = workingCopy[i]
					
					InstanceMgr.GetInstances crnt &rptInstances  -- get all instances of the current object
					instances = for n in rptInstances where (areNodesInstances crnt n) AND (findItem workingCopy n != 0) collect n -- make sure they are instances, not references and check if these are selected
					
					for r in instances do(  -- for each found instance set the working arrays item to undefined (so we skip it if we already got the instance before)
						workingCopy[finditem workingCopy r] = undefined
					)
					append groupArr instances -- append the current instance group to the overall collection
				)
			)
			tempConvData.instanceGroups = groupArr
		),
		
		fn validateOutputPath outPath =(  
			local newPath = outPath
			if (doesFileExist outpath) and settings.promptWhenOverwrite do ( -- checks if the path already exists and pops up a notification
				if not (queryBox (outPath + "\n already exists, do you want to overwrite?") title:"Name conflict") then(
					newPath = undefined
				)
			)
			newPath
		),
		
		fn createProxyFiles =(
			local ig = tempConvData.instanceGroups
			local proxyArr = #()
			
			for subGrp in ig do ( -- for each group of instances do...
				local crntObj = subGrp[1] -- take the first object in the group
				if settings.exportToSingle then(  -- if export to single proxy mode..
					local outname = settings.exportToSingleName
					local outpath = (settings.outputPath + "\\" + outname + ".cgeo") -- we already validated singleProxy export path before
				)else(
					local outname = crntObj.name -- proxy will have the name of the first object in the group
					local outpath = validateOutputPath (settings.outputPath + "\\" + outname + ".cgeo") -- check if the file already exists 
				)
				
				
				if outpath == undefined then( -- skip if path is invalid
					append proxyArr undefined
				)else(
					local newProxy = CProxy name:(settings.proxyObjPrefix + outname) -- create a new proxy instance
					newProxy.cacheInRam = settings.cacheInRam
					newProxy.previzType = settings.visualizationMethod - 1
					newProxy.pointcloudDensity = settings.pointCloundPercentage
					
					append proxyArr newProxy  -- collect all created proxies
					
					if settings.exportAnimated then(
						local startFr = if settings.animUseActiveTime then (animationRange.start as integer / ticksperframe) else settings.animStartFrame
						local endFr =  if settings.animUseActiveTime then (animationRange.end as integer / ticksperframe) else settings.animEndFrame
						newProxy.animationOffset = startFr
						CProxy.ProxyFp.fromSceneAnimated newProxy crntObj outpath startFr endFr 10000 1 
					)else(
						CProxy.ProxyFp.fromScene newProxy crntObj outpath -- export the proxy to disk
					)
				)
			)
			tempConvData.instanceProxies = proxyArr 
		),
		
		fn distributeProxies =(
			local iGrp = tempConvData.instanceGroups -- all instance groups
			local iPrx = tempConvData.instanceProxies -- associated proxies (indices match)
			
			for iGrpIndex = 1 to iGrp.count do(
				local crntGroup = iGrp[iGrpIndex]
				local crntPrx = iPrx[iGrpIndex]
				if crntPrx != undefined do( -- if the proxy exists...
					if settings.replaceSourceObjects then( -- replaces all original objects
						InstanceMgr.MakeObjectsUnique crntGroup #Group -- make the group of instances unique! important, we would modify all non-selected instances too
						maxOps.CollapseNodeTo crntGroup[1] 1 off -- collapse the stack
						for i in crntGroup do(
							i.baseobject = crntPrx -- replace the baseobject with the cproxy instance 
							i.name = settings.proxyObjPrefix + i.name -- append the prexfix to the name
						)
						delete crntPrx -- delete the original proxy object, we don't need it anymore
					)
					else( -- if we don't replace the original objects
						for i = 1 to crntGroup.count do( 
							local origObj = crntGroup[i]
							local prxClone
							if i == 1 then prxClone = crntPrx else prxClone = instance crntPrx -- for each but the first item of the group make an instance of the proxy (we already have the first)
							
							prxClone.transform = origObj.transform  -- assign object properties
							prxClone.material = origObj.material 
							prxClone.wirecolor = origObj.wirecolor
							prxClone.renderable = origObj.renderable
							prxClone.primaryVisibility = origObj.primaryVisibility
							if settings.exportToSingle then (delete crntGroup)  -- if we are ONLY exporting 1 collapsed proxy, then we do not need the collapsed mesh (used for generating the proxy) anymore
						)
					)
				)
			)
		),
		
		fn cleanUpConversionData =(
			tempConvData.instanceGroups = #()
			tempConvData.instanceProxies = #()
		),
		
		fn returnValidNodes input =(
			for obj in input where (canConvertTo obj Editable_mesh) and classof obj != CProxy collect obj
		),
		
		fn collapseNodesToSingle objList workWithCopy:false =(
			-- http://forums.cgsociety.org/showthread.php?f=98&t=922140&page=1&pp=15
			if workWithCopy then (
				local objArr
				maxOps.CloneNodes objList cloneType:#instance newNodes:&objArr
			)else(
				local objArr = objList
			)
			
			local j = 1
			local count = objArr.count
			
			while objArr.count > 1 do
			(
				if classof objArr[j] != Editable_Poly then convertToPoly objArr[j]
				
				polyop.attach objArr[j] objArr[j+1]
				deleteItem objArr (j+1)
				j += 1
				if (j + 1) > objArr.count then j = 1
			)
			objArr[1].name = settings.exportToSingleName  
			objArr[1]
		),
		
		fn runExport silent:false enabledUndo:on =(
			if getCommandPanelTaskMode() != #create then setCommandPanelTaskMode #create 
			if (doesFileExist settings.outputPath) then(
				undo "Proxy Export" enabledUndo ( 
					local validNodes = returnValidNodes (selection as array)  -- filter for geometry, exclude cproxy
					if validNodes.count != 0 then(
						if settings.exportToSingle == true then(  -- if only outputting 1 combined proxy..
							local result = validateOutputPath (settings.outputPath + "\\" + settings.exportToSingleName + ".cgeo")  -- check the path
							if result != undefined do(
								
								if settings.replaceSourceObjects then(
									validNodes = #(collapseNodesToSingle validNodes workWithCopy:false)  -- combine all original objects to 1 editable poly (replacing)
								)else(
									validNodes = #(collapseNodesToSingle validNodes workWithCopy:true)  -- make a copy of the selected objects and collapse the copies (not replacing)
								)
								splitInstanceGroups validNodes
								createProxyFiles()
								distributeProxies()
								cleanUpConversionData()
							)
						)else(  -- when exporting with multiple
							splitInstanceGroups validNodes  -- split selection into instanced groups
							createProxyFiles()  -- create proxy objects, save to disk
							distributeProxies() -- distribute the proxies on all instances (-> instanced groups)
							cleanUpConversionData()  -- reset the conversionData arrays (when someone presses the button twice)
						)
						
					)
				)
				true
			)
			else(
				if not silent do messagebox "Output path is invalid" title:"Error"
				false
			)
		),
		
		
		
		
		
		
		
		-- rollout related
		proxyExporterRoll = (
			rollout proxyExporterRoll ("Corona Proxy Exporter v" + version) width:350 (
				local owner = if owner != undefined do owner
				group "Output options" (
					button btnSelectOutFolder owner.settings.outputPath width:330
					radiobuttons rdoSingle labels:#("Collapse and export to single proxy file", "Export each node to seperate proxy file") align:#left default:(if owner.settings.exportToSingle == true then 1 else 2) 
					label lblSinglePrx "Combined Proxy name: " width:112 across:2 align:#left offset:[0,3]  enabled:false
					edittext edxSingleName "" text:"" pos:(lblSinglePrx.pos + [113, -1]) width:200 enabled:false
					checkbox chkAnimated "Animated" 
					radiobuttons rdoAnimInterval labels:#("Active time segment", "From frame / To frame") align:#left default:1 columns:1
					spinner spnAnimFrom "" type:#integer range:[-999999, 999999, 0] width:60 pos:(rdoAnimInterval.pos + [130, 15])
					spinner spnAnimTo "" type:#integer range:[-999999, 999999, 100] width:60 pos:(spnAnimFrom.pos + [20, 0])
					label lblWarn1 "WARNING: Single Proxy export may take several seconds to" offset:[0,6]
					label lblWarn2 "complete. Can also be very memory intensive when used on"
					label lblWarn3 "many objects or objects with a high face count."
				)
				
				group "Proxy properties" (
					checkbox chkCacheInRam "Cache in RAM" checked: owner.settings.cacheInRam
					checkbox chkReplaceSource "Replace source objects" checked:owner.settings.replaceSourceObjects 
					checkbox chkPromptWhenOverwrite "Warn for existing .cgeo files" checked:owner.settings.promptWhenOverwrite
					edittext edtProxyPrefix "Proxy name prefix: " text:owner.settings.proxyObjPrefix width:200
					dropdownlist drpVizMethod "Viewport visualization method: " items:#("Solid bounding box", "Wire bounding box", "Point cloud", "Full mesh") selection:owner.settings.visualizationMethod
					spinner spnPCloudPerc "Point cloud displayed [%]: " align:#left width:100 type:#float range:[0.0, 100.0, owner.settings.pointCloundPercentage]
				)
				
				group "Export" (
					button btnExport "Export selected objects" width:180 height:30
				)
				
				fn animControlsEnabled state =(
					rdoAnimInterval.enabled = state 
					spnAnimFrom.enabled = state 
					spnAnimTo.enabled = state 
					owner.settings.exportAnimated = false
				)
				
				on btnSelectOutFolder pressed do(
					local svpath = getSavePath()
					if svpath != undefined then(
						owner.settings.outputPath = svpath
						btnSelectOutFolder.tooltip = btnSelectOutFolder.text = owner.settings.outputPath 
					)
				)
				
				on rdoSingle changed state do(
					if state == 1 then(
						owner.settings.exportToSingle = true
						lblSinglePrx.enabled = edxSingleName.enabled = true
						chkAnimated.enabled = false
						chkAnimated.checked = false
						animControlsEnabled false
						
					)else(
						owner.settings.exportToSingle = false
						lblSinglePrx.enabled = edxSingleName.enabled = false
						chkAnimated.enabled = true
						animControlsEnabled true
					) 
				)
				
				on edxSingleName changed textstr do(
					owner.settings.exportToSingleName = textstr
				)
				
				on chkAnimated changed state do(
					animControlsEnabled state
					
					owner.settings.exportAnimated = state
				)
				
				on rdoAnimInterval changed state do(
					owner.settings.animUseActiveTime = if state == 1 then true else false
				)
				
				on spnAnimFrom changed val do(
					owner.settings.animStartFrame = val
					if spnAnimFrom.value > spnAnimTo.value then(
						spnAnimTo.value = spnAnimFrom.value + 1
						owner.settings.animEndFrame = spnAnimTo.value
					)
				)
				
				on spnAnimTo changed val do(
					owner.settings.animEndFrame = val
					if spnAnimTo.value < spnAnimFrom.value then(
						spnAnimFrom.value = spnAnimTo.value - 1
						owner.settings.animStartFrame = spnAnimFrom.value
					)
				)
				
				on chkCacheInRam changed state do(
					owner.settings.cacheInRam = state
				)
				
				on chkReplaceSource changed state do(
					owner.settings.replaceSourceObjects = state
				)
				
				on chkPromptWhenOverwrite changed state do(
					owner.settings.promptWhenOverwrite = state
				)
				
				on edtProxyPrefix changed textstr do(
					owner.settings.proxyObjPrefix = textstr
				)
				
				on drpVizMethod selected state do( 
					owner.settings.visualizationMethod = state
				)
				
				on spnPCloudPerc changed state do(
					owner.settings.pointCloundPercentage = state
				)
				
				on btnExport pressed do(
					with redraw off(
						local useUndo = on
						if selection.count > 100 then(
							result = querybox "You are trying to export a big number of objects (100+). This can lead to a HUGE slowdown if undo is enabled during this process. Do you want to temporarily disable undo until export is finshed?" title:"Warning"
							if result then useUndo = off
						)
						owner.runExport enabledUndo:useUndo
					)
				)
				
				
				on proxyExporterRoll open do(
					fn getIniSet sectionStr keyStr default =(
						out = (getinisetting owner.settings.iniPath sectionStr keyStr) as string
						if out == "" then out = default as string
						out
					)
					
					pxs = owner.settings
					
					btnSelectOutFolder.text = btnSelectOutFolder.tooltip = pxs.outputPath = (getIniSet "Options" "outputPath" pxs.outputPath)
					rdoSingle.state = if (getIniSet "Options" "exportToSingle_Value" pxs.exportToSingle) == "true" then 1 else 2
					owner.settings.exportToSingle = true
					lblSinglePrx.enabled = edxSingleName.enabled = pxs.exportToSingle = if rdoSingle.state == 1 then true else false
					edxSingleName.text = pxs.exportToSingleName = (getIniSet "Options" "exportToSingleName_Text" pxs.exportToSingleName)
					chkCacheInRam.checked = pxs.cacheInRam = if (getIniSet "Options" "cacheInRam_Checked" pxs.cacheInRam) == "true" then true else false
					chkReplaceSource.checked = pxs.replaceSourceObjects = if (getIniSet "Options" "replaceSource_Checked" pxs.replaceSourceObjects) == "true" then true else false
					chkPromptWhenOverwrite.checked = pxs.promptWhenOverwrite = if (getIniSet "Options" "promptWhenOverwrite_Checked" pxs.promptWhenOverwrite) == "true" then true else false
					edtProxyPrefix.text = pxs.proxyObjPrefix = (getIniSet "Options" "proxyObjPrefix_Text" pxs.proxyObjPrefix)
					drpVizMethod.selection = pxs.visualizationMethod = (getIniSet "Options" "visualizationMethod_Value" pxs.visualizationMethod) as integer
					spnPCloudPerc.value = pxs.pointCloundPercentage = (getIniSet "Options" "pointCloundPercentage_Value" pxs.pointCloundPercentage) as float
					
					if rdoSingle.state == 1 then (
						chkAnimated.enabled = false
						animControlsEnabled false
						
					)else(
						chkAnimated.enabled = true
						animControlsEnabled false
					)
					
					pxs.dialogPosX = (getIniSet "DialogPos" "pos_x" pxs.dialogPosX) as float 
					pxs.dialogPosY = (getIniSet "DialogPos" "pos_y" pxs.dialogPosY) as float 
					if pxs.dialogPosX != 0.0 and pxs.dialogPosY != 0.0 then (
						if (pxs.dialogPosX > 0 and pxs.dialogPosX < sysInfo.desktopSize.x - 200) do(
							if (pxs.dialogPosY > 0 and pxs.dialogPosY < sysInfo.desktopSize.y - 100) do(
								SetDialogPos proxyExporterRoll [pxs.dialogPosX, pxs.dialogPosY]
							)
						)
					)
				)
				
				on proxyExporterRoll close do(
					ini = owner.settings.iniPath
					
					setINISetting ini "options" "outputPath" (btnSelectOutFolder.text as string)
					setINISetting ini "options" "exportToSingle_Value" (if rdoSingle.state == 1 then "true" else "false")
					setINISetting ini "options" "exportToSingleName_Text" (edxSingleName.text as string)
					setINISetting ini "options" "cacheInRam_Checked" (chkCacheInRam.checked as string)
					setINISetting ini "options" "replaceSource_Checked" (chkReplaceSource.checked as string)
					setINISetting ini "options" "promptWhenOverwrite_Checked" (chkPromptWhenOverwrite.checked as string)
					setINISetting ini "options" "proxyObjPrefix_Text" (edtProxyPrefix.text as string)
					setINISetting ini "options" "visualizationMethod_Value" (drpVizMethod.selection as string)
					setINISetting ini "options" "pointCloundPercentage_Value" (spnPCloudPerc.value as string)
					
					try(setINISetting ini "DialogPos" "pos_x" ((GetDialogPos owner.proxyExporterRoll).x as string) )catch()
					try(setINISetting ini "DialogPos" "pos_y" ((GetDialogPos owner.proxyExporterRoll).y as string) )catch()
				)
				
			)
		),
		
		fn openGui =(
-- 			try(destroyDialog CoronaProxyExporter.proxyExporterRoll)catch()
-- 			createDialog proxyExporterRoll
		), 
		
		fn closeGui = (
			try(destroyDialog proxyExporterRoll)catch()
		),
		
		on create do(
			proxyExporterRoll.owner = this
		)
	)
	CoronaProxyExporterPerso = CoronaProxyExporterStructPERSO()
)
