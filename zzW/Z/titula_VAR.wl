//EXTERN ".\zzW\Z\titula_VAR.wl" // windows



sCapituloINI,sCpo,sMascara,sTitulo is string  	// carga/descarga
sPreObj,sObjeto is string			// Pinta



// Ejemplo -----------------------------------------------
//	CASE "TITULA"
//		gsKata = gapA[1]
//		IF gsKata = "" THEN Input("Titula CAT�LOGO ?",gsKata)
//		IF gsKata = "" THEN Error("Imposible continuar sin definir Cat�logo a titular..."); RETURN
//		gsKata = Upper(gsKata); gapA[1] = Upper(gsKata)
//
//		//Ejecuta("REFRESCA_QRY_lWe")
//		IF sCapituloINI = "" THEN sCapituloINI = gsKata
//		TABLE_mongo.COL_Cata..Caption = gapA[1]
//		sPreObj = "TABLE_QRY_lWe"
//		EXTERN ".\zzW\titula_pinta.wl"
//		sCapituloINI = ""
//
//		TableDisplay(TABLE_mongo)
