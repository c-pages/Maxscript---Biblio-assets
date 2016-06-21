macroScript BiblioV1
category:"Perso"
toolTip:""
-- buttonText:"RANCHecker"
-- icon:#("RANCHecker",1)
(
	
	global bibliotheque
	
	on execute do
	(


		if bibliotheque == undefined then 
			fileIn "$userScripts\bibliotheque\Bibliotheque.ms"

		if bibliotheque.isOpen then	(
			bibliotheque.fermerFenetre()
			bibliotheque.isOpen = false--and lower the flag
		)
		else 	(
			bibliotheque.ouvrirFenetre()
			bibliotheque.isOpen = true --and raise the flag
		)
		
	)
	
	on isChecked return try ( bibliotheque.isOpen ) catch ()
	
)