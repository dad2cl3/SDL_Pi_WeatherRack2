DROP VIEW IF EXISTS weather.vw_humidity;

CREATE OR REPLACE VIEW weather.vw_humidity AS (
    SELECT
        tr.reading_ts,
        tr.reading_device_channel,
        tcl.channel_id || '-' || tcl.channel_location channel_location,
        (tr.reading->>'humidity')::DECIMAL humidity
    FROM
        weather.t_readings tr, weather.t_channel_locations tcl
    WHERE
        tr.reading_device_channel = tcl.channel_id
);

GRANT SELECT ON weather.vw_humidity TO grafana;