
--a. Mostrar nombre, dirección y teléfono de los establecimientos que tuvieron la inspección fallida más reciente.
SELECT E.estNombre, E.estDireccion, E.estDireccion 
FROM Establecimientos E
INNER JOIN Inspecciones I on I.estNumero = E.estNumero and I.inspResultado = 'Falla' 
and I.inspFecha = (	SELECT TOP 1 (I.inspFecha)
					FROM Inspecciones I
					WHERE I.inspResultado = 'Falla'
					ORDER BY I.inspFecha DESC
					)


--b. Mostrar los 5 tipos de violaciones mas comunes, el informe debe mostrar código y descripción de la violación y cantidad de inspecciones en el año presente.

SELECT TOP 5 COUNT(I.violCodigo) as 'Cantidad', I.violCodigo as 'Codigo Violacion', T.violDescrip as 'Descripcion Violacion'
FROM Inspecciones I
INNER JOIN TipoViolacion T on T.violCodigo = I.violCodigo
WHERE YEAR(I.inspFecha) = YEAR(GetDate())
GROUP BY (I.violCodigo), T.violDescrip
ORDER BY COUNT(I.violCodigo) DESC

--c. Mostrar número y nombre de los establecimientos que cometieron todos los tipos de violación que existen.

SELECT E.estNombre 'Nombre', E.estNumero as 'Numero Establecimiento'
FROM Establecimientos E
INNER JOIN Inspecciones I on I.estNumero = E.estNumero
INNER JOIN TipoViolacion T on T.violCodigo = I.violCodigo
GROUP BY E.estNumero, E.estNombre
HAVING COUNT(DISTINCT I.violCodigo) = (	SELECT COUNT(*)
										FROM TipoViolacion
									  )
										

--d. Mostrar el porcentaje de inspecciones reprobadas por cada establecimiento, incluir dentro de la reprobación las categorías 'Falla', 'Pasa con condiciones'.

SELECT estNombre as 'Nombre Establecimiento', COUNT(DISTINCT I.inspID) as 'Cantidad Inspecciones',     (SELECT COUNT(I2.inspID)
																										FROM Inspecciones I2
																										WHERE (I2.inspResultado = 'Falla' OR I2.inspResultado = 'Pasa con condiciones') AND I2.estNumero = I.estNumero
																										) * 100 / COUNT(DISTINCT I.inspID) as 'Porcentaje reprobados'
FROM Establecimientos E																				
INNER JOIN Inspecciones I on I.estNumero = E.estNumero
GROUP BY E.estNumero, E.estNombre, I.estNumero


--e. Mostrar el ranking de inspecciones de establecimientos, dicho ranking debe mostrar número y nombre del establecimiento, total de inspecciones, total de inspecciones aprobadas
--('Pasa'), porcentaje de dichas inspecciones aprobadas, total de inspecciones reprobadas
-- ('Falla', 'Pasa con condiciones') y porcentaje de dichas inspecciones reprobadas, solo tener en cuenta establecimientos cuyo status de licencia es APR.

-- Notas: (1, '2024-02-02', '2024-03-01', 'REV'), (2, '2024-02-15', '2024-04-15', 'REV') -> Se agrego como ultima licencia en estado REV para los Establecimientos 1,2
-- Para comprobar que no aparecieran en el resultado de la consulta

SELECT
    E.estNumero,
    E.estNombre AS 'Nombre Establecimiento',
    COUNT(DISTINCT I.inspID) AS 'Total Inspecciones',
    SUM(CASE WHEN I.inspResultado = 'Pasa' THEN 1 ELSE 0 END) AS 'Cantidad Aprobados',
    SUM(CASE WHEN I.inspResultado IN ('Falla', 'Pasa con condiciones') THEN 1 ELSE 0 END) AS 'Cantidad Fallidos',
    SUM(CASE WHEN I.inspResultado = 'Pasa' THEN 1 ELSE 0 END) * 100.0 / COUNT(I.inspID) AS 'Porcentaje Aprobados',
	SUM(CASE WHEN I.inspResultado IN ('Falla', 'Pasa con condiciones') THEN 1 ELSE 0 END) * 100.0 / COUNT(I.inspID) AS 'Porcentaje Fallidos'
FROM Establecimientos E 
INNER JOIN Inspecciones I ON I.estNumero = E.estNumero
INNER JOIN Licencias L ON L.estNumero = E.estNumero
WHERE
    L.licStatus = 'APR'
    AND L.licFchEmision = (
        SELECT TOP 1 L1.licFchEmision
        FROM Licencias L1
        WHERE L1.estNumero = E.estNumero
        ORDER BY L1.licFchEmision DESC
    )
GROUP BY E.estNumero, E.estNombre
ORDER BY 'Porcentaje Aprobados' DESC, 'Cantidad Aprobados' DESC

--f. Mostrar la diferencia de días en que cada establecimiento renovó su licencia.(Modificada la consigna por profesora)
-- Se utilizaran las ultimas 2 licencias aprovadas

--Para conseguir la ultima licencia aprovada
SELECT TOP 1 L.licFchEmision
FROM Licencias L
WHERE L.estNumero = 1 and L.licStatus = 'APR'
ORDER BY L.licFchEmision DESC

--Para conseguir la fecha de vencimiento de la penultima licencia aprovada
SELECT MIN(licFchVto)
FROM (
    SELECT TOP 2 L.licFchVto
    FROM Licencias L
    WHERE L.estNumero = 1 AND L.licStatus = 'APR'
    ORDER BY L.licFchVto DESC
) AS Top2

--Mostrar la diferencia

SELECT E.*,
       DATEDIFF(
           DAY,
           (SELECT TOP 1 L1.licFchEmision
            FROM Licencias L1
            WHERE L1.estNumero = E.estNumero AND L1.licStatus = 'APR'
            ORDER BY L1.licFchEmision DESC),
           (SELECT MIN(licFchVto)
            FROM (
                SELECT TOP 2 L2.licFchVto
                FROM Licencias L2
                WHERE L2.estNumero = E.estNumero AND L2.licStatus = 'APR'
                ORDER BY L2.licFchVto DESC
            ) AS Temp)
       ) AS 'Diferencia Dias para renovacion'
FROM Establecimientos E;





