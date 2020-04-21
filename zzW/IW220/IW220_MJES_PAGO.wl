//EXTERN ".\zzW\IW220\IW220_MJES_PAGO.wl"

// Ejecuta("ABRE_PAGO")
// Ejecuta("XXX_ABRE_PAGO")  // sin prefijo   "XXX_xxxx"    es codigo base
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

// Inicales..
STC_total = "TOTAL "+NumToString(gcyImporte,"8.2f")
STC_pagado = 0

// Fijos no cambian
STC_sub = " SubT"+NumToString((gcyImporte-gcyDescTot)/1.16,"8.2f")
STC_des = " Desc"+NumToString(gcyDescTot,"8.2f")
STC_tax = " Tax1"+NumToString(gcyImporte - (gcyImporte-gcyDescTot)/1.16,"8.2f")
STC_tot = "Total"+NumToString(gcyImporte,"8.2f")
STC_uni = "Unidades:  "+gnUniTot

ggcrT = gcyImporte // cambio/falta en m41
//BCOD_1 = "www.portalPago.com"
