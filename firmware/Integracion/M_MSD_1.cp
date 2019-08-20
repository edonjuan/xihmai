#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/Integracion/M_MSD_1.c"
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/integracion/libraries/th02.h"



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
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/integracion/libraries/accel.h"






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
#line 1 "c:/users/uteq/documents/github/xihmai/firmware/integracion/libraries/metodos_ds1307.h"

void Escribir(unsigned char direccion_esclavo,
 unsigned char direccion_memoria,
 unsigned char dato){
 I2C2_Start();
 I2C2_Wr(direccion_esclavo);
 I2C2_Wr(direccion_memoria);
 I2C2_Wr(dato);
 I2C2_Stop();
}

int Leer(unsigned char direccion_esclavo,
 unsigned char direccion_memoria){
 int valor;

 I2C2_Start();
 I2C2_Wr(direccion_esclavo);
 I2C2_Wr(direccion_memoria);

 I2C2_Repeated_Start();
 I2C2_Wr(direccion_esclavo+1);

 LATB.F5 = 1;
 valor=I2C2_Rd(0);
 LATB.F5 = 0;
 I2C2_Stop();
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
#line 15 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/Integracion/M_MSD_1.c"
sbit Mmc_Chip_Select at LATB3_bit;
sbit Mmc_Chip_Select_Direction at TRISB3_bit;



float temperature = 0;
float humidity = 0;
unsigned int drops = 0;
unsigned int drops_b = 0;
unsigned char i = 0;
unsigned short home = 0;
char txt[20];
int time[6];
unsigned int sec=0;
unsigned int min=0;

const LINE_LEN = 43;
char err_txt[20] = "FAT16 not found";
char file_contents[LINE_LEN] = "\n\r";

char file_contents2[LINE_LEN]= "dia 2" ;
char file_contents1[LINE_LEN]= "mes1" ;

char filename[14] = "XIHMAIx.CSV";
unsigned short loop, loop2;
unsigned long size;
char Buffer[512];





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
 M_Create_New_File();
 home = 0;
 }


 sec++;
 if(sec>=60)
 {
 sec=0;
 min++;

 if((min% (5) )==0)
 {
 temperature = getTemperature();
 floattostr(temperature, txt);
 UART1_Write_Text("TEMPERATURE: ");
 UART1_Write_Text(txt);
 uart1_write_text("°C\r\n");

 humidity = getHumidity();
 floattostr(humidity, txt);
 UART1_Write_Text("HUMEDAD: ");
 UART1_Write_Text(txt);
 uart1_write_text("%\r\n");

 UART1_Write_Text("Drops: ");
 drops = TMR0L;
 drops |= (TMR0H << 8);
 inttostr(drops, txt);
 UART1_Write_Text(txt);
 uart1_write_text("\r\n");
 TMR0L = 0;
 TMR0H = 0;


 UART1_Write_Text("Time: ");
 for(i=6; i>0; i--)
 {
 time[i] = Leer( (0xD0) ,i);
 }

 for(i=6; i>0; i--)
 {
 time[i] = Bcd2Dec(time[i]);
 UART1_Write( (time[i]/10) + 48 );
 UART1_Write( (time[i]%10) + 48 );
 UART1_Write( ':' );
 }
 min = time[1];

 M_Open_File_Append();

 uart1_write_text("\r\n");
 uart1_write_text("\r\n");
 }
 }
  (LATB.F7)  = ~  (LATB.F7) ;
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
 drops_b = drops;
  (LATB.F6)  = 1;
 delay_ms(10);
  (LATB.F6)  = 0;
 }
 delay_ms(20);
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

 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Starting Xihmai: ");
 uart1_write_text("\r\n");

 th02Init();
 Accelconfig();
}

void M_Create_New_File() {


 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 if (Mmc_Fat_Init_B() == 0) {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 UART1_Write_Text("Creating new file");
 uart1_write_text("\r\n");

 Mmc_Fat_Assign_B(&filename, 0xA0);
 Mmc_Fat_Rewrite_B();


 UART1_Write_Text("New file created");
 uart1_write_text("\r\n");
 }
 else {
 UART1_Write_Text("error creating new file");
 }
}

void M_Open_File_Append() {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 if (Mmc_Fat_Init_B() == 0) {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 UART1_Write_Text("Writing on new file");
 uart1_write_text("\r\n");

 Mmc_Fat_Assign_B(&filename, 0xA0);
 Mmc_Fat_Append_B();
 Mmc_Fat_Write_B(file_contents2, 27);
 Mmc_Fat_Write_B(file_contents1, 27);

 UART1_Write_Text("Writed!");
 uart1_write_text("\r\n");
 }
 else {
 UART1_Write_Text("error writing");
 }
}
