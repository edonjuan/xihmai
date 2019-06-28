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
#line 6 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 char txt[20];

 long double accel, cool,ok, finally;
 unsigned int buff, cofe, test ;
 signed char jugar;





void main()
{
 uart1_init(9600);
 I2C1_Init(100000);
 TH02Init();
#line 28 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
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
#line 87 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 while(1)
 {
#line 106 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x41);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 buff = I2C1_Rd(0);
 I2C1_Stop();
 delay_ms(100);




 uart1_write(buff);


 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x42);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 cofe = I2C1_Rd(0);
 I2C1_Stop();




 uart1_write(cofe);
 delay_ms(500);
 uart1_write_text("\r\n");
 uart1_write_text("\r\n");
 uart1_write_text("\r\n");


 buff=(buff<<8);
 buff=buff | cofe;
#line 150 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 buff=!buff;
 buff=(buff | (0x01));
 if(buff>=32768)
 buff= buff & (0xFFFF);

 uart1_write(buff );
 uart1_write_text("\r\n");


 intToStr(finally, txt);
 uart1_write_text("Temp final :                ");
 uart1_write_text(txt);
 uart1_write_text("°C ");
 uart1_write_text("\r\n");
 delay_ms(5000);

 ~buff;
#line 392 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 }
}
