//EXTERN ".\zzW\IW220\IW220_ZALI.wl"

//Ejecuta("XXX_","")  // sin prefijo   "XXX_xxxx"    es codigo base
// Ejecuta("ZALI","LOGIN")  // sin prefijo   "XXX_xxxx"    es codigo base
/////////////////////////////////////////////////////////////////////////
// Flujo:   BTN_<0..1> --> EDT_Captura / EDT_Usuario (ciclo)
//            BTN_E --> ENTER --> FIND --> FORM (INI)     // login
//            BTN_E --> ENTER --> FIND --> FORM (Recibo)  // sku
//            BTN_P --> ENTER --> FIND --> FORM (kata)    // pago
//            BTN_C --> ABRE  (cancela)
//          MJES --> IWxxx_ZALI   (muy variado)
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

// Valida ... 0219
IF Upper(gapA[1]) NOT IN("LOGIN","SKU","PAGO")  THEN gapA[1] = ""
IF gapA[1] = "" THEN
  Error("X parametro CAPA aucente/erroneo en "+sCompilaTXT)
  SWITCH {gestoyEn,indWindow}..Plane
    CASE gnCapaLogin: gapA[1] = "LOGIN"
    CASE gnCapaSku: gapA[1] = "SKU"
    CASE gnCapaPago: gapA[1] = "PAGO"
    OTHER CASE: Error("X no definida Tarea en "+sCompilaTXT); EndProgram()
  END
END

IF Upper(gapA[1]) = "LOGIN" THEN  /////////////////////////////////////////////
  // LogIn

ELSE IF Upper(gapA[1]) = "PAGO" /////////////////////////////////////////////
    IF nDebug = Today() THEN Info("Ejecuta.ZALI."+gapA[1])
    HourGlass(False)

    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    // Definicion variables proceso
    EXTERN ".\zzW\V\PAGO_reciboANT.wl"
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


    //      T O T A L E S
    ggcyPr = 0; ggcyCo = 0; ggnUn = 0; ggcyDescT = 0

    HReadFirst(Recibo)
    WHILE HOut(Recibo) = False
      Recibo.extendido = Recibo.precio*Recibo.uni
      ggcyPr = ggcyPr + Recibo.extendido
      ggcyCo = ggcyCo + Recibo.costo*Recibo.uni
      ggcyDescT = ggcyDescT + Recibo.descuento
      ggnUn = ggnUn + Recibo.uni

      HReadNext(Recibo)
    END

    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    EXTERN ".\zzW\V\PAGO_reciboDETALLE.wl"
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    // Respalda
    fCopyFile(fCurrentDir+[fSep]+"recibo.html" , ggsSAVE+[fSep]+ggsRef+"recibo.html")
    fAddText(ggsSAVE+[fSep]+"ESCAN",sCpa3)
    fAddText(ggsSAVE+[fSep]+"VNTA",ggsVNXER)
    //fAddText(ggsSAVE+[fSep]+"VNTA",ggsVNXE+ggsVN+ggsVNXER)
    //fAddText("ALMA",ggsALES)
    fAddText(ggsSAVE+[fSep]+"TOTAL",ggcyPr+";"+ggcyCo+";"+ggcyDescT+";"+ggnUn)

    HourGlass(False)

    IF ggsCia = "BX" THEN
      Info("BX es una cuenta restringida. No genera transaccion...")
      Ejecuta("FIRMA_INICIO")
    END

    IF nDebug = Today()
      Info("ggsALES","",ggsALES); Info("ggsVNXER","",ggsVNXER)
      Info("ggsVNXE","",ggsVNXE); Info("ggsVNXI","",ggsVNXI); Info("ggsVN","",ggsVN)
      Info("PAGA: "+ggsCia,"ggsDB="+ggsDB,"ggsDB_WS_SP4L="+ggsDB_WS_SP4L,"ggsDBtemp="+ggsDBtemp,"ggsDB4Temp="+ggsDB4Temp,"","ggsDBOri="+ggsDBOri,"ggsDB4Ori="+ggsDB4Ori)
    END


    // Genera transaccion ...
    // **********************************************************
    Ejecuta("F","LOG;>>>>>>>>>>>>>>>"+Now()) //LOG("A",">>>>>>>>>>>>>>>"+Now())
    Ejecuta("F","TEMPO_B") // Asegura (prepara escritura)

     // H I S T O R I C O
    sEnvia is string = gsCas+ggsVNXER+gsCas   //ggsALES+ggsVNXER+ggsVNXE+ggsVNXI+ggsVN  Doble encomillado
    ggbFlash_m = False; ggbFlash_n = False; Ejecuta("A",sEnvia) //* 
    // L O G
    sEnvia = Replace(Left(sEnvia,99),";","/"); sEnvia = Replace(sEnvia,gsCas,"") // prepara para log
    Ejecuta("F","LOG;"+ggsDB+"/"+ggsDB_WS_SP4L+"_"+ggsCia+" (historicos.term1)"+sEnvia)

      // R E P O R T E S  (Copia ultimos 30 dias para generacion flash)
    sEnvia = gsCas+ggsVNXER+gsCas // Doble encomillado
    ggbFlash_m = True; ggbFlash_n = False; Ejecuta("A",sEnvia) //*
    // L O G
    sEnvia = Replace(Left(sEnvia,99),";","/"); sEnvia = Replace(sEnvia,gsCas,"") // prepara para log
    Ejecuta("F","LOG;"+ggsDB+"/"+ggsDB_WS_SP4L+" "+ggsCia+"M"+" (reportes.term2)"+sEnvia)


      // R E P L I C A
    ggsDBtemp = "HIF"; ggsDB4Temp = "S1" // default
    IF ggsDB_WS_SP4L = "S1" AND ggsDBOri = "HIF" THEN ggsDB4Temp = "S2"
    sEnvia = gsCas+ggsVNXER+gsCas // Doble encomillado
    ggbFlash_m = False; ggbFlash_n = False; Ejecuta("A",sEnvia)   //* (Historico)
    // L O G
    sEnvia = Replace(Left(sEnvia,99),";","/"); sEnvia = Replace(sEnvia,gsCas,"") // prepara para log
    Ejecuta("F","LOG;"+ggsDBtemp+"/"+ggsDB4temp+" "+ggsCia+" (copia seguridad.term3)"+sEnvia)

    ggsDBtemp = "HIF"; ggsDB4Temp = "S1" // default
    IF ggsDB_WS_SP4L = "S1" AND ggsDBOri = "HIF" THEN ggsDB4Temp = "S2"
    sEnvia = gsCas+ggsVNXER+gsCas // Doble encomillado
    ggbFlash_m = True; ggbFlash_n = False; Ejecuta("A",sEnvia)   //* (Reportes)
    // L O G
    sEnvia = Replace(Left(sEnvia,99),";","/"); sEnvia = Replace(sEnvia,gsCas,"") // prepara para log
    Ejecuta("F","LOG;"+ggsDBtemp+"/"+ggsDB4temp+" "+ggsCia+"M"+" (copia seguridad reportes.term4)"+sEnvia)


    ggsVNXER = "" // Asegura nuevas transacciones
    Ejecuta("F","LOG;>>>>>>>>>>>>>>>"+Now())
    // **********************************************************
    Ejecuta("ABRE","LOGIN") //Ejecuta("ABRE","SKU")
ELSE IF Upper(gapA[1]) = "SKU"  /////////////////////////////////////////////

END
