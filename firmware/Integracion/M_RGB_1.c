/* Libraries */
#include "th02.h"
#include "Accel.h"
#include "Metodos_DS1307.h"

/* Defines */
#define RED   (LATB.F7)
#define GREEN (LATB.F6)
#define BLUE  (LATB.F5)

#define ADDRESS_RTC (0xD0)
#define RATE (5)


/* Global variables */
float temperature = 0;
float humidity = 0;
unsigned int drops = 0;
unsigned int drops_b = 0;
unsigned char i = 0;
unsigned short home = 0;
char txt[20];
int time = 0;
unsigned int sec=0;
unsigned int min=0;

/* Functions definition */
void config (void);
void modules (void);

void interrupt()
{
      if(INTCON.F1)                     // External interrupt
    {

          if(home)
          {
             modules();
             home = 0;
          }
          
          // RATE = 1 sec
          sec++;
          if(sec>=60)
          {
              sec=0;
              min++;
              
              if((min%RATE)==0)
              {
                   temperature = getTemperature();
                   floattostr(temperature, txt);
                   UART1_Write_Text("TEMPERATURE: ");
                   UART1_Write_Text(txt);
                   uart1_write_text("°C\r\n");

                   humidity = getHumidity();
                   floattostr(humidity, txt);
                   UART1_Write_Text("HUMEDAD: ");
                   UART1_Write_Text(txt);
                   uart1_write_text("%\r\n");

                   UART1_Write_Text("Drops: ");
                   drops = TMR0L;
                   drops |=  (TMR0H << 8);
                   inttostr(drops, txt);
                   UART1_Write_Text(txt);
                   uart1_write_text("\r\n");
                   TMR0L = 0;
                   TMR0H = 0;

                   // DATE
                   UART1_Write_Text("Time: ");
                   for(i=6; i>0; i--)
                   {
                      time = Leer(ADDRESS_RTC,i);

                      time = Bcd2Dec(time);
                      UART1_Write( (time/10) + 48 );
                      UART1_Write( (time%10) + 48 );
                      UART1_Write( ':' );
                   }
                   
                   min = time;
                   uart1_write_text("\r\n");
                   uart1_write_text("\r\n");
              }
              
              

          }
          RED = ~ RED;              // Clear flag
          INTCON.F1 = 0;
      }
}

/* Main */
void main()
{
     config();
     
     /* Loop */
     while(1)
     {
             drops = TMR0L;
             drops |=  (TMR0H << 8);
             if(drops_b != drops)
             {
                drops_b = drops;
                GREEN = 1;
                delay_ms(10);
                GREEN = 0;
             }
             delay_ms(20);
     }
}

/* Functions structures */
void config (void)
{
     /* DIGITAL PORTS*/
     ANSELA=0;
     ANSELB=0;
     ANSELC=0;

     /* DIGITAL OUTPUTS RGB */
     TRISB.F7=0;
     TRISB.F6=0;
     TRISB.F5=0;
     
     /* External interrupt */
     INTCON = 0XD0;
     INTCON.F1 = 0;          // FLAG
     INTCON2.F6 = 0;         // EDGE
     TRISB.F0=1;

     /* Timer configuration 16 bits T0CLKIN No preescaler */
     T0CON = 0XA8;
     TMR0L = 0X00;
     TMR0H = 0X00;
     TRISA.F4 = 1;

     /* Clear Ports */
     PORTA = 0;
     PORTB = 0;
     PORTC = 0;
     
     home = 1;
}

void modules (void)
{
     /* SERIAL PORT, TH02*/
     UART1_Init(9600);               // Initialize UART module at 9600 bps
     Delay_ms(100);                  // Wait for UART module to stabilize

     UART1_Write_Text("Configuration init: ");
     uart1_write_text("\r\n");

     th02Init();
     Accelconfig();
}