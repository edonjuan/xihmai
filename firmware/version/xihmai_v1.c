/* Libraries */
#include "th02.h"
#include "Accel.h"
//#include "Metodos_DS1307.h"

/* Defines */
#define RED   (LATB.F7)
#define GREEN (LATB.F6)
#define BLUE  (LATB.F5)

#define ADDRESS_RTC (0xD0)
#define RATE (1)

// MMC module connections
sbit Mmc_Chip_Select           at LATB3_bit;
sbit Mmc_Chip_Select_Direction at TRISB3_bit;
// eof MMC module connections

/* Global variables */
float temperature = 0;
float humidity = 0;
unsigned int drops = 0;
unsigned int drops_b = 0;
short i = 0;
unsigned short home = 0;
char txt[5];
int time[6];
unsigned int sec=0;
unsigned int min=0;
char rtcvalue[7];
char rtcdata;


const LINE_LEN = 43;
char err_txt[20]       = "FAT16 not found";
char msgSD[38];


char           filename[12] = "   XIMAI";          // File names
unsigned short loop, loop2;
unsigned long  size;
char           Buffer[512];

unsigned int filenumber;
unsigned short filenumbercen=0;
unsigned short filenumberdec=0;
unsigned short filenumberuni=0;

long goute=0;   //variable to make a coutner

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

             home = 0;
             sec=59;     //agregado
             min=RATE-1; //agregado
            /*uart1_write_text("eeprom here");
             uart1_write_text("\r\n");*/
             filename[0] = EEPROM_Read(0) + 48;      // centenas
             filename[1] = EEPROM_Read(1) + 48;      // decenas
             filename[2] = EEPROM_Read(2) + 48;      // unidades

             filename[8] = 46;              //.
             filename[9] = 67;              //C
             filename[10] = 83;             //S
             filename[11] = 86;             //V

             filenumber = EEPROM_Read(0)*100 + EEPROM_Read(1)*10 + EEPROM_Read(2);

             /*UART1_Write_Text("creando archivo numero: ");
             inttostr(filenumber, txt);
             UART1_Write_Text(txt);
             uart1_write_text("\r\n");*/

             M_Create_New_File();


           }

          // RATE = 1 sec
          sec++;
          if(sec>=60)
          {
              sec=0;
              min++;

              if((min%RATE)==0)
              {
                   /*uart1_write_text("\r\n");
                   uart1_write_text("\r\n");*/

                   // DATE
                    /*UART1_Write_Text("Time: ");*/

                    I2C2_Start();
                    I2C2_Wr(ADDRESS_RTC);
                    I2C2_Wr(0);        // Direccion de memoria
                    I2C2_Repeated_Start();
                    I2C2_Wr(ADDRESS_RTC+1);

                     //LATB.F5 = 1;
                     for(i=0; i<6; i++)
                     {
                       rtcvalue[i]=I2C2_Rd(1);
                     }
                     //LATB.F5 = 0;

                     rtcvalue[i]=I2C2_Rd(0);
                     I2C2_Stop();

                     msgSD[0] = ((Bcd2Dec(rtcvalue[4]))/10)+48;
                     msgSD[1] = ((Bcd2Dec(rtcvalue[4]))%10)+48;
                     msgSD[2] =  47;
                     msgSD[3] = ((Bcd2Dec(rtcvalue[5]))/10)+48;
                     msgSD[4] = ((Bcd2Dec(rtcvalue[5]))%10)+48;
                     msgSD[5] =  47;
                     msgSD[6] = ((Bcd2Dec(rtcvalue[6]))/10)+48;
                     msgSD[7] = ((Bcd2Dec(rtcvalue[6]))%10)+48;
                     msgSD[8] =  32;
                     msgSD[9] = ((Bcd2Dec(rtcvalue[2]))/10)+48;
                     msgSD[10] = ((Bcd2Dec(rtcvalue[2]))%10)+48;
                     msgSD[11]=  58;
                     msgSD[12] = ((Bcd2Dec(rtcvalue[1]))/10)+48;
                     msgSD[13] = ((Bcd2Dec(rtcvalue[1]))%10)+48;
                     msgSD[14]=  58;
                     msgSD[15] = ((Bcd2Dec(rtcvalue[0]))/10)+48;
                     msgSD[16] = ((Bcd2Dec(rtcvalue[0]))%10)+48;

                     msgSD[17]=  44;   //COMA



                       for(i=6; i>=0; i--)
                      {
                          rtcdata = Bcd2Dec(rtcvalue[i]);
                          /*UART1_Write( (rtcdata/10) + 48 );
                          UART1_Write( (rtcdata%10) + 48 );
                          uart1_write(58);  //:*/

                      }

                      /*uart1_write(10);
                      uart1_write(13);*/

                      // Sincronia
                      min = Bcd2Dec(rtcvalue[1]);
                      sec = Bcd2Dec(rtcvalue[0]);


                     /*uart1_write(10);
                      uart1_write(13);*/

                   temperature = getTemperature();
                   /*floattostr(temperature, txt);
                   UART1_Write_Text("TEMPERATURE: ");
                   UART1_Write_Text(txt);
                   uart1_write_text("°C\r\n");*/

                    temperature=temperature*100;
                    msgSD[18] = ((int)(temperature/1000)%10)+48;
                    msgSD[19] = ((int)(temperature/100)%10)+48;
                    msgSD[20] = 46;
                    msgSD[21] =((int)(temperature/10)%10 )+48;
                    msgSD[22] = ((int)(temperature/1)%10 )+48;
                    msgSD[23] = 44;

                   humidity = getHumidity();
                   /*floattostr(humidity, txt);
                   UART1_Write_Text("HUMEDAD: ");
                   UART1_Write_Text(txt);
                   uart1_write_text("\r\n");*/
                   humidity=humidity*100;

                   msgSD[24] = ((int)(humidity/1000)%10)+48;
                   msgSD[25] = ((int)(humidity/100)%10)+48;
                   msgSD[26] =  46;
                   msgSD[27] = ((int)(humidity/10)%10 )+48;
                   msgSD[28] = ((int)(humidity/1)%10 )+48;
                   msgSD[29] = 44;



                  // UART1_Write_Text("Drops: ");
                   //drops=goute;
                   //drops = TMR0L;
                   drops |=  (TMR0H << 8);
                   longtostr(goute,txt);
                   //inttostr(drops, txt);
                   //UART1_Write_Text(txt);
                   TMR0L = 0;
                   TMR0H = 0;

                   msgSD[30] = ((int)(goute/1000)%10)+48;
                   msgSD[31] = ((int)(goute/100)%10)+48;
                   msgSD[32] = ((int)(goute/10)%10 )+48;
                   msgSD[33] = ((int)(goute/1)%10 )+48;
                   msgSD[34] = 44;
                   msgSD[35] = 13;

                   //uart1_write_text("\r\n");
                   goute=0;
              }
              M_Open_File_Append() ;
          }
          //BLUE = ~ BLUE;              // Clear flag
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
                GREEN=1;
                delay_ms(100);
                GREEN=0;
                goute++;
                drops_b = TMR0L;
                drops_b |=  (TMR0H << 8);
             }
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
    /*UART1_Init(9600);               // Initialize UART module at 9600 bps
     Delay_ms(100);*/                 // Wait for UART module to stabilize

     /*UART1_Write_Text("Starting Xihmai: ");
     uart1_write_text("\r\n");*/

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


    /*UART1_Write_Text("Creating new file");
    uart1_write_text("\r\n");*/


    //--- Test routines. Uncomment them one-by-one to test certain features
    Mmc_Fat_Assign_B(&filename, 0xA0);          // Find existing file or create a new one
    //Mmc_Fat_Rewrite_B();                        // To clear file and start with new data
    //Mmc_Fat_Write_B(file_contents, LINE_LEN-1);   // write data to the assigned file

   /*UART1_Write_Text("New file created");
    uart1_write_text("\r\n");*/

    filenumber++;
     EEPROM_Write(0, (filenumber/100)%10);
     EEPROM_Write(1, (filenumber/10)%10);
     EEPROM_Write(2, (filenumber/1)%10);

  }
  else {

    /*UART1_Write_Text("error creating new file"); // Note: Mmc_Fat_Init_B tries to initialize a card more than once.
    uart1_write_text("\r\n");*/

  }
}

void M_Open_File_Append() {
  // START SPI
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

  if (Mmc_Fat_Init_B() == 0) {
    // reinitialize spi at higher speed
    SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
    //--- Test start

    /*UART1_Write_Text("Writing on new file");
    uart1_write_text("\r\n");*/

    //--- Test routines. Uncomment them one-by-one to test certain features
    Mmc_Fat_Assign_B(filename, 0xA0);
    Mmc_Fat_Append_B();                                    // Prepare file for append
    Mmc_Fat_Write_B(msgSD, 36);   // Write data to assigned file

    /*UART1_Write_Text("Writed!");
    uart1_write(10);
    uart1_write(13);*/
  }
  else {
    RED=1;
    /*UART1_Write_Text("error writing"); // Note: Mmc_Fat_Init_B tries to initialize a card more than once.
    uart1_write_text("\r\n");*/
    Delay_ms(500);
    RED=0;
  }
}