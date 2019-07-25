#include <MPU6050_tockn.h>

#include <Adafruit_SSD1306.h>
#include <splash.h>
#define OLED_RESET 4
Adafruit_SSD1306 display(OLED_RESET);
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>
#include <SoftwareSerial.h>
#include <TH02_dev.h>
#include <Wire.h> 


SoftwareSerial mySerial (3, 4); //rx/tx
//*****************************************CONFIGURACIÓN DEL ACELEROMETRO*********************************************

//********************************************************************************************************************

float hum,temp,hum1,temp1;
int relay = 7,led = 6;
int i = 0;
char k,d2,d1[2] = {},point;


void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);
  Wire.begin();
  pinMode(relay, OUTPUT);
  pinMode(led,OUTPUT);
}

void loop() {
        while(mySerial.available()){                // Leer datos del serial
       d1[k]=mySerial.read();                  
       int t;
       if(t<=3){
           t++;   
       
          switch(d1[k]){                                //Orden para tomar el dato de humedad
            case 'A':
             {   
                Serial.print("Humidity Value:");
                leerHumedad();                  //Función que promedia la lectura
                 Serial.print(hum1);
                 Serial.println("%");
                 mySerial.write(hum1);
                 break;
             }

           case 'B':
            {
                Serial.print("Temperature Value:");
                 leerTemperatura();                  
                 Serial.println(temp1);
                 mySerial.write(temp1);
                 break;
            }
            case 'O':
            {
             digitalWrite(relay,HIGH);
             digitalWrite(led,HIGH);
             break;
            }
            case 'I':
            {
              digitalWrite(relay,LOW);
              digitalWrite(led,LOW);
              break; 
            }
           }//switch
           }//if  
         }//while
  }//loop
  

  void leerHumedad(void)
  {
    for(i=0;i<15;i++)
    {
        hum = analogRead(A1);
        hum1 = hum1 + hum;
        
   }
    hum1 = (hum/15); 
   }  

   void leerTemperatura(void)
   {
    for(i=0;i<50;i++)
    {
        temp = analogRead(A0);
        temp = (temp * 5 * 100)/1024;
        temp1 = temp + temp1;
   }
    temp1 = (temp1/50);
   }

