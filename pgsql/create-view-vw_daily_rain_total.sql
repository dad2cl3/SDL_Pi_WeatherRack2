CREATE OR REPLACE VIEW weather.vw_daily_rain_total AS (
    SELECT
        DATE_PART('Year', tr.reading_ts::DATE) "year",
        DATE_PART('Month', tr.reading_ts::DATE) "month",
        DATE_PART('Day', tr.reading_ts::DATE) "day",
        tr.reading_ts::DATE "date",
        ROUND((MAX((tr.reading->>'cumulativerain')::INT) - MIN((tr.reading->>'cumulativerain')::INT))/10 * 0.0394, 2) daily_total
    FROM weather.t_readings tr
    WHERE tr.reading_device_channel = 0
    GROUP BY 1, 2, 3, 4
);
