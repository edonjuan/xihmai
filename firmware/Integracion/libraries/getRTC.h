#include "Metodos_DS1307.h"


void setRTC(int hr, int mi, int se, int di, int ds, int ms, int an)
{
      set_Fecha_hora(se,mi,hr,ds,di,ms,an);
}

void setAlarm(int se1, int mi1, int hr1, int di1, int mi2, int hr2, int di2, int conf)
{
      Alarmas(se1, mi1, hr1, di1, mi2, hr2, di2, conf);
}

int getRTC(void)
{

    //char txt[20];
    int hora, minutos, segundos, dia, mes, ano, dia_semana;
    //int hora=9, minutos=14, segundos=35, dia=14, mes=8, ano=19, dia_semana=3 ;
    int A1seg=15,A1min=15,A1hora=9, A1dia=2,A2min=15,A2hora=20, A2dia=0x80, conf=28;

    //set_Fecha_hora(segundos,minutos,hora,dia_semana,dia,mes,ano);
    //Alarmas  (A1seg, A1min, A1hora, A1dia, A2min, A2hora, A2dia, conf);

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
    conf       = Leer(0xD0,10);

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
    conf       = Bcd2Dec(conf);

}