#include "th02.h"
 //  (ok)
float ok, cool ;
char txt[20];

void ACE1_Init(void)
{
   I2C1_Init(100000);         // Initialize I2C communication
   delay_ms(100);

   ADCON1=0x0F;               // PortB as digital
   INTCON2.RBPU=0;            // Pull-up resistors
   PORTB=0;                   // Clear PORTB
}


float getAxis(void)
{
   float Axis;
   unsigned int buff;

   I2C1_Start();
   I2C1_Wr(0x68);                // Address Device + Write
   I2C1_Wr(0x03);                // Address Pointer
   I2C1_Wr(0x72);                // Register Data
   I2C1_Stop();

   delay_ms(80);                 // Conversion time (MAX = 40ms)

   I2C1_Start();
   I2C1_Wr(0x68);                // Address Device + Write
   I2C1_Wr(0x73);                // Address Pointer
   I2C1_Repeated_start();
   I2C1_Wr(0x69);                // Address Device + Read
   buff =  I2C1_Rd(1) << 8;
   buff |=  I2C1_Rd(0);
   I2C1_Stop();

   buff >>= 2;                 // Equation from data sheet
   Axis = buff;
   Axis = (Axis/32)-50;

   return Axis;
}

void main() {
 uart1_init(9600);
 ACE1_Init();
   
   //---------------------------------------------------------------------------


  while(1){

   ok = getTemperature();
   floattostr(ok,txt);
   uart1_write_text(txt);
      uart1_write_text("\r\n");
   delay_ms(1000);


   cool = getAxis();
   floattostr(cool,txt);
   uart1_write_text(txt);
      uart1_write_text("\r\n");

      }

   
   

}