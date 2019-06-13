
void escribir_datos_ds1307(unsigned char direccion_esclavo,
                           unsigned char direccion_memoria,
                                    unsigned char dato){
                      I2C1_Start();
                      I2C1_Wr(direccion_esclavo);
                      I2C1_Wr(direccion_memoria);    // MEMORIA L
                      I2C1_Wr(dato); // DATO
                      I2C1_Stop();
}
int Leer_datos_ds1307(unsigned char direccion_esclavo,
                           unsigned char direccion_memoria){

                      int valor;
                      I2C1_Start();
                      I2C1_Wr(direccion_esclavo);
                      I2C1_Wr(direccion_memoria);    // MEMORIA L
                      I2C1_Repeated_Start();
                      I2C1_Wr(direccion_esclavo+1);
                      valor=I2C1_Rd(0);
                      I2C1_Stop();
                      return valor;
}

void set_datos_ds1307(int segundos,int minutos,int horas,
                      int dias, int semanas, int mes, int ano){
        int i;
        segundos = Dec2Bcd(segundos);
        minutos =  Dec2Bcd(minutos);
        horas = Dec2Bcd(horas);
        dias = Dec2Bcd(dias);
        semanas = Dec2Bcd(semanas);
        mes = Dec2Bcd(mes);
        ano = Dec2Bcd(ano);
        for(i=0; i<=6;i++){
          switch(i){
            case 0: escribir_datos_ds1307(0xD0,i,segundos); break;
            case 1: escribir_datos_ds1307(0xD0,i,minutos);  break;
            case 2: escribir_datos_ds1307(0xD0,i,horas);    break;
            case 3: escribir_datos_ds1307(0xD0,i,dias);     break;
            case 4: escribir_datos_ds1307(0xD0,i,semanas);  break;
            case 5: escribir_datos_ds1307(0xD0,i,mes);      break;
            case 6: escribir_datos_ds1307(0xD0,i,ano);      break;
          }
        }
}