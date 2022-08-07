--2-A

SELECT DISTINCT
	T.*
FROM
	TRENES T,
	Pasa P,
	Tiene TI
WHERE
	T.Numero = P.ID_TREN AND
	TI.CODIGO_ESTACION = P.CODIGO_ESTACION AND
	P.Fecha_Hora = (SELECT  
					MAX (FECHA_HORA)
					FROM
					PASA
					)
					
--2-B

SELECT distinct
	p.codigo_estacion,
	COUNT(p.fecha_hora) AS Cantidad_Trenes
FROM
	Pasa p
WHERE 
	YEAR(P.FECHA_HORA) = 2021
group by p.codigo_estacion
HAVING COUNT(p.fecha_hora) > (SELECT AVG(Total)
                        FROM (SELECT p2.codigo_Estacion,count(p2.fecha_hora) as Total
                              FROM pasa p2
                                                 WHERE YEAR(p2.fecha_hora)=2020
                              GROUP BY p2.codigo_estacion) promedio)
							  
--2-C

SELECT DISTINCT
	L.Numero as Numero_linea,
	L.Descripcion,
	E1.Descripcion as Estacion_Inicio,
	E2.Descripcion as Estacion_Fin,
	COUNT(T.Codigo_Estacion) as Cantidad_Estaciones
FROM
	TIENE T,
	ESTACIONES E,
	LINEAS L
INNER JOIN
	ESTACIONES E1 ON L.Codigo_Estacion_Inicio=E1.Codigo
INNER JOIN 
	ESTACIONES E2 ON L.Codigo_Estacion_Final=E2.Codigo
WHERE
	L.Numero = T.Numero_Linea and
	E.Codigo=T.Codigo_Estacion
GROUP BY
	L.Numero,
	L.Descripcion,
	E1.Descripcion,
	E2.Descripcion 

--2-D

SELECT
	L.*
FROM
	LINEAS L
WHERE
	Longitud=(SELECT MAX(LONGITUD) FROM LINEAS)

--2-E

SELECT
	E.*
FROM
	ESTACIONES E,
	LINEAS L,
	TIENE T
WHERE
	E.Codigo=T.Codigo_Estacion AND
	T.Numero_Linea=L.Numero AND
	L.Color ='ROJO' AND 
	E.Codigo NOT IN (SELECT
						L1.Codigo_Estacion_Final 
					FROM
						LINEAS L1
					WHERE
						L1.Color ='AMARILLO') AND
						E.Codigo NOT IN (SELECT
										L2.Codigo_Estacion_Inicio 
										FROM
										LINEAS L2
										WHERE
										L2.Color ='AMARILLO')

--2-F

SELECT
	T.*
FROM
	TRENES T,
	pasa p,
	estaciones e
WHERE
	T.Numero=P.Id_Tren AND
	p.Codigo_Estacion=e.Codigo
group by 
	t.Descripcion,t.Cantidad_Vagon, t.Capacidad_Vagon, t.Letra, t.Numero
having
count (distinct p.Codigo_Estacion)=(select count(distinct e1.Codigo) from Estaciones e1)