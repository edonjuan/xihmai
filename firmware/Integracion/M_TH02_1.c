/* Libraries */
#include "th02.h"

/* Defines */
#define RED RA1_bit
#define GREEN LATA.f2
#define BLUE LATA.F3


/* Global variables */
float temperature, humidity;
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
             
             //UART1_Write_Text("TEMPERATURE:");
             //uart1_write_text("\r\n");
             //BLUE=0;
             //GREEN =1;                                         // LED GREEN ON
             //delay_ms(100);
             temperature = getTemperature();
             inttostr(temperature, txt);
             //UART1_Write_Text(txt);
             //uart1_write_text("\r\n");
             //UART1_Write_Text("HUMEDAD:");
             //uart1_write_text("\r\n");
             humidity = getHumidity();
             inttostr(humidity, txt);
             //UART1_Write_Text(txt);
             //uart1_write_text("\r\n");
             //uart1_write_text("\r\n");
             delay_ms(100);
             
             //GREEN = 0;
             //RED=1;
             //delay_ms(1000);
     }
}

/* Functions structures */
void config (void)
{
     /* DIGITAL PORTS */
     //TRISA.f1=0;                           // PORT A pin 1 as output
     //TRISA.f2=0;                           // PORT A pin 2 as output
     //TRISB.f3=0;                           // PORT A pin 3 as output
     
     ANSELC=0;
     ANSELA=0;
     TRISC =0;
     TRISA =0;

     /* SERIAL PORT */
     /*UART1_Init(9600);               // Initialize UART module at 9600 bps
     Delay_ms(100);                  // Wait for UART module to stabilize
     */

     th02Init();
     
     
}