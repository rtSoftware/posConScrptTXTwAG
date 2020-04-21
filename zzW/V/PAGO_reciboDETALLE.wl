//EXTERN ".\zzW\PAGO_reciboDETALLE.wl" // android Windows



//////////////////////////////////////
//		DETALLE + HONESTIDA			//
//////////////////////////////////////
ggsA = ""; ggsA3 = ""; sCpa3 = ""
ggcyPr = 0; ggcyCo = 0;  ggnUn = 0; ggcyDescT = 0
HReadFirst(Recibo) //, codigo)
WHILE HOut(Recibo) = False
  // Acumulados termino WHILE ...
  Recibo.extendido = Recibo.precio*Recibo.uni
  ggcyPr = ggcyPr + Recibo.extendido
  ggcyCo = ggcyCo + Recibo.costo*Recibo.uni
  ggcyDescT = ggcyDescT + Recibo.descuento
  ggnUn = ggnUn + Recibo.uni

  Recibo.codigo = Right("0000000000000"+Recibo.codigo,13) // normaliza

  gnTxSeq++; ggsSeq = "_"+NumToString(gnTxSeq)  // secuencia


  // 		VNXER (ticket Recibo)
  ////////////////////////////////////
  ggsD = ggsSoyNombre //   ggsH = ""	// Honestidad
  //ggsU = NumToString(ggcyPr-ggcyCo) // Utilidad
  ggsV =  ";+"+NumToString(Recibo.extendido)+";+"+NumToString(Recibo.costo)+";+"+NumToString(Recibo.uni)
  ggsX = ";"+Recibo.descripcion+";;"+ggsEst+";"+ggsRef+";"+ggsSoyCodigo+";;"+Recibo.codigo //	;20;;b;c;d
  ggsY = ggsX
  ggsZ = ";;" + CR //m;N;fecha;hora
  // Pendientes (no pagadas)
  IF ggbE3 THEN
    // Pago Pendiente
    ggsV = ";+;+;+"
    ggsZ = ";+"+NumToString(Recibo.extendido)+";+"+NumToString(Recibo.uni)+ CR //m;N;;    Pendientes;Unidades
  END

  // ;VNXER;90831_123_1;juanPerez;11;9;1;;;4321;2;750123890123;1999;cocacola;;;
  ggsCDe = Right(Today(),5)+"_"+ggsSoyCodigo+"_"+ggsRef+"_"+ggsSeq	// codigo dia
  ggsVNXER = ggsVNXER+";VNXER;"+ggsCDe+";"+ggsD+ggsV+ggsX+ggsZ


  sCpa3 = sCpa3 +Recibo.codigo+"\"+Recibo.descripcion...
  +"\"+Recibo.extendido+"\"+Recibo.costo+"\"+Recibo.uni...
  +"\"+Recibo.promo+"\"+Recibo.cagoria+"\"+Recibo.presentacion...
  +"\"+Recibo.caducidad+"\"+Recibo.flag+"\"+Recibo.mesa+"\"

  HReadNext(Recibo)
END	// while...


///////////////////////
//		T####
// Registros para envio automatico de correos de cobro morosos
ggsD = INIRead("EMPL","EstatusCompra","",ggsIni) // Descripcion
//ggsU = NumToString(cyImproT-cyCostoT) // Utilidad

//ggsV = ";+"+NumToString(cyImproT)+";+"+NumToString(cyCostoT)+";+"+NumToString(nUniT)
// tambien correcto pero no lo lee compilacion externa

ggsV = ";+"+NumToString(ggcyPr)+";+"+NumToString(ggcyCo)+";+"+NumToString(ggnUn)
ggsX = ";"+ggNumeroCelular+";"+sCpa3+";"+ggsEst+";"+ggsSoyNombre +";;;"
ggsZ = ";;" + CR //m;N [;fecha;hora]

//;T9999;_123_;Pendiente;200;100;4;5512345678;...;4;Juan Perez;;;;;
ggsVNXER = ggsVNXER +";T"+ggsSoyCodigo+";"+   Right(Now(),5)+"_"+ggsSoyCodigo+"_"+ggsRef   +";"+ggsD+ggsV+ggsX+ggsZ
