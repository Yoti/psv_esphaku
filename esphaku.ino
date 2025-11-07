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

  int pathLastIndexOf = -1;
  String pathAfterLastIndexOf = "";

  // Regional fixes
  if (path.indexOf("/psvita/b/") > -1) {
    #ifdef DEBUG
      Serial.print("[asia] ");
    #endif
    path.replace("/psvita/b/", "/");
  }

  // WebServer
  if (!path.endsWith("/") && !path.endsWith(".bin")
  && !path.endsWith(".html") && !path.endsWith(".js")
  && !path.endsWith(".png") && !path.endsWith(".sfo")
  && !path.endsWith("prx") && !path.endsWith(".xml")) {
    #ifdef DEBUG
      Serial.print("[other] ");
    #endif
    if (path.endsWith(".pkg"))
      path = "EmptyPath.pkg";
    else
      path = "/index.html";
  }

  else

  // 3.55-3.60 HENkaku
  if (path.endsWith("/go/"))
    path = "/go/index.html";
  // 3.55-3.60 SD2VITA
  else if (path.endsWith("/tf/"))
    path = "/tf/index.html";
  // 3.63-3.74 HENkaku
  else if (path.endsWith("/henlo/henlo.html")) {
    #ifdef DEBUG
      Serial.print("[/henlo/henlo.html] ");
    #endif
    path = "/henlo/index.html";
  }
  // WebServer
  else if (path.endsWith("/"))
    path = "/index.html";

  else

  // VitaShell
  if (path.endsWith(".png") || path.endsWith(".sfo") || path.endsWith(".xml")) {
    #ifdef DEBUG
      Serial.print("[.png|.sfo|.xml] ");
    #endif
    pathLastIndexOf = path.lastIndexOf("/");
    pathAfterLastIndexOf = path.substring(pathLastIndexOf);
    path = "/release" + pathAfterLastIndexOf;
  }

  else

  // HENkaku and VitaShell
  if (path.endsWith(".bin")) {
    #ifdef DEBUG
      Serial.print("[.bin] ");
    #endif
    // VitaShell
    if (path.endsWith("eboot.bin"))
      path = "/release/eboot.bin";
    else if (path.endsWith("head.bin"))
      path = "/release/head.bin";
  }

  else

  // HENkaku
  if (path.endsWith("prx")) {
    if (path.endsWith(".skprx")) {
      #ifdef DEBUG
        Serial.print("[.skprx] ");
      #endif
      // 3.55-3.60 HENkaku
      if (path.indexOf("/go/") > -1) {
        #ifdef DEBUG
          Serial.print("[/go/] ");
        #endif
        pathLastIndexOf = path.lastIndexOf("/");
        pathAfterLastIndexOf = path.substring(pathLastIndexOf);
        path = "/go" + pathAfterLastIndexOf;
      }
      // 3.55-3.60 SD2VITA
      if (path.indexOf("/tf/") > -1) {
        #ifdef DEBUG
          Serial.print("[/tf/] ");
        #endif
        pathLastIndexOf = path.lastIndexOf("/");
        pathAfterLastIndexOf = path.substring(pathLastIndexOf);
        path = "/tf" + pathAfterLastIndexOf;
      }
    } else if (path.endsWith(".suprx")) {
      #ifdef DEBUG
        Serial.print("[.suprx] ");
      #endif
      // 3.55-3.60 HENkaku
      if (path.indexOf("/go/") > -1) {
        #ifdef DEBUG
          Serial.print("[/go/] ");
        #endif
        pathLastIndexOf = path.lastIndexOf("/");
        pathAfterLastIndexOf = path.substring(pathLastIndexOf);
        path = "/go" + pathAfterLastIndexOf;
      }
      // 3.55-3.60 SD2VITA
      if (path.indexOf("/tf/") > -1) {
        #ifdef DEBUG
          Serial.print("[/tf/] ");
        #endif
        pathLastIndexOf = path.lastIndexOf("/");
        pathAfterLastIndexOf = path.substring(pathLastIndexOf);
        path = "/tf" + pathAfterLastIndexOf;
      }
    }
  }

  #ifdef DEBUG
    Serial.print("[final] ");
    Serial.println(path);
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
