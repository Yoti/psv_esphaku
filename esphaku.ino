/*
 * Arduino 1.8.19
 * 
 * Project: ESPhaku
 * Version: 2.0
 * Authors: Yoti
 * Licence: GPLv3
 */

#include <FS.h>
#include <DNSServer.h>
#include <ESP8266WebServer.h>

DNSServer dnsServer;
const byte dnsPort = 53;
IPAddress apIp(11,22,33,44);
IPAddress apSubnet(255,255,255,0);
ESP8266WebServer apServer(80);

//#define DEBUG

bool ffsLoad(String path) {
  #ifdef DEBUG
      Serial.print("Read ");
      Serial.print(path);
      Serial.print(" -> ");
  #endif

  // Workaround for HENkaku
  path.replace("go/pkg/hen", "go/hen");
  path.replace("go/pkg/tai", "go/tai");
  // Workaround for VitaShell
  path.replace("go/pkg/", "release/");
  path.replace("sce_sys/", "");
  path.replace("package/", "");
  path.replace("livearea/", "");
  path.replace("contents/", "");

  if (path.endsWith("/"))
    path += "index.html";

  #ifdef DEBUG
      Serial.println(path);
  #endif

  File ffsFile = SPIFFS.open(path, "r");
  if (!ffsFile)
    return false;

  String ffsMime = "application/octet-stream";
  if (path.endsWith(".html"))
    ffsMime = "text/html";
  else if (path.endsWith(".js"))
    ffsMime = "text/javascript";

  #ifdef DEBUG
      Serial.print("Send ");
      Serial.print(path);
      Serial.print(" as ");
      Serial.println(ffsMime);
  #endif

  apServer.streamFile(ffsFile, ffsMime);
  ffsFile.close();
  return true;
}

void handleNotFound() {
  if (ffsLoad(apServer.uri()))
    return;

  apServer.send(404, "text/plain", "404 Not Found");
}

void setup() {
  #ifdef DEBUG
    Serial.begin(115200);
  #endif

  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(apIp, apIp, apSubnet);
  WiFi.softAP("ESPhaku");

  dnsServer.setTTL(300);
  dnsServer.start(dnsPort, "*", apIp);

  SPIFFS.begin();
  apServer.onNotFound(handleNotFound);
  apServer.begin();
}

void loop() {
  dnsServer.processNextRequest();
  apServer.handleClient();
}
