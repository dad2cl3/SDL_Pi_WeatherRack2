DROP VIEW IF EXISTS weather.vw_temperature;

CREATE OR REPLACE VIEW weather.vw_temperature AS (
    SELECT
        /* DATE_PART('Year', tr.reading_ts::DATE) "year",
        DATE_PART('Month', tr.reading_ts::DATE) "month",
        DATE_PART('Day', tr.reading_ts::DATE) "day",
        DATE_TRUNC('day', tr.reading_ts::DATE) "date", */
        reading_ts,
        tr.reading_device_channel,
        (CASE
            WHEN reading_device_channel = 0 THEN
                ROUND(((reading->>'temperature')::INT - 400)/10.0, 1)
            ELSE
                (reading->>'temperature_F')::DECIMAL
            END) temperature
    FROM weather.t_readings tr
);

GRANT SELECT ON weather.vw_temperature TO grafana;