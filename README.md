# psv_esphaku
PS Vita 3.55-3.60 and 3.65-3.74 HENkaku for [NodeMcu](https://www.nodemcu.com/index_en.html#fr_54747661d775ef1a3600009e) board

ESPhaku IP address is 11.22.33.44

## Building (Windows)
  * Download and install or unpack [Arduino IDE](https://docs.arduino.cc/software/ide-v1/tutorials/PortableIDE/) (v1.8.19 is recommended)
  * [Configure IDE](https://arduino-esp8266.readthedocs.io/en/latest/installing.html) to use ESP8266 based board (v3.1.2 is the tested one)
  * Clone project repo as "esphaku" and open "esphaku.ino" in the IDE
    * Select the "NodeMCU v1.0 (ESP-12E Module)" as target board
    * Select the "4MB (FS:3MB OTA:~512KB)" as flash size
    * Export firmware as binary file by pressing "Ctrl+Alt+S"
  * Run the "0getffs.bat" file and wait for it to complete
  * Connect the ESP8266 based board to your PC now
  * Run the "1spiffs.bat" file and wait for it to complete

## Tested boards
  * NodeMCU v3 "Lolin" by Wemos
