

#include "th02.h"


   char txt[20];

   float accel, cool,ok;
   unsigned int buff;
   char tyt[20];

void g_ACE_1(void)
{   
   I2C_Set_Active(&I2C1_Start, &I2C1_Repeated_Start, &I2C1_Wr, &I2C1_Wr, &I2C1_Stop, &I2C1_Is_Idle); // Sets the I2C1 module active


   I2C1_Init(100000);         // Initialize I2C communication
   delay_ms(100);

   ADCON1=0x0F;               // PortB as digital
   INTCON2.RBPU=0;            // Pull-up resistors
   PORTB=0;                   // Clear PORTB
   

   
}


float getaccel(void)
{  
   unsigned short take;       /*NOt acknowledge*/



   float acel;

   I2C1_Start();                  // configuring device
   I2C1_Wr(0x68);                // Address Device + Write
   I2C1_Wr(0x6B);
   I2C1_Wr(0b00000000);
   I2C1_Wr(0x1C);
   I2C1_Wr(0b00011000);
   I2C1_Wr(0x75);
   I2C1_Wr(0x68);
   I2C1_Stop();
    //yes
    

   
   I2C1_Start();
   I2C1_Wr(0x68);                // Address Device + Write
   I2C1_Wr(0x32);                // Register Data
     //yes
   I2C1_Stop();
   Delay_100ms();


   I2C1_repeated_Start();
   I2C1_Wr(0x69); 
        //yes
        
   //I2C1_Rd(1);
   //I2C1_Wr(0x33);
   
   take =  I2C1_Rd(0);
   uart1_write_text("It still goes");
      uart1_write_text("\r\n");
      
   acel=take;

   I2C1_Stop();
   return acel;

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
   uart1_write_text("temperture:");
   uart1_write_text("\r\n");
   ok = getTemperature();                /*temperture*/
   floattostr(ok,txt);
   uart1_write_text(txt);
      uart1_write_text("\r\n");
      uart1_write_text("\r\n");
   delay_ms(1000);

   uart1_write_text("while");          /*while*/
   uart1_write_text("\r\n");
   uart1_write_text("\r\n");
   
   buff = getaccel();
   //buff=46.32;
   
   uart1_write_text("convertion");       /*convertion*/
   uart1_write_text("\r\n");


   
   floattostr(buff,tyt);                /*buff*/
   uart1_write_text(tyt);
   uart1_write_text("\r\n");
   delay_ms(1000);

     
      uart1_write_text("");        /*fin*/
      uart1_write_text("\r\n");
      
      }


   
   

}