////EXTERN ".\zzW\Z\IW_EXISTE.wl" // windows



// Dentro de un 2do compilado no puede ir un EXTERN

IF ggsDash_Nombre = "" THEN ggsDash_Nombre = INIRead("cfg","DASH","",ggsIni); bCpa1 = False
IF ggsDash_Nombre = "" THEN Error("X no definido DASH en ini..."); RETURN
IF ggsA = "" THEN Error("X no definido Widget..."); RETURN   // ggsA = "IW_grafica"

IF ggsA <> "" AND ggsDash_Nombre <> "" THEN
	FOR nCpa1 = 1 TO DashCount({ggsDash_Nombre,indControl},toTotal)
		IF {ggsA1,indControl}[nCpa1]..Name = ggsA THEN bCpa1 = True; BREAK
	END
END
//IF nDebug = Today() THEN Info(ggsDash_Nombre,ggsA,"","Existe="+bCpa1,"Lugar="+nCpa1)
