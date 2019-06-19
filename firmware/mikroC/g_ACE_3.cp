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
#line 7 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_3.c"
 char txt[20];

 float accel, cool,ok;
 unsigned int buff;
 char tyt[20];




void main()
{
 uart1_init(9600);
 uart1_write_text("It goes");
 uart1_write_text("\r\n");
 uart1_write_text("\r\n");

 I2C1_Init(100000);
 TH02Init();

 while(1)
 {
 cool= getHumidity ();
 uart1_write_text("humidity:");
 uart1_write_text("\r\n");
 floattostr(cool,txt);
 uart1_write_text(txt);
 uart1_write_text("\r\n");

 uart1_write_text("temperture:");
 uart1_write_text("\r\n");
 ok = getTemperature();
 floattostr(ok,txt);
 uart1_write_text(txt);
 uart1_write_text("\r\n");
 uart1_write_text("\r\n");
 delay_ms(1000);





 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x6B);
 I2C1_Wr(0x00);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x1C);
 I2C1_Wr(0x18);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x75);
 I2C1_Wr(0x68);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x42);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 uart1_write_text("Start reading1:");
 buff = I2C1_Rd(0);
 I2C1_Stop();
 delay_ms(100);

 inttostr(buff, txt);
 uart1_write_text(txt);
 uart1_write_text("\r\n");
 uart1_write_text("\r\n");


 }
}
