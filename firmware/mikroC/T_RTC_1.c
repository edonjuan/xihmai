
#include "Metodos_DS1307.h"
#include "th02.h"

  int tem, hum;
  char txt[20];
  int hora=14, minutos=48, segundos=00, dia=8, mes=8, ano=19, dia_semana=4 ;
  int A1seg=0x50,A1min=15,A1hora=0x80, A1dia=0x80, A2seg=0x00,A2min=0,A2hora=0, A2dia ;

void main() {
        A2dia =dia;
        th02Init();
       // getTemperature();
       // getHumidity();

        UART1_Init(9600);               // Initialize UART module at 9600 bps
        Delay_ms(100);

        UART1_Write_Text("Bienvenido ");

        //set_Fecha_hora(segundos,minutos,hora,dia_semana,dia,mes,ano);
        Alarmas  (A1seg, A1min, A1hora, A1dia, A2seg, A2min, A2hora, A2dia);
        while(1){
            segundos   = Leer(0xD0,0);
            minutos    = Leer(0xD0,1);
            hora       = Leer(0xD0,2);
            dia_semana = Leer(0xD0,3);
            dia        = Leer(0xD0,4);
            mes        = Leer(0xD0,5);
            ano        = Leer(0xD0,6);
            A1seg      = Leer(0xD0,7);
            A1min      = Leer(0xD0,8);
            A1hora     = Leer(0xD0,9);

            segundos   = Bcd2Dec(segundos);
            minutos    = Bcd2Dec(minutos);
            hora       = Bcd2Dec(hora);
            dia_semana = Bcd2Dec(dia_semana);
            dia        = Bcd2Dec(dia);
            mes        = Bcd2Dec(mes);
            ano        = Bcd2Dec(ano);
            A1seg      = Bcd2Dec(A1seg);
            A1min      = Bcd2Dec(A1min);
            A1hora     = Bcd2Dec(A1hora);


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

       /*tem=getTemperature();
       hum=getHumidity();
        intToStr(tem,txt);
        UART1_Write_Text("temperatura:  ");
        UART1_Write_Text(txt);
         UART1_Write_Text("\r\n   \r\n");

        intToStr(hum,txt);
        UART1_Write_Text("humedad:   ");
         UART1_Write_Text(txt);
          UART1_Write_Text("\r\n   \r\n");*/
        }
}