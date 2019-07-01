#include "th02.h"

#define ADW 0xD0
#define ADR 0xD1
   char txt[20], errorCode;

   long double accel, cool,ok, finally;
   unsigned int  buff, cofe, test ;
   signed char jugar;
   
   

   I2C1_TimeoutCallback(errorCode)
     {
       if (errorCode == _I2C_TIMEOUT_RD) {
     // do something if timeout is caused during read
     uart1_write_text("read problem");
       uart1_write_text("\r\n");
   }

   if (errorCode == _I2C_TIMEOUT_WR) {
     // do something if timeout is caused during write
     uart1_write_text("write problem");
       uart1_write_text("\r\n");
   }

   if (errorCode == _I2C_TIMEOUT_START) {
     // do something if timeout is caused during start
     uart1_write_text("start problem");
       uart1_write_text("\r\n");
   }

   if (errorCode == _I2C_TIMEOUT_REPEATED_START) {
     // do something if timeout is caused during repeated start
     uart1_write_text("repeat start problem");
       uart1_write_text("\r\n");
   }

      }
      // initialize I2C module
      //I2C1_Remappable_Init(100000);

       // set timeout period and callback function
      //I2C1_SetTimeoutCallback(1000, I2C1_TimeoutCallback);




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
       I2C1_Wr(ADW);                // 19 x(4F)
       I2C1_Wr(0x19);
       I2C1_Wr(0x07);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // 1A   (0b00000111)
       I2C1_Wr(0x1A);
       I2C1_Wr(0b00000000);
       I2C1_Stop();
       delay_ms(100);

         I2C1_Start();
       I2C1_Wr(ADW);                // 6B   yes (RESETS ALL)(new)
       I2C1_Wr(0x6B);
       I2C1_Wr(0x01);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // 1B    yes (18)
       I2C1_Wr(0x1B);
       I2C1_Wr(0x00);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // 1C    yes    (18)
       I2C1_Wr(0x1C);
       I2C1_Wr(0x00);
       I2C1_Stop();
       delay_ms(100);
        /*
       I2C1_Start();
       I2C1_Wr(ADW);                // interrupt data ready
       I2C1_Wr(0x38);
       I2C1_Wr(0x01);
       I2C1_Stop();
       delay_ms(100);
        */
       I2C1_Start();
       I2C1_Wr(ADW);                // interrupt data ready (INTERRUPT) STATUS
       I2C1_Wr(0x3A);
       I2C1_Wr(0x01);
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

        delay_ms(100);

 while(1)
  {
      uart1_write_text("GO ON");
       uart1_write_text("\r\n");
       



        
      /*temperture*/
        /*
       uart1_write_text("REAL TEMP :                 ");
       ok = getTemperature();
       floattostr(ok,txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       delay_ms(100);
         */
         

      
        /*
        I2C1_Start();
        I2C1_Wr(ADW);                                   // Address Device + Write
        I2C1_Wr(0x41);                                  // Address Pointer
        I2C1_Repeated_Start();
        I2C1_Wr(ADR);
        buff = I2C1_Rd(0);                              // <<8
        I2C1_Stop();
        delay_ms(100);
       

        //inttostr(buff, txt);                            // primer byte
        //uart1_write_text(txt);
        uart1_write(buff);
        //uart1_write_text("\r\n");

        I2C1_Start();
        I2C1_Wr(ADW);                                   // Address Device + Write
        I2C1_Wr(0x42);                                  // Address Pointer
        I2C1_Repeated_Start();
        I2C1_Wr(ADR);
        cofe =  I2C1_Rd(0);                            //
        I2C1_Stop();

       
        //inttostr(cofe, txt);                            // second byte
        //uart1_write_text(txt);
        uart1_write(cofe);
        delay_ms(500);
        uart1_write_text("\r\n");
        uart1_write_text("\r\n");
        uart1_write_text("\r\n");


        buff=(buff<<8);
        buff=buff  | cofe;
        
        /*inttostr(buff, txt);
        uart1_write_text(txt);            // print concomplemento A2
        uart1_write_text("\r\n");
        uart1_write_text("\r\n");
        uart1_write_text("\r\n");
         */
         
          /*--------------------------------------------------------------
         buff=~buff;
         buff=(buff | (0x01));
         if(buff>=32768)
          buff= buff & (0xFFFF);
          
         uart1_write(buff );
         uart1_write_text("\r\n");
          //buff=(buff/(-340))+36.53;               // ecuacion °C   -
          
         intToStr(finally, txt);
         uart1_write_text("Temp final :                ");
         uart1_write_text(txt);
         uart1_write_text("°C ");
         uart1_write_text("\r\n");
         delay_ms(5000);
         

         
          
         //finally = atol("txt");;
        //finally=(finally*(-1));
        
        /*finally=(finally/(-340))+36.53;               // ecuacion °C   -
        
        //uart1_write_text("la pizza de don cangrejo... es la mejor            ");
        
        FloatToStr(finally, txt);
        uart1_write_text("Temp final :                ");
        uart1_write_text(txt);
        uart1_write_text("°C ");
        uart1_write_text("\r\n");
        delay_ms(5000);
             */




        //(Gyroscope)
       //lectura axis X----------------------------------------------------------
       //uart1_write_text("X Axis");
       //uart1_write_text("\r\n");
        /*
       I2C1_Start();
       I2C1_Wr(ADW);                                   // Address Device + Write
       I2C1_Wr(0x43);                                  // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);

       inttostr(buff, txt);                            // primer byte
       uart1_write_text(txt);
       uart1_write_text("\r\n");

       
       I2C1_Start();
       I2C1_Wr(ADW);                                   // Address Device + Write
       I2C1_Wr(0x44);                                  // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       cofe =  I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);

       inttostr(cofe, txt);
       uart1_write_text(txt);                           // second byte
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");


       buff=(buff<<8);
       buff=buff  | cofe;                              // deux bytes ensambles
       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");



       finally=buff;
       //finally=finally*(-1);
       //finally=(finally/(-131));               // ecuacion de convercion
       
       FloatToStr(finally, txt);
       uart1_write_text("Gyro X: ");
       uart1_write_text(txt);
       uart1_write_text("°C ");
       uart1_write_text("\r\n");

       
       /*
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
         */
        //(Accelerometer)
       //lectura axis X----------------------------------------------------------

       I2C1_Start();
       I2C1_Wr(ADW);                                   // Address Device + Write
       I2C1_Wr(0x3B);                                  // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);
        /*
       inttostr(buff, txt);                            // primer byte
       uart1_write_text(txt);
       uart1_write_text("\r\n");
         */

       I2C1_Start();
       I2C1_Wr(ADW);                                   // Address Device + Write
       I2C1_Wr(0x3C);                                  // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       cofe =  I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);
        /*
       inttostr(cofe, txt);
       uart1_write_text(txt);                           // second byte
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
         */

       buff=(buff<<8);
       buff=buff  | cofe;                              // deux bytes ensambles
       /*
       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
        */

       finally=buff;
       finally= ((finally * 2)/16386);


       FloatToStr(finally, txt);
       uart1_write_text("ACCEL X: ");
       uart1_write_text(txt);
       uart1_write_text("°C ");
       uart1_write_text("\r\n");
       //delay_ms(5000);

       //lectura axis Y**********************************************************

       I2C1_Start();
       I2C1_Wr(ADW);                                   // Address Device + Write
       I2C1_Wr(0x3D);                                  // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);
        /*
       inttostr(buff, txt);                            // primer byte
       uart1_write_text(txt);
       uart1_write_text("\r\n");
        */

       I2C1_Start();
       I2C1_Wr(ADW);                                   // Address Device + Write
       I2C1_Wr(0x3E);                                  // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       cofe =  I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);
        /*
       inttostr(cofe, txt);
       uart1_write_text(txt);                           // second byte
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
        */

       buff=(buff<<8);
       buff=buff  | cofe;                              // deux bytes ensambles
       /*
       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       */

       finally=buff;
       finally= ((finally * 2)/16386);


       FloatToStr(finally, txt);
       uart1_write_text("ACCEL Y: ");
       uart1_write_text(txt);
       uart1_write_text("°C ");
       uart1_write_text("\r\n");


       //lectura axis Z**********************************************************

      I2C1_Start();
       I2C1_Wr(ADW);                                   // Address Device + Write
       I2C1_Wr(0x3F);                                  // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       buff = I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(10000);
        /*
       inttostr(buff, txt);                            // primer byte
       uart1_write_text(txt);
       uart1_write_text("\r\n");
         */

       I2C1_Start();
       I2C1_Wr(ADW);                                   // Address Device + Write
       I2C1_Wr(0x40);                                  // Address Pointer
       I2C1_Repeated_Start();
       I2C1_Wr(ADR);
       cofe =  I2C1_Rd(0);
       I2C1_Stop();
       delay_ms(100);
        /*
       inttostr(cofe, txt);
       uart1_write_text(txt);                           // second byte
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
        */

       buff=(buff<<8);
       buff=buff  | cofe;                              // deux bytes ensambles
       /*
       inttostr(buff, txt);
       uart1_write_text(txt);
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       uart1_write_text("\r\n");
       */

       finally=buff;
       finally= ((finally * 2)/16386);


       FloatToStr(finally, txt);
       uart1_write_text("ACCEL Z: ");
       uart1_write_text(txt);
       uart1_write_text("°C ");
       uart1_write_text("\r\n");


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