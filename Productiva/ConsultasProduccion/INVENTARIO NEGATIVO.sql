SELECT id,nombreSerie,documento
FROM Solicitudes
WHERE documento in('3500043','')

SELECT almacen
FROM SolicitudesLineas
WHERE idSolicitud in( 500956)
GROUP BY almacen

SELECT d.id
	,a.ItemCode
	,a.OnHand
	,a.WhsCode
	,sum(c.cantDespachada) AS cantDespachada
	,c.cantNoDespachada
	,d.tipoOrden
--,c.lineNum
FROM GlobalWine.dbo.OITW a
INNER JOIN GlobalWine.dbo.OITM b ON a.ItemCode = b.ItemCode
INNER JOIN OrdenesAlistamientoLineas c ON c.itemCode = a.ItemCode
	AND c.whsCode = a.WhsCode
INNER JOIN OrdenesAlistamiento d ON d.id = c.idOrdenAlistamiento
WHERE d.idSolicitud = 500956
	AND c.cantDespachada != 0
	AND c.whsCode = '1401'
--and a.itemCode = '105045
GROUP BY a.OnHand
	,a.WhsCode
	,c.cantNoDespachada
	,a.ItemCode
	,d.tipoOrden
	,d.id
HAVING sum(c.cantDespachada) > a.OnHand
	--select sum(cantidadAsignada) from BDI.dbo.SolicitudesLineas where idSolicitud = 492439 and itemCode = '105045'
	--select * from Solicitudes where documento = '20869865'
	--select * from OrdenesAlistamiento where idSolicitud = 492439
	--select * from OrdenesAlistamientoLineas where idOrdenAlistamiento = 151913
