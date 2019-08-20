
void Escribir(unsigned char direccion_esclavo,
                           unsigned char direccion_memoria,
                                    unsigned char dato){
                      I2C2_Start();
                      I2C2_Wr(direccion_esclavo);
                      I2C2_Wr(direccion_memoria);    // MEMORIA L
                      I2C2_Wr(dato); // DATO
                      I2C2_Stop();
}

int Leer(unsigned char direccion_esclavo,
                           unsigned char direccion_memoria){
                      int valor;

                    I2C2_Start();
                    I2C2_Wr(direccion_esclavo);
                    I2C2_Wr(direccion_memoria);    // MEMORIA L

                    I2C2_Repeated_Start();
                    I2C2_Wr(direccion_esclavo+1);
                    
                    LATB.F5 = 1;   //BLUE
                    valor=I2C2_Rd(0);
                           LATB.F5 = 0;
                    I2C2_Stop();
                    return valor;
}

void set_Fecha_hora(int segundos, int minutos, int hora,
                       int dia_semana, int dia, int mes, int ano){
    int i;
    segundos   = Dec2Bcd(segundos);
    minutos    = Dec2Bcd(minutos);
    hora       = Dec2Bcd(hora);
    dia_semana = Dec2Bcd(dia_semana);
    dia        = Dec2Bcd(dia);
    mes        = Dec2Bcd(mes);
    ano        = Dec2Bcd(ano);

    for(i=0; i<=6; i++){
        switch(i){
           case 0: Escribir(0xD0,i,segundos)  ;break;
           case 1: Escribir(0xD0,i,minutos)   ;break;
           case 2: Escribir(0xD0,i,hora)      ;break;
           case 3: Escribir(0xD0,i,dia_semana);break;
           case 4: Escribir(0xD0,i,dia)       ;break;
           case 5: Escribir(0xD0,i,mes)       ;break;
           case 6: Escribir(0xD0,i,ano)       ;break;
        }
    }
}

void Alarmas(int A1seg, int A1min, int A1hora, int A1dia,
                          int A2min, int A2hora, int A2dia, int conf){
     int t;
     A1seg =  Dec2Bcd(A1seg);
     A1min =  Dec2Bcd(A1min);
     A1hora=  Dec2Bcd(A1hora);
     A1dia =  Dec2Bcd(A1dia);
     A2min =  Dec2Bcd(A2min);
     A2hora=  Dec2Bcd(A2hora);
     A2dia =  Dec2Bcd(A2dia);
     conf  =  Dec2Bcd(conf);
     
     UART1_Write_Text("Configurando");
     UART1_Write_Text("\r\n   \r\n");
     for(t=7; t<=14; t++){
        switch (t){
           case 7: Escribir(0xD0,t,A1seg)   ;break;
           case 8: Escribir(0xD0,t,A1min)   ;break;
           case 9: Escribir(0xD0,t,A1hora)  ;break;
           case 10: Escribir(0xD0,t,A1dia)  ;break;
           case 11: Escribir(0xD0,t,A2min)  ;break;
           case 12: Escribir(0xD0,t, A2hora);break;
           case 13: Escribir(0xD0,t, A2dia) ;break;
           case 14: Escribir(0xD0,t, conf) ;break;
        }
    }
     UART1_Write_Text("finish");
     UART1_Write_Text("\r\n   \r\n");
}