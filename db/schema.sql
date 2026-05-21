CREATE EXTENSION IF NOT EXISTS postgis;

DROP TABLE IF EXISTS ais_positions CASCADE;
DROP TABLE IF EXISTS vessels CASCADE;
DROP TABLE IF EXISTS vessel_types CASCADE;
DROP TABLE IF EXISTS nav_status CASCADE;

CREATE TABLE vessels (
    mmsi BIGINT NOT NULL,
    imo BIGINT,
    vessel_name TEXT,
    call_sign TEXT,
    vessel_type_id INTEGER,
    vessel_length DOUBLE PRECISION,
    vessel_width DOUBLE PRECISION,
    draft DOUBLE PRECISION
);

ALTER TABLE vessels
ADD PRIMARY KEY (mmsi);

CREATE TABLE vessel_types (
    vessel_type_id INTEGER NOT NULL,
    type_name TEXT NOT NULL
);

ALTER TABLE vessel_types
ADD PRIMARY KEY (vessel_type_id);

CREATE TABLE nav_status (
    status_id INTEGER NOT NULL,
    status_name TEXT NOT NULL
);

ALTER TABLE nav_status
ADD PRIMARY KEY (status_id);

CREATE TABLE ais_positions (
    id BIGSERIAL NOT NULL,
    mmsi BIGINT NOT NULL,
    base_date_time TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    geom GEOMETRY(Point, 4326),
    sog DOUBLE PRECISION,
    cog DOUBLE PRECISION,
    heading DOUBLE PRECISION,
    status_id INTEGER,
    transceiver TEXT NOT NULL
);

ALTER TABLE ais_positions
ADD PRIMARY KEY (id);

ALTER TABLE ais_positions
ADD CONSTRAINT ais_positions_status_id_foreign
FOREIGN KEY (status_id) REFERENCES nav_status(status_id);

ALTER TABLE vessels
ADD CONSTRAINT vessels_vessel_type_id_foreign
FOREIGN KEY (vessel_type_id) REFERENCES vessel_types(vessel_type_id);

ALTER TABLE ais_positions
ADD CONSTRAINT ais_positions_mmsi_foreign
FOREIGN KEY (mmsi) REFERENCES vessels(mmsi);