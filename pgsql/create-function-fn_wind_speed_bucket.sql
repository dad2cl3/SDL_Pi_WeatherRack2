CREATE OR REPLACE FUNCTION weather.fn_wind_speed_bucket(p_wind_speed DECIMAL)
-- RETURNS INTEGER
RETURNS VARCHAR[]
AS $BODY$
DECLARE
    -- v_bucket INTEGER := 0;
    v_bucket VARCHAR[] := ARRAY ['0', '0-1'];
BEGIN
    IF p_wind_speed <= 1.0 THEN
        -- v_bucket = 0;
        -- v_bucket = '0-1';
        v_bucket = ARRAY ['0', '0-1'];
    ELSIF p_wind_speed <= 3.0 THEN
        -- v_bucket = 1;
        -- v_bucket = '1-3';
        v_bucket = ARRAY ['1', '1-3'];
    ELSIF p_wind_speed <= 5.0 THEN
        -- v_bucket = 2;
        -- v_bucket = '3-5';
        v_bucket = ARRAY ['2', '3-5'];
    ELSIF p_wind_speed <= 8.0 THEN
        -- v_bucket = 3;
        -- v_bucket = '5-8';
        v_bucket = ARRAY ['4', '5-8'];
    ELSIF p_wind_speed <= 12.0 THEN
        -- v_bucket = 4;
        -- v_bucket = '8-12';
        v_bucket = ARRAY ['5', '8-12'];
    ELSIF p_wind_speed > 12.0 THEN
        -- v_bucket = 5;
        -- v_bucket = '12+';
        v_bucket = ARRAY ['6', '12+'];
    END IF;

    RETURN v_bucket;
END;
$BODY$
    LANGUAGE PLPGSQL;