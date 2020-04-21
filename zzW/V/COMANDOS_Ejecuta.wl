//EXTERN ".\zzW\V\COMANDOS_Ejecuta.wl"



IF nDebug = Today() THEN Info("Comando="+sCpa1)
SWITCH sCpa1
  CASE "G"


    //Widget
    sCpa1 = "WIN_R.DASH_MAIN" // <<-----------------------
    FOR nCpa1 = 1 TO DashCount({sCpa1,indControl},toTotal)
      IF {sCpa1,indControl}[nCpa1]..Name = "IW_grafica" THEN
        // E X I S T E

        // Muevo a otra posicion en DASH ...
        DashMoveWidget({sCpa1,indControl},nCpa1,2,4,dashNoReorganization)
        DashResizeWidget({sCpa1,indControl},4 ,4,1)

        // Genero serie en forma aleatoria ...
        garrTit2 = ["L","M","M","J","V","S","D"] 	// Titulo series
        garrVal21 = [Random(5,20),Random(10,30),Random(20,40),Random(30,70),Random(40,80),Random(50,60),Random(50,60)]
        garrVal22 = [Random(10,40),Random(20,40),Random(30,60),Random(40,70),Random(50,60),Random(60,70),Random(50,80)]
        //IW_grafica.Ejecuta("GRA_ABRE" ,"C2;Ventas Dia")

        BREAK
      END
    END // for
  CASE "BX_VN"
    // Provisional ventas broxel ... (parametros externos)
        //    ggsCiaTemp = "BX"; ggsDBTemp = "HIF"; ggsDB4Temp = "K2"; ggbFlash_m = True; ggsFLASH = "M"
        //    ggsFecha1 = 20200207; ggsFecha2 = 20200209; ggsKataAlias = "VN"
        //    Ejecuta("F","CALC")

    //Ejecuta("K","HEMK2")
    //Ejecuta("K","E;CIA:BX,DB:HIF,DB4:K2,FLASH:M,KATA:VN,FECHA1:20200207,FECHA2:20200209")

    gsBloqueP = "" // calc.txt
    Ejecuta("F","CALC;CIA:BX,DB:HIF,DB4:K2,FLASH:M,KATA:VN,FECHA1:20200207,FECHA2:20200209")
    IF gsBloqueP <> ""
      gapA[2] = "VENTAS" 				// Titulo grafica
      FOR EACH STRING ggsA OF gsBloqueP SEPARATED BY CR
        // Importante usar ggsA ...
      	IF ggsA = "" THEN CONTINUE
      	sa1 is array of ANSI string
      	StringToArray(ggsA,sa1,";")
          IF ArrayCount(sa1) > 6 THEN
            ArrayAdd(garrVal21 , sa1[7] )
            ArrayAdd(garrVal22 , Val(sa1[7])+100 )
          END
      END
      garrTit2 = ["V7","S8","D9"] 	// Titulo series
    END

    //IW_grafica.Ejecuta("GRA_ABRE" ,"C2;Ventas Dia")
    bCpa1 = True
  CASE "R"
    //IW_recibo.Ejecuta("RBO_ABRE","LOGIN")
    //IW_captura..Visible = False
  CASE ~~"TABLETA" //0221
Info("en remodelacion modo: TABLETA")  
//    IF COMBO_productos..Visible = True THEN
//      INIWrite("cfg","Tableta_YN","N",ggsIni)
//      COMBO_productos..Visible = False
//      Info("Modo tableta DES-ACTIVADO")
//    ELSE
//      // Verifica contenido
//      IF ListCount(COMBO_productos) THEN
//      	FOR nCpa1 = 1 TO ArrayCount(garDi)
//      		ListAdd(COMBO_productos,garDi[nCpa1])
//      	END
//      	ListDisplay(COMBO_productos)
//      END
//      // Graba en configuracion ...
//      INIWrite("cfg","Tableta_YN","Y",ggsIni)
//      COMBO_productos..Visible = True
//      Info("Modo tableta ACTIVADO")
//    END

  CASE "TEST"
    info(gapA[1],ArrayCount(gapA),gapA[1],gapA[2],gapA[3],gapA[4]); RETURN

  OTHER CASE: Error(Upper(gapA[1])+"<-- tarea no definidad en IWcap_CALC(6588)")
END
