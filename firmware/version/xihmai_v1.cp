#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/version/libraries/th02.h"



void th02Init(void)
{
 I2C2_Init(100000);
 delay_ms(100);
}

float getTemperature(void)
{
 float temperature;
 unsigned int buffer;

 I2C2_Start();
 I2C2_Wr(0x80);
 I2C2_Wr(0x03);
 I2C2_Wr(0x11);
 I2C2_Stop();

 delay_ms(80);

 I2C2_Start();
 I2C2_Wr(0x80);
 I2C2_Wr(0x01);
 I2C2_Repeated_start();
 I2C2_Wr(0x81);
 buffer = I2C2_Rd(1) << 8;
 buffer |= I2C2_Rd(0);
 I2C2_Stop();

 buffer >>= 2;
 temperature = buffer;
 temperature = (temperature/32)-50;

 return temperature;
}

float getHumidity(void)
{
 float humidity;
 unsigned int buffer;

 I2C2_Start();
 I2C2_Wr(0x80);
 I2C2_Wr(0x03);
 I2C2_Wr(0x01);
 I2C2_Stop();

 delay_ms(80);

 I2C2_Start();
 I2C2_Wr(0x80);
 I2C2_Wr(0x01);
 I2C2_Repeated_start();
 I2C2_Wr(0x81);
 buffer = I2C2_Rd(1) << 8;
 buffer |= I2C2_Rd(0);
 I2C2_Stop();

 buffer >>= 4;

 if(buffer>1984)
 humidity = 1984;
 else if(buffer<384)
 humidity = 384;
 else
 humidity = buffer;
 humidity = (humidity/16)-24;

 return humidity;
}
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/version/libraries/accel.h"






void Accelconfig(void)
{

 I2C2_Start();
 I2C2_Wr(0xD2);
 I2C2_Wr(0x19);
 I2C2_Wr(0x07);
 I2C2_Stop();
 delay_ms(100);


 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x6B);
 I2C2_Wr(0x00);
 I2C2_Stop();
 delay_ms(100);


 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x6C);
 I2C2_Wr(0x00);
 I2C2_Stop();
 delay_ms(100);


 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x1B);
 I2C2_Wr(0x00);
 I2C2_Stop();
 delay_ms(100);

 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x1C);
 I2C2_Wr(0x00);
 I2C2_Stop();
 delay_ms(100);

 I2C2_Start();
 delay_ms(100);
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x38);
 I2C2_Wr(0x40);
 I2C2_Stop();
 delay_ms(100);

 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x20);
 I2C2_Wr(0x01);
 I2C2_Stop();
 delay_ms(100);

 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x3A);
 I2C2_Wr(0x01);
 I2C2_Stop();
 delay_ms(100);


 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x1F);
 I2C2_Wr(0x01);
 I2C2_Stop();
 delay_ms(200);


 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x1A);
 I2C2_Wr(0xFF);
 I2C2_Stop();
 delay_ms(100);


 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x6C);
 I2C2_Wr(0x60);
 I2C2_Stop();
 delay_ms(100);


 I2C2_Start();
 I2C2_Wr( 0xD2 );
 I2C2_Wr(0x6B);
 I2C2_Wr(0x10);
 I2C2_Stop();
 delay_ms(100);


 delay_ms(200);
}
#line 15 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
sbit Mmc_Chip_Select at LATB3_bit;
sbit Mmc_Chip_Select_Direction at TRISB3_bit;



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
char err_txt[20] = "FAT16 not found";
char msgSD[38];


char filename[12] = "   XIMAI";
unsigned short loop, loop2;
unsigned long size;
char Buffer[512];

unsigned int filenumber;
unsigned short filenumbercen=0;
unsigned short filenumberdec=0;
unsigned short filenumberuni=0;

long goute=0;


void config (void);
void modules (void);
void M_Create_New_File(void);
void M_Open_File_Append(void);

void interrupt()
{
 if(INTCON.F1)
 {

 if(home)
 {
 modules();

 home = 0;
 sec=59;
 min= (1) -1;
#line 71 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 filename[0] = EEPROM_Read(0) + 48;
 filename[1] = EEPROM_Read(1) + 48;
 filename[2] = EEPROM_Read(2) + 48;

 filename[8] = 46;
 filename[9] = 67;
 filename[10] = 83;
 filename[11] = 86;

 filenumber = EEPROM_Read(0)*100 + EEPROM_Read(1)*10 + EEPROM_Read(2);
#line 87 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 M_Create_New_File();


 }


 sec++;
 if(sec>=60)
 {
 sec=0;
 min++;

 if((min% (1) )==0)
 {
#line 107 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 I2C2_Start();
 I2C2_Wr( (0xD0) );
 I2C2_Wr(0);
 I2C2_Repeated_Start();
 I2C2_Wr( (0xD0) +1);


 for(i=0; i<6; i++)
 {
 rtcvalue[i]=I2C2_Rd(1);
 }


 rtcvalue[i]=I2C2_Rd(0);
 I2C2_Stop();

 msgSD[0] = ((Bcd2Dec(rtcvalue[4]))/10)+48;
 msgSD[1] = ((Bcd2Dec(rtcvalue[4]))%10)+48;
 msgSD[2] = 47;
 msgSD[3] = ((Bcd2Dec(rtcvalue[5]))/10)+48;
 msgSD[4] = ((Bcd2Dec(rtcvalue[5]))%10)+48;
 msgSD[5] = 47;
 msgSD[6] = ((Bcd2Dec(rtcvalue[6]))/10)+48;
 msgSD[7] = ((Bcd2Dec(rtcvalue[6]))%10)+48;
 msgSD[8] = 32;
 msgSD[9] = ((Bcd2Dec(rtcvalue[2]))/10)+48;
 msgSD[10] = ((Bcd2Dec(rtcvalue[2]))%10)+48;
 msgSD[11]= 58;
 msgSD[12] = ((Bcd2Dec(rtcvalue[1]))/10)+48;
 msgSD[13] = ((Bcd2Dec(rtcvalue[1]))%10)+48;
 msgSD[14]= 58;
 msgSD[15] = ((Bcd2Dec(rtcvalue[0]))/10)+48;
 msgSD[16] = ((Bcd2Dec(rtcvalue[0]))%10)+48;

 msgSD[17]= 44;



 for(i=6; i>=0; i--)
 {
 rtcdata = Bcd2Dec(rtcvalue[i]);
#line 152 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 }
#line 158 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 min = Bcd2Dec(rtcvalue[1]);
 sec = Bcd2Dec(rtcvalue[0]);
#line 165 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 temperature = getTemperature();
#line 171 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 temperature=temperature*100;
 msgSD[18] = ((int)(temperature/1000)%10)+48;
 msgSD[19] = ((int)(temperature/100)%10)+48;
 msgSD[20] = 46;
 msgSD[21] =((int)(temperature/10)%10 )+48;
 msgSD[22] = ((int)(temperature/1)%10 )+48;
 msgSD[23] = 44;

 humidity = getHumidity();
#line 184 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 humidity=humidity*100;

 msgSD[24] = ((int)(humidity/1000)%10)+48;
 msgSD[25] = ((int)(humidity/100)%10)+48;
 msgSD[26] = 46;
 msgSD[27] = ((int)(humidity/10)%10 )+48;
 msgSD[28] = ((int)(humidity/1)%10 )+48;
 msgSD[29] = 44;






 drops |= (TMR0H << 8);
 longtostr(goute,txt);


 TMR0L = 0;
 TMR0H = 0;

 msgSD[30] = ((int)(goute/1000)%10)+48;
 msgSD[31] = ((int)(goute/100)%10)+48;
 msgSD[32] = ((int)(goute/10)%10 )+48;
 msgSD[33] = ((int)(goute/1)%10 )+48;
 msgSD[34] = 44;
 msgSD[35] = 13;


 goute=0;
 }
 M_Open_File_Append() ;
 }

 INTCON.F1 = 0;
 }
}


void main()
{
 config();


 while(1)
 {
 drops = TMR0L;
 drops |= (TMR0H << 8);
 if(drops_b != drops)
 {
  (LATB.F6) =1;
 delay_ms(100);
  (LATB.F6) =0;
 goute++;
 drops_b = TMR0L;
 drops_b |= (TMR0H << 8);
 }
 }
}


void config (void)
{

 ANSELA=0;
 ANSELB=0;
 ANSELC=0;


 TRISB.F7=0;
 TRISB.F6=0;
 TRISB.F5=0;


 INTCON = 0XD0;
 INTCON.F1 = 0;
 INTCON2.F6 = 0;
 TRISB.F0=1;


 T0CON = 0XA8;
 TMR0L = 0X00;
 TMR0H = 0X00;
 TRISA.F4 = 1;


 PORTA = 0;
 PORTB = 0;
 PORTC = 0;


 home = 1;
 for(i=0; i<6; i++)
 {
 time[i] = 0;
 }
}

void modules (void)
{
#line 291 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 th02Init();
 Accelconfig();
}

void M_Create_New_File() {


 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 if (Mmc_Fat_Init_B() == 0) {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
#line 311 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 Mmc_Fat_Assign_B(&filename, 0xA0);
#line 318 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 filenumber++;
 EEPROM_Write(0, (filenumber/100)%10);
 EEPROM_Write(1, (filenumber/10)%10);
 EEPROM_Write(2, (filenumber/1)%10);

 }
 else {
#line 329 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 }
}

void M_Open_File_Append() {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 if (Mmc_Fat_Init_B() == 0) {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
#line 345 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 Mmc_Fat_Assign_B(filename, 0xA0);
 Mmc_Fat_Append_B();
 Mmc_Fat_Write_B(msgSD, 36);
#line 352 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 }
 else {
  (LATB.F7) =1;
#line 357 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/version/xihmai_v1.c"
 Delay_ms(500);
  (LATB.F7) =0;
 }
}
