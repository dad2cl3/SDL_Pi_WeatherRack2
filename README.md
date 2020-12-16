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
3. [Blynk](https://blynk.io/en/developers) developer account
4. Blynk [iOS](https://apps.apple.com/us/app/blynk-iot-for-arduino-esp32/id808760481) or [Android](https://play.google.com/store/apps/details?id=cc.blynk) mobile phone application

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

### Node-RED flow
![Mallory Node-RED flow](https://github.com/dad2cl3/SDL_Pi_WeatherRack2/blob/master/doc/WeatherSenseMalloryNodeRED.png)

### Blynk application
![Blynk application](https://github.com/dad2cl3/SDL_Pi_WeatherRack2/blob/master/doc/WeatherSenseMalloryBlynk.png)