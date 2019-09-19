#include <SoftwareSerial.h>
#include "DHT.h"

SoftwareSerial mySerial (3, 4); //rx/tx
DHT dht(2, DHT11);
int h;

float hum,temp,hum1,temp1;
int relay = 7,led = 6;
int i = 0;
char k,d1[2] = {},point;


void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);
  dht.begin();
  pinMode(relay, OUTPUT);
  pinMode(led,OUTPUT); 
}

void loop() {
        while(mySerial.available()){                // Leer datos del serial
       d1[k]=mySerial.read();                  
          switch(d1[k]){                                //Orden para tomar el dato de humedad
            case 'A':
             {   
                Serial.print("Humidity Value:");
                h = dht.readHumidity();
                //leerHumedad();                  //Función que promedia la lectura
                 Serial.print(h,DEC);
                 Serial.println("%");
                 mySerial.write(h);
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
         }//while
  }//loop
  
 void leerTemperatura(void)
   {
    for(i=0;i<50;i++)
    {
        temp = analogRead(A0);
        temp = (temp * 5 * 100)/1024;
        temp1 = temp + temp1;
    }//for
    temp1 = (temp1/50);
   }//funtion

