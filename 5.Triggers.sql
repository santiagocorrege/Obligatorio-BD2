--a. Cada vez que se crea un nuevo establecimiento, se debe crear una licencia de aprobación
--con vencimiento 90 días, el disparador debe ser escrito teniendo en cuenta la posibilidad de
--ingresos múltiples.

CREATE TRIGGER Trg_InsertEstablecimientoLicenciaNueva
ON Establecimientos
AFTER INSERT
AS
BEGIN
    INSERT INTO Licencias (estNumero, licFchEmision, licFchVto, licStatus)
    SELECT i.estNumero, GETDATE(), DATEADD(DAY, 90, GETDATE()), 'APR'
    FROM INSERTED i
END

--Probando Trigger
SELECT * From Licencias 

INSERT INTO Establecimientos  VALUES
('Prueba', 'Canelones 1120', '2212-2321', -74.9112, -76.1521)

SELECT * 
FROM Licencias L
INNER JOIN Establecimientos E on E.estNumero = L.estNumero
WHERE E.estNombre = 'RenovaBurger'


--b. No permitir que se ingresen inspecciones de establecimientos cuya licencia está próxima a
--vencer, se entiende por próxima a vencer a todas aquellas cuyo vencimiento esté dentro de
--los siguientes 5 días, el disparador debe tener en cuenta la posibilidad de registros
--múltiples.

CREATE TRIGGER Trg_CntrlInsertInspeccionesLicenciasVencidas
ON Inspecciones
INSTEAD OF INSERT	
AS
BEGIN
    INSERT INTO Inspecciones (inspFecha, estNumero, inspRiesgo, inspResultado, violCodigo, inspComents)
    SELECT Ins.inspFecha, Ins.estNumero, Ins.inspRiesgo, Ins.inspResultado, Ins.violCodigo, Ins.inspComents
    FROM Inserted Ins
    WHERE EXISTS (
        SELECT 1
        FROM Licencias L
        WHERE L.estNumero = Ins.estNumero
		  AND (Ins.inspFecha BETWEEN L.licFchEmision AND L.licFchVto) --Puse esto para comprobar la licencia en el momento de la inspeccion
          AND (L.licStatus = 'APR')
          AND (L.licFchVto NOT BETWEEN GETDATE() AND DATEADD(DAY, 5, GETDATE()))
		  AND (L.licFchVto > GETDATE())
    )
END
--DBCC USEROPTIONS 
--mdy

--Creo datos de prueba ya que los existentes no sirven . Se crearon Licencias Vigentes por el trigger Trg_InsertEstablecimientoLicenciaNueva hay que eliminarlas

INSERT INTO Establecimientos (estNombre, estDireccion, estTelefono, estLatitud, estLongitud) VALUES
('Panaderia 5b', 'Monteav 211', '985-1234', -34.9036, -56.1914),
('Hamby 5b', 'Bosq Verde 1121', '645-5678', -34.9075, -56.1648),
('FAsTF 5b', 'Jamaica 2312', '113-9876', -34.9112, -56.1521)


SELECT L.*
FROM Licencias L
INNER JOIN Establecimientos E on E.estNumero = L.estNumero
WHERE E.estNombre IN ('Panaderia 5b', 'Hamby 5b', 'FAsTF 5b')

--Elimino licencias creadas por el trigger Trg_InsertEstablecimientoLicenciaNueva
DELETE L
FROM Licencias L
WHERE L.estNumero IN (
    SELECT E.estNumero
    FROM Establecimientos E
    WHERE E.estNombre IN ('Panaderia 5b', 'Hamby 5b', 'FAsTF 5b')
)

--Compruebo licencias eliminadas
SELECT L.*
FROM Licencias L
INNER JOIN Establecimientos E on E.estNumero = L.estNumero
WHERE E.estNombre IN ('Panaderia 5b', 'Hamby 5b', 'FAsTF 5b')

--Chequeo numero Establecimiento para la creacion de licencias
SELECT E.*
FROM Establecimientos E
WHERE E.estNombre IN ('Panaderia 5b', 'Hamby 5b', 'FAsTF 5b')

--Creo las licencias para los establecimientos creados sin licencias creadas
INSERT INTO Licencias VALUES
--Establecimiento numero 12 - Panaderia 5b
(12, DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, 4, GETDATE()), 'APR'), --Caso licencia vigente proxima a vencer
--Establecimiento numero 13 - Hamby 5b
(13, DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, -2, GETDATE()), 'APR'), --Licencia vencida Creada hace 20 dias vencida hace 2
--Establecimiento numero 13 - Hamby 5b
(13, DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, 30, GETDATE()), 'APR') --Licencia vigente NO proxima a vencer

SELECT COUNT (*) FROM INSPECCIONES --41 total

--Compruebo Trigger
INSERT INTO Inspecciones VALUES
(GETDATE(), 12, 'ALTO', 'PASA', 2, 'Sin cmnt'),
(GETDATE(), 13, 'ALTO', 'PASA', 2, 'Sin cmnt'),
(GETDATE(), 14, 'ALTO', 'PASA', 2, 'Sin cmnt')

SELECT COUNT (*) FROM INSPECCIONES --Deberia tener +42  Dio 42