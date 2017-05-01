-- Tabla red vial para usar pgrouting
CREATE TABLE red_vial_pgr (
    id serial,
    source integer,
    target integer,
    cost double precision,
    the_geom geometry
);

-- Insertar datos a la tabla red_vial_pgr
INSERT INTO red_vial_pgr (cost,the_geom)
SELECT ST_Length(ST_TRANSFORM(geom,3857)), geom
FROM (
	SELECT ST_GeometryN(geom,generate_series(1,ST_NumGeometries(geom))) AS geom 
	FROM red_vial) AS foo;