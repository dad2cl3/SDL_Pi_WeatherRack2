CREATE OR REPLACE VIEW weather.vw_rain_last_hour AS (
	SELECT JSONB_BUILD_OBJECT('name', 'RainInLast60Minutes', 'value',
		(MAX((tr.reading->>'cumulativerain')::INT) - MIN((tr.reading->>'cumulativerain')::INT))/10,
		'units', 'mm/h'
	) rain_last_hour
	FROM weather.t_readings tr
	WHERE tr.reading_device_channel = 0
	AND tr.reading_ts > CURRENT_TIMESTAMP - INTERVAL '1 hour'
);