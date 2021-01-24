DROP VIEW IF EXISTS weather.vw_temperature;

CREATE OR REPLACE VIEW weather.vw_temperature AS (
    SELECT
        /* DATE_PART('Year', tr.reading_ts::DATE) "year",
        DATE_PART('Month', tr.reading_ts::DATE) "month",
        DATE_PART('Day', tr.reading_ts::DATE) "day",
        DATE_TRUNC('day', tr.reading_ts::DATE) "date", */
        tr.reading_ts,
        tr.reading_device_channel,
        tcl.channel_id || '-' || tcl.channel_location channel_location,
        (CASE
            WHEN tr.reading_device_channel = 0 THEN
                ROUND(((tr.reading->>'temperature')::INT - 400)/10.0, 1)
            ELSE
                (tr.reading->>'temperature_F')::DECIMAL
            END) temperature
    FROM weather.t_readings tr, weather.t_channel_locations tcl
    WHERE tr.reading_device_channel = tcl.channel_id
);

GRANT SELECT ON weather.vw_temperature TO grafana;