#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/T_sd_1/MMC_Fat16_Test.c"

sbit Mmc_Chip_Select at LATC0_bit;
sbit Mmc_Chip_Select_Direction at TRISC0_bit;


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
char err_txt[20] = "FAT16 not found";
char file_contents[LINE_LEN] = "XX Muestreo del dia 1\n\r";

char file_contents2[LINE_LEN]= "dia 2" ;
char file_contents1[LINE_LEN]= "mes1" ;

char filename[14] = "XIHMAIx.TXT";
unsigned short loop, loop2;
unsigned long i, size;
char Buffer[512],txt;
int contador=0;




void UART1_Write_Line(char *uart_text) {
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd (_LCD_CLEAR);
 Lcd_Out(1,1,uart_text);
}


void M_Create_New_File() {


 Mmc_Fat_Assign_B(&filename, 0xA0);
 Mmc_Fat_Rewrite_B();

 Mmc_Fat_Write_B(file_contents, LINE_LEN-1);

}




void M_Open_File_Append() {

 Mmc_Fat_Assign_B(&filename, 0xA0);

 Mmc_Fat_Append_B();
 Mmc_Fat_Write_B(file_contents2, 27);
 Mmc_Fat_Write_B(file_contents1, 27);
}




void main() {

 ADCON1 |= 0x0F;
 CMCON |= 7;


 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd (_LCD_CLEAR);
 Delay_ms(10);

 Lcd_Out(1,1,"PIC iniciado");
 Delay_ms(500);

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 Lcd_Out(2,1,txt);

 if (Mmc_Fat_Init_B() == 0) {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);



 M_Create_New_File();
 while (contador <15){
 contador++;

 M_Open_File_Append();
 Lcd_Cmd (_LCD_CLEAR);
 Lcd_Out(1,1,"Wait");
 delay_ms(500);
 }



 UART1_Write_Line("Test finalizado.");

 }
 else {
 UART1_Write_Line(err_txt);

 }

}
