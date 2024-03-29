#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/Integracion/M_TH02_1.c"
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/integracion/libraries/th02.h"



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
 humidity = (humidity/16)-24;

 return humidity;
}
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/integracion/libraries/accel.h"






void Accelconfig(void)
{

 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(0x19);
 I2C1_Wr(0x07);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x6B);
 I2C1_Wr(0x00);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x6C);
 I2C1_Wr(0x00);
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

 I2C1_Start();
 delay_ms(100);
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x38);
 I2C1_Wr(0x40);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x20);
 I2C1_Wr(0x01);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x3A);
 I2C1_Wr(0x01);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x1F);
 I2C1_Wr(0x01);
 I2C1_Stop();
 delay_ms(200);


 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x1A);
 I2C1_Wr(0xFF);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x6C);
 I2C1_Wr(0x60);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(0x6B);
 I2C1_Wr(0x10);
 I2C1_Stop();
 delay_ms(100);


 delay_ms(200);
}
#line 12 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/Integracion/M_TH02_1.c"
float temperature, humidity;

unsigned int drops;
char txt[20];


void config (void);


void main()
{
 config();


 while(1)
 {


 temperature = getTemperature();
 floattostr(temperature, txt);
 UART1_Write_Text("TEMPERATURE: ");
 UART1_Write_Text(txt);
 uart1_write_text("�C\r\n");

 humidity = getHumidity();
 floattostr(humidity, txt);
 UART1_Write_Text("HUMEDAD: ");
 UART1_Write_Text(txt);
 uart1_write_text("%\r\n");

 delay_ms(1000);

 UART1_Write_Text("Drops: ");
 drops = TMR0L;
 drops |= (TMR0H << 8);
 inttostr(drops, txt);
 UART1_Write_Text(txt);
 uart1_write_text("\r\n");
 uart1_write_text("\r\n");
 delay_ms(400);
 }
}


void config (void)
{






 T0CON = 0XA8;
 TMR0L = 0X00;
 TMR0H = 0X00;
 TRISA.F4 = 1;

 ANSELC=0;
 ANSELA=0;
 TRISC =0;
 TRISA =0;


 UART1_Init(9600);
 Delay_ms(100);

 th02Init();
 Accelconfig();


}
