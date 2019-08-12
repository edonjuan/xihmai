
_Escribir:

;metodos_ds1307.h,5 :: 		unsigned char dato){
;metodos_ds1307.h,6 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;metodos_ds1307.h,7 :: 		I2C1_Wr(direccion_esclavo);
	MOVF        FARG_Escribir_direccion_esclavo+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,8 :: 		I2C1_Wr(direccion_memoria);    // MEMORIA L
	MOVF        FARG_Escribir_direccion_memoria+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,9 :: 		I2C1_Wr(dato); // DATO
	MOVF        FARG_Escribir_dato+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,10 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;metodos_ds1307.h,11 :: 		}
L_end_Escribir:
	RETURN      0
; end of _Escribir

_Leer:

;metodos_ds1307.h,14 :: 		unsigned char direccion_memoria){
;metodos_ds1307.h,16 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;metodos_ds1307.h,17 :: 		I2C1_Wr(direccion_esclavo);
	MOVF        FARG_Leer_direccion_esclavo+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,18 :: 		I2C1_Wr(direccion_memoria);    // MEMORIA L
	MOVF        FARG_Leer_direccion_memoria+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,19 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;metodos_ds1307.h,20 :: 		I2C1_Wr(direccion_esclavo+1);
	MOVF        FARG_Leer_direccion_esclavo+0, 0 
	ADDLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,21 :: 		valor=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Leer_valor_L0+0 
	MOVLW       0
	MOVWF       Leer_valor_L0+1 
;metodos_ds1307.h,22 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;metodos_ds1307.h,23 :: 		return valor;
	MOVF        Leer_valor_L0+0, 0 
	MOVWF       R0 
	MOVF        Leer_valor_L0+1, 0 
	MOVWF       R1 
;metodos_ds1307.h,24 :: 		}
L_end_Leer:
	RETURN      0
; end of _Leer

_set_Fecha_hora:

;metodos_ds1307.h,27 :: 		int dia_semana, int dia, int mes, int ano){
;metodos_ds1307.h,29 :: 		segundos   = Dec2Bcd(segundos);
	MOVF        FARG_set_Fecha_hora_segundos+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_segundos+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_segundos+1 
;metodos_ds1307.h,30 :: 		minutos    = Dec2Bcd(minutos);
	MOVF        FARG_set_Fecha_hora_minutos+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_minutos+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_minutos+1 
;metodos_ds1307.h,31 :: 		hora       = Dec2Bcd(hora);
	MOVF        FARG_set_Fecha_hora_hora+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_hora+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_hora+1 
;metodos_ds1307.h,32 :: 		dia_semana = Dec2Bcd(dia_semana);
	MOVF        FARG_set_Fecha_hora_dia_semana+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_dia_semana+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_dia_semana+1 
;metodos_ds1307.h,33 :: 		dia        = Dec2Bcd(dia);
	MOVF        FARG_set_Fecha_hora_dia+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_dia+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_dia+1 
;metodos_ds1307.h,34 :: 		mes        = Dec2Bcd(mes);
	MOVF        FARG_set_Fecha_hora_mes+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_mes+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_mes+1 
;metodos_ds1307.h,35 :: 		ano        = Dec2Bcd(ano);
	MOVF        FARG_set_Fecha_hora_ano+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_ano+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_ano+1 
;metodos_ds1307.h,39 :: 		for(i=0; i<=6; i++){
	CLRF        set_Fecha_hora_i_L0+0 
	CLRF        set_Fecha_hora_i_L0+1 
L_set_Fecha_hora0:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       set_Fecha_hora_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora39
	MOVF        set_Fecha_hora_i_L0+0, 0 
	SUBLW       6
L__set_Fecha_hora39:
	BTFSS       STATUS+0, 0 
	GOTO        L_set_Fecha_hora1
;metodos_ds1307.h,40 :: 		switch(i){
	GOTO        L_set_Fecha_hora3
;metodos_ds1307.h,41 :: 		case 0: Escribir(0xD0,i,segundos)  ;break;
L_set_Fecha_hora5:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_segundos+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,42 :: 		case 1: Escribir(0xD0,i,minutos)   ;break;
L_set_Fecha_hora6:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_minutos+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,43 :: 		case 2: Escribir(0xD0,i,hora)      ;break;
L_set_Fecha_hora7:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_hora+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,44 :: 		case 3: Escribir(0xD0,i,dia_semana);break;
L_set_Fecha_hora8:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_dia_semana+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,45 :: 		case 4: Escribir(0xD0,i,dia)       ;break;
L_set_Fecha_hora9:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_dia+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,46 :: 		case 5: Escribir(0xD0,i,mes)       ;break;
L_set_Fecha_hora10:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_mes+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,47 :: 		case 6: Escribir(0xD0,i,ano)       ;break;
L_set_Fecha_hora11:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_ano+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,48 :: 		}
L_set_Fecha_hora3:
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora40
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora40:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora5
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora41
	MOVLW       1
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora41:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora6
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora42
	MOVLW       2
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora42:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora7
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora43
	MOVLW       3
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora43:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora8
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora44
	MOVLW       4
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora44:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora9
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora45
	MOVLW       5
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora45:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora10
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora46
	MOVLW       6
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora46:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora11
L_set_Fecha_hora4:
;metodos_ds1307.h,39 :: 		for(i=0; i<=6; i++){
	INFSNZ      set_Fecha_hora_i_L0+0, 1 
	INCF        set_Fecha_hora_i_L0+1, 1 
;metodos_ds1307.h,49 :: 		}
	GOTO        L_set_Fecha_hora0
L_set_Fecha_hora1:
;metodos_ds1307.h,50 :: 		}
L_end_set_Fecha_hora:
	RETURN      0
; end of _set_Fecha_hora

_Alarmas:

;metodos_ds1307.h,52 :: 		int A2min, int A2hora, int A2dia){
;metodos_ds1307.h,54 :: 		A1seg =  Dec2Bcd(A1seg);
	MOVF        FARG_Alarmas_A1seg+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A1seg+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A1seg+1 
;metodos_ds1307.h,55 :: 		A1min =  Dec2Bcd(A1min);
	MOVF        FARG_Alarmas_A1min+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A1min+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A1min+1 
;metodos_ds1307.h,56 :: 		A1hora=  Dec2Bcd(A1hora);
	MOVF        FARG_Alarmas_A1hora+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A1hora+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A1hora+1 
;metodos_ds1307.h,57 :: 		A1dia =  Dec2Bcd(A1dia);
	MOVF        FARG_Alarmas_A1dia+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A1dia+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A1dia+1 
;metodos_ds1307.h,58 :: 		A2seg =  Dec2Bcd(A2seg);
	MOVF        FARG_Alarmas_A2seg+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A2seg+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A2seg+1 
;metodos_ds1307.h,59 :: 		A2min =  Dec2Bcd(A2min);
	MOVF        FARG_Alarmas_A2min+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A2min+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A2min+1 
;metodos_ds1307.h,60 :: 		A2hora=  Dec2Bcd(A2hora);
	MOVF        FARG_Alarmas_A2hora+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A2hora+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A2hora+1 
;metodos_ds1307.h,61 :: 		A2dia =  Dec2Bcd(A2dia);
	MOVF        FARG_Alarmas_A2dia+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A2dia+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A2dia+1 
;metodos_ds1307.h,62 :: 		UART1_Write_Text("Configurando");
	MOVLW       ?lstr1_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;metodos_ds1307.h,63 :: 		UART1_Write_Text("\r\n   \r\n");
	MOVLW       ?lstr2_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;metodos_ds1307.h,64 :: 		for(t=7; t<=14; t++){
	MOVLW       7
	MOVWF       Alarmas_t_L0+0 
	MOVLW       0
	MOVWF       Alarmas_t_L0+1 
L_Alarmas12:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       Alarmas_t_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas48
	MOVF        Alarmas_t_L0+0, 0 
	SUBLW       14
L__Alarmas48:
	BTFSS       STATUS+0, 0 
	GOTO        L_Alarmas13
;metodos_ds1307.h,65 :: 		switch (t){
	GOTO        L_Alarmas15
;metodos_ds1307.h,66 :: 		case 7: Escribir(0xD0,t,A1seg)   ;break;
L_Alarmas17:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A1seg+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas16
;metodos_ds1307.h,67 :: 		case 8: Escribir(0xD0,t,A1min)   ;break;
L_Alarmas18:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A1min+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas16
;metodos_ds1307.h,68 :: 		case 9: Escribir(0xD0,t,A1hora)  ;break;
L_Alarmas19:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A1hora+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas16
;metodos_ds1307.h,69 :: 		case 10: Escribir(0xD0,t,A1dia)  ;break;
L_Alarmas20:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A1dia+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas16
;metodos_ds1307.h,70 :: 		case 11: Escribir(0xD0,t,A2seg)  ;break;
L_Alarmas21:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A2seg+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas16
;metodos_ds1307.h,71 :: 		case 12: Escribir(0xD0,t,A2min)  ;break;
L_Alarmas22:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A2min+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas16
;metodos_ds1307.h,72 :: 		case 13: Escribir(0xD0,t, A2hora);break;
L_Alarmas23:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A2hora+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas16
;metodos_ds1307.h,73 :: 		case 14: Escribir(0xD0,t, A2dia) ;break;
L_Alarmas24:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A2dia+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas16
;metodos_ds1307.h,74 :: 		}
L_Alarmas15:
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas49
	MOVLW       7
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas49:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas17
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas50
	MOVLW       8
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas50:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas18
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas51
	MOVLW       9
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas51:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas19
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas52
	MOVLW       10
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas52:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas20
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas53
	MOVLW       11
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas53:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas21
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas54
	MOVLW       12
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas54:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas22
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas55
	MOVLW       13
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas55:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas23
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas56
	MOVLW       14
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas56:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas24
L_Alarmas16:
;metodos_ds1307.h,64 :: 		for(t=7; t<=14; t++){
	INFSNZ      Alarmas_t_L0+0, 1 
	INCF        Alarmas_t_L0+1, 1 
;metodos_ds1307.h,75 :: 		}
	GOTO        L_Alarmas12
L_Alarmas13:
;metodos_ds1307.h,76 :: 		UART1_Write_Text("finish");
	MOVLW       ?lstr3_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;metodos_ds1307.h,77 :: 		UART1_Write_Text("\r\n   \r\n");
	MOVLW       ?lstr4_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;metodos_ds1307.h,78 :: 		}
L_end_Alarmas:
	RETURN      0
; end of _Alarmas

_th02Init:

;th02.h,4 :: 		void th02Init(void)
;th02.h,6 :: 		I2C1_Init(100000);         // Initialize I2C communication
	MOVLW       50
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;th02.h,7 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_th02Init25:
	DECFSZ      R13, 1, 1
	BRA         L_th02Init25
	DECFSZ      R12, 1, 1
	BRA         L_th02Init25
	DECFSZ      R11, 1, 1
	BRA         L_th02Init25
	NOP
	NOP
;th02.h,9 :: 		ADCON1=0x0F;               // PortB as digital
	MOVLW       15
	MOVWF       ADCON1+0 
;th02.h,10 :: 		INTCON2.RBPU=0;            // Pull-up resistors
	BCF         INTCON2+0, 7 
;th02.h,11 :: 		PORTB=0;                   // Clear PORTB
	CLRF        PORTB+0 
;th02.h,12 :: 		}
L_end_th02Init:
	RETURN      0
; end of _th02Init

_getTemperature:

;th02.h,14 :: 		float getTemperature(void)
;th02.h,19 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;th02.h,20 :: 		I2C1_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,21 :: 		I2C1_Wr(0x03);                // Address Pointer
	MOVLW       3
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,22 :: 		I2C1_Wr(0x11);                // Register Data
	MOVLW       17
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,23 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;th02.h,25 :: 		delay_ms(80);                 // Conversion time (MAX = 40ms)
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_getTemperature26:
	DECFSZ      R13, 1, 1
	BRA         L_getTemperature26
	DECFSZ      R12, 1, 1
	BRA         L_getTemperature26
	DECFSZ      R11, 1, 1
	BRA         L_getTemperature26
;th02.h,27 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;th02.h,28 :: 		I2C1_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,29 :: 		I2C1_Wr(0x01);                // Address Pointer
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,30 :: 		I2C1_Repeated_start();
	CALL        _I2C1_Repeated_Start+0, 0
;th02.h,31 :: 		I2C1_Wr(0x81);                // Address Device + Read
	MOVLW       129
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,32 :: 		buffer =  I2C1_Rd(1) << 8;
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       getTemperature_buffer_L0+1 
	CLRF        getTemperature_buffer_L0+0 
;th02.h,33 :: 		buffer |=  I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       getTemperature_buffer_L0+0, 1 
	MOVLW       0
	IORWF       getTemperature_buffer_L0+1, 1 
;th02.h,34 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;th02.h,36 :: 		buffer >>= 2;                 // Equation from data sheet
	MOVF        getTemperature_buffer_L0+0, 0 
	MOVWF       R0 
	MOVF        getTemperature_buffer_L0+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	MOVWF       getTemperature_buffer_L0+0 
	MOVF        R1, 0 
	MOVWF       getTemperature_buffer_L0+1 
;th02.h,37 :: 		temperature = buffer;
	CALL        _word2double+0, 0
;th02.h,38 :: 		temperature = (temperature/32)-50;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
;th02.h,40 :: 		return temperature;
;th02.h,41 :: 		}
L_end_getTemperature:
	RETURN      0
; end of _getTemperature

_getHumidity:

;th02.h,43 :: 		float getHumidity(void)
;th02.h,48 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;th02.h,49 :: 		I2C1_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,50 :: 		I2C1_Wr(0x03);                // Address Pointer
	MOVLW       3
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,51 :: 		I2C1_Wr(0x01);                // Register Data
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,52 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;th02.h,54 :: 		delay_ms(80);                 // Conversion time (MAX = 40ms)
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_getHumidity27:
	DECFSZ      R13, 1, 1
	BRA         L_getHumidity27
	DECFSZ      R12, 1, 1
	BRA         L_getHumidity27
	DECFSZ      R11, 1, 1
	BRA         L_getHumidity27
;th02.h,56 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;th02.h,57 :: 		I2C1_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,58 :: 		I2C1_Wr(0x01);                // Address Pointer
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,59 :: 		I2C1_Repeated_start();
	CALL        _I2C1_Repeated_Start+0, 0
;th02.h,60 :: 		I2C1_Wr(0x81);                // Address Device + Read
	MOVLW       129
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,61 :: 		buffer =  I2C1_Rd(1) << 8;
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       getHumidity_buffer_L0+1 
	CLRF        getHumidity_buffer_L0+0 
;th02.h,62 :: 		buffer |=  I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       getHumidity_buffer_L0+0, 1 
	MOVLW       0
	IORWF       getHumidity_buffer_L0+1, 1 
;th02.h,63 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;th02.h,65 :: 		buffer >>= 4;                 // Equation from data sheet
	MOVF        getHumidity_buffer_L0+0, 0 
	MOVWF       R1 
	MOVF        getHumidity_buffer_L0+1, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	MOVF        R1, 0 
	MOVWF       getHumidity_buffer_L0+0 
	MOVF        R2, 0 
	MOVWF       getHumidity_buffer_L0+1 
;th02.h,67 :: 		if(buffer>1984)
	MOVF        R2, 0 
	SUBLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__getHumidity60
	MOVF        R1, 0 
	SUBLW       192
L__getHumidity60:
	BTFSC       STATUS+0, 0 
	GOTO        L_getHumidity28
;th02.h,68 :: 		humidity = 1984;
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+0 
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+1 
	MOVLW       120
	MOVWF       getHumidity_humidity_L0+2 
	MOVLW       137
	MOVWF       getHumidity_humidity_L0+3 
	GOTO        L_getHumidity29
L_getHumidity28:
;th02.h,69 :: 		else if(buffer<384)
	MOVLW       1
	SUBWF       getHumidity_buffer_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getHumidity61
	MOVLW       128
	SUBWF       getHumidity_buffer_L0+0, 0 
L__getHumidity61:
	BTFSC       STATUS+0, 0 
	GOTO        L_getHumidity30
;th02.h,70 :: 		humidity = 384;
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+0 
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+1 
	MOVLW       64
	MOVWF       getHumidity_humidity_L0+2 
	MOVLW       135
	MOVWF       getHumidity_humidity_L0+3 
	GOTO        L_getHumidity31
L_getHumidity30:
;th02.h,72 :: 		humidity = buffer;
	MOVF        getHumidity_buffer_L0+0, 0 
	MOVWF       R0 
	MOVF        getHumidity_buffer_L0+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       getHumidity_humidity_L0+0 
	MOVF        R1, 0 
	MOVWF       getHumidity_humidity_L0+1 
	MOVF        R2, 0 
	MOVWF       getHumidity_humidity_L0+2 
	MOVF        R3, 0 
	MOVWF       getHumidity_humidity_L0+3 
L_getHumidity31:
L_getHumidity29:
;th02.h,73 :: 		humidity = (humidity/16)-24;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        getHumidity_humidity_L0+0, 0 
	MOVWF       R0 
	MOVF        getHumidity_humidity_L0+1, 0 
	MOVWF       R1 
	MOVF        getHumidity_humidity_L0+2, 0 
	MOVWF       R2 
	MOVF        getHumidity_humidity_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       64
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       getHumidity_humidity_L0+0 
	MOVF        R1, 0 
	MOVWF       getHumidity_humidity_L0+1 
	MOVF        R2, 0 
	MOVWF       getHumidity_humidity_L0+2 
	MOVF        R3, 0 
	MOVWF       getHumidity_humidity_L0+3 
;th02.h,75 :: 		return humidity;
;th02.h,76 :: 		}
L_end_getHumidity:
	RETURN      0
; end of _getHumidity

_main:

;T_RTC_1.c,10 :: 		void main() {
;T_RTC_1.c,11 :: 		A2dia =dia;
	MOVF        _dia+0, 0 
	MOVWF       _A2dia+0 
	MOVF        _dia+1, 0 
	MOVWF       _A2dia+1 
;T_RTC_1.c,12 :: 		th02Init();
	CALL        _th02Init+0, 0
;T_RTC_1.c,16 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;T_RTC_1.c,17 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main32:
	DECFSZ      R13, 1, 1
	BRA         L_main32
	DECFSZ      R12, 1, 1
	BRA         L_main32
	DECFSZ      R11, 1, 1
	BRA         L_main32
	NOP
	NOP
;T_RTC_1.c,19 :: 		UART1_Write_Text("Bienvenido ");
	MOVLW       ?lstr5_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,22 :: 		Alarmas  (A1seg, A1min, A1hora, A1dia, A2seg, A2min, A2hora, A2dia);
	MOVF        _A1seg+0, 0 
	MOVWF       FARG_Alarmas_A1seg+0 
	MOVF        _A1seg+1, 0 
	MOVWF       FARG_Alarmas_A1seg+1 
	MOVF        _A1min+0, 0 
	MOVWF       FARG_Alarmas_A1min+0 
	MOVF        _A1min+1, 0 
	MOVWF       FARG_Alarmas_A1min+1 
	MOVF        _A1hora+0, 0 
	MOVWF       FARG_Alarmas_A1hora+0 
	MOVF        _A1hora+1, 0 
	MOVWF       FARG_Alarmas_A1hora+1 
	MOVF        _A1dia+0, 0 
	MOVWF       FARG_Alarmas_A1dia+0 
	MOVF        _A1dia+1, 0 
	MOVWF       FARG_Alarmas_A1dia+1 
	MOVF        _A2seg+0, 0 
	MOVWF       FARG_Alarmas_A2seg+0 
	MOVF        _A2seg+1, 0 
	MOVWF       FARG_Alarmas_A2seg+1 
	MOVF        _A2min+0, 0 
	MOVWF       FARG_Alarmas_A2min+0 
	MOVF        _A2min+1, 0 
	MOVWF       FARG_Alarmas_A2min+1 
	MOVF        _A2hora+0, 0 
	MOVWF       FARG_Alarmas_A2hora+0 
	MOVF        _A2hora+1, 0 
	MOVWF       FARG_Alarmas_A2hora+1 
	MOVF        _A2dia+0, 0 
	MOVWF       FARG_Alarmas_A2dia+0 
	MOVF        _A2dia+1, 0 
	MOVWF       FARG_Alarmas_A2dia+1 
	CALL        _Alarmas+0, 0
;T_RTC_1.c,23 :: 		while(1){
L_main33:
;T_RTC_1.c,24 :: 		segundos   = Leer(0xD0,0);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	CLRF        FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _segundos+0 
	MOVF        R1, 0 
	MOVWF       _segundos+1 
;T_RTC_1.c,25 :: 		minutos    = Leer(0xD0,1);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       1
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _minutos+0 
	MOVF        R1, 0 
	MOVWF       _minutos+1 
;T_RTC_1.c,26 :: 		hora       = Leer(0xD0,2);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       2
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _hora+0 
	MOVF        R1, 0 
	MOVWF       _hora+1 
;T_RTC_1.c,27 :: 		dia_semana = Leer(0xD0,3);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       3
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _dia_semana+0 
	MOVF        R1, 0 
	MOVWF       _dia_semana+1 
;T_RTC_1.c,28 :: 		dia        = Leer(0xD0,4);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       4
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _dia+0 
	MOVF        R1, 0 
	MOVWF       _dia+1 
;T_RTC_1.c,29 :: 		mes        = Leer(0xD0,5);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       5
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _mes+0 
	MOVF        R1, 0 
	MOVWF       _mes+1 
;T_RTC_1.c,30 :: 		ano        = Leer(0xD0,6);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       6
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _ano+0 
	MOVF        R1, 0 
	MOVWF       _ano+1 
;T_RTC_1.c,31 :: 		A1seg      = Leer(0xD0,7);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       7
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _A1seg+0 
	MOVF        R1, 0 
	MOVWF       _A1seg+1 
;T_RTC_1.c,32 :: 		A1min      = Leer(0xD0,8);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       8
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _A1min+0 
	MOVF        R1, 0 
	MOVWF       _A1min+1 
;T_RTC_1.c,33 :: 		A1hora     = Leer(0xD0,9);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       9
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _A1hora+0 
	MOVF        R1, 0 
	MOVWF       _A1hora+1 
;T_RTC_1.c,35 :: 		segundos   = Bcd2Dec(segundos);
	MOVF        _segundos+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _segundos+0 
	MOVLW       0
	MOVWF       _segundos+1 
;T_RTC_1.c,36 :: 		minutos    = Bcd2Dec(minutos);
	MOVF        _minutos+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _minutos+0 
	MOVLW       0
	MOVWF       _minutos+1 
;T_RTC_1.c,37 :: 		hora       = Bcd2Dec(hora);
	MOVF        _hora+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _hora+0 
	MOVLW       0
	MOVWF       _hora+1 
;T_RTC_1.c,38 :: 		dia_semana = Bcd2Dec(dia_semana);
	MOVF        _dia_semana+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _dia_semana+0 
	MOVLW       0
	MOVWF       _dia_semana+1 
;T_RTC_1.c,39 :: 		dia        = Bcd2Dec(dia);
	MOVF        _dia+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _dia+0 
	MOVLW       0
	MOVWF       _dia+1 
;T_RTC_1.c,40 :: 		mes        = Bcd2Dec(mes);
	MOVF        _mes+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _mes+0 
	MOVLW       0
	MOVWF       _mes+1 
;T_RTC_1.c,41 :: 		ano        = Bcd2Dec(ano);
	MOVF        _ano+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _ano+0 
	MOVLW       0
	MOVWF       _ano+1 
;T_RTC_1.c,42 :: 		A1seg      = Bcd2Dec(A1seg);
	MOVF        _A1seg+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _A1seg+0 
	MOVLW       0
	MOVWF       _A1seg+1 
;T_RTC_1.c,43 :: 		A1min      = Bcd2Dec(A1min);
	MOVF        _A1min+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _A1min+0 
	MOVLW       0
	MOVWF       _A1min+1 
;T_RTC_1.c,44 :: 		A1hora     = Bcd2Dec(A1hora);
	MOVF        _A1hora+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _A1hora+0 
	MOVLW       0
	MOVWF       _A1hora+1 
;T_RTC_1.c,47 :: 		UART1_Write_Text("HORA: ");
	MOVLW       ?lstr6_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,49 :: 		UART1_Write( (hora/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _hora+0, 0 
	MOVWF       R0 
	MOVF        _hora+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,50 :: 		UART1_Write( (hora%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _hora+0, 0 
	MOVWF       R0 
	MOVF        _hora+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,51 :: 		UART1_Write( ':' );
	MOVLW       58
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,52 :: 		UART1_Write( (minutos/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _minutos+0, 0 
	MOVWF       R0 
	MOVF        _minutos+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,53 :: 		UART1_Write( (minutos%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _minutos+0, 0 
	MOVWF       R0 
	MOVF        _minutos+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,54 :: 		UART1_Write( ':' );
	MOVLW       58
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,55 :: 		UART1_Write( (segundos/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _segundos+0, 0 
	MOVWF       R0 
	MOVF        _segundos+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,56 :: 		UART1_Write( (segundos%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _segundos+0, 0 
	MOVWF       R0 
	MOVF        _segundos+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,58 :: 		UART1_Write_Text("    ");
	MOVLW       ?lstr7_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,59 :: 		UART1_Write_Text("FECHA: ");
	MOVLW       ?lstr8_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,60 :: 		UART1_Write( (dia/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _dia+0, 0 
	MOVWF       R0 
	MOVF        _dia+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,61 :: 		UART1_Write( (dia%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _dia+0, 0 
	MOVWF       R0 
	MOVF        _dia+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,62 :: 		UART1_Write( '-' );
	MOVLW       45
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,63 :: 		UART1_Write( (mes/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _mes+0, 0 
	MOVWF       R0 
	MOVF        _mes+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,64 :: 		UART1_Write( (mes%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _mes+0, 0 
	MOVWF       R0 
	MOVF        _mes+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,65 :: 		UART1_Write( '-' );
	MOVLW       45
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,66 :: 		UART1_Write( (ano/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _ano+0, 0 
	MOVWF       R0 
	MOVF        _ano+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,67 :: 		UART1_Write( (ano%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _ano+0, 0 
	MOVWF       R0 
	MOVF        _ano+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,69 :: 		UART1_Write_Text("    ");
	MOVLW       ?lstr9_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,70 :: 		UART1_Write_Text("Alarma1: ");
	MOVLW       ?lstr10_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,71 :: 		UART1_Write( (A1hora/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _A1hora+0, 0 
	MOVWF       R0 
	MOVF        _A1hora+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,72 :: 		UART1_Write( (A1hora%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _A1hora+0, 0 
	MOVWF       R0 
	MOVF        _A1hora+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,73 :: 		UART1_Write( ':' );
	MOVLW       58
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,74 :: 		UART1_Write( (A1min/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _A1min+0, 0 
	MOVWF       R0 
	MOVF        _A1min+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,75 :: 		UART1_Write( (A1min%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _A1min+0, 0 
	MOVWF       R0 
	MOVF        _A1min+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,76 :: 		UART1_Write( ':' );
	MOVLW       58
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,77 :: 		UART1_Write( (A1seg/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _A1seg+0, 0 
	MOVWF       R0 
	MOVF        _A1seg+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,78 :: 		UART1_Write( (A1seg%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _A1seg+0, 0 
	MOVWF       R0 
	MOVF        _A1seg+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,79 :: 		UART1_Write_Text("\r\n   \r\n");
	MOVLW       ?lstr11_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,80 :: 		UART1_Write_Text("\r\n   \r\n");
	MOVLW       ?lstr12_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,82 :: 		delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main35:
	DECFSZ      R13, 1, 1
	BRA         L_main35
	DECFSZ      R12, 1, 1
	BRA         L_main35
	DECFSZ      R11, 1, 1
	BRA         L_main35
	NOP
;T_RTC_1.c,95 :: 		}
	GOTO        L_main33
;T_RTC_1.c,96 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
