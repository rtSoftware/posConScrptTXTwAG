//EXTERN ".\zzW\Z\titula_pintaAUX.wl" // windows



//sCapituloINI,sCpo,sTitulo,sObjeto is string


    IF sPreObj = "" THEN Error("sPreObj invalido en titula_pintaAUX"); RETURN
    sObjeto = sPreObj+".COL_"+sCpo

		sTitulo = INIRead(sCapituloINI,sCpo,sCpo,ggsIni)
		IF sTitulo = "ESCONDE" THEN
			{sObjeto}..Visible = False
		ELSE
			{sObjeto}..Visible = True
			{sObjeto}..Caption = sTitulo
			//{sObjeto}..DisplayMask = INIRead(gapA[1],sCpo+"_m","maskAlpha",ggsIni)
		END
