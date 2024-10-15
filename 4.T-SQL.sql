--a. Escribir un procedimiento almacenado que dado un tipo de riesgo ('Bajo','Medio','Alto'),
--muestre los datos de las violaciones (violCodigo, violDescrip) para dicho tipo, no devolver
--datos repetidos.

CREATE PROCEDURE SP_TipoViolacion
@tipoRiesgo varchar(10)

AS
BEGIN
	SELECT DISTINCT V.violCodigo as 'Codigo Violacion', V.violDescrip as 'Descripcion'
	FROM TipoViolacion V
	INNER JOIN Inspecciones I on I.violCodigo = V.violCodigo 
	WHERE @tipoRiesgo = I.inspRiesgo
END

EXEC SP_TipoViolacion @tipoRiesgo = 'Medio';	

--b. Mediante una función que reciba un código de violación, devolver cuantos establecimientos
--con licencia vencida y nunca renovada tuvieron dicha violación.

CREATE FUNCTION FN_CantidadEstablecimientosVencidosConTipoViolacion
(
    @tipoViolacion VARCHAR(10)
)
RETURNS INT	
AS
BEGIN
    DECLARE @Resultado INT		

	SELECT @Resultado = COUNT(DISTINCT E.estNumero)
	FROM Establecimientos E
	INNER JOIN Inspecciones I on I.estNumero = E.estNumero
	INNER JOIN TipoViolacion T on T.violCodigo = I.violCodigo
	INNER JOIN Licencias L on L.estNumero = E.estNumero
	WHERE EXISTS (SELECT TOP 1 1 FROM Licencias L2 WHERE L2.estNumero = E.estNumero and L2.licStatus = 'REV' ORDER BY L2.licFchEmision DESC)	
	AND T.violCodigo = @tipoViolacion
    RETURN @Resultado
END

--Mostrar Resultado
SELECT dbo.FN_CantidadEstablecimientosVencidosConTipoViolacion(1)
SELECT dbo.FN_CantidadEstablecimientosVencidosConTipoViolacion(3)


--c. Escribir un procedimiento almacenado que dado un rango de fechas, retorne por
--parámetros de salida la cantidad de inspecciones que tuvieron un resultado 'Oficina no
--encontrada' y la cantidad de inspecciones que no tienen comentarios.

CREATE PROCEDURE SP_CantidadInspeccionesSinComentariosYNoEncontradaXFecha
@FechaInicio date,
@FechaFin date,
@CantidadOficinaNoEncontrada INT OUTPUT,
@CantidadSinComentarios INT OUTPUT
AS
BEGIN
	SET @CantidadOficinaNoEncontrada = 0
    SET @CantidadSinComentarios = 0
    SELECT @CantidadOficinaNoEncontrada = COUNT(*)
    FROM Inspecciones
    WHERE inspFecha BETWEEN @FechaInicio AND @FechaFin
    AND inspResultado = 'Oficina no encontrada'

    SELECT @CantidadSinComentarios = COUNT(*)
    FROM Inspecciones
    WHERE inspFecha BETWEEN @FechaInicio AND @FechaFin
    AND inspComents IS NULL
END

DECLARE @FechaInicioExecutar date = '01-01-2024',
        @FechaFinExecutar date = '01-01-2025',
        @CantidadOficinaNoEncontradaEx INT,
        @CantidadSinComentariosEx INT

EXEC SP_CantidadInspeccionesSinComentariosYNoEncontradaXFecha @FechaInicioExecutar, @FechaFinExecutar, @CantidadOficinaNoEncontradaEx OUTPUT, @CantidadSinComentariosEx OUTPUT

SELECT @CantidadOficinaNoEncontradaEx AS CantidadOficinaNoEncontrada, @CantidadSinComentariosEx AS CantidadSinComentarios