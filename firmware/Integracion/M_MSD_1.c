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

// MMC module connections
sbit Mmc_Chip_Select           at LATB3_bit;
sbit Mmc_Chip_Select_Direction at TRISB3_bit;
// eof MMC module connections

/* Global variables */
float temperature = 0;
float humidity = 0;
unsigned int drops = 0;
unsigned int drops_b = 0;
unsigned char i = 0;
unsigned short home = 0;
char txt[20];
int time[6];
unsigned int sec=0;
unsigned int min=0;

const LINE_LEN = 43;
char err_txt[20]       = "FAT16 not found";
char file_contents[LINE_LEN] = "\n\r";

char file_contents2[LINE_LEN]= "dia 2" ;
char file_contents1[LINE_LEN]= "mes1" ;

char           filename[14] = "XIHMAIx.CSV";          // File names
unsigned short loop, loop2;
unsigned long  size;
char           Buffer[512];




/* Functions definition */
void config (void);
void modules (void);
void M_Create_New_File(void);
void M_Open_File_Append(void);

void interrupt()
{
      if(INTCON.F1)                     // External interrupt
    {

          if(home)
          {
             modules();
             M_Create_New_File();
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
                      time[i] = Leer(ADDRESS_RTC,i);
                   }
                   
                   for(i=6; i>0; i--)
                   {
                      time[i] = Bcd2Dec(time[i]);
                      UART1_Write( (time[i]/10) + 48 );
                      UART1_Write( (time[i]%10) + 48 );
                      UART1_Write( ':' );
                   }
                   min = time[1];
                   
                   M_Open_File_Append();
                   
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
     
      /* Set variables */
     home = 1;
     for(i=0; i<6; i++)
     {
        time[i] = 0;
     }
}

void modules (void)
{
     /* SERIAL PORT, TH02*/
     UART1_Init(9600);               // Initialize UART module at 9600 bps
     Delay_ms(100);                  // Wait for UART module to stabilize

     UART1_Write_Text("Starting Xihmai: ");
     uart1_write_text("\r\n");

     th02Init();
     Accelconfig();
}

void M_Create_New_File() {

  // START SPI
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
  
  if (Mmc_Fat_Init_B() == 0) {
    // reinitialize spi at higher speed
    SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
    //--- Test start
    UART1_Write_Text("Creating new file");
    uart1_write_text("\r\n");
    //--- Test routines. Uncomment them one-by-one to test certain features
    Mmc_Fat_Assign_B(&filename, 0xA0);          // Find existing file or create a new one
    Mmc_Fat_Rewrite_B();                        // To clear file and start with new data
    //Mmc_Fat_Write_B(file_contents, LINE_LEN-1);   // write data to the assigned file

    UART1_Write_Text("New file created");
    uart1_write_text("\r\n");
  }
  else {
    UART1_Write_Text("error creating new file"); // Note: Mmc_Fat_Init_B tries to initialize a card more than once.
  }
}

void M_Open_File_Append() {
  // START SPI
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

  if (Mmc_Fat_Init_B() == 0) {
    // reinitialize spi at higher speed
    SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
    //--- Test start
    UART1_Write_Text("Writing on new file");
    uart1_write_text("\r\n");
    //--- Test routines. Uncomment them one-by-one to test certain features
    Mmc_Fat_Assign_B(&filename, 0xA0);
    Mmc_Fat_Append_B();                                    // Prepare file for append
    Mmc_Fat_Write_B(file_contents2, 27);   // Write data to assigned file
    Mmc_Fat_Write_B(file_contents1, 27);

    UART1_Write_Text("Writed!");
    uart1_write_text("\r\n");
  }
  else {
    UART1_Write_Text("error writing"); // Note: Mmc_Fat_Init_B tries to initialize a card more than once.
  }
}