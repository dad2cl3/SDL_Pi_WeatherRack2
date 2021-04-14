CREATE OR REPLACE VIEW weather.vw_daily_wind_rose AS (
WITH wind_data AS (
    SELECT
			weather.fn_wind_speed_bucket(ROUND((tr.reading ->> 'avewindspeed')::DECIMAL / 10 * 3600 / 1609.344, 2)) wind_speed_bucket,
			weather.fn_wind_direction_bucket((tr.reading->>'winddirection')::INTEGER) wind_direction_bucket,
      COUNT(*) speed_direction_count
    FROM weather.t_readings tr
    WHERE tr.reading_device_channel = 0
    AND tr.reading_ts AT TIME ZONE 'US/Eastern' > CURRENT_TIMESTAMP AT TIME ZONE 'US/Eastern' - INTERVAL '24' HOUR
    GROUP BY 1, 2
),
	bucket_totals AS (
		SELECT
			weather.fn_wind_speed_bucket(ROUND((tr.reading ->> 'avewindspeed')::DECIMAL / 10 * 3600 / 1609.344, 2)) wind_speed_bucket,
			COUNT(*) speed_direction_count
		FROM weather.t_readings tr
		WHERE tr.reading_device_channel = 0
		AND tr.reading_ts AT TIME ZONE 'US/Eastern' > CURRENT_TIMESTAMP AT TIME ZONE 'US/Eastern' - INTERVAL '24' HOUR
		GROUP BY 1
		ORDER BY 1
)
SELECT
	wd.wind_speed_bucket[2] strength,
	wd.wind_direction_bucket[2] direction,
  ROUND((wd.speed_direction_count)::DECIMAL/(bt.speed_direction_count)::DECIMAL, 2) * 100 frequency
FROM wind_data wd, bucket_totals bt
WHERE wd.wind_speed_bucket = bt.wind_speed_bucket
ORDER BY wd.wind_speed_bucket[1], wd.wind_direction_bucket[1]
);