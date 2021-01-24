DROP TABLE IF EXISTS weather.t_channel_locations;

CREATE TABLE IF NOT EXISTS weather.t_channel_locations (
    channel_id INT NOT NULL,
    channel_location VARCHAR(25) NOT NULL,
    CONSTRAINT pk_t_channel_locations_channel_id PRIMARY KEY (channel_id)
);

INSERT INTO weather.t_channel_locations (
    channel_id, channel_location
) VALUES
    (0, 'Outdoor'),
    (1, 'Garage'),
    (2, 'Playroom Crawl'),
    (3, 'Playroom'),
    (4, 'Middle Bedroom'),
    (5, 'Front Bedroom'),
    (6, 'Office'),
    (7, 'Back Bedroom'),
    (8, 'Thermostat')
;