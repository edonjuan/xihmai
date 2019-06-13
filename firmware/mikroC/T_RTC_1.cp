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
 case 0: Escribir(0xD0,i,segundos); break;
 case 1: Escribir(0xD0,i,minutos); break;
 case 2: Escribir(0xD0,i,hora); break;
 case 3: Escribir(0xD0,i,dia_semana); break;
 case 4: Escribir(0xD0,i,dia); break;
 case 5: Escribir(0xD0,i,mes); break;
 case 6: Escribir(0xD0,i,ano); break;
 }
 }
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


 return humidity;
}
#line 6 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/T_RTC_1.c"
void main() {
 int hora, minutos, segundos, dia, mes, ano, dia_semana;
 th02Init();
 UART1_Init(9600);
 Delay_ms(100);

 I2C1_Init(100000);

 while(1){
 segundos = Leer(0xD0,0);
 minutos = Leer(0xD0,1);
 hora = Leer(0xD0,2);
 dia_semana = Leer(0xD0,3);
 dia = Leer(0xD0,4);
 mes = Leer(0xD0,5);
 ano = Leer(0xD0,6);

 segundos = Bcd2Dec(segundos);
 minutos = Bcd2Dec(minutos);
 hora = Bcd2Dec(hora);
 dia_semana = Bcd2Dec(dia_semana);
 dia = Bcd2Dec(dia);
 mes = Bcd2Dec(mes);
 ano = Bcd2Dec(ano);



 UART1_Write_Text("HORA: ");

 UART1_Write( (hora/10) + 48 );
 UART1_Write( (hora%10) + 48 );
 UART1_Write( ':' );
 UART1_Write( (minutos/10) + 48 );
 UART1_Write( (minutos%10) + 48 );
 UART1_Write( ':' );
 UART1_Write( (segundos/10) + 48 );
 UART1_Write( (segundos%10) + 48 );

 UART1_Write_Text("     ");
 UART1_Write_Text("Fecha: ");
 UART1_Write( (dia/10) + 48 );
 UART1_Write( (dia%10) + 48 );
 UART1_Write( '-' );
 UART1_Write( (mes/10) + 48 );
 UART1_Write( (mes%10) + 48 );
 UART1_Write( '-' );
 UART1_Write( (ano/10) + 48 );
 UART1_Write( (ano%10) + 48 );
 UART1_Write_Text("\r\n   \r\n");
 delay_ms(1000);

 }
}
