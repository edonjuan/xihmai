#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/libraries/g_SLEEP_1.c"
int compte;
char txt[20];
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/mikroc/libraries/th02.h"



void th02Init(void)
{
 I2C1_Init(100000);
 delay_ms(100);

 ADCON1=0x0F;
 INTCON2.RBPU=0;
 PORTB=0;
}

float getTemperature(void)
{
 float temperature;
 unsigned int buffer;

 I2C1_Start();
 I2C1_Wr(0x80);
 I2C1_Wr(0x03);
 I2C1_Wr(0x11);
 I2C1_Stop();

 delay_ms(80);

 I2C1_Start();
 I2C1_Wr(0x80);
 I2C1_Wr(0x01);
 I2C1_Repeated_start();
 I2C1_Wr(0x81);
 buffer = I2C1_Rd(1) << 8;
 buffer |= I2C1_Rd(0);
 I2C1_Stop();

 buffer >>= 2;
 temperature = buffer;
 temperature = (temperature/32)-50;

 return temperature;
}

float getHumidity(void)
{
 float humidity;
 unsigned int buffer;

 I2C1_Start();
 I2C1_Wr(0x80);
 I2C1_Wr(0x03);
 I2C1_Wr(0x01);
 I2C1_Stop();

 delay_ms(80);

 I2C1_Start();
 I2C1_Wr(0x80);
 I2C1_Wr(0x01);
 I2C1_Repeated_start();
 I2C1_Wr(0x81);
 buffer = I2C1_Rd(1) << 8;
 buffer |= I2C1_Rd(0);
 I2C1_Stop();

 buffer >>= 4;

 if(buffer>1984)
 humidity = 1984;
 else if(buffer<384)
 humidity = 384;
 else
 humidity = buffer;


 return humidity;
}
#line 12 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/libraries/g_SLEEP_1.c"
 char errorCode;

 long double accel, cool,ok, finally;
 unsigned int buff, cofe, test ;
 signed char jugar;
 int flag;
#line 147 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/libraries/g_SLEEP_1.c"
void main()
{



 TRISD=0;

 TRISA=0;
 TRISB=1;
 OSCCON=0x00;
 INTCON2=0x40;
 INTCON=0x00;
 INTCON=1;
 INTCON=0b00010011;

 flag = 0;
 PORTA= 0b0000010;
 while(!flag)
 {
  LATA  = ~ LATA ;
 delay_ms(300);
 }

 INTCON.TMR0IF=0;
 }
#line 182 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/libraries/g_SLEEP_1.c"
void MSdelay(unsigned int val)
{
 unsigned int i,j;
 for(i=0;i<val;i++)
 for(j=0;j<165;j++);
}
