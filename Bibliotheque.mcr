
macroScript Biblio
category:"Perso"
toolTip:""
-- buttonText:"RANCHecker"
-- icon:#("RANCHecker",1)
(
	local	Roll_Biblio 

	----- le rollout principal -----
	cheminRollouts = getdir #userScripts	+ 	"\bibliotheque\Bibliotheque_rollouts.ms"
	include  "C:\Users\kris\AppData\Local\Autodesk\3dsMax\2014 - 64bit\ENU\scripts\bibliotheque\Bibliotheque_rollouts.ms" 
	try (	DestroyDialog Roll_Biblio ) catch ( format  ("rien à destroy\n") )
	createDialog Roll_Biblio pos:[ 50, 50]  width:500  height:300   lockHeight:false  style:#(#style_resizing,#style_toolwindow, #style_sysmenu ) 

)