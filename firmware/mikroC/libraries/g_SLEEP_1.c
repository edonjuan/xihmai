int compte;
char txt[20];

#include "th02.h"

#define ADW 0xD0
#define ADR 0xD1

#define LED LATA                    //sleep mode  LED = port A


   char  errorCode;

   long double accel, cool,ok, finally;
   unsigned int  buff, cofe, test ;
   signed char jugar;
   int flag;                        //sleep mode


  /*
void main()
{





   uart1_init(9600);
   I2C1_Init(100000);                   // initialize I2C communication
   TH02Init();

   uart1_write_text("STARTING");
   uart1_write_text("\r\n");
   uart1_write_text("\r\n");




       I2C1_Start();                // Configuring MPU6050 and interruption
       I2C1_Wr(0xD0);                          // 19 x(4F)
       I2C1_Wr(0x19);
       I2C1_Wr(0x07);
       I2C1_Stop();
       delay_ms(100);

                                            // �tre sure du Reset de touts les registers
       I2C1_Start();
       I2C1_Wr(ADW);                // 6B   yes (RESETS ALL)(new)
       I2C1_Wr(0x6B);
       I2C1_Wr(0x00);
       I2C1_Stop();
       delay_ms(100);


       I2C1_Start();
       I2C1_Wr(ADW);                // 6C il manque les premier deux zeros pour wake-ups
       I2C1_Wr(0x6C);               // bits 7 y 6
       I2C1_Wr(0x00);
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

       I2C1_Start();
       delay_ms(100);
       I2C1_Wr(ADW);                //  38   Activar motion interrupt ( activa el bit (-))
       I2C1_Wr(0x38);
       I2C1_Wr(0x40);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // Motion interrupt duration
       I2C1_Wr(0x20);
       I2C1_Wr(0x01);
       I2C1_Stop();
       delay_ms(100);

       I2C1_Start();
       I2C1_Wr(ADW);                // interrupt data ready (INTERRUPT) STATUS
       I2C1_Wr(0x3A);
       I2C1_Wr(0x01);
       I2C1_Stop();
       delay_ms(100);


       I2C1_Start();
       I2C1_Wr(ADW);                // 1F     Treshold = 100 320mg
       I2C1_Wr(0x1F);               // 20=32mg=0x14
       I2C1_Wr(0x01);
       I2C1_Stop();
       delay_ms(200);                // delay extra


       I2C1_Start();
       I2C1_Wr(ADW);                // 1A   (0b00000111)  MOtion HPF HOLD    (07)
       I2C1_Wr(0x1A);
       I2C1_Wr(0xFF);
       I2C1_Stop();
       delay_ms(100);


       I2C1_Start();
       I2C1_Wr(ADW);                // 6C (2) il manque les premier deux zeros pour wake-ups
       I2C1_Wr(0x6C);               // bits 7 y 6
       I2C1_Wr(0x60);
       I2C1_Stop();
       delay_ms(100);


       I2C1_Start();
       I2C1_Wr(ADW);                // 6B   activate cycle
       I2C1_Wr(0x6B);
       I2C1_Wr(0x10);
       I2C1_Stop();
       delay_ms(100);


       delay_ms(300);
      */

       
    /*
    Enter PIC18F4550 in sleep and wake-up through external interrupt
    www.electronicwings.com
   */







void main()
{

     //sbit LED at RB0_bit;

    TRISD=0;

    TRISA=0;                         // Set PORTA.0 as output
    TRISB=1;                         // Set PORTB.0 as input
    OSCCON=0x00;                     //Internal osc. freq. 8MHz with IDLEN=0,  enabling IDLEN enables sleep mode    (72)
    INTCON2=0x40;                    // INT0 rising edge interrupt selected
    INTCON=0x00;                        //Clear INT0 interrupt flag
    INTCON=1;                        // Enable INTOIF interrupt
    INTCON=0b00010011;               // Enable global interrupt, High and Low, flag nad mismatch reading port b
    
    flag = 0;
    PORTA= 0b0000010;                     //Turn OFF led initially      PORTA0B1= 1;
    while(!flag)
    {
        LED = ~LED;                 // Blink LED continuously
        delay_ms(300);
    }
    //SLEEP();                        // Enter in sleep mode
    INTCON.TMR0IF=0;
 }

/*
void interrupt ISR()
{
    flag = ~flag;
    if (INT0 == 1) { // If we have got INT0 interrupt generated by RB0 transition
    INT0 = 0 ;       // reset interrupt flag to stop re-entry until another interrupt
     }                //INTCONbits.INT0IF=0;
}
  */
void MSdelay(unsigned int val)
{
    unsigned int i,j;
    for(i=0;i<val;i++)
        for(j=0;j<165;j++);
}

 //---------------------------------------------------------------------------------



//void main (void){
  /*
 ADCON1 = 0xFF;                     // Voltage Reference
 CMCON = 0x7;                       // Comparator Mode bits
 TRISC = 0;                         // port C as outputs
 TRISA.RA4 = 1;                    //make RA4/TOCKI an input for interrupt signal
 T0CON = 0X28;                     //Counter 0, 16-bit mode, no prescaler
 TMR0H = 0;
 TMR0L = 0;                        //set count to 0


 uart1_init(9600);
 uart1_write_text("On commence ici");
 uart1_write_text("\r\n");


 while(1)
  {
    //do {

   T0CON.TMR0ON = 1 ;                   //turn on T0
   PORTC = TMR0H+TMR0L;                 //place value on pins
    
     compte = TMR0L;                    //TMR0H+
     inttostr(compte,txt);
     uart1_write_text(txt);
     uart1_write_text("\r\n");
     uart1_write_text("\r\n");
     delay_ms(1000);

       //}while (INTCON.TMR0IF==0);    //wait for TF0 to roll over
       
      T0CON.TMR0ON = 0;                //turn off T0
      INTCON.TMR0IF = 0;               //clear TF0
   }

}