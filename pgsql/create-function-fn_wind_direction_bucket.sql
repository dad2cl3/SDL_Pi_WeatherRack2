CREATE OR REPLACE FUNCTION weather.fn_wind_direction_bucket(p_degrees INTEGER)
-- RETURNS INTEGER
RETURNS VARCHAR[]
AS $BODY$
DECLARE
    -- v_bucket INTEGER := 0;
    v_bucket VARCHAR[] := ARRAY ['0', 'N'];
BEGIN
    IF p_degrees >= 348.75 OR p_degrees < 11.25 THEN
        -- v_bucket = 0;
        v_bucket := ARRAY ['0', 'N'];
    ELSIF p_degrees >= 11.25 AND p_degrees < 33.75 THEN
        v_bucket := ARRAY ['1', 'NNE'];
    ELSIF p_degrees >= 33.75 AND p_degrees < 56.25 THEN
        -- v_bucket = 1;
        v_bucket := ARRAY ['2', 'NE'];
    ELSIF p_degrees >= 56.25 AND p_degrees < 78.75 THEN
        -- v_bucket = 2;
        v_bucket := ARRAY ['3', 'ENE'];
    ELSIF p_degrees >= 78.75 AND p_degrees < 101.25 THEN
        v_bucket := ARRAY ['4', 'E'];
    ELSIF p_degrees >= 101.25 AND p_degrees < 123.75 THEN
        v_bucket := ARRAY ['5', 'ESE'];
    ELSIF p_degrees >= 123.75 AND p_degrees < 146.25 THEN
        -- v_bucket = 3;
        v_bucket := ARRAY ['6', 'SE'];
    ELSIF p_degrees >= 146.25 AND p_degrees < 168.75 THEN
        v_bucket := ARRAY ['7', 'SSE'];
    ELSIF p_degrees >= 168.75 AND p_degrees < 191.25 THEN
        -- v_bucket = 4;
        v_bucket := ARRAY ['8', 'S'];
    ELSIF p_degrees >= 191.25 AND p_degrees < 213.75 THEN
        v_bucket := ARRAY ['9', 'SSW'];
    ELSIF p_degrees >= 213.75 AND p_degrees < 236.25 THEN
        -- v_bucket = 5;
        v_bucket := ARRAY ['10', 'SW'];
    ELSIF p_degrees >= 236.25 AND p_degrees < 258.75 THEN
        v_bucket := ARRAY ['11', 'WSW'];
    ELSIF p_degrees >= 258.75 AND p_degrees < 281.25 THEN
        -- v_bucket = 6;
        v_bucket := ARRAY ['12', 'W'];
    ELSIF p_degrees >= 281.25 AND p_degrees < 303.75 THEN
        v_bucket := ARRAY ['13', 'WNW'];
    ELSIF p_degrees >= 303.75 AND p_degrees < 326.25 THEN
        -- v_bucket = 7;
        v_bucket := ARRAY ['14', 'NW'];
    ELSIF p_degrees >= 326.25 AND p_degrees < 348.75 THEN
        v_bucket := ARRAY ['15', 'NNW'];
    END IF;

    RETURN v_bucket;
END;
$BODY$
    LANGUAGE PLPGSQL;