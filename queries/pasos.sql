-- Crear tologia para red_vial_pgr
SELECT pgr_createTopology('red_vial_pgr',0.001);

-- Precalcular nodo cercano
DROP TABLE IF EXISTS nodos_pTrabajar;
SELECT 
	id_a,id_b,
	buscarNodo(geom_a,'red_vial_pgr_vertices_pgr') AS id_nd_a,
	buscarNodo(geom_b,'red_vial_pgr_vertices_pgr') AS id_nd_b
INTO nodos_pTrabajar
FROM (	
	SELECT (row_number() over())::INTEGER AS index, a.id AS id_a,b.id AS id_b,a.geom AS geom_a, b.geom AS geom_b
	FROM puntos AS a, puntos AS b
	WHERE a.id != b.id
	LIMIT 100
) AS foo;

-- Calcular ruta
WITH nodos_pTrabajar_sub AS(
	SELECT id_a,id_b,id_nd_a,id_nd_b
	FROM nodos_pTrabajar
	LIMIT 10
)
SELECT 
	id_a,id_b,
	dTotalRutaCorta(id_nd_a,id_nd_b,'red_vial_pgr')	
FROM nodos_pTrabajar_sub
WHERE id_a != id_b;