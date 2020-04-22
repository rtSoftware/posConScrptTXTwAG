//EXTERN ".\zzW\Z\DASH_Lee.wl" // DASH --> {ggsA1}



IF ggsDash_Nombre = "" THEN
	ggsDash_Nombre = "DASH_1"
	Input("Nombre control: DASH ?",ggsDash_Nombre)
	IF ggsDash_Nombre = "" THEN
		Error("X no definido DASH en ini..."); RETURN
	ELSE
		INIWrite("cfg","DASH",ggsDash_Nombre,ggsIni)
	END
END
