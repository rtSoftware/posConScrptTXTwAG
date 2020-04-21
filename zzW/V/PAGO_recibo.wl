//EXTERN ".\zzW\PAGO_recibo.wl" // android Windows



//190901
//190911 sRef de Recibo.tax2 (reconstruccion de WXER)


//FOR EACH Recibo ... PAGO (fuera de uso ?)
  ggsA = ""
  HReadFirst(Recibo) //, codigo)
  WHILE HOut(Recibo) = False


			Recibo.extendido = Recibo.precio*Recibo.uni
			ggcyTotal = ggcyTotal + Recibo.extendido
			ggcyCostoT = ggcyCostoT + Recibo.costo*Recibo.uni
			ggcyDescT = ggcyDescT + Recibo.descuento
			ggnUniT = ggnUniT + Recibo.uni


			// +++++++++++++++++++++++++++++++++++++++++++++//
			sRef = "_"+Right(Now(),3)
			IF Recibo.tax1 > 0 THEN sEB = NumToString(IntegerPart(Recibo.tax1)) //190911
			IF Recibo.tax2 > 0 THEN sRef = "_"+NumToString(IntegerPart(Recibo.tax2)) //190911
			gnTxSeq++ ;sQ = "_"+NumToString(gnTxSeq)+";"  // secuencia

			sV = ";+"+NumToString(Recibo.extendido)+";+"+NumToString(Recibo.costo*Recibo.uni)+";+"+NumToString(Recibo.uni)
      sF = ";;;;;;;" ;sFE = ";;;"+sEB+";;;;"	// ;c20;Nota;b;c;d;f;g; //190912
			sUtil = NumToString(Recibo.extendido-(Recibo.costo*Recibo.uni))
			sV2 = ";+"+sUtil+";" + CR //";;" + CR    // m;N;;    190912
			// +++++++++++++++++++++++++++++++++++++++++++++//

			////////////////////////////
			// 		V E N T A
			////////////////////////////
			// BX;VN;90830_;VentaDiaria;...
			sBqeVnt = sBqeVnt +ggsC+";VN"+sC+";VENTA DIARIA"+ sV+sF+sV2
			sBqeVnt = sBqeVnt +ggsC+";VNS"+sC+sEB+ ";VENTA DIARIA E"+sV+sFE+sV2
			IF bYe THEN
        sBqeVnt = sBqeVnt +ggsCY+";VNY"+sCY+ ";VENTA ANUAL"+sV+sF+sV2
        sBqeVnt = sBqeVnt +ggsCY+";VNSY"+sCY+sEB+ ";VENTA ANUAL E"+sV+sFE+sV2
			END
			IF bMe THEN
        sBqeVnt = sBqeVnt +ggsCM+";VNM"+sCM+ ";VENTA MES"+sV+sF+sV2
        sBqeVnt = sBqeVnt +ggsCM+";VNSM"+sCM+sEB+ ";VENTA MES E"+sV+sFE+sV2
      END
			IF bWe THEN
        sBqeVnt = sBqeVnt +ggsCW+";VNW"+sCW+ ";VENTA SEMANA"+sV+sF+sV2
        sBqeVnt = sBqeVnt +ggsCW+";VNSW"+sCW+sEB+ ";VENTA SEMANA E"+sV+sFE+sV2
      END


      // ************************************* //
			// Recibo      XXR
			// code=_sRef_sQ	           B=sE ;; d=Utilidad ; f=empl ; g=sku
			// BXR;VNXER;90831_123_1;juanPerez;11;9;1;;;4321;2;750123890123;1999;cocacola;;;
			sBqeVnt = sBqeVnt+ggsC+";VNXER"+sC+sRef+sQ+sSoyNombre+sV+";;;"+sEB+";"+...
			sSoyCodigo+";"+Recibo.codigo+";;"+Recibo.descripcion+sV2  //190912
			// 	replica >>>>>>>>>>>>>>
			sBqeRpl = sBqeRpl+ggsC+";VNXER"+sC+sRef+sQ+sSoyNombre+sV+";;;"+sEB+";"+...
			sSoyCodigo+";"+Recibo.codigo+";;"+Recibo.descripcion+sV2  //190912
      // ************************************* //



      // VNXE... codigo   E M P L E A D O    en d
      sF = ";;;;"+Right(sRef,3)+";"+sSoyCodigo+";;"+Recibo.descripcion
      //          b       c                  d                 g
      sFE = ";;;"+sEB+";"+Right(sRef,3)+";"+sSoyCodigo+";;"+Recibo.descripcion

			// Acumulado Empleado    XXE
			// BRE;VNXE;91230_1999;JuanPerez;... [B=sEB]
			sBqeVnt = sBqeVnt+ggsC+";VNXE"+sC+sSoyCodigo+";"+sSoyNombre+sV+sF+sV2
			sBqeVnt = sBqeVnt+ggsC+";VNXES"+sC+sEB+sSoyCodigo+";"+sSoyNombre+sV+sFE+sV2
			IF bYe THEN
        sBqeVnt = sBqeVnt+ggsCY+";VNXEY"+sCY+sSoyCodigo+";"+sSoyNombre+sV+sF+sV2
        sBqeVnt = sBqeVnt+ggsCY+";VNXESY"+sCY+sEB+sSoyCodigo+";"+sSoyNombre+sV+sFE+sV2
			END
			IF bMe THEN
        sBqeVnt = sBqeVnt+ggsCM+";VNXEM"+sCM+sSoyCodigo+";"+sSoyNombre+sV+sF+sV2
        sBqeVnt = sBqeVnt+ggsCM+";VNXESM"+sCM+sEB+sSoyCodigo+";"+sSoyNombre+sV+sFE+sV2
			END
			IF bWe THEN
        sBqeVnt = sBqeVnt+ggsCW+";VNXEW"+sCW+sSoyCodigo+";"+sSoyNombre+sV+sF+sV2
        sBqeVnt = sBqeVnt+ggsCW+";VNXESW"+sCW+sEB+sSoyCodigo+";"+sSoyNombre+sV+sFE+sV2
      END


      // Entradas de Almacen vs. VNXI
      IF NOT bALES THEN
        // Sin REFERENCIA --> ALES = VNXI
        sKat = "ALES"
 			  sV = ";-"+NumToString(Recibo.extendido)+";-"+NumToString(Recibo.costo*Recibo.uni)+";-"+NumToString(Recibo.uni)
      ELSE
        // VNXI(acumulado)  y mas adelante ALES(detalle/referencia)
        sKat = "VNXI"
  			sV = ";+"+NumToString(Recibo.extendido)+";+"+NumToString(Recibo.costo*Recibo.uni)+";+"+NumToString(Recibo.uni)
      END

      // VNXI... codigo   P R O D U C T O    en d
      sF = ";;;;;"+Recibo.codigo+";;"
      //          b        d               g
      sFE = ";;;"+sEB+";;"+Recibo.codigo+";;"

			// Acumulado Producto    XXI
			// BRE;VNXI;91230_123456789012;Item;... [B=sEB]
			sBqeVnt = sBqeVnt+ggsC+";"+sKat+sC+Recibo.codigo+";"+Recibo.descripcion+sV+sF+sV2
			sBqeVnt = sBqeVnt+ggsC+";"+sKat+"S"+sC+sEB+Recibo.codigo+";"+Recibo.descripcion+sV+sFE+sV2
      IF bYe THEN
        sBqeVnt = sBqeVnt+ggsCY+";"+sKat+"Y"+sCY+Recibo.codigo+";"+Recibo.descripcion+sV+sF+sV2
        sBqeVnt = sBqeVnt+ggsCY+";"+sKat+"SY"+sCY+sEB+Recibo.codigo+";"+Recibo.descripcion+sV+sFE+sV2
      END
      IF bMe THEN
        sBqeVnt = sBqeVnt+ggsCM+";"+sKat+"M"+sCM+Recibo.codigo+";"+Recibo.descripcion+sV+sF+sV2
        sBqeVnt = sBqeVnt+ggsCM+";"+sKat+"SM"+sCM+sEB+Recibo.codigo+";"+Recibo.descripcion+sV+sFE+sV2
      END
      IF bWe THEN
        sBqeVnt = sBqeVnt+ggsCW+";"+sKat+"W"+sCW+Recibo.codigo+";"+Recibo.descripcion+sV+sF+sV2
        sBqeVnt = sBqeVnt+ggsCW+";"+sKat+"SW"+sCW+sEB+Recibo.codigo+";"+Recibo.descripcion+sV+sFE+sV2
      END

      IF sKat = "VNXI" THEN
        sKat = "ALES"
 			  sV = ";-"+NumToString(Recibo.extendido)+";-"+NumToString(Recibo.costo*Recibo.uni)+";-"+NumToString(Recibo.uni)
      ELSE
        sKat = "VNXI"
  			sV = ";+"+NumToString(Recibo.extendido)+";+"+NumToString(Recibo.costo*Recibo.uni)+";+"+NumToString(Recibo.uni)
      END
			sBqeVnt = sBqeVnt+ggsC+";"+sKat+sC+Recibo.codigo+";"+Recibo.descripcion+sV+sF+sV2
			sBqeVnt = sBqeVnt+ggsC+";"+sKat+"S"+sC+sEB+Recibo.codigo+";"+Recibo.descripcion+sV+sFE+sV2
      IF bYe THEN
        sBqeVnt = sBqeVnt+ggsCY+";"+sKat+"Y"+sCY+Recibo.codigo+";"+Recibo.descripcion+sV+sF+sV2
        sBqeVnt = sBqeVnt+ggsCY+";"+sKat+"SY"+sCY+sEB+Recibo.codigo+";"+Recibo.descripcion+sV+sFE+sV2
      END
      IF bMe THEN
        sBqeVnt = sBqeVnt+ggsCM+";"+sKat+"M"+sCM+Recibo.codigo+";"+Recibo.descripcion+sV+sF+sV2
        sBqeVnt = sBqeVnt+ggsCM+";"+sKat+"SM"+sCM+sEB+Recibo.codigo+";"+Recibo.descripcion+sV+sFE+sV2
      END
      IF bWe THEN
        sBqeVnt = sBqeVnt+ggsCW+";"+sKat+"W"+sCW+Recibo.codigo+";"+Recibo.descripcion+sV+sF+sV2
        sBqeVnt = sBqeVnt+ggsCW+";"+sKat+"SW"+sCW+sEB+Recibo.codigo+";"+Recibo.descripcion+sV+sFE+sV2
      END



			sV = ";-"+NumToString(Recibo.extendido)+";-"+NumToString(Recibo.costo*Recibo.uni)+";-"+NumToString(Recibo.uni)

			////////////////////////////
			// 	E X I S T E N C I A
			////////////////////////////
			// BX;ALEX;123456789012;coca;11;9;1;;;4321;;2;1999;750123890123;;
			sBqeVnt = sBqeVnt+ggsC+";ALEX;"+Recibo.codigo+";"+Recibo.descripcion+sV+";;;;;;;"+sV2
			sBqeVnt = sBqeVnt+ggsC+";ALEXS;"+Recibo.codigo+";"+Recibo.descripcion+sV+";;;"+sEB+";;;;"+sV2
			// 	replica >>>>>>>>>>>>>>
			// BX;ALEX;123456789012;coca;11;9;1;;;4321;;2;1999;750123890123;;
			//sBqeRpl = sBqeRpl+ggsC+";ALEX;"+Recibo.codigo+";"+Recibo.descripcion+sV+";;;;;;;"+sV2
			//sBqeRpl = sBqeRpl+ggsC+";ALEXS;"+Recibo.codigo+";"+Recibo.descripcion+sV+";;;"+sEB+";;;;"+sV2




      IF bALES THEN
          // +++++++++++++++++++++++++++++++++++++++++++++//
          sF=";;;;;"+sRef+";;;"+Recibo.codigo
          //         b        d           g
          sFE=";;;"+sEB+";;"+sRef+";;;"+Recibo.codigo
          // +++++++++++++++++++++++++++++++++++++++++++++//

          //	Entrada/Salida       XXA     (Detalle_ref)
          // BXA;AALES;123456789012_234[1];coca;11;9;1;;;4321;;2;1999;750123890123;;
          sBqeVnt = sBqeVnt+ggsC+";ALES;"+Recibo.codigo+sRef+"S;"+Recibo.descripcion+sV+sF+sV2
          sBqeVnt = sBqeVnt+ggsC+";ALESS;"+Recibo.codigo+sRef+"S;"+Recibo.descripcion+sV+sFE+sV2

          IF bYe THEN
            sBqeVnt = sBqeVnt+ggsC+";ALESY"+sCY+Recibo.codigo+sRef+"S;"+Recibo.descripcion+sV+sF+sV2
            sBqeVnt = sBqeVnt+ggsC+";ALESSY"+sCY+Recibo.codigo+sRef+sEB+"S;"+Recibo.descripcion+sV+sFE+sV2
          END
          IF bMe THEN
            sBqeVnt = sBqeVnt+ggsC+";ALESM"+sCM+Recibo.codigo+sRef+"S;"+Recibo.descripcion+sV+sF+sV2
            sBqeVnt = sBqeVnt+ggsC+";ALESSM"+sCM+Recibo.codigo+sRef+sEB+"S;"+Recibo.descripcion+sV+sFE+sV2
          END
          IF bWe THEN
            sBqeVnt = sBqeVnt+ggsC+";ALESW"+sCW+Recibo.codigo+sRef+"S;"+Recibo.descripcion+sV+sF+sV2
            sBqeVnt = sBqeVnt+ggsC+";ALESSW"+sCW+Recibo.codigo+sRef+sEB+"S;"+Recibo.descripcion+sV+sFE+sV2
          END
      END

  END
