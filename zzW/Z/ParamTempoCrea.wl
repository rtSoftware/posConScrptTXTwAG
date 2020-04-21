//EXTERN ".\zzW\ParamTempoCrea.wl" // windows



IF ggsAccion = "ParamTempo" THEN Info("ParamTempoCrea...","","ggsT="+ggsT)

arrPaTe is array <growth=n> of String // PArametros TEmporales
StringToArray(ggsT,arrPaTe,",")
ggnX = 1
WHILE ggnX < 11
	IF Contains(arrPaTe[ggnX],"CIA:",IgnoreCase) THEN ggsCiaTemp = Middle(arrPaTe[ggnX],5,5)
	IF Contains(arrPaTe[ggnX],"DB:",IgnoreCase) THEN ggsDBtemp = Middle(arrPaTe[ggnX],4,5)
	IF Contains(arrPaTe[ggnX],"DB4:",IgnoreCase) THEN ggsDB4Temp = Middle(arrPaTe[ggnX],5,2)
	IF Contains(arrPaTe[ggnX],"FLASH:",IgnoreCase) THEN
		ggsFLASH = Middle(arrPaTe[ggnX],7,1)
		ggbFlash_a = False; ggbFlash_c = False; ggbFlash_m = False; ggbFlash_n = False
		SWITCH Upper(ggsFLASH)
			CASE "A": ggbFlash_a = True
			CASE "C": ggbFlash_c = True
			CASE "M": ggbFlash_m = True
			CASE "N": ggbFlash_n = True
		END
	END
	IF Contains(arrPaTe[ggnX],"KATA:",IgnoreCase) THEN ggsKataAlias = Middle(arrPaTe[ggnX],6,9)
	IF Contains(arrPaTe[ggnX],"INTRANET:",IgnoreCase) THEN ggsA1 = Middle(arrPaTe[ggnX],10,99)

	IF Contains(arrPaTe[ggnX],"FECHA1:",IgnoreCase) THEN ggsFECHA1 = Middle(arrPaTe[ggnX],8,8)
	IF Contains(arrPaTe[ggnX],"FECHA2:",IgnoreCase) THEN ggsFECHA2 = Middle(arrPaTe[ggnX],8,8)
	IF Contains(arrPaTe[ggnX],"HORA1:",IgnoreCase) THEN ggsHORA1 = Middle(arrPaTe[ggnX],7,8)
	IF Contains(arrPaTe[ggnX],"HORA2:",IgnoreCase) THEN ggsHORA2 = Middle(arrPaTe[ggnX],7,8)

	IF Contains(arrPaTe[ggnX],"CAPA:",IgnoreCase) THEN ggsCAPA = Middle(arrPaTe[ggnX],6,2)

	ggnX++
END
IF ggsAccion = "ParamTempo" THEN
	Info("ggsCiaTemp="+ggsCiaTemp , "ggsDBTemp="+ggsDBTemp , "ggsDB4Temp="+ggsDB4Temp ,...
	 	"ggbFlash_m="+ggbFlash_m , "ggsFECHA1="+ggsFECHA1, "ggsFECHA2="+ggsFECHA2,...
		 "ggsHORA1="+ggsHORA1 ,"ggsHORA2="+ggsHORA2, "ggsKataAlias="+ggsKataAlias,...
		 "ggsCAPA="+ggsCAPA)
END
