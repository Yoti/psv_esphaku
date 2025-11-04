/*
 * Arduino 1.8.19
 * 
 * Project: ESPhaku
 * Version: 2.1
 * Authors: Yoti
 * Licence: GPLv3
 */

#include <FS.h>
#include <DNSServer.h>
#include <ESP8266WebServer.h>

DNSServer dnsServer;
const byte dnsPort = 53;
IPAddress apIp(11,22,33,44);  // (0x59,0x6F,0x74,0x69)
IPAddress apSubnet(255,255,255,0);
ESP8266WebServer apServer(80);

#define DEBUG

bool ffsLoad(String path) {
  #ifdef DEBUG
    Serial.print("Read ");
    Serial.print(path);
    Serial.print(" -> ");
  #endif

  /// SPIFFS workaround
  // ...
  path.replace("//", "/");
  // ...
  if (path.equals("/"))
    path = "/index.html";
  if (path.equals("/go/"))
    path += "index.html";
  if (path.equals("/tf/"))
    path += "index.html";
  if (path.equals("/henlo/"))
    path += "index.html";
  // VitaShell for 3.55-3.60 HEN
  if (path.indexOf("go/pkg/sce_sys/livearea/contents") > 0)
    path.replace("go/pkg/sce_sys/livearea/contents", "release");
  if (path.indexOf("go/pkg/sce_sys/package") > 0)
    path.replace("go/pkg/sce_sys/package", "release");
  if (path.indexOf("go/pkg/sce_sys") > 0)
    path.replace("go/pkg/sce_sys", "release");
  if (path.indexOf("go/pkg") > 0) {
    // 3.55-3.60 HEN
    if (path.endsWith(".skprx"))
      path.replace("go/pkg", "go");
    // 3.55-3.60 HEN
    else if (path.endsWith(".suprx"))
      path.replace("go/pkg", "go");
    // VitaShell for 3.55-3.60 HEN
    else
      path.replace("go/pkg", "release");
  }

  // Browser LiveArea Help button
  if (path.startsWith("/document/")) {
    #ifdef DEBUG
      Serial.print("[startsWith=/document/] ");
    #endif
    // ...
    if (path.endsWith("error.html"))
      path = "/error.html";
    // 3.55-3.60 HEN main page
    if (path.indexOf("/go/go.html") > 0)
      path = "/go/index.html";
    if (path.endsWith("go.html"))
      path = "/go.html";
    if (path.endsWith("/go/"))
      path = "/go/index.html";
    // 3.63-3.74 HEN main page
    if (path.endsWith("/browser/henlo/"))
      path = "/henlo/index.html";
    if (path.endsWith("henlo.html"))
      path = "/henlo.html";
    // ...
    if ((!path.endsWith("/go/index.html")) && (!path.endsWith("/tf/index.html")) && (!path.endsWith("/henlo/index.html")) && (path.endsWith("index.html")))
      path = "/index.html";
    // 3.55-3.60 HEN additional files
    if (path.indexOf("/browser/go/") > 0) {
      if (path.endsWith("/go/henkaku.bin"))
        path = "/go/henkaku.bin";
      if (path.endsWith("/go/henkaku.skprx"))
        path = "/go/henkaku.skprx";
      if (path.endsWith("/go/henkaku.suprx"))
        path = "/go/henkaku.suprx";
      if (path.endsWith("/go/payload.js"))
        path = "/go/payload.js";
      if (path.endsWith("/go/taihen.skprx"))
        path = "/go/taihen.skprx";
    }
    // 3.63-3.74 HEN additional files
    if (path.indexOf("/browser/henlo/") > 0) {
      if (path.endsWith("/henlo/exploit.js"))
        path = "/henlo/exploit.js";
      if (path.endsWith("/henlo/jsos.js"))
        path = "/henlo/jsos.js";
      if (path.endsWith("/henlo/kernel.js"))
        path = "/henlo/kernel.js";
      if (path.endsWith("/henlo/offsets.js"))
        path = "/henlo/offsets.js";
      if (path.endsWith("/henlo/payload.bin"))
        path = "/henlo/payload.bin";
    }
  }

  #ifdef DEBUG
      Serial.println("[final] " + path);
  #endif

  File ffsFile = SPIFFS.open(path, "r");
  if (!ffsFile) {
    #ifdef DEBUG
      Serial.println("");
    #endif
    return false;
  }

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
      Serial.println("");
  #endif

  apServer.streamFile(ffsFile, ffsMime);
  ffsFile.close();
  return true;
}

void handleNotFound() {
  if (ffsLoad(apServer.uri()))
    return;
  else
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
