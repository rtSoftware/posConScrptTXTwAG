//EXTERN ".\zzW\Z\DASH_Lee.wl" // DASH --> {ggsA1}



IF ggsDash_Nombre = "" THEN ggsDash_Nombre = INIRead("cfg","DASH","",ggsIni); bCpa1 = False
IF ggsDash_Nombre = "" THEN
	Input("Nombre control: DASH ?",ggsDash_Nombre)
	IF ggsDash_Nombre = "" THEN
		Error("X no definido DASH en ini..."); RETURN
	ELSE
		INIWrite("cfg","DASH",ggsDash_Nombre,ggsIni)
	END
END
