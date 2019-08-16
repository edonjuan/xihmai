#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/Integracion/M_RGB_1.c"
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
 I2C1_Wr(0xD2);
 I2C1_Wr(0x19);
 I2C1_Wr(0x07);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x6B);
 I2C1_Wr(0x00);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x6C);
 I2C1_Wr(0x00);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x1B);
 I2C1_Wr(0x00);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x1C);
 I2C1_Wr(0x00);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 delay_ms(100);
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x38);
 I2C1_Wr(0x40);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x20);
 I2C1_Wr(0x01);
 I2C1_Stop();
 delay_ms(100);

 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x3A);
 I2C1_Wr(0x01);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x1F);
 I2C1_Wr(0x01);
 I2C1_Stop();
 delay_ms(200);


 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x1A);
 I2C1_Wr(0xFF);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x6C);
 I2C1_Wr(0x60);
 I2C1_Stop();
 delay_ms(100);


 I2C1_Start();
 I2C1_Wr( 0xD2 );
 I2C1_Wr(0x6B);
 I2C1_Wr(0x10);
 I2C1_Stop();
 delay_ms(100);


 delay_ms(200);
}
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/integracion/libraries/metodos_ds1307.h"

void Escribir(unsigned char direccion_esclavo,
 unsigned char direccion_memoria,
 unsigned char dato){
 I2C1_Start();
 I2C1_Wr(direccion_esclavo);
 I2C1_Wr(direccion_memoria);
 I2C1_Wr(dato);
 I2C1_Stop();
}

int Leer(unsigned char direccion_esclavo,
 unsigned char direccion_memoria){
 int valor;

 I2C1_Start();
 I2C1_Wr(direccion_esclavo);
 I2C1_Wr(direccion_memoria);

 I2C1_Repeated_Start();
 I2C1_Wr(direccion_esclavo+1);


 delay_ms(200);
 LATB.F5 = 1;
 valor=I2C1_Rd(0);
 LATB.F5 = 0;
 I2C1_Stop();

 delay_ms(200);

 return valor;
}

void set_Fecha_hora(int segundos, int minutos, int hora,
 int dia_semana, int dia, int mes, int ano){
 int i;
 segundos = Dec2Bcd(segundos);
 minutos = Dec2Bcd(minutos);
 hora = Dec2Bcd(hora);
 dia_semana = Dec2Bcd(dia_semana);
 dia = Dec2Bcd(dia);
 mes = Dec2Bcd(mes);
 ano = Dec2Bcd(ano);

 for(i=0; i<=6; i++){
 switch(i){
 case 0: Escribir(0xD0,i,segundos) ;break;
 case 1: Escribir(0xD0,i,minutos) ;break;
 case 2: Escribir(0xD0,i,hora) ;break;
 case 3: Escribir(0xD0,i,dia_semana);break;
 case 4: Escribir(0xD0,i,dia) ;break;
 case 5: Escribir(0xD0,i,mes) ;break;
 case 6: Escribir(0xD0,i,ano) ;break;
 }
 }
}

void Alarmas(int A1seg, int A1min, int A1hora, int A1dia,
 int A2min, int A2hora, int A2dia, int conf){
 int t;
 A1seg = Dec2Bcd(A1seg);
 A1min = Dec2Bcd(A1min);
 A1hora= Dec2Bcd(A1hora);
 A1dia = Dec2Bcd(A1dia);
 A2min = Dec2Bcd(A2min);
 A2hora= Dec2Bcd(A2hora);
 A2dia = Dec2Bcd(A2dia);
 conf = Dec2Bcd(conf);

 UART1_Write_Text("Configurando");
 UART1_Write_Text("\r\n   \r\n");
 for(t=7; t<=14; t++){
 switch (t){
 case 7: Escribir(0xD0,t,A1seg) ;break;
 case 8: Escribir(0xD0,t,A1min) ;break;
 case 9: Escribir(0xD0,t,A1hora) ;break;
 case 10: Escribir(0xD0,t,A1dia) ;break;
 case 11: Escribir(0xD0,t,A2min) ;break;
 case 12: Escribir(0xD0,t, A2hora);break;
 case 13: Escribir(0xD0,t, A2dia) ;break;
 case 14: Escribir(0xD0,t, conf) ;break;
 }
 }
 UART1_Write_Text("finish");
 UART1_Write_Text("\r\n   \r\n");
}
#line 16 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/Integracion/M_RGB_1.c"
float temperature, humidity;

unsigned int drops;
unsigned char i;
char txt[20];

int time;


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
 uart1_write_text("°C\r\n");


 delay_ms(500);


 humidity = getHumidity();
 floattostr(humidity, txt);
 UART1_Write_Text("HUMEDAD: ");
 UART1_Write_Text(txt);
 uart1_write_text("%\r\n");



 delay_ms(500);


 UART1_Write_Text("Drops: ");
 drops = TMR0L;
 drops |= (TMR0H << 8);
 inttostr(drops, txt);
 UART1_Write_Text(txt);
 uart1_write_text("\r\n");



 delay_ms(500);



 UART1_Write_Text("Time: ");
 for(i=1; i<=6; i++)
 {
 time = Leer( (0xD0) ,i);

 time = Bcd2Dec(time);
 UART1_Write( (time/10) + 48 );
 UART1_Write( (time%10) + 48 );
 UART1_Write( ':' );
 }

 uart1_write_text("\r\n");
 uart1_write_text("\r\n");
 }
}


void config (void)
{


 TRISB.F7=0;
 TRISB.F6=0;
 TRISB.F5=0;


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

 UART1_Write_Text("Configuration init: ");
 uart1_write_text("\r\n");


 th02Init();
 Accelconfig();

}
