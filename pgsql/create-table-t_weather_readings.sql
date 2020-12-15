CREATE TABLE IF NOT EXISTS weather.t_weather_readings (
    reading_id INT8 NOT NULL DEFAULT NEXTVAL('weather.seq_weather_reading_id'),
    reading_ts TIMESTAMP NOT NULL,
    reading_device VARCHAR(100) NOT NULL,
    reading_device_channel INT2,
    reading JSONB NOT NULL,
    CONSTRAINT pk_t_weather_readings_reading_id PRIMARY KEY (reading_id)
);

ALTER TABLE IF EXISTS weather.t_weather_readings OWNER TO "Jason";

ALTER SEQUENCE IF EXISTS weather.seq_weather_reading_id OWNED BY weather.t_weather_readings.reading_id;

CREATE UNIQUE INDEX unq_reading ON weather.t_weather_readings (reading_ts, reading_device, reading_device_channel);
