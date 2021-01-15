DROP VIEW IF EXISTS weather.vw_humidity;

CREATE OR REPLACE VIEW weather.vw_humidity AS (
    SELECT
        reading_ts,
        reading_device_channel,
        (reading->>'humidity')::DECIMAL humidity
    FROM
        weather.t_readings
);

GRANT SELECT ON weather.vw_humidity TO grafana;