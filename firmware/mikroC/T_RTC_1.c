
#include "Metodos_DS1307.h"
#include "th02.h"


void main() {
        int hora, minutos, segundos, dia, mes, ano, dia_semana;
        th02Init();
        UART1_Init(9600);               // Initialize UART module at 9600 bps
        Delay_ms(100);

        I2C1_Init(100000);
        //set_Fecha_hora(segundos,minutos,hora,dia_semana,dia,mes,ano);
        while(1){
            segundos   = Leer(0xD0,0);
            minutos    = Leer(0xD0,1);
            hora       = Leer(0xD0,2);
            dia_semana = Leer(0xD0,3);
            dia        = Leer(0xD0,4);
            mes        = Leer(0xD0,5);
            ano        = Leer(0xD0,6);

            segundos   = Bcd2Dec(segundos);
            minutos    = Bcd2Dec(minutos);
            hora       = Bcd2Dec(hora);
            dia_semana = Bcd2Dec(dia_semana);
            dia        = Bcd2Dec(dia);
            mes        = Bcd2Dec(mes);
            ano        = Bcd2Dec(ano);



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