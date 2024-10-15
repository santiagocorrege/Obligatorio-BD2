--6. Escribir una vista que muestre todos los datos de las licencias vigentes y los días que faltan para
--el vencimiento de cada una de ellas.


CREATE VIEW LicenciasVigentes
AS
(
SELECT DISTINCT(L.estNumero) as 'Numero Establecimiento' , L.licNumero, L.licFchEmision, L.licFchVto, L.licStatus, DATEDIFF(day, GETDATE(), L.licFchVto) as 'Cantidad dias para el vencimiento', GETDATE() as 'Fecha Actual'
FROM Licencias L
WHERE (GETDATE() BETWEEN L.licFchEmision and L.licFchVto) and L.licStatus = 'APR'
)

SELECT * FROM LicenciasVigentes