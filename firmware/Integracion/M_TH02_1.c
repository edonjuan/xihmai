/* Libraries */
#include "th02.h"
#include "Accel.h"

/* Defines */
#define RED RA1_bit
#define GREEN LATA.f2
#define BLUE LATA.F3


/* Global variables */
float temperature, humidity;
//unsigned short dropsL, dropsH;
unsigned int drops;
char txt[20];

/* Functions definition */
void config (void);

/* Main */
void main()
{
     config();
     
     /* Loop */
     while(1)
     {       


             temperature = getTemperature();
             floattostr(temperature, txt);
             UART1_Write_Text("TEMPERATURE: ");
             UART1_Write_Text(txt);
             uart1_write_text("�C\r\n");
             
             humidity = getHumidity();
             floattostr(humidity, txt);
             UART1_Write_Text("HUMEDAD: ");
             UART1_Write_Text(txt);
             uart1_write_text("%\r\n");
             
             delay_ms(1000);

             UART1_Write_Text("Drops: ");
             drops = TMR0L;
             drops |=  (TMR0H << 8);
             inttostr(drops, txt);
             UART1_Write_Text(txt);
             uart1_write_text("\r\n");
             uart1_write_text("\r\n");
             delay_ms(400);
     }
}

/* Functions structures */
void config (void)
{
     /* DIGITAL PORTS */
     //TRISA.f1=0;                           // PORT A pin 1 as output
     //TRISA.f2=0;                           // PORT A pin 2 as output
     //TRISB.f3=0;                           // PORT A pin 3 as output
     
     /* Timer configuration 16 bits T0CLKIN No preescaler */
     T0CON = 0XA8;
     TMR0L = 0X00;
     TMR0H = 0X00;
     TRISA.F4 = 1;
     
     ANSELC=0;
     ANSELA=0;
     TRISC =0;
     TRISA =0;

     /* SERIAL PORT, TH02*/
     UART1_Init(9600);               // Initialize UART module at 9600 bps
     Delay_ms(100);                  // Wait for UART module to stabilize
     
     th02Init();
     Accelconfig();
     
     
}