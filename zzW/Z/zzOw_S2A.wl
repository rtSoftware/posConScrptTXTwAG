//EXTERN ".\zzW\zzOw_S2A.wl" // windows
sExterno is string = "zzOw_S2A"
////////////// excepcion //////////////
//EXTERN ".\zzW\zzOw_InicioProceso.wl"
//nDebug is int
///////////////////////////////////////


ggsLog = "" // Asegura

sLog is string
sDelimitador is string

IF pCadena = "" THEN ggsLog = "X cadena vacia" ;RETURN

// Vaalida que sea un arreglo ...
IF ArrayCount(pArreglo) THEN ArrayDeleteAll(pArreglo)


// TXT ...
IF Upper(Right(pCadena,4)) = ".TXT" THEN
	IF fFileExist(fCurrentDir()+[fSep]+pCadena) THEN
    pCadena = floadText(fCurrentDir()+[fSep]+pCadena)
	ELSE
		IF fFileExist(pCadena) THEN	pCadena = floadText(pCadena)
	END
	IF pCadena = "" THEN ggsLog = "X TXT vacio/inexistente" ;RETURN
END


///////////// URLs ///////////////
IF sDelimitador = "" AND Contains(pCadena," �� ") THEN
  StringToArray(pCadena+sDelimitador,pArreglo," �� ")
  RETURN
END

IF Contains(pCadena,"|") THEN sDelimitador = "|"

IF Contains(pCadena,"�") AND sDelimitador = "" THEN sDelimitador = "�"
IF Contains(pCadena,"�") AND sDelimitador = "" THEN sDelimitador = "�"
IF Contains(pCadena,"~") AND sDelimitador = "" THEN sDelimitador = "~"

IF Contains(pCadena,";") AND sDelimitador = "" THEN sDelimitador = ";"
IF Contains(pCadena,",") AND sDelimitador = "" THEN sDelimitador = ","
IF Contains(pCadena,"/") AND sDelimitador = "" THEN sDelimitador = "/"
IF Contains(pCadena,"\") AND sDelimitador = "" THEN sDelimitador = "\"
IF Contains(pCadena,"_") AND sDelimitador = "" THEN sDelimitador = "_"

IF Contains(pCadena,CR) AND sDelimitador = "" THEN sDelimitador = CR
IF Contains(pCadena,TAB) AND sDelimitador = "" THEN sDelimitador = TAB

StringToArray(pCadena,pArreglo,sDelimitador)
IF ArrayCount(pArreglo) = 1 THEN
  ggsLog = "X aucente DELIMITADOR"
  INIWrite("S2A","Delimitador","",ggsIni)
  INIWrite("S2A","Campos","1",ggsIni)
ELSE
  INIWrite("S2A","Delimitador",sDelimitador,ggsIni)
  INIWrite("S2A","Campos",NumToString(ArrayCount(pArreglo)),ggsIni)
END

//CASE EXCEPTION:
//	ggsLog = "X 180429709"
//	RETURN
