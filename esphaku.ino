#include <FS.h>
#include <DNSServer.h>
#include <ESP8266WebServer.h>

DNSServer dnsServer;
byte henVersion = 0;
const byte dnsPort = 53;
IPAddress apIp(11,22,33,44);
IPAddress apGate(11,22,33,44);
IPAddress apSubnet(255,255,255,0);
ESP8266WebServer apServer(80);

bool ffsLoad(String path) {
//Serial.print("in ");
//Serial.println(path);

  if (path.equals("/")) {
    if (henVersion != 0) {
      dnsServer.stop();
      henVersion = 0;
//Serial.println("DNS off");
    }
  }
  else if (path.startsWith("/360")) {
    if (henVersion == 0) {
      dnsServer.start(dnsPort, "www.henkaku.xyz", apIp);
      henVersion = 60;
//Serial.println("DNS 360");
    }
  }
  /*else if (path.startsWith("/365")) {
  }
  else if (path.startsWith("/367")) {
  }
  else if (path.startsWith("/368")) {
  }*/

  if (henVersion == 60) {
    path.replace("go/", "360/");
    path.replace("pkg/", "");
    path.replace("sce_sys/", "");
    path.replace("package/", "");
    path.replace("livearea/", "");
    path.replace("contents/", "");
  }

  if (path.endsWith("/"))
    path += "index.html";

//Serial.print("out ");
//Serial.println(path);

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
  // check file from ffs
  if (ffsLoad(apServer.uri()))
    return;

  // return not found 404
  apServer.send(404, "text/plain", "404 Not Found");
}

void setup() {
  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(apIp, apGate, apSubnet);
  WiFi.softAP("ESPhaku");

  dnsServer.setTTL(300);

  SPIFFS.begin();
  apServer.onNotFound(handleNotFound);
  apServer.begin();

//Serial.begin(115200);
//Serial.setDebugOutput(true);
}

void loop() {
  if (henVersion != 0)
    dnsServer.processNextRequest();

  apServer.handleClient();
}
