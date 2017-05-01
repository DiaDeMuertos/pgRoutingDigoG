-- Funcion para buscar nodo
CREATE OR REPLACE FUNCTION buscarNodo(point GEOMETRY, table_name VARCHAR) 
RETURNS INTEGER AS $$ 
DECLARE
	result INTEGER;
BEGIN 

	EXECUTE FORMAT('
		SELECT id 
		FROM %s
		WHERE ST_INTERSECTS(ST_TRANSFORM(ST_BUFFER(ST_TRANSFORM(ST_GEOMFROMEWKT(%s),3857),30000),4326),the_geom)
		ORDER BY ST_DISTANCE(the_geom,ST_GEOMFROMEWKT(%s)) ASC
		LIMIT 1;',table_name, quote_literal(ST_ASEWKT(point)),quote_literal(ST_ASEWKT(point)))
	INTO result;

	RETURN result;      
	
END; 
$$ LANGUAGE plpgsql;

-- Distancia total de la ruta mas corta
CREATE OR REPLACE FUNCTION dTotalRutaCorta(a INTEGER, b INTEGER, tableName VARCHAR) 
RETURNS  DOUBLE PRECISION AS $$ 
DECLARE
	result DOUBLE PRECISION;
BEGIN 

	SELECT SUM(cost)
	INTO result
	FROM pgr_dijkstra('SELECT id, source, target,cost FROM ' || tableName,a,b,false,false);
		
	RETURN result;      
	
END; 
$$ LANGUAGE plpgsql;