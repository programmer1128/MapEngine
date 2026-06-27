/*
 * Copyright (c) 2026 Aritra Banerjee. All Rights Reserved.
 Written by Aritra Banerjee
 * Not allowed to be copied
 */

-- Enable the spatial database engine extension
CREATE EXTENSION IF NOT EXISTS postgis;
-- Enable the fuzzy string matching extension for flexible location searching
CREATE EXTENSION IF NOT EXISTS pg_trgm;

--Table for Spatial Node mapping for C++ routing engine queries
CREATE TABLE road_nodes (
    node_id BIGINT PRIMARY KEY, -- The converted global OpenStreetMap Node ID
    geom GEOMETRY(Point, 4326) NOT NULL -- WGS84 Geodetic coordinates
);

-- Table for Forward Geocoding (Text Search -> Coordinates)
CREATE TABLE named_locations (
    id BIGSERIAL PRIMARY KEY,
    osm_id BIGINT NOT NULL,
    name TEXT NOT NULL,
    place_type VARCHAR(50), -- e.g., 'residential', 'restaurant', 'suburb', 'monument'
    geom GEOMETRY(Point, 4326) NOT NULL
);

--- PERFORMANCE INDEXES ---

-- Spatial Indexing (GiST) for fast nearest-neighbor snapping
CREATE INDEX idx_road_nodes_geom ON road_nodes USING gist (geom);
CREATE INDEX idx_named_locations_geom ON named_locations USING gist (geom);

-- Trigram Indexing (GIN) for fast fuzzy text searching for finding places like a particular spot
CREATE INDEX idx_locations_name_trgm ON named_locations USING gin (name gin_trgm_ops);






/*
 * End of file
 * Written by Aritra Banerjee
 * Not allowed to be copied
 */
