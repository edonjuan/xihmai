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


 return humidity;
}
#line 11 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/Integracion/M_TH02_1.c"
float temperature, humidity;
char txt[20];



void config (void);


void main()
{
 config();




 while(1)
 {






 temperature = getTemperature();
 inttostr(temperature, txt);




 humidity = getHumidity();
 inttostr(humidity, txt);



 delay_ms(100);




 }
}


void config (void)
{





 ANSELC=0;
 ANSELA=0;
 TRISC =0;
 TRISA =0;
#line 71 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/Integracion/M_TH02_1.c"
 th02Init();


}
