macroScript BiblioV1
category:"Perso"
toolTip:""
-- buttonText:"RANCHecker"
-- icon:#("RANCHecker",1)
(
	
	global bibliotheque
	local isOpen = false
	
	on execute do
	(


		if bibliotheque == undefined then ( 
			
			fileIn "$userScripts\bibliotheque\Bibliotheque.ms"
			
			-- on nettoie une fois par session au debut ----
			bibliotheque.arbo.nettoyer()
		)
		
		
		if isOpen then	
			bibliotheque.fermerFenetre()
		else 	
			bibliotheque.ouvrirFenetre()
		
		isOpen = not isOpen
	)
	
	on isChecked return isOpen
	
)