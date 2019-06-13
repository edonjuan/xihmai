#include "th02.h"


   char txt[20];

   float accel, cool,ok;
   unsigned int buff;
   char tyt[20];

void g_ACE_1(void)
{   

   I2C1_Init(100000);         // Initialize I2C communication
   delay_ms(100);

   ADCON1=0x0F;               // PortB as digital
   INTCON2.RBPU=0;            // Pull-up resistors
   PORTB=0;                   // Clear PORTB
}


float getaccel(void)
{  

   
   float acel;

   I2C1_Start();
   I2C1_Wr(0x68);                // Address Device + Write
   //ack
   //I2C1_Wr(0x72);                // Address Pointer
   I2C1_Wr(0x33);                // Register Data
   //I2C1_repeated_Start();
   I2C1_Wr(0x00);
    //acel =  I2C1_Rd(0);
   //buff |=  I2C1_Rd(0);
   I2C1_Stop();


   return 1.25;

}


void main()
{
   uart1_init(9600);
   g_ACE_1();
   uart1_write_text("It goes");
   uart1_write_text("\r\n");
   uart1_write_text("\r\n");
   // th02init();


  while(1){

   ok = getTemperature();
   floattostr(ok,txt);
   uart1_write_text(txt);
      uart1_write_text("\r\n");
      uart1_write_text("\r\n");
   delay_ms(1000);

   uart1_write_text("while");
   uart1_write_text("\r\n");
   uart1_write_text("\r\n");
   
   buff = getaccel();
   //buff=46.32;
   
   uart1_write_text("convertion");
   uart1_write_text("\r\n");
   
   floattostr(buff,tyt);
   uart1_write_text(tyt);
   uart1_write_text("\r\n");
   delay_ms(1000);


      }
     uart1_write_text("termina");

   
   

}