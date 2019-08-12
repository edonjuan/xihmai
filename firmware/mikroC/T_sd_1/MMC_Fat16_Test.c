// MMC module connections
sbit Mmc_Chip_Select           at LATC0_bit;  // for writing to output pin always use latch (PIC18 family)
sbit Mmc_Chip_Select_Direction at TRISC0_bit;
// eof MMC module connections

 sbit LCD_RS at RD0_bit;
 sbit LCD_EN at RD1_bit;
 sbit LCD_D4 at RD4_bit;
 sbit LCD_D5 at RD5_bit;
 sbit LCD_D6 at RD6_bit;
 sbit LCD_D7 at RD7_bit;
 sbit LCD_RS_Direction at TRISD0_bit;
 sbit LCD_EN_Direction at TRISD1_bit;
 sbit LCD_D4_Direction at TRISD4_bit;
 sbit LCD_D5_Direction at TRISD5_bit;
 sbit LCD_D6_Direction at TRISD6_bit;
 sbit LCD_D7_Direction at TRISD7_bit;


const LINE_LEN = 43;
char err_txt[20]       = "FAT16 not found";
char file_contents[LINE_LEN] = "XX Muestreo del dia 1\n\r";

char file_contents2[LINE_LEN]= "dia 2" ;
char file_contents1[LINE_LEN]= "mes1" ;

char           filename[14] = "XIHMAIx.TXT";          // File names
unsigned short loop, loop2;
unsigned long  i, size;
char           Buffer[512],txt;
int contador=0;



// UART1 write text and new line (carriage return + line feed)
void UART1_Write_Line(char *uart_text) {
  Lcd_Cmd(_LCD_CURSOR_OFF);
  Lcd_Cmd (_LCD_CLEAR);
  Lcd_Out(1,1,uart_text);
}

// Crea un nuevo archivo y le escribe algunos datos.
void M_Create_New_File() {
  //filename[7] = 'A';

  Mmc_Fat_Assign_B(&filename, 0xA0);          // Find existing file or create a new one
  Mmc_Fat_Rewrite_B();                        // To clear file and start with new data

  Mmc_Fat_Write_B(file_contents, LINE_LEN-1);   // write data to the assigned file

}


 // Abre un archivo existente y le agrega datos
//               (and alters the date/time stamp)
void M_Open_File_Append() {
   //filename[7] = 'A';
   Mmc_Fat_Assign_B(&filename, 0xA0);

   Mmc_Fat_Append_B();                                    // Prepare file for append
   Mmc_Fat_Write_B(file_contents2, 27);   // Write data to assigned file
    Mmc_Fat_Write_B(file_contents1, 27);
}



// Main. Uncomment the function(s) to test the desired operation(s)
void main() {
  //#define COMPLETE_EXAMPLE         // comment this line to make simpler/smaller example
  ADCON1 |= 0x0F;                  // Configure AN pins as digital
  CMCON  |= 7;                     // Turn off comparators
  
  // Initialize UART1 module
  Lcd_Init();
  Lcd_Cmd(_LCD_CURSOR_OFF);
  Lcd_Cmd (_LCD_CLEAR);
  Delay_ms(10);

  Lcd_Out(1,1,"PIC iniciado"); // PIC present report
  Delay_ms(500);
  // Initializar modulo SPI1
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

  Lcd_Out(2,1,txt);
  // use el formato rápido fat16 en lugar de la rutina init si se necesita un formateo
  if (Mmc_Fat_Init_B() == 0) {
    // reinitialize spi at higher speed
    SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
    //--- Test start
    //UART1_Write_Line("Test finalizado.");
    //--- Test routines. Uncomment them one-by-one to test certain features
      M_Create_New_File();
      while (contador <15){
      contador++;

      M_Open_File_Append();
      Lcd_Cmd (_LCD_CLEAR);
      Lcd_Out(1,1,"Wait");
      delay_ms(500);
      }


    //#endif
    UART1_Write_Line("Test finalizado.");

  }
  else {
    UART1_Write_Line(err_txt); // Note: Mmc_Fat_Init_B tries to initialize a card more than once.
                               //       If card is not present, initialization may last longer (depending on clock speed)
  }

}