CREATE OR REPLACE VIEW weather.vw_daily_temp_range AS (
    SELECT
        DATE_PART('Year', tr.reading_ts::DATE) "year",
        DATE_PART('Month', tr.reading_ts::DATE) "month",
        DATE_PART('Day', tr.reading_ts::DATE) "day",
        MIN(ROUND(((reading->>'temperature')::INT - 400)/10.0, 2)) daily_min,
        MAX(ROUND(((reading->>'temperature')::INT - 400)/10.0, 2)) daily_max,
        (MAX(ROUND(((reading->>'temperature')::INT - 400)/10.0, 2)) -
            MIN(ROUND(((reading->>'temperature')::INT - 400)/10.0, 2))) daily_range
    FROM weather.t_readings tr
    WHERE tr.reading_device_channel = 0
    GROUP BY 1, 2, 3
    ORDER BY 1, 2, 3
);