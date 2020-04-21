//http://tapia.kalanda.info/KSW22_WEB/awws/ksw22.awws?wsdl
//http://tap22.pcscloud.net/PSW22_WEB/awws/pSW22.awws?wsdl
//http://137.74.212.177/PSW22_WEB/awws/pSW22.awws?wsdl

//ggsAplicacion is string = "wAG"
//EXTERN ".\zzW\GLOBALcomponente.wl"

/////////////// Solo Windows ///////////////
//ggsMac is string = NetMACAddress()							// solo windows
//ggsMac = Replace(ggsMac,":","_")             				// solo windows

//EXTERN WIN_LWE
//EXTERN WIN_KWE
//EXTERN WIN_SEARCH_LWE
//LoadWDL("LIB_KWE.WDL")

// ------------------------------------------------------------








ggsA, ggsA1, ggsA2, ggsA3 is string
ggni, ggni1 is int
ggsLog,ggsLogA is ANSI string
ggsProcedimiento is string = "GLOBALcomponente"  // debug y LOG (zzOw_InicioProceso)
gsVersion is string = "ver " +ExeInfo(exeVersion)	//190826


// Solo se prende en el codigo LOCAL antes de escribir
// y se apaga nuevamente  despues de escribir ...
gbNube is boolean // Fuerza a usar la nube

ggsDirParam,ggsIni,ggsSAVE is string
ggsCia,ggsCiaTemp is string           //191103
ggsDB,ggsDBtemp,ggsDB4Temp,ggsDBOri,ggsDB4Ori,ggsFLASH is string  //191103 191119 200209
ggsCreaFic is string

IF Left(ggsAplicacion,1) = "e" THEN
  // web service
  ggsDirParam = fDataDir() + [fSep]
  ggsIni = fDataDir() + [fSep] + "ws.ini"
  //ggsDB_WS_SP4L is string = pSP4L //INIRead("DB","DB_WS_SP4L","NULO",ggsIni)

  ggsDB = INIRead("DB","Drive","HIF",ggsIni)
  IF ggsDB <> "HIF" THEN INIWrite("DB","Drive","HIF",ggsIni) ;ggsDB = "HIF"

  //         C I A


  //    D A T A     B A S E

ELSE
  // Escritorio
  ggsDirParam = fExeDir() + [fSep]
  ggsIni = fExeDir() + [fSep] + ggsAplicacion + ".INI"
  ggsDB_WS_SP4L is string = INIRead("DB","DB_WS_SP4L","NULO",ggsIni)

  IF NOT fDirectoryExist("LOG") THEN
    IF NOT fMakeDir("LOG") THEN
      Error("X Imposible crear carpeta LOG (interno wCLog  1702171013)")
    END
  END

  // No aplica en nube solo LOCAL... 190922
  ggsLogA = fCurrentDir()+[fSep]+"LOG"+[fSep]+Right(Today(),5)+ggsAplicacion+".LOG"
  IF NOT fDirExist(fCurrentDir()+[fSep]+"LOG") THEN fMakeDir(fCurrentDir()+[fSep]+"LOG")
  IF NOT fDirExist(fCurrentDir()+[fSep]+"IMAGENES") THEN fMakeDir(fCurrentDir()+[fSep]+"IMAGENES")
  //190922
  IF NOT fDirExist(fCurrentDir()+[fSep]+"SAVE") THEN fMakeDir(fCurrentDir()+[fSep]+"SAVE")
  ggsSAVE = fCurrentDir()+[fSep]+"SAVE"+[fSep]+Right(Today(),5)
  IF NOT fDirExist(ggsSAVE) THEN fMakeDir(ggsSAVE)


  //         C I A
  ggsCia = INIRead("cfg","CIA","NULO",ggsIni)
  IF ggsCia = "NULO" THEN
    ggsCia = "IP"	// al subir al webService se transforma en la direccion IP
    INIWrite("cfg","CIA",ggsCia,ggsIni)
  END
  ggsCia = INIRead("cfg","CIA",Upper(Right(ggsAplicacion,2)),ggsIni)
  // kWe/lWe <-- ggsCia en webService
  INIWrite("cfg","CIA",ggsCia,ggsIni)



  //    D A T A     B A S E
  // DB = FIC(local/red) HIF (webServer: K1,K2, MG, S1,S2) SQL MYSQL
  ggsA = INIRead("DB","Drive","NULO",ggsIni)
  IF ggsA = "NULO" THEN INIWrite("DB","Drive","HIF",ggsIni)
  ggsDB = INIRead("DB","Drive","HIF",ggsIni)

  IF ggsDB_WS_SP4L = "NULO" THEN INIWrite("DB","DB_WS_SP4L","K2",ggsIni) ;ggsDB_WS_SP4L = "K2"

  // CUIDADO! aqui no esta cargada aun la funcion LOG("A"...
  ggsLog = ggsAplicacion+" CIA="+ggsCia+" (DBdrive)ggsDB="+ggsDB +" conexion="+ggsDB_WS_SP4L +" INI="+ggsIni
  fAddText(ggsLogA,Now()+" "+ggsProcedimiento+": "+ggsLog+CR)

  //        O T R O S
  // rtr 190825 ----- remoto sincroniza DROPBOX
//  ggsA = INIRead("DB","SINCRONIZAR","NULO",ggsIni)
//  IF ggsA = "NULO" THEN INIWrite("DB","SINCRONIZAR","N",ggsIni)

  // rtr 190814 ----- remoto
  ggsA = INIRead("DB","INTRANET","NULO",ggsIni)
  IF ggsA = "NULO" THEN INIWrite("DB","INTRANET","N",ggsIni)


END
INIWrite("info",ggsAplicacion+"EXE",fExeDir()+[fSep]+ggsAplicacion+".EXE",ggsIni)



          // T E M P O R L E S //
// Usados para pasar variables a procedimientos ...
ggArrT is array of string
ggsT,ggsT1,ggsT2,ggsT3 is string
ggnT,ggnT1,ggnT2,gnT3 is int
ggbT is boolean
ggcrT, ggcrT1 is currency
ggbContinua is boolean
// Parametros ...
ggsFECHA1,ggsFECHA2,ggsHORA1,ggsHORA2,ggsCAPA is string


          // C O M P I L A //
ggnIe,ggnIe1,ggnIe2,ggnIe3 is int

ggnDesdeE,ggnHastaE , ggnDesdeE2,ggnHastaE2 is int
ggArrC is array of string

ggArrIe,ggArrIe1,ggArrIe2,ggArrIe3 is array of int
ggArrE,ggArrE1,ggArrE2,ggArrE3 is array of string
ggArrEjecuta is array of string   //0305 concluye
ggbE,ggbE1,ggbE2,ggbE3 is boolean
ggbExisteOrigenE,ggbExisteDestinoE is boolean
ggnLquitaE,ggnLugarE is int
ggnE,ggnE1,ggnE2,ggnE3,ggnSeqE is int
ggsE,ggsE1,ggsE2,ggsE3,ggsE4,ggsE5,ggsE6,ggsE7,ggsE8,ggsE9 is string
ggsLineaE is string
ggsNuevaPalabraE is string

ggsALES,ggsVNXER,ggsVNXE,ggsVNXI,ggsVN is string      // cat�gos a formar
ggsSoyCodigo,ggsSoyNombre,ggNumeroCelular is string
ggcyPr,ggcyCo is currency                     // Totales Precio, Costo
ggnUn is int                                  // Totales Unidades
//Descrip,Util,Val,intermedio(XY),fin(m,N)   <---cuerpo cat�logo
ggsD,ggsH,ggsU,ggsV,ggsX,ggsY,ggsZ is string
ggsCDe,ggsCYe,ggsCMe,ggsCWe is string   // Codigo (preposicion)
ggsEst,ggsRef,ggsSeq is string          // Estacion   REFerencia
ggbYe,ggbMe,ggbWe is boolean            // Year Mes Week
//ggarrEMPL is array of string //191026 movido a varios
ggarrCorreo is array of ANSI string //200220
ggsRespuesta is string


            // C L A S I C O S //
//ggsLog,ggsLogA is ANSI string
//ggni, ggni1 is int
ggnX,ggnY,ggnZ,ggnD is int
//ggsA, ggsA1, ggsA2, ggsA3 is string
ggsAccion is string
ggarrA,ggarrA1 is array of string
gsBloqueP is string
ggsW_activo is string // debug
//190803
gsCas is string = Charact(34)



              // D E B U G //
sdg is boolean
ggsDebug,ggsMetodoRespuesta,ggsFlujo is string
ggnDebug,ggnFlujo,ggnDTrace is int
ggbEstadisticaTermina,ggbSilencio,ggbSilencioTemp is boolean
ggbSilencio = True
ggbSilencioTemp = True



              // V A R I O S //
gsMotores is string = "SP21 SP22 SP LITE DINASERVER GUEBS HGSP NPG NMSSQL NMYSQL LOCAL POST"
sTabla,sTabla1 is string
gsLanza,gsEtiqueta is string  // componente
ggnCant is int
ggbSimula is boolean  //191106
ggarrCLIE,ggarrEMPL,ggarrINVE,ggarrPROV is array of string  //191108
ggarrCLIEc,ggarrEMPLc,ggarrINVEc,ggarrPROVc is array of string  //191205
ggbFlash_a,ggbFlash_c,ggbFlash_m,ggbFlash_n is boolean  //191224 200116
ggsDash_Nombre is string

// IW_grafica
garrTit1,garrTit2,garrTit3,garrTit4 is array of ANSI string
garrVal11,garrVal21,garrVal22,garrVal31,garrVal32,garrVal33,garrVal41,garrVal42,garrVal43,garrVal44 is array of currency


//190901
       // R E G I S T R A D O R A //
gnTxNum,gnTxAnt,gnTxSeq,gnMesa is int
gnTx is int
//gcyImpo is currency
gnCobraModo is int
gbSumaResta is boolean = True  // boton4sumaResta prendido apagado ...


      // M O N E D A S //
ggsMoneda,ggsMonedaRef is string
gcyPrecio,gcyIva,gcyPaga is currency
garrPagoDesc is array of string
garrPagoVal is array of currency
garrPagoMoneda is array of ANSI string
garrPagoRef is array of ANSI string
ggsCambio is string
gcyDescAplica is int
gcyDue is currency

cyPagoApartado is currency
garrcyTotales is array of 10 currencies

gcyEfectivo is currency
gcyCambio is currency
gcyTransfer is currency
gcyCredito is currency
gcyDebito is currency
gcyCupon is currency
gcyNotaCr is currency
gcyCxc is currency
gcyLy is currency
gcyPagado is currency
gcyFalta is currency
gcyTotal is currency
gcyDescuento is currency
gcyTax is currency
gcyFondoFijo is currency
gcyDesconocida is currency




      // T O T A L E S //
ggcyTax1 is currency
ggcyTax2 is currency
ggcyTax3 is currency
ggcyTax is currency

ggcyTax1T is currency
ggcyTax2T is currency
ggcyTax3T is currency
ggcyTaxT is currency


ggcyPrecio,ggcyCosto,ggcyExtendido is currency
ggcyDesc is currency
ggnUni is int = 0
ggcyValor is currency

ggcyPrecioT,ggcyCostoT,ggcyExtendidoT is currency
ggcySubT is currency
ggcyTotal is currency
ggcyDescT is currency
ggnUniT is int = 0
ggcyValorT is currency


ggsB,ggsB1,ggsB2,ggsB3 is string  // Bloque
ggsCY,ggsCM,ggsCW,ggsC is string  // cia Year/Mes/Week



              // W E B //
ggsSoy,ggsClave is string
ggbAdmin is boolean



              // W E B    S E R V I C E //
ggwsP1,ggwsP2,ggwsP3,ggwsP4 is string



            // A R C H I V O S //
gsDir1,gsDir2,gsDir3 is string
gsArchi1,gsArchi2,gsArchi3 is string
gbContesta is boolean
gsContestaMje,gsContestaErro is string
garrContesta is array of ANSI string
gnContestaRefTemp is int
// ZIP
garrNom,garrTam,garrFecha,garrHora is array of ANSI string



// Alias ...
ggalA,ggalC,ggalM,ggalN,ggalK is Data Source
ggsAliasCreados,ggsAliasActivo,ggsKataAlias is string


          // SUPER ESTRUCTURAS //
XXXX is Structure
	tda is string
	cata is string
	codigo is string
	descripcion is string
	val1 is currency	// precio
	val2 is currency	// costo
	flag is int
	Flagc20 is string		// proveedor
	nota is string
	b is string
	c is string
	d is string
	f is string
	g is string
	m is currency
	n is int
	fecha is string
	hora is string
END
ACL,AEM,AIN,APV,AXX,AYY is array of XXXX
