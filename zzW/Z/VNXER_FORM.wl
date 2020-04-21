//EXTERN ".\zzW\VNXER_FORM.wl" // windows


// Regresa:  	garrLetra con descripcion
//				ggArrE3 con codigo
//				AXX[i]:val1  AXX[i]:val2  AXX[i]:flag   AXX[i]:m  AXX[i]:n
//				pr			 co 		  gPrr 			ud 		  gudr


// Prepara
ArrayDeleteAll(garrSku); ArrayDeleteAll(garrLetra); ArrayDeleteAll(garrEsta); ArrayDeleteAll(garrHC)
ArrayDeleteAll(garrPrec); ArrayDeleteAll(garrCost); ArrayDeleteAll(garrUnid); ArrayDeleteAll(garrRe); ArrayDeleteAll(garrReU)
gpr = 0; gco = 0; gPrr = 0; gud = 0; gudr = 0

ggsB = ""; ggni = 0; ggsLog = ""
ggcyPrecio = 0; ggcyCosto = 0; ggcyTax1T = 0
ggcyPrecioT = 0; ggcyDescT = 0	// Rechazados


///////////////////////////////////
// forma SUPER-ARREGLO global AXX
///////////////////////////////////
ArrayDeleteAll(AXX)
StringToArray(Replace(gsBloqueP,";",TAB),AXX,CR)
IF nDebug = Today() THEN Info(sCompilaTXT+"  Calcula...","AXX="+ArrayCount(AXX),"",left(gsBloqueP,399),"ggsKataAlias="+ggsKataAlias)

FOR i = 1 _TO_ ArrayCount(AXX)
  IF AXX[i]:d = "" OR AXX[i]:g = "" THEN CONTINUE	// Asegura
  //if AXX[i]:g <> "7501000133031" THEN CONTINUE

  //;VNXER;91229_1493__107__1;GUA... ;9   ;8.67 ;1; Jumex     ;;3;_107;1493;;7501013174038;0;0;20191229
  SWITCH ggsKataAlias
    CASE "VNS": sLlave = AXX[i]:b				// estacion
    CASE "VNXE": sLlave = AXX[i]:d 				// #EMPL
    CASE "VNXI","ALES": sLlave = AXX[i]:g 				// SKU
    CASE "VNXES": sLlave = AXX[i]:b+AXX[i]:d	// estacion + #EMPL
    CASE "VNXIS","ALESS": sLlave = AXX[i]:b+AXX[i]:g	// estacion + SKU
  END
  ggnT = ArraySeek(garrSku,asLinearFirst,sLlave)
  IF ggnT <=0 THEN
    ArrayAdd(garrSku,sLlave); ggnT = ArrayCount(garrSku) //
    IF ggsKataAlias IN ("VNXE","VNXES") THEN
      ArrayAdd(garrLetra,AXX[i]:descripcion); ArrayAdd(ggArrE3,AXX[i]:d)
      ArrayAdd(garrEsta,AXX[i]:b)	// 0109 estacion
    ELSE
      ArrayAdd(garrLetra,AXX[i]:Flagc20); ArrayAdd(ggArrE3,AXX[i]:g)
      ArrayAdd(garrEsta,AXX[i]:b) // 0109 estacion
    END
    // Inicializa suma ...
    IF ggsKataAlias = "ALES" THEN
      AXX[i]:val1 = AXX[i]:val1 * -1; AXX[i]:val2 = AXX[i]:val2 * -1; AXX[i]:flag = AXX[i]:flag * -1
      AXX[i]:m = AXX[i]:m * -1; AXX[i]:n = AXX[i]:n * -1
    END
    ArrayAdd(garrPrec,AXX[i]:val1); ArrayAdd(garrCost,AXX[i]:val2); ArrayAdd(garrUnid,AXX[i]:flag)
    ArrayAdd(garrRe,AXX[i]:m); ArrayAdd(garrReU,AXX[i]:n)
  ELSE
    // Acumula si hay otro igual
    garrPrec[ggnT] += AXX[i]:val1; garrCost[ggnT] += AXX[i]:val2; garrUnid[ggnT] += AXX[i]:flag
    garrRe[ggnT] += AXX[i]:m; garrReU[ggnT] += AXX[i]:n
  END

  // Acumulados VN
  gpr += AXX[i]:val1; gco += AXX[i]:val2; gud += AXX[i]:flag
  gPrr += AXX[i]:m; gudr += AXX[i]:n	// Rechazados

END	// fin Acumula x Estacion
IF ggsKataAlias = "ALES" THEN
  // Entradas ...

END
IF nDebug = Today() THEN Info("VNXER_FORM... ","","AXX="+ArrayCount(AXX),"garrSku="+ArrayCount(garrSku),"",Left(gsBloqueP,399),"ggsKataAlias="+ggsKataAlias)
//Info("VNXER_FORM... garrSku="+ArrayCount(garrSku),garrSku[1],ggsKataAlias, "gud="+gud,"gpr="+gpr)
