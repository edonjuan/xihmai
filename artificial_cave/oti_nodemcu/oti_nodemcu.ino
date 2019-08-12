#include <ESP8266WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#define OLED_ADDR 0x3C
#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels
#define OLED_RESET     4 // Reset pin # (or -1 if sharing Arduino reset pin)
Adafruit_SSD1306 display(-3);//Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);
/************************* WiFi Access Point *********************************/

#define WLAN_SSID       "DIPLOMADO-CIC40"
#define WLAN_PASS       ""

/************************* Adafruit.io Setup *********************************/

#define AIO_SERVER      "io.adafruit.com"
#define AIO_SERVERPORT  1883                   // use 8883 for SSL
#define AIO_USERNAME    "Alejandra_Cruz"
#define AIO_KEY         "7b2c704342344e9389ff2a17d9a61c56"

/************ Global State (you don't need to change this!) ******************/

// Create an ESP8266 WiFiClient class to connect to the MQTT server.
WiFiClient client;
// or... use WiFiFlientSecure for SSL
//WiFiClientSecure client;

// Setup the MQTT client class by passing in the WiFi client and MQTT server and login details.
Adafruit_MQTT_Client mqtt(&client, AIO_SERVER, AIO_SERVERPORT, AIO_USERNAME, AIO_KEY);

/****************************** Feeds ***************************************/

// Setup a feed called 'photocell' for publishing.
// Notice MQTT paths for AIO follow the form: <username>/feeds/<feedname>
Adafruit_MQTT_Publish humedad = Adafruit_MQTT_Publish(&mqtt, AIO_USERNAME "/feeds/humedad");
Adafruit_MQTT_Publish temperatura = Adafruit_MQTT_Publish(&mqtt, AIO_USERNAME "/feeds/temperatura");
// Setup a feed called 'onoff' for subscribing to changes.
Adafruit_MQTT_Subscribe controlhum = Adafruit_MQTT_Subscribe(&mqtt, AIO_USERNAME "/feeds/controlhum");

/*************************** Sketch Code ************************************/

// Bug workaround for Arduino 1.6.6, it seems to need a function declaration
// for some reason (only affects ESP8266, likely an arduino-builder bug).
int hum,temp,hum0,temp0,hum2,temp2,tempa;
int x=0,y=0,r=0,s=0,u=0,v=0,w=0,z=0;
void MQTT_connect();
char set;
int t=1,resp; 

void setup() {
  Serial.begin(9600);
  Wire.begin(D1,D2);
  display.begin(SSD1306_SWITCHCAPVCC, OLED_ADDR);
  //delay(10);
  Serial.println(F("Adafruit MQTT demo"));

  // Connect to WiFi access point.
  Serial.println(); Serial.println();
  Serial.print("Connecting to ");
  Serial.println(WLAN_SSID);

  WiFi.begin(WLAN_SSID, WLAN_PASS);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("WiFi connected");
  Serial.println("IP address: "); Serial.println(WiFi.localIP());

  // Setup MQTT subscription for onoff feed.
  mqtt.subscribe(&controlhum);
  
   display.clearDisplay ();
   display.display();
   display.drawPixel (0, 0, WHITE);
    display.drawPixel (127, 0, WHITE);
    display.drawPixel (0, 63, WHITE);
    display.drawPixel (127, 63, WHITE);
    testfilltriangle();
    display.setTextSize (2);
    display.setTextColor (WHITE);
    display.setCursor (0,10);
    display.print("Oti");
    display.display();

    Serial.print('A');
    delay(5000);
    int s;
    s = Serial.read();
    delay(1000);

    Serial.print('B');
    delay(5000);
    int r;
    r = Serial.read();
}


//uint32_t x=0;


void loop() {
  // Ensure the connection to the MQTT server is alive (this will make the first
  // connection and automatically reconnect when disconnected).  See the MQTT_connect
  // function definition further below.
  MQTT_connect();

  // this is our 'wait for incoming subscription packets' busy subloop
  // try to spend your time here

  Adafruit_MQTT_Subscribe *subscription;
  while ((subscription = mqtt.readSubscription(1000))) {
    if (subscription == &controlhum) {
      Serial.print(F("Got: "));
      Serial.println((char *)controlhum.lastread);
      
    }
   
  }
  set = atoi((char *)controlhum.lastread); 
  
  // Now we can publish stuff!
  //Lectura sensor LZ08
  Serial.println('A');
  delay(5000);
  hum = Serial.read();
  Serial.println(hum);
  x = hum;
  delay(1000);
  
  Serial.println('B');
  delay(5000);
  temp = Serial.read();
  Serial.println(temp);
  y = temp;
  delay(1000);
  if(x < set){
    Serial.print('O');
    delay(10000);
  }else {
    Serial.print('I');
    delay(10000);
  }

  dataupdate();
  
  if(x > 0){
  Serial.print(F("\nSending humedad val "));
  Serial.print(x);
  Serial.print("...");

  if (! humedad.publish(x++)) {
    Serial.println(F("Failed"));
  } else {
    Serial.println(F("oK!"));
  }
}

  if(y > 0){
  Serial.print(F("\nSending temperatura val "));
  Serial.print(y);
  Serial.print("...");
  
  if (! temperatura.publish(y++)) {
    Serial.println(F("Failed"));
  } else {
    Serial.println(F("oK!"));
  }

  // ping the server to keep the mqtt connection alive
  // NOT required if you are publishing once every KEEPALIVE seconds
  /*
  if(! mqtt.ping()) {
    mqtt.disconnect();
  }
  */
  }
}

// Function to connect and reconnect as necessary to the MQTT server.
// Should be called in the loop function and it will take care if connecting.
void MQTT_connect() {
  int8_t ret;

  // Stop if already connected.
  if (mqtt.connected()) {
    return;
  }

  Serial.print("Connecting to MQTT... ");

  uint8_t retries = 3;
  while ((ret = mqtt.connect()) != 0) { // connect will return 0 for connected
       Serial.println(mqtt.connectErrorString(ret));
       Serial.println("Retrying MQTT connection in 5 seconds...");
       mqtt.disconnect();
       delay(5000);  // wait 5 seconds
       retries--;
       if (retries == 0) {
         // basically die and wait for WDT to reset me
         while (1);
       }
  }
  Serial.println("MQTT Connected!");
}
void dataupdate(void) {
  display.clearDisplay();
  display.display();

  display.setTextSize(2);             // Normal 1:1 pixel scale
  display.setTextColor(WHITE);        // Draw white text
  display.setCursor(0,0);             // Start at top-left corner
  display.println();
  display.print(F(" Hum:"));
  display.print(hum);
  display.println("%");
  display.setTextColor(WHITE);        // Draw 'inverse' text
  display.print(" Temp:");
  display.print(temp);
  display.print((char)223);
  display.print("C");
  display.display();
  delay(2000);
}
void testfilltriangle(void) {
  display.clearDisplay();

  for(int16_t i=max(display.width(),display.height())/2; i>0; i-=5) {
    // The INVERSE color is used so triangles alternate white/black
    display.fillTriangle(
      display.width()/2  , display.height()/2-i,
      display.width()/2-i, display.height()/2+i,
      display.width()/2+i, display.height()/2+i, INVERSE);
    display.display();
    delay(1);
  }
  

  delay(2000);
}
