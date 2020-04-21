//EXTERN ".\zzW\IWtit\IWtit_EDT.wl" // windows



// Ejecuta("EDT")
//sTarea is string  = MySelf..Name; Ejecuta("EDT",MySelf..Name)
//sTarea is string  = MySelf..Name; Ejecuta("EDT",MySelf..Caption)
//Ejecuta("EDT","tarea")
/////////////////////////////////////////////////////////////////////////
// Flujo:   BTN_<0..1> --> EDT_Captura / EDT_Usuario (ciclo)
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

sCTL = MySelf..Name; IF gapA[1] = "" THEN gapA[1] = sCTL
sCpa1 = MySelf..Caption
IF nDebug = Today() THEN Info("sCTL="+sCTL,"gapA[1]="+gapA[1],"","Caption="+sCpa1,"Caption="+{sCTL}..Caption)

// Inicializacion GLOBAL de la IW_xxxxx
//CONSTANT
//VK_RETURN  =       0x0D
//VK_TAB     =       0x09
//END
//gnKey,gnKey1 is int
//gnKey = VK_RETURN
//gnKey1 = VK_TAB

//IF KeyPressed(gnKey) OR KeyPressed(gnKey1) THEN

	IF {gestoyEn,indWindow}..Plane = gnCapaLogin THEN
		//0221
		IF Left(EDT_Usuario,1) = "," THEN
	    sCpa1 = Upper(Right(EDT_Usuario,Length(EDT_Usuario)-1))
			//EXTERN ".\zzW\V\COMANDOS_Ejecuta.wl"
			Ejecuta("COMANDO",sCpa1)
	    Ejecuta("ABRE",gapA[1]) // login
	    //RETURN // sobra por ReturnToCapture(EDT_1) en XXX_ABRE
	  END


    //0219
		IF Contains(EDT_Usuario,".") AND NOT gbPin THEN
			// Tarea , LOGIN;1001;1234
//			Ejecuta("ENTER","LOGIN;"+Replace(MySelf..Value,".",";"))	//usuario.clave
		ELSE
			IF EDT_Pin = "" THEN ReturnToCapture(EDT_Pin)
			Ejecuta("ENTER","LOGIN;"+EDT_Usuario+";"+EDT_Pin)	//usuario.clave
		END
	ELSE IF {gestoyEn,indWindow}..Plane = gnCapaSku
		// Tarea , SKU;7501234561234;2
//		Ejecuta("ENTER","SKU;"+Replace(MySelf..Value,".",";"))	//producto.cantidad
	END
//END
