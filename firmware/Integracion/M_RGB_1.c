/* Libraries */
#include "th02.h"
#include "Accel.h"
//#include "getRTC.h"
#include "Metodos_DS1307.h"

/* Defines */
#define RED   LATB.F7
#define GREEN LATB.F6
#define BLUE  LATB.F5

#define ADDRESS_RTC (0xD0)


/* Global variables */
float temperature, humidity;
//unsigned short dropsL, dropsH;
unsigned int drops;
unsigned char i;
char txt[20];

int time;

/* Functions definition */
void config (void);

/* Main */
void main()
{
     config();

     /* Loop */
     while(1)
     {

             //RED = 1;
             temperature = getTemperature();
             floattostr(temperature, txt);
             UART1_Write_Text("TEMPERATURE: ");
             UART1_Write_Text(txt);
             uart1_write_text("°C\r\n");

             
             delay_ms(500);


             humidity = getHumidity();
             floattostr(humidity, txt);
             UART1_Write_Text("HUMEDAD: ");
             UART1_Write_Text(txt);
             uart1_write_text("%\r\n");

             //RED = 0;

             delay_ms(500);

             //BLUE = 1;
             UART1_Write_Text("Drops: ");
             drops = TMR0L;
             drops |=  (TMR0H << 8);
             inttostr(drops, txt);
             UART1_Write_Text(txt);
             uart1_write_text("\r\n");

             //BLUE = 0;
             
             delay_ms(500);
             
             // MANDAR FECHA Y HORA

             UART1_Write_Text("Time: ");
             for(i=1; i<=6; i++)
             {
                time = Leer(ADDRESS_RTC,i);

                time = Bcd2Dec(time);
                UART1_Write( (time/10) + 48 );
                UART1_Write( (time%10) + 48 );
                UART1_Write( ':' );
             }

             uart1_write_text("\r\n");
             uart1_write_text("\r\n");
     }
}

/* Functions structures */
void config (void)
{

     /* DIGITAL PORTS */
     TRISB.F7=0;
     TRISB.F6=0;
     TRISB.F5=0;

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
     
      UART1_Write_Text("Configuration init: ");
     uart1_write_text("\r\n");
     

     th02Init();
     Accelconfig();
     
}