SwitchDoc Labs WeatherSense WeatherRack2 Raspberry Pi Interface Code<BR>

Version 1.2 Initial Release October 17, 2020  <BR>

Before using this software, you must download and install the version of rtl_433 in this repository. 

git clone https://github.com/switchdoclabs/rtl_433

Follow the Raspberry Pi instructions for installation in rtl_433 README.md.

You will also need an inexpensive compatible RTL SDR (Software Definted Radio) such as this:

https://amzn.to/3fhH3V8

Search on SDR and RTL2832U to find a compatible USB SDR

to Run:

sudo python3 readWeatherSensors.py


# Description
The repository is forked from [SwitchDoc Labs WeatherRack2 Raspberry Pi repository](https://github.com/switchdoclabs/SDL_Pi_WeatherRack2). The weather rack can be purchased from SwitchDoc Labs [here](https://shop.switchdoc.com/products/wireless-weatherrack2). The software provided by SwitchDoc Labs supports reading sensor data from the weather rack. The code in this repository supports the post-processing of the sensor data read from the weather rack.

## Dependencies
The post-processing of the sensor data requires the following dependencies:
1. Running [Node-RED](https://www.nodered.org) server with the following node collections added to the pallette:
    1. [node-red-contrib-blynk-ws](https://github.com/gablau/node-red-contrib-blynk-ws)
    2. [node-red-contrib-re-postgres](https://www.npmjs.com/package/node-red-contrib-re-postgres)
2. Running [PostgreSQL](https://www.postgresql.org) server
3. Running [Mosquitto](https://mosquitto.org) broker
4. [Blynk](https://blynk.io/en/developers) developer account
5. Blynk [iOS](https://apps.apple.com/us/app/blynk-iot-for-arduino-esp32/id808760481) or [Android](https://play.google.com/store/apps/details?id=cc.blynk) mobile phone application

## Node-RED
### Node-RED Design
The Node-RED flow supports two input devices:
1. SwitchDoc Labs WeatherSense WeatherRack2 FT020T which provides the outdoor weather readings
2. SwitchDoc Labs WeatherSense Indoor T/H F016TH which provides indoor temperature and humidity readings

The readings from the two devices are published to a common topic within the Mosquitto broker. The JSON data generated by the two types of devices is different so the Node-RED flow immediates splits them out into different branches based on the JSON key *model* which has the values of *SwitchDoc Labs FT020T AIO* or *SwitchDoc Labs F016TH Thermo-Hygrometer*.

The JSON data generated by the weather rack requires calculations in order to transform the values. An example of the raw JSON data, along with an explanation of the data, can be found on the weather rack product page linked above. The Node-RED flow leverages Imperial units so the temperature is *°F*, wind speeds are *MPH*, and rain measurements is *inches*.

Compass directions are calculated utilizing the standard 22.5° divisor to split up the compass into 17 quadrants with 16 possible values. First, the compass directions are stored in an array. Next, the Javascript [Math.round()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round) function is applied to the ratio of wind direction and 22.5. Finally, the value returned, which represents the nearest whole number of the calculated ratio, is used as the index in the array of quadrants to select the compass direction. The following code snippet illustrates the mathematics described above:

```
quadrants = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW", "N"];

quadrant_size = 22.5;
quadrant = Math.round(msg.payload/quadrant_size);
abbr = quadrants[quadrant];
```

### Blynk considerations
The most important note regarding the flow is the utilization of the Blynk WebSockets write node. The node is configured to be *Dynamic*. As a result, the pin is set in `msg.pin` in the preceding function node for every value that is being passed to Blynk. The function node does not automatically pass through the message payload. As a result, a message payload must be set within the function even if the function is simply passing along the received message payload. The following code snippet shows a function node that is setting the Blynk pin and passing along the received payload.

```
msg.payload = msg.payload;
msg.pin = 39;
return msg;
```

### Node-RED flow
![Mallory Node-RED flow](https://github.com/dad2cl3/SDL_Pi_WeatherRack2/blob/master/doc/WeatherRacksMalloryNodeRED.png)
### Blynk Pin Configuration
Channel/Sensor | Temperature | Humidity | Battery | Time
-------------- | ----------- | -------- | ------- | ----
0 (Outdoor) | 0 | 9 | 18 | 27
1 | 1 | 10 | 19 | 28
2 | 2 | 11 | 20 | 29
3 | 3 | 12 | 21 | 30
4 | 4 | 13 | 22 | 31
5 | 5 | 14 | 23 | 32
6 | 6 | 15 | 24 | 33
7 | 7 | 16 | 25 | 34
8 | 8 | 17 | 26 | 35


Sensor | Pin
------ | ---
Average Wind Speed | 36
Gust Wind Speed | 37
Wind Direction | 38
Light Intensity | 39
UV Intensity | 40
Cumulative Rain | 41

### Blynk application
![Blynk application](https://github.com/dad2cl3/SDL_Pi_WeatherRack2/blob/master/doc/WeatherSenseMalloryBlynk.png)