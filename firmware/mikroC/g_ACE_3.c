#include "th02.h"

#define ADW 0xD0
#define ADR 0xD1

   char txt[20];

   float accel, cool,ok;
   signed int  buff, cofe;   //signed int
   signed char jugar;         //signed char
   //char tyt[20];




void main()
{
   uart1_init(9600);
   I2C1_Init(100000);         // initialize I2C communication
   TH02Init();
   
   uart1_write_text("STARTING");
   uart1_write_text("\r\n");
   uart1_write_text("\r\n");

    // DESPERTAR AL ACEL

       I2C1_Start();
       delay_ms(100);
       I2C1_Wr(ADW);                // 19
       I2C1_Wr(0x19);
       I2C1_Wr(0x4F);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // 1A
       I2C1_Wr(0x1A);
       I2C1_Wr(0b00000111);
       I2C1_Stop();
       delay_ms(100);

         I2C1_Start();
       I2C1_Wr(ADW);                // 6B   yes (RESETS ALL)
       I2C1_Wr(0x6B);
       I2C1_Wr(0x00);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // 1B    yes
       I2C1_Wr(0x1B);
       I2C1_Wr(0x00);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // 1C    yes
       I2C1_Wr(0x1C);
       I2C1_Wr(0x00);
       I2C1_Stop();
       delay_ms(100);



        /*
       I2C1_Start();
       I2C1_Wr(ADW);                // 6A
       I2C1_Wr(0x6A);
       I2C1_Wr(0b00000101);
       I2C1_Stop();
       delay_ms(100);




       I2C1_Start();
       I2C1_Wr(ADW);                // 74
       I2C1_Wr(0x74);
       I2C1_Wr(0x00);
       cool = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);
        */


 while(1)
  {


        
      /*temperture*/
        /*
       uart1_write_text("REAL TEMP :  ");
       ok = getTemperature();
       floattostr(ok,txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       delay_ms(100);

       uart1_write_text("hasta aqui vamos bien");
        uart1_write_text("\r\n");
       uart1_write_text("bytes:");
        uart1_write_text("\r\n");
         */
        
       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x41);                // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0);             //<<8
       I2C1_Stop();
       delay_ms(100);
       

       inttostr(buff, txt);             // primer byte
       uart1_write_text(txt);
       uart1_write_text("\r\n");

       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x42);                // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       cofe =  I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);
       
       inttostr(cofe, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       
       cofe=(cofe <<8)| buff;
        inttostr(buff, txt);
       uart1_write_text(txt);            // deux bytes ensambles
       uart1_write_text("\r\n");
       
        /*
       uart1_write_text("mero solo :  ");
       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");


       buff=((buff)/340)+36.53;               // ecuacion °C
       uart1_write_text("mero con la ecuacion  :  ");
       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("°C ");
       uart1_write_text("\r\n");
          */
        /*
        //(Gyroscope)
       //lectura axis X----------------------------------------------------------
       
       I2C1_Start();
       I2C1_Wr(ADW);
       I2C1_Wr(0x43);
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       uart1_write_text("Gyro Eje X:");
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x44);                // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0)<< 8;
       I2C1_Stop();
       delay_ms(100);

       //buff=((buff*(-1))/340)+36.53;               // ecuacion °C

       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");

       //lectura axis Y**********************************************************
       buff=0;
       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x45);                // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       uart1_write_text("Gyro Eje Y:");
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x46);                // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0)<< 8;
       I2C1_Stop();
       delay_ms(100);

       //buff=((buff*(-1))/340)+36.53;               // ecuacion °C

       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");

        //lectura axis Z**********************************************************
        buff=0;
       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x47);                // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       uart1_write_text("Gyro Eje Z:");
       buff = I2C1_Rd(0); 
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // Address Device + Write
       I2C1_Wr(0x48);                // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0)<< 8;
       I2C1_Stop();
       delay_ms(100);

       //buff=((buff*(-1))/340)+36.53;               // ecuacion °C

       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");

        //(Accelerometer)
       //lectura axis X----------------------------------------------------------

       I2C1_Start();
       I2C1_Wr(ADW);
       I2C1_Wr(0x3B);
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       uart1_write_text("ACCEL Eje X:");
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);
       I2C1_Wr(0x3C);
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0)<< 8;
       I2C1_Stop();
       delay_ms(100);

       //buff=((buff*(-1))/340)+36.53;               // ecuacion °C

       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");

       //lectura axis Y**********************************************************

       I2C1_Start();
       I2C1_Wr(ADW);
       I2C1_Wr(0x3D);
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       uart1_write_text("ACCEL Eje Y:");
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);
       I2C1_Wr(0x3E);
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0)<< 8;
       I2C1_Stop();
       delay_ms(100);

       //buff=((buff*(-1))/340)+36.53;               // ecuacion °C

       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");

       //lectura axis Z**********************************************************

       I2C1_Start();
       I2C1_Wr(ADW);
       I2C1_Wr(0x3F);
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       uart1_write_text("ACCEL Eje Z:");
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);
       I2C1_Wr(0x40);
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0)<< 8;
       I2C1_Stop();
       delay_ms(100);

       //buff=((buff*(-1))/340)+36.53;               // ecuacion °C

       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       */

        /*(RESETS signal paths)
       I2C1_Start();
       I2C1_Wr(ADW);                // 6B   yes (RESETS ALL)
       I2C1_Wr(0x68);
       I2C1_Wr(0b00000111);
       I2C1_Stop();
       delay_ms(100);
          */

      }
}