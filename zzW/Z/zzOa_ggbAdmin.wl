//EXTERN ".\zzW\Z\zzOa_ggbAdmin.wl" // android WINDOWS



    sClave,sClave1 is string
    nClave is int

IF Contains(fCurrentDir(),"Simulaaaaaaa",IgnoreCase) OR...
	 Contains(fCurrentDir(),"YandexDiskaaaaaa",IgnoreCase) THEN

	 ggbAdmin = True

ELSE
		IF ggbAdmin = False THEN
			sClave1 = Right(Now(),6)
			nClave = Val(Middle(sClave1,5,1)) + Val(Middle(sClave1,6,1))
			Input("Clave Administrador "+sClave1,sClave)
			// Ultimos dos digitos
			IF sClave <> NumToString(nClave) THEN
				Info("Acceso Denegado !")
				RETURN
			END
			ggbAdmin = True
		END
END
