CREATE OR REPLACE VIEW weather.vw_temp_trend AS
    SELECT
        REGR_SLOPE(
            (tr.reading->>'temperature')::INT,
            EXTRACT(EPOCH FROM tr.reading_ts)
        ) "slope"
    FROM weather.t_readings tr
    WHERE tr.reading_device_channel = 0
    AND TIMEZONE('America/New_York', tr.reading_ts) >= CURRENT_TIMESTAMP - INTERVAL '1 HOUR'
;