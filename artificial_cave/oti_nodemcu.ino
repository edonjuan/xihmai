/***************************************************
  Adafruit MQTT Library ESP8266 Example

  Must use ESP8266 Arduino from:
    https://github.com/esp8266/Arduino

  Works great with Adafruit's Huzzah ESP board & Feather
  ----> https://www.adafruit.com/product/2471
  ----> https://www.adafruit.com/products/2821

  Adafruit invests time and resources providing this open source code,
  please support Adafruit and open-source hardware by purchasing
  products from Adafruit!

  Written by Tony DiCola for Adafruit Industries.
  MIT license, all text above must be included in any redistribution
 ****************************************************/
#include <ESP8266WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"

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
int hum,temp,ac;
int x=0,y=0,z=0;
void MQTT_connect();
char set;

void setup() {
  Serial.begin(9600);
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
  Serial.println();

  Serial.println("WiFi connected");
  Serial.println("IP address: "); Serial.println(WiFi.localIP());

  // Setup MQTT subscription for onoff feed.
  mqtt.subscribe(&controlhum);
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
  switch (set){
    case 0:
    {
      Serial.println('P'); 
      break;
      
    }
    case 10:
    {
      Serial.println('Q');
      break;
    }
    case 20:
    {
      Serial.println('R');
      break;
      
    }
    case 30:
    {
      Serial.println('S');
      break;
      
    }
    case 40:
    {
      Serial.println('T');
      break;
      
    }
    case 50:
    {
      Serial.println('U');
      break;
      
    }
    case 60:
    {
      Serial.println('V');
      break;
      
    }
    case 70:
    {
      Serial.println('W');
      break;
      
    }
    case 80:
    {
      Serial.println('X');
      break;
      
    }
    case 90:
    {
      Serial.println('Y');
      break;
      
    }
    case 100:
    {
      Serial.println('Z');
      break; 
    }
  }
 // delay(10000);
     
         
/*
  if(&led == ON){
    Serial.println(1);
  }
  else if(&led==OFF)
  {
    Serial.println(0);
  }*/
  // Now we can publish stuff!
delay(2000);
  Serial.println('A');
  delay(12000);
  hum = Serial.read();
  Serial.println(hum);
  x = hum;
  delay(2000);
  
  Serial.println('B');
  delay(12000);
  temp = Serial.read();
  Serial.println(temp);
  y = temp;
  delay(2000);
if(x > 0){
  Serial.print(F("\nSending humedad val "));
  Serial.print(x);
  Serial.print("...");

  if (! humedad.publish(x++)) {
    Serial.println(F("Failed"));
  } else {
    Serial.println(F("OK!"));
  }
}

  if(y > 0){
  Serial.print(F("\nSending temperatura val "));
  Serial.print(y);
  Serial.print("...");
  
  if (! temperatura.publish(y++)) {
    Serial.println(F("Failed"));
  } else {
    Serial.println(F("OK!"));
  }

  }

  // ping the server to keep the mqtt connection alive
  // NOT required if you are publishing once every KEEPALIVE seconds
  /*
  if(! mqtt.ping()) {
    mqtt.disconnect();
  }
  */
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
