/*
 * Arduino 1.8.5
 * 
 * Project: ESPhaku
 * Version: 1.1
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

bool ffsLoad(String path) {
  path.replace("pkg/", "");
  path.replace("sce_sys/", "");
  path.replace("package/", "");
  path.replace("livearea/", "");
  path.replace("contents/", "");

  path.replace("TheOfficialFloW/VitaShell/master/release/", "go/"); // TODO: httpS

  if (path.endsWith("/"))
    path += "index.html";

  File ffsFile = SPIFFS.open(path, "r");
  if (!ffsFile)
    return false;

  String ffsMime = "application/octet-stream";
  if (path.endsWith(".html"))
    ffsMime = "text/html";
  else if (path.endsWith(".js"))
    ffsMime = "text/javascript";

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
