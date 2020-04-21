//EXTERN ".\zzW\PAGO_reciboTOTALES.wl" // android Windows



	// Uso variables globales para poder usar
	// compilacion externa ...
	
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
