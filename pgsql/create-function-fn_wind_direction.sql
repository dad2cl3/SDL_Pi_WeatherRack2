CREATE OR REPLACE FUNCTION weather.fn_wind_direction (p_degrees INTEGER)
RETURNS VARCHAR
-- RETURNS INTEGER
AS $BODY$
DECLARE
    -- v_quadrants VARCHAR[] = '{N, NNE, NE, ENE, E, ESE, SE, SSE, S, SSW, SW, WSW, W, WNW, NW, NNW, N}';
    v_quadrants VARCHAR[] DEFAULT ARRAY ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW', 'N'];
    v_quadrant_size DECIMAL = 22.5;
    v_quadrant_int INTEGER = 0;
    v_quadrant_str VARCHAR;
BEGIN
    v_quadrant_int = ROUND(p_degrees/v_quadrant_size) + 1;
    v_quadrant_str = v_quadrants[v_quadrant_int];

    RETURN v_quadrant_str;
    -- RETURN v_quadrant_int;
END;
$BODY$
    LANGUAGE PLPGSQL;

