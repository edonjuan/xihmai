#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
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
#line 5 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 char txt[20], errorCode;

 long double accel, cool,ok, finally;
 unsigned int buff, cofe, test ;
 signed char jugar;



 I2C1_TimeoutCallback(errorCode)
 {
 if (errorCode == _I2C_TIMEOUT_RD) {

 uart1_write_text("read problem");
 uart1_write_text("\r\n");
 }

 if (errorCode == _I2C_TIMEOUT_WR) {

 uart1_write_text("write problem");
 uart1_write_text("\r\n");
 }

 if (errorCode == _I2C_TIMEOUT_START) {

 uart1_write_text("start problem");
 uart1_write_text("\r\n");
 }

 if (errorCode == _I2C_TIMEOUT_REPEATED_START) {

 uart1_write_text("repeat start problem");
 uart1_write_text("\r\n");
 }

 }









void main()
{





 uart1_init(9600);
 I2C1_Init(100000);
 TH02Init();

 uart1_write_text("STARTING");
 uart1_write_text("\r\n");
 uart1_write_text("\r\n");



 I2C1_Start();
 delay_ms(100);
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x19);
 I2C1_Wr(0x07);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x1A);
 I2C1_Wr(0b00000000);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x6B);
 I2C1_Wr(0x01);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x1B);
 I2C1_Wr(0x00);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x1C);
 I2C1_Wr(0x00);
 I2C1_Stop();
 delay_ms(100);
#line 109 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x3A);
 I2C1_Wr(0x01);
 I2C1_Stop();
 delay_ms(100);
#line 137 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 delay_ms(100);

 while(1)
 {
 uart1_write_text("GO ON");
 uart1_write_text("\r\n");
#line 358 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x3B);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 buff = I2C1_Rd(0);
 I2C1_Stop();
 delay_ms(100);
#line 372 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x3C);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 cofe = I2C1_Rd(0);
 I2C1_Stop();
 delay_ms(100);
#line 388 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 buff=(buff<<8);
 buff=buff | cofe;
#line 398 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 finally=buff;
 finally= ((finally * 2)/16386);


 FloatToStr(finally, txt);
 uart1_write_text("ACCEL X: ");
 uart1_write_text(txt);
 uart1_write_text("°C ");
 uart1_write_text("\r\n");




 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x3D);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 buff = I2C1_Rd(0);
 I2C1_Stop();
 delay_ms(100);
#line 425 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x3E);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 cofe = I2C1_Rd(0);
 I2C1_Stop();
 delay_ms(100);
#line 441 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 buff=(buff<<8);
 buff=buff | cofe;
#line 451 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 finally=buff;
 finally= ((finally * 2)/16386);


 FloatToStr(finally, txt);
 uart1_write_text("ACCEL Y: ");
 uart1_write_text(txt);
 uart1_write_text("°C ");
 uart1_write_text("\r\n");




 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x3F);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 buff = I2C1_Rd(0);
 I2C1_Stop();
 delay_ms(10000);
#line 478 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x40);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 cofe = I2C1_Rd(0);
 I2C1_Stop();
 delay_ms(100);
#line 494 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 buff=(buff<<8);
 buff=buff | cofe;
#line 504 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 finally=buff;
 finally= ((finally * 2)/16386);


 FloatToStr(finally, txt);
 uart1_write_text("ACCEL Z: ");
 uart1_write_text(txt);
 uart1_write_text("°C ");
 uart1_write_text("\r\n");
#line 524 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 }
}
