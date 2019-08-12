#include <Adafruit_SSD1306.h>
#include <splash.h>
#define OLED_RESET 4
Adafruit_SSD1306 display(OLED_RESET);
//#include <Adafruit_Sensor.h>
//#include <DHT.h>
//#include <DHT_U.h>
#include <SoftwareSerial.h>
//#include <TH02_dev.h>
#include <Wire.h> 

//#include <rgb_lcd.h>

//#include <DHT.h>      //Sensor de temperatura y humedad DHT11
//#define DHTPIN 8
//#define DHTTYPE DHT11
//DHT dht(DHTPIN, DHTTYPE);
/*
rgb_lcd lcd;
const int colorR = 250;
const int colorG = 72;
const int colorB = 178; 
*/
SoftwareSerial mySerial (3, 4); //rx/tx

int set;
String set1;
float hum,temp;
int relay = 7,led = 6;
float hum1,temp1;
int i = 0;
char k,d2,d1[2] = {},point;


void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);
  //TH02.begin();
  Wire.begin();
  //dht.begin();
   pinMode(relay, OUTPUT);
   pinMode(led,OUTPUT);
   display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
}

void loop() {
        serialEvent();
        /*
        display.clearDisplay();
        display.setTextColor(WHITE);
        display.setCursor(0,0);
        
        testfilltriangle();
*/
        Serial.print("set :");
        Serial.println(set);
        display.println("set point: ");
        display.print(set);   
       
         if(hum1 < set){        
         digitalWrite(relay,HIGH);
         digitalWrite(led,HIGH);
          }//end if <90
          else {                
         digitalWrite(relay,LOW);
         digitalWrite(led,LOW);             
           }//end if >30
           delay(12000);
           
         
         
  }//loop
  

  void leerHumedad(void)
  {
    for(i=0;i<10;i++)
    {
        hum = analogRead(A1);
        hum = hum + hum;
   }
    hum1 = (hum/10)+17; 
   }  
 void leerTemperatura(void)
  {    
    for(i=0;i<10;i++)
    {
        temp =( analogRead(A1)/3);
        temp = temp + temp;
    }
    temp1 = (temp/10);
   } 
  void serialEvent(){   
      while(mySerial.available()){                // Leer datos del serial
       d1[k]=mySerial.read();      
          switch(d1[k]){                                //Orden para tomar el dato de humedad
            
            case 'A':
             {   
                Serial.print("Humidity Value:");
                //hum = TH02.ReadHumidity();        // Lectura del sensor TH02
                //hum = dht.readHumidity();             //Lectura del sensor DHT11
                //hum=analogRead(A1);                   //Lectura del sensor LZ08 HMZ
                leerHumedad();                  //Función que promedia la lectura
                 Serial.print(hum1);
                 Serial.println("%\r\n");
                 mySerial.write(hum1);
                 display.print("Humedad: ");
                 display.print(hum1); 
                 break;
             }

           case 'B':
            {
                Serial.print("Temperature Value:");
                 //temp = TH02.ReadTemperature();         //Lectura del sensor TH02
                 // temp = dht.readTemperature();              //Lectura del sensor DHT11
                 //temp = analogRead(A2);                      //Lectura del sensor LZ08 HMZ
                 leerTemperatura();                    //Función que promedia la lectura
                 Serial.print(temp1);
                 Serial.println("°C\r\n");
                 mySerial.write(temp1);
                 display.println("Temperatura: "); 
                 display.print(temp1);
                 break;
            }
            case 'P':
            {
              set = 0;
              break;
            }
            case 'Q':
            {
              set = 10;
              break;
            }
            case 'R':
            {
              set = 20;
              break;
            }
            case 'S':
            {
              set = 30;
              break;
            }
            case 'T':
            {
              set = 40;
              break;
            }
            case 'U':
            {
              set = 50;
              break;
            }
            case 'V':
            {
              set = 60;
              break;
            }
            case 'W':
            {
              set = 70;
              break;
            }
            case 'X':
            {
              set = 80;
              break;
            }
            case 'Y':
            {
              set = 90;
              break;
            }
            case 'Z':
            {
              set = 100;
              break;
            }
            }//switch  
           }//while
  }//funtion
  
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

  //delay(2000);
}

