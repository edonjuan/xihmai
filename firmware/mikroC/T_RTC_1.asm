
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
;metodos_ds1307.h,29 :: 		segundos = Dec2Bcd(segundos);
	MOVF        FARG_set_Fecha_hora_segundos+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_segundos+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_segundos+1 
;metodos_ds1307.h,30 :: 		minutos = Dec2Bcd(minutos);
	MOVF        FARG_set_Fecha_hora_minutos+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_minutos+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_minutos+1 
;metodos_ds1307.h,31 :: 		hora = Dec2Bcd(hora);
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
;metodos_ds1307.h,33 :: 		dia = Dec2Bcd(dia);
	MOVF        FARG_set_Fecha_hora_dia+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_dia+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_dia+1 
;metodos_ds1307.h,34 :: 		mes = Dec2Bcd(mes);
	MOVF        FARG_set_Fecha_hora_mes+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_mes+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_mes+1 
;metodos_ds1307.h,35 :: 		ano = Dec2Bcd(ano);
	MOVF        FARG_set_Fecha_hora_ano+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_ano+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_ano+1 
;metodos_ds1307.h,37 :: 		for(i=0; i<=6; i++){
	CLRF        set_Fecha_hora_i_L0+0 
	CLRF        set_Fecha_hora_i_L0+1 
L_set_Fecha_hora0:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       set_Fecha_hora_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora26
	MOVF        set_Fecha_hora_i_L0+0, 0 
	SUBLW       6
L__set_Fecha_hora26:
	BTFSS       STATUS+0, 0 
	GOTO        L_set_Fecha_hora1
;metodos_ds1307.h,38 :: 		switch(i){
	GOTO        L_set_Fecha_hora3
;metodos_ds1307.h,39 :: 		case 0: Escribir(0xD0,i,segundos); break;
L_set_Fecha_hora5:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_segundos+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,40 :: 		case 1: Escribir(0xD0,i,minutos); break;
L_set_Fecha_hora6:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_minutos+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,41 :: 		case 2: Escribir(0xD0,i,hora); break;
L_set_Fecha_hora7:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_hora+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,42 :: 		case 3: Escribir(0xD0,i,dia_semana); break;
L_set_Fecha_hora8:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_dia_semana+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,43 :: 		case 4: Escribir(0xD0,i,dia); break;
L_set_Fecha_hora9:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_dia+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,44 :: 		case 5: Escribir(0xD0,i,mes); break;
L_set_Fecha_hora10:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_mes+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,45 :: 		case 6: Escribir(0xD0,i,ano); break;
L_set_Fecha_hora11:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_ano+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora4
;metodos_ds1307.h,46 :: 		}
L_set_Fecha_hora3:
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora27
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora27:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora5
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora28
	MOVLW       1
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora28:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora6
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora29
	MOVLW       2
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora29:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora7
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora30
	MOVLW       3
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora30:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora8
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora31
	MOVLW       4
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora31:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora9
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora32
	MOVLW       5
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora32:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora10
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora33
	MOVLW       6
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora33:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora11
L_set_Fecha_hora4:
;metodos_ds1307.h,37 :: 		for(i=0; i<=6; i++){
	INFSNZ      set_Fecha_hora_i_L0+0, 1 
	INCF        set_Fecha_hora_i_L0+1, 1 
;metodos_ds1307.h,47 :: 		}
	GOTO        L_set_Fecha_hora0
L_set_Fecha_hora1:
;metodos_ds1307.h,48 :: 		}
L_end_set_Fecha_hora:
	RETURN      0
; end of _set_Fecha_hora

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
L_th02Init12:
	DECFSZ      R13, 1, 1
	BRA         L_th02Init12
	DECFSZ      R12, 1, 1
	BRA         L_th02Init12
	DECFSZ      R11, 1, 1
	BRA         L_th02Init12
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
L_getTemperature13:
	DECFSZ      R13, 1, 1
	BRA         L_getTemperature13
	DECFSZ      R12, 1, 1
	BRA         L_getTemperature13
	DECFSZ      R11, 1, 1
	BRA         L_getTemperature13
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
L_getHumidity14:
	DECFSZ      R13, 1, 1
	BRA         L_getHumidity14
	DECFSZ      R12, 1, 1
	BRA         L_getHumidity14
	DECFSZ      R11, 1, 1
	BRA         L_getHumidity14
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
	GOTO        L__getHumidity37
	MOVF        R1, 0 
	SUBLW       192
L__getHumidity37:
	BTFSC       STATUS+0, 0 
	GOTO        L_getHumidity15
;th02.h,68 :: 		humidity = 1984;
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+0 
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+1 
	MOVLW       120
	MOVWF       getHumidity_humidity_L0+2 
	MOVLW       137
	MOVWF       getHumidity_humidity_L0+3 
	GOTO        L_getHumidity16
L_getHumidity15:
;th02.h,69 :: 		else if(buffer<384)
	MOVLW       1
	SUBWF       getHumidity_buffer_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getHumidity38
	MOVLW       128
	SUBWF       getHumidity_buffer_L0+0, 0 
L__getHumidity38:
	BTFSC       STATUS+0, 0 
	GOTO        L_getHumidity17
;th02.h,70 :: 		humidity = 384;
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+0 
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+1 
	MOVLW       64
	MOVWF       getHumidity_humidity_L0+2 
	MOVLW       135
	MOVWF       getHumidity_humidity_L0+3 
	GOTO        L_getHumidity18
L_getHumidity17:
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
L_getHumidity18:
L_getHumidity16:
;th02.h,75 :: 		return humidity;
	MOVF        getHumidity_humidity_L0+0, 0 
	MOVWF       R0 
	MOVF        getHumidity_humidity_L0+1, 0 
	MOVWF       R1 
	MOVF        getHumidity_humidity_L0+2, 0 
	MOVWF       R2 
	MOVF        getHumidity_humidity_L0+3, 0 
	MOVWF       R3 
;th02.h,76 :: 		}
L_end_getHumidity:
	RETURN      0
; end of _getHumidity

_main:

;T_RTC_1.c,6 :: 		void main() {
;T_RTC_1.c,8 :: 		th02Init();
	CALL        _th02Init+0, 0
;T_RTC_1.c,9 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;T_RTC_1.c,10 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main19:
	DECFSZ      R13, 1, 1
	BRA         L_main19
	DECFSZ      R12, 1, 1
	BRA         L_main19
	DECFSZ      R11, 1, 1
	BRA         L_main19
	NOP
	NOP
;T_RTC_1.c,12 :: 		I2C1_Init(100000);
	MOVLW       50
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;T_RTC_1.c,14 :: 		while(1){
L_main20:
;T_RTC_1.c,15 :: 		segundos   = Leer(0xD0,0);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	CLRF        FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       main_segundos_L0+0 
	MOVF        R1, 0 
	MOVWF       main_segundos_L0+1 
;T_RTC_1.c,16 :: 		minutos    = Leer(0xD0,1);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       1
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       main_minutos_L0+0 
	MOVF        R1, 0 
	MOVWF       main_minutos_L0+1 
;T_RTC_1.c,17 :: 		hora       = Leer(0xD0,2);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       2
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       main_hora_L0+0 
	MOVF        R1, 0 
	MOVWF       main_hora_L0+1 
;T_RTC_1.c,18 :: 		dia_semana = Leer(0xD0,3);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       3
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       main_dia_semana_L0+0 
	MOVF        R1, 0 
	MOVWF       main_dia_semana_L0+1 
;T_RTC_1.c,19 :: 		dia        = Leer(0xD0,4);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       4
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       main_dia_L0+0 
	MOVF        R1, 0 
	MOVWF       main_dia_L0+1 
;T_RTC_1.c,20 :: 		mes        = Leer(0xD0,5);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       5
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       main_mes_L0+0 
	MOVF        R1, 0 
	MOVWF       main_mes_L0+1 
;T_RTC_1.c,21 :: 		ano        = Leer(0xD0,6);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVLW       6
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       main_ano_L0+0 
	MOVF        R1, 0 
	MOVWF       main_ano_L0+1 
;T_RTC_1.c,23 :: 		segundos   = Bcd2Dec(segundos);
	MOVF        main_segundos_L0+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       main_segundos_L0+0 
	MOVLW       0
	MOVWF       main_segundos_L0+1 
;T_RTC_1.c,24 :: 		minutos    = Bcd2Dec(minutos);
	MOVF        main_minutos_L0+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       main_minutos_L0+0 
	MOVLW       0
	MOVWF       main_minutos_L0+1 
;T_RTC_1.c,25 :: 		hora       = Bcd2Dec(hora);
	MOVF        main_hora_L0+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       main_hora_L0+0 
	MOVLW       0
	MOVWF       main_hora_L0+1 
;T_RTC_1.c,26 :: 		dia_semana = Bcd2Dec(dia_semana);
	MOVF        main_dia_semana_L0+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       main_dia_semana_L0+0 
	MOVLW       0
	MOVWF       main_dia_semana_L0+1 
;T_RTC_1.c,27 :: 		dia        = Bcd2Dec(dia);
	MOVF        main_dia_L0+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       main_dia_L0+0 
	MOVLW       0
	MOVWF       main_dia_L0+1 
;T_RTC_1.c,28 :: 		mes        = Bcd2Dec(mes);
	MOVF        main_mes_L0+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       main_mes_L0+0 
	MOVLW       0
	MOVWF       main_mes_L0+1 
;T_RTC_1.c,29 :: 		ano        = Bcd2Dec(ano);
	MOVF        main_ano_L0+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       main_ano_L0+0 
	MOVLW       0
	MOVWF       main_ano_L0+1 
;T_RTC_1.c,33 :: 		UART1_Write_Text("HORA: ");
	MOVLW       ?lstr1_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,35 :: 		UART1_Write( (hora/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_hora_L0+0, 0 
	MOVWF       R0 
	MOVF        main_hora_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,36 :: 		UART1_Write( (hora%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_hora_L0+0, 0 
	MOVWF       R0 
	MOVF        main_hora_L0+1, 0 
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
;T_RTC_1.c,37 :: 		UART1_Write( ':' );
	MOVLW       58
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,38 :: 		UART1_Write( (minutos/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_minutos_L0+0, 0 
	MOVWF       R0 
	MOVF        main_minutos_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,39 :: 		UART1_Write( (minutos%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_minutos_L0+0, 0 
	MOVWF       R0 
	MOVF        main_minutos_L0+1, 0 
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
;T_RTC_1.c,40 :: 		UART1_Write( ':' );
	MOVLW       58
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,41 :: 		UART1_Write( (segundos/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_segundos_L0+0, 0 
	MOVWF       R0 
	MOVF        main_segundos_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,42 :: 		UART1_Write( (segundos%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_segundos_L0+0, 0 
	MOVWF       R0 
	MOVF        main_segundos_L0+1, 0 
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
;T_RTC_1.c,44 :: 		UART1_Write_Text("     ");
	MOVLW       ?lstr2_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,45 :: 		UART1_Write_Text("Fecha: ");
	MOVLW       ?lstr3_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,46 :: 		UART1_Write( (dia/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_dia_L0+0, 0 
	MOVWF       R0 
	MOVF        main_dia_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,47 :: 		UART1_Write( (dia%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_dia_L0+0, 0 
	MOVWF       R0 
	MOVF        main_dia_L0+1, 0 
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
;T_RTC_1.c,48 :: 		UART1_Write( '-' );
	MOVLW       45
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,49 :: 		UART1_Write( (mes/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_mes_L0+0, 0 
	MOVWF       R0 
	MOVF        main_mes_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,50 :: 		UART1_Write( (mes%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_mes_L0+0, 0 
	MOVWF       R0 
	MOVF        main_mes_L0+1, 0 
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
;T_RTC_1.c,51 :: 		UART1_Write( '-' );
	MOVLW       45
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,52 :: 		UART1_Write( (ano/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_ano_L0+0, 0 
	MOVWF       R0 
	MOVF        main_ano_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTC_1.c,53 :: 		UART1_Write( (ano%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_ano_L0+0, 0 
	MOVWF       R0 
	MOVF        main_ano_L0+1, 0 
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
;T_RTC_1.c,54 :: 		UART1_Write_Text("\r\n   \r\n");
	MOVLW       ?lstr4_T_RTC_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_T_RTC_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTC_1.c,55 :: 		delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 1
	BRA         L_main22
	DECFSZ      R12, 1, 1
	BRA         L_main22
	DECFSZ      R11, 1, 1
	BRA         L_main22
	NOP
;T_RTC_1.c,57 :: 		}
	GOTO        L_main20
;T_RTC_1.c,58 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
