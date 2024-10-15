INSERT INTO Establecimientos (estNombre, estDireccion, estTelefono, estLatitud, estLongitud) VALUES
('Restaurante A', 'Calle 123', '555-1234', -34.9036, -56.1914),
('Cafetería B', 'Avenida XYZ', '555-5678', -34.9075, -56.1648),
('Pizzería C', 'Calle 456', '555-9876', -34.9112, -56.1521),
('Comida Rápida X', 'Avenida Principal', '555-1111', -34.8992, -56.1865),
('Restaurante Y', 'Calle Central', '555-2222', -34.9058, -56.1789),
('Parrillada Z', 'Bulevar 123', '555-3333', -34.9156, -56.1672),
('Bar de Tapas W', 'Ruta 456', '555-4444', -34.8999, -56.1765),
('Cafetería V', 'Calle Peatonal', '555-5555', -34.9023, -56.1621),
('Heladería U', 'Rambla Costera', '555-6666', -34.8997, -56.1943),
('Pizzería T', 'Plaza Central', '555-7777', -34.9107, -56.1834);

--Creo datos de prueba ya que los existentes no sirven . Se crearon Licencias Vigentes por el trigger Trg_InsertEstablecimientoLicenciaNueva hay que eliminarlas
INSERT INTO Establecimientos (estNombre, estDireccion, estTelefono, estLatitud, estLongitud) VALUES
('Panaderia 5b', 'Monteav 211', '985-1234', -34.9036, -56.1914),
('Hamby 5b', 'Bosq Verde 1121', '645-5678', -34.9075, -56.1648),
('FAsTF 5b', 'Jamaica 2312', '113-9876', -34.9112, -56.1521)

INSERT INTO Licencias (estNumero, licFchEmision, licFchVto, licStatus) VALUES
(1, '2023-01-01', '2024-01-01', 'APR'),
(2, '2023-02-15', '2024-02-15', 'APR'),
(3, '2023-03-30', '2024-03-30', 'APR'),
(4, '2023-04-10', '2024-04-10', 'APR'),
(5, '2023-05-20', '2024-05-20', 'APR'),
(6, '2023-06-30', '2024-06-30', 'APR'),
(7, '2023-07-05', '2024-07-05', 'APR'),
(8, '2023-08-15', '2024-08-15', 'APR'),
(9, '2023-09-25', '2024-09-25', 'APR'),
(10, '2023-10-30', '2024-10-30', 'APR');

--Licencias anteriores, Datos utilizados para :3.f. Mostrar el tiempo promedio que tarda cada establecimiento en renovar su licencia.
INSERT INTO Licencias (estNumero, licFchEmision, licFchVto, licStatus) VALUES
(1, '2020-01-01', '2021-01-01', 'APR'),
(2, '2020-02-15', '2021-02-15', 'APR'),
(3, '2020-03-30', '2021-03-30', 'APR'),
(4, '2020-04-10', '2021-04-10', 'APR'),
(5, '2020-05-20', '2021-05-20', 'APR'),
(6, '2020-06-30', '2021-06-30', 'APR'),
(7, '2020-07-05', '2021-07-05', 'APR'),
(8, '2020-08-15', '2021-08-15', 'APR'),
(9, '2020-09-25', '2021-09-25', 'APR'),
(10, '2020-10-30', '2021-10-30', 'APR'),
(1, '2021-01-01', '2022-01-01', 'APR'),
(2, '2021-02-15', '2022-02-15', 'APR'),
(3, '2021-03-30', '2022-03-30', 'APR'),
(4, '2021-04-10', '2022-04-10', 'APR'),
(5, '2021-05-20', '2022-05-20', 'APR'),
(6, '2021-06-30', '2022-06-30', 'APR'),
(7, '2021-07-05', '2022-07-05', 'APR'),
(8, '2021-08-15', '2022-08-15', 'APR'),
(9, '2021-09-25', '2022-09-25', 'APR'),
(10, '2021-10-30', '2022-10-30', 'APR'),
(1, '2022-01-01', '2023-01-01', 'APR'),
(2, '2022-02-15', '2023-02-15', 'APR'),
(3, '2022-03-30', '2023-03-30', 'APR'),
(4, '2022-04-10', '2023-04-10', 'APR'),
(5, '2022-05-20', '2023-05-20', 'APR'),
(6, '2022-06-30', '2023-06-30', 'APR'),
(7, '2022-07-05', '2023-07-05', 'APR'),
(8, '2022-08-15', '2023-08-15', 'APR'),
(9, '2022-09-25', '2023-09-25', 'APR'),
(10, '2022-10-30', '2023-10-30', 'APR');

INSERT INTO Licencias (estNumero, licFchEmision, licFchVto, licStatus) VALUES
(1, '2024-02-02', '2024-03-01', 'REV'),
(2, '2024-02-15', '2024-04-15', 'REV')

INSERT INTO Licencias VALUES
--Establecimiento numero 12 - Panaderia 5b
(12, DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, 4, GETDATE()), 'APR'), --Caso licencia vigente proxima a vencer
--Establecimiento numero 13 - Hamby 5b
(13, DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, -2, GETDATE()), 'APR'), --Licencia vencida Creada hace 20 dias vencida hace 2
--Establecimiento numero 13 - Hamby 5b
(13, DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, 30, GETDATE()), 'APR') --Licencia vigente NO proxima a vencer

INSERT INTO TipoViolacion (violDescrip) VALUES
('Higiene'),
('Manipulación de Alimentos'),
('Infraestructura'),
('Documentación'),
('Control de Plagas'),
('Seguridad Laboral'),
('Publicidad Engañosa'),
('Contaminación Ambiental'),
('Servicio al Cliente'),
('Falsificación de Documentos');

INSERT INTO Inspecciones (inspFecha, estNumero, inspRiesgo, inspResultado, violCodigo, inspComents) VALUES
('2024-03-15', 1, 'Bajo', 'Pasa', 1, 'Ninguno'),
('2024-03-20', 2, 'Medio', 'Pasa con condiciones', 2, 'No se utilizan guantes para la manipulacion'),
('2024-03-25', 3, 'Alto', 'Falla', 3, 'Mal estado establecimiento'),
('2024-04-01', 4, 'Bajo', 'Pasa', 4, 'Cumple con todos los requisitos'),
('2024-04-05', 5, 'Medio', 'Falla', 5, 'Se encuentran plagas en la zona inferior de la cocina'),
('2024-04-10', 6, 'Alto', 'Falla', 1, 'Falta de higiene en áreas de cocina'),
('2024-04-15', 7, 'Bajo', 'Pasa', 2, 'Poca limpieza en los almacenamientos alimentos'),
('2024-04-20', 8, 'Medio', 'Pasa con condiciones', 3, 'Debe realizar reformas en las paredes por humedades'),
('2024-04-25', 9, 'Alto', 'Falla', 4, 'Falto permiso DC-212'),
('2024-04-30', 10, 'Bajo', 'Pasa', 5, 'Leves irregularidades de plagas'),
('2024-05-05', 2, 'Medio', 'Falla', 1, 'Debe realizar lavados mas regulares a los instrumentos de cocina'),
('2024-05-10', 2, 'Alto', 'Falla', 2, 'No cumple ningun estandar de manipulacion de alimentos'),
('2024-05-15', 3, 'Bajo', 'Pasa con condiciones', 2, 'No debe reutilizar envases descartables'),
('2024-05-20', 4, 'Medio', 'Falla', 3, 'Debe reparar perdida menor de agua'),
('2024-05-25', 5, 'Alto', 'Falla', 3, 'El establecimiento tiene riesgo de rerrumbe'),
('2024-06-01', 6, 'Bajo', 'Pasa', 6, 'Las hornallas de la cocina no estan homologadas peligro para los cocineros'),
('2024-06-05', 7, 'Medio', 'Falla', 7, 'El tamano de los productos no cumple con lo publicitado'),
('2024-06-10', 8, 'Alto', 'Falla', 8, 'Mala gestion de desperdicios, contamina en gran medida'),
('2024-06-15', 9, 'Bajo', 'Pasa', 9, 'Largas colas de espera'),
('2024-06-20', 10, 'Medio', 'Pasa con condiciones', 10, 'Debe presentar permiso legal DX-221 el entregado no es valido'),
('2024-08-05', 2, 'Alto', 'Falla', 5, 'Inadecuado');

--Datos para: 3.c. Mostrar número y nombre de los establecimientos que cometieron todos los tipos de violación que existen
-- Inspecciones con comentarios ajustados para el Establecimiento 1 (Restaurante A)
INSERT INTO Inspecciones (inspFecha, estNumero, inspRiesgo, inspResultado, violCodigo, inspComents) VALUES
('2024-06-20', 1, 'Alto', 'Falla', 1, 'Higiene deficiente en áreas de preparación de alimentos'),
('2024-06-25', 1, 'Bajo', 'Falla', 2, 'Documentos falsificados presentados durante la inspección'),
('2024-06-30', 1, 'Medio', 'Falla', 3, 'Falta de medidas de higiene en el personal'),
('2024-07-05', 1, 'Alto', 'Falla', 4, 'Manipulación inapropiada de alimentos en la cocina'),
('2024-07-10', 1, 'Bajo', 'Falla', 5, 'Problemas estructurales detectados en el establecimiento'),
('2024-07-15', 1, 'Medio', 'Falla', 6, 'Documentación falsificada relacionada con la seguridad alimentaria'),
('2024-07-20', 1, 'Alto', 'Falla', 7, 'Falta de control efectivo de plagas en el establecimiento'),
('2024-07-25', 1, 'Bajo', 'Falla', 8, 'Publicidad engañosa sobre la calidad de los productos'),
('2024-07-30', 1, 'Medio', 'Falla', 9, 'Presencia de contaminantes ambientales en el área de cocina'),
('2024-08-05', 1, 'Alto', 'Falla', 10, 'Servicio al cliente inadecuado según normas de seguridad alimentaria');

--Datos para 4.c. Escribir un procedimiento almacenado que dado un rango de fechas, retorne por
--parámetros de salida la cantidad de inspecciones que tuvieron un resultado 'Oficina no
--encontrada' y la cantidad de inspecciones que no tienen comentarios.
INSERT INTO Inspecciones (inspFecha, estNumero, inspRiesgo, inspResultado, violCodigo, inspComents)
VALUES
('2024-06-11', '1', 'Alto', 'Oficina no encontrada', '1', 'No se localizo la oficina'),
('2024-06-12', '2', 'Medio', 'Pasa', '2', NULL),
('2024-06-13', '3', 'Bajo', 'Pasa', '3', NULL),
('2024-06-14', '4', 'Alto', 'Oficina no encontrada', '4', NULL),
('2024-06-15', '5', 'Medio', 'Pasa', '5', NULL),
('2024-06-16', '6', 'Bajo', 'Pasa', '6', NULL),
('2024-06-17', '7', 'Alto', 'Pasa', '7', NULL),
('2024-06-18', '8', 'Medio', 'Pasa', '8', NULL),
('2024-06-19', '9', 'Bajo', 'Oficina no encontrada', '9', NULL),
('2024-06-20', '10', 'Alto', 'Oficina no encontrada', '10', NULL);
