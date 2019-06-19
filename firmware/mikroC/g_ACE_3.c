#include "th02.h"


#define ADW 0xD0
#define ADR 0xD1

   char txt[20];

   float accel, cool,ok;
   unsigned int buff;
   char tyt[20];




void main()
{
   uart1_init(9600);
   uart1_write_text("It goes");
   uart1_write_text("\r\n");
   uart1_write_text("\r\n");
   
   I2C1_Init(100000);         // initialize I2C communication
   TH02Init();
   
 while(1)
  {


       uart1_write_text("temperture:");
       uart1_write_text("\r\n");
       ok = getTemperature();                /*temperture*/
       floattostr(ok,txt);
       uart1_write_text(txt);
          uart1_write_text("\r\n");
          uart1_write_text("\r\n");
       delay_ms(1000);

       // LEER GIROSC
       
       
       // DESPERTAR AL ACEL
       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x6B);
       I2C1_Wr(0x00);
       I2C1_Stop();
       delay_ms(100);
       
       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x1C);
       I2C1_Wr(0x18);
       I2C1_Stop();
       delay_ms(100);
       
       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x75);
       I2C1_Wr(0x68);
       I2C1_Stop();
       delay_ms(100);
       
       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x42);                // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       uart1_write_text("Start reading1:");
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);

       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");


      }
}
