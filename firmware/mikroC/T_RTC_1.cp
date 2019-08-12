#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/T_RTC_1.c"
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/mikroc/metodos_ds1307.h"


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
 valor=I2C1_Rd(0);
 I2C1_Stop();
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
 void Alarmas(int A1seg, int A1min, int A1hora, int A1dia, int A2seg,
 int A2min, int A2hora, int A2dia){
 int t;
 A1seg = Dec2Bcd(A1seg);
 A1min = Dec2Bcd(A1min);
 A1hora= Dec2Bcd(A1hora);
 A1dia = Dec2Bcd(A1dia);
 A2seg = Dec2Bcd(A2seg);
 A2min = Dec2Bcd(A2min);
 A2hora= Dec2Bcd(A2hora);
 A2dia = Dec2Bcd(A2dia);
 UART1_Write_Text("Configurando");
 UART1_Write_Text("\r\n   \r\n");
 for(t=7; t<=14; t++){
 switch (t){
 case 7: Escribir(0xD0,t,A1seg) ;break;
 case 8: Escribir(0xD0,t,A1min) ;break;
 case 9: Escribir(0xD0,t,A1hora) ;break;
 case 10: Escribir(0xD0,t,A1dia) ;break;
 case 11: Escribir(0xD0,t,A2seg) ;break;
 case 12: Escribir(0xD0,t,A2min) ;break;
 case 13: Escribir(0xD0,t, A2hora);break;
 case 14: Escribir(0xD0,t, A2dia) ;break;
 }
 }
 UART1_Write_Text("finish");
 UART1_Write_Text("\r\n   \r\n");
}
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
 humidity = (humidity/16)-24;

 return humidity;
}
#line 5 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/T_RTC_1.c"
 int tem, hum;
 char txt[20];
 int hora=14, minutos=48, segundos=00, dia=8, mes=8, ano=19, dia_semana=4 ;
 int A1seg=0x50,A1min=15,A1hora=0x80, A1dia=0x80, A2seg=0x00,A2min=0,A2hora=0, A2dia ;

void main() {
 A2dia =dia;
 th02Init();



 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Bienvenido ");


 Alarmas (A1seg, A1min, A1hora, A1dia, A2seg, A2min, A2hora, A2dia);
 while(1){
 segundos = Leer(0xD0,0);
 minutos = Leer(0xD0,1);
 hora = Leer(0xD0,2);
 dia_semana = Leer(0xD0,3);
 dia = Leer(0xD0,4);
 mes = Leer(0xD0,5);
 ano = Leer(0xD0,6);
 A1seg = Leer(0xD0,7);
 A1min = Leer(0xD0,8);
 A1hora = Leer(0xD0,9);

 segundos = Bcd2Dec(segundos);
 minutos = Bcd2Dec(minutos);
 hora = Bcd2Dec(hora);
 dia_semana = Bcd2Dec(dia_semana);
 dia = Bcd2Dec(dia);
 mes = Bcd2Dec(mes);
 ano = Bcd2Dec(ano);
 A1seg = Bcd2Dec(A1seg);
 A1min = Bcd2Dec(A1min);
 A1hora = Bcd2Dec(A1hora);


 UART1_Write_Text("HORA: ");

 UART1_Write( (hora/10) + 48 );
 UART1_Write( (hora%10) + 48 );
 UART1_Write( ':' );
 UART1_Write( (minutos/10) + 48 );
 UART1_Write( (minutos%10) + 48 );
 UART1_Write( ':' );
 UART1_Write( (segundos/10) + 48 );
 UART1_Write( (segundos%10) + 48 );

 UART1_Write_Text("    ");
 UART1_Write_Text("FECHA: ");
 UART1_Write( (dia/10) + 48 );
 UART1_Write( (dia%10) + 48 );
 UART1_Write( '-' );
 UART1_Write( (mes/10) + 48 );
 UART1_Write( (mes%10) + 48 );
 UART1_Write( '-' );
 UART1_Write( (ano/10) + 48 );
 UART1_Write( (ano%10) + 48 );

 UART1_Write_Text("    ");
 UART1_Write_Text("Alarma1: ");
 UART1_Write( (A1hora/10) + 48 );
 UART1_Write( (A1hora%10) + 48 );
 UART1_Write( ':' );
 UART1_Write( (A1min/10) + 48 );
 UART1_Write( (A1min%10) + 48 );
 UART1_Write( ':' );
 UART1_Write( (A1seg/10) + 48 );
 UART1_Write( (A1seg%10) + 48 );
 UART1_Write_Text("\r\n   \r\n");
 UART1_Write_Text("\r\n   \r\n");

 delay_ms(1000);
#line 95 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/T_RTC_1.c"
 }
}
