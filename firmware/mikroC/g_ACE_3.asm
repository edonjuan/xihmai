
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
L_th02Init0:
	DECFSZ      R13, 1, 1
	BRA         L_th02Init0
	DECFSZ      R12, 1, 1
	BRA         L_th02Init0
	DECFSZ      R11, 1, 1
	BRA         L_th02Init0
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
L_getTemperature1:
	DECFSZ      R13, 1, 1
	BRA         L_getTemperature1
	DECFSZ      R12, 1, 1
	BRA         L_getTemperature1
	DECFSZ      R11, 1, 1
	BRA         L_getTemperature1
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
L_getHumidity2:
	DECFSZ      R13, 1, 1
	BRA         L_getHumidity2
	DECFSZ      R12, 1, 1
	BRA         L_getHumidity2
	DECFSZ      R11, 1, 1
	BRA         L_getHumidity2
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
	GOTO        L__getHumidity33
	MOVF        R1, 0 
	SUBLW       192
L__getHumidity33:
	BTFSC       STATUS+0, 0 
	GOTO        L_getHumidity3
;th02.h,68 :: 		humidity = 1984;
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+0 
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+1 
	MOVLW       120
	MOVWF       getHumidity_humidity_L0+2 
	MOVLW       137
	MOVWF       getHumidity_humidity_L0+3 
	GOTO        L_getHumidity4
L_getHumidity3:
;th02.h,69 :: 		else if(buffer<384)
	MOVLW       1
	SUBWF       getHumidity_buffer_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getHumidity34
	MOVLW       128
	SUBWF       getHumidity_buffer_L0+0, 0 
L__getHumidity34:
	BTFSC       STATUS+0, 0 
	GOTO        L_getHumidity5
;th02.h,70 :: 		humidity = 384;
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+0 
	MOVLW       0
	MOVWF       getHumidity_humidity_L0+1 
	MOVLW       64
	MOVWF       getHumidity_humidity_L0+2 
	MOVLW       135
	MOVWF       getHumidity_humidity_L0+3 
	GOTO        L_getHumidity6
L_getHumidity5:
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
L_getHumidity6:
L_getHumidity4:
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

_I2C1_TimeoutCallback:

;g_ACE_3.c,13 :: 		I2C1_TimeoutCallback(errorCode)
;g_ACE_3.c,15 :: 		if (errorCode == _I2C_TIMEOUT_RD) {
	MOVF        _errorCode+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C1_TimeoutCallback7
;g_ACE_3.c,17 :: 		uart1_write_text("read problem");
	MOVLW       ?lstr1_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,18 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr2_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,19 :: 		}
L_I2C1_TimeoutCallback7:
;g_ACE_3.c,21 :: 		if (errorCode == _I2C_TIMEOUT_WR) {
	MOVF        _errorCode+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C1_TimeoutCallback8
;g_ACE_3.c,23 :: 		uart1_write_text("write problem");
	MOVLW       ?lstr3_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,24 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr4_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,25 :: 		}
L_I2C1_TimeoutCallback8:
;g_ACE_3.c,27 :: 		if (errorCode == _I2C_TIMEOUT_START) {
	MOVF        _errorCode+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C1_TimeoutCallback9
;g_ACE_3.c,29 :: 		uart1_write_text("start problem");
	MOVLW       ?lstr5_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,30 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr6_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,31 :: 		}
L_I2C1_TimeoutCallback9:
;g_ACE_3.c,33 :: 		if (errorCode == _I2C_TIMEOUT_REPEATED_START) {
	MOVF        _errorCode+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C1_TimeoutCallback10
;g_ACE_3.c,35 :: 		uart1_write_text("repeat start problem");
	MOVLW       ?lstr7_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,36 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr8_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,37 :: 		}
L_I2C1_TimeoutCallback10:
;g_ACE_3.c,39 :: 		}
L_end_I2C1_TimeoutCallback:
	RETURN      0
; end of _I2C1_TimeoutCallback

_main:

;g_ACE_3.c,49 :: 		void main()
;g_ACE_3.c,56 :: 		uart1_init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;g_ACE_3.c,57 :: 		I2C1_Init(100000);         // initialize I2C communication
	MOVLW       50
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;g_ACE_3.c,58 :: 		TH02Init();
	CALL        _th02Init+0, 0
;g_ACE_3.c,60 :: 		uart1_write_text("STARTING");
	MOVLW       ?lstr9_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,61 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr10_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,62 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr11_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,67 :: 		I2C1_Start();                // Configuring MPU6050 and interruption
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,68 :: 		I2C1_Wr(0xD0);                          // 19 x(4F)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,69 :: 		I2C1_Wr(0x19);
	MOVLW       25
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,70 :: 		I2C1_Wr(0x07);
	MOVLW       7
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,71 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,72 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	DECFSZ      R11, 1, 1
	BRA         L_main11
	NOP
	NOP
;g_ACE_3.c,75 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,76 :: 		I2C1_Wr(ADW);                // 6B   yes (RESETS ALL)(new)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,77 :: 		I2C1_Wr(0x6B);
	MOVLW       107
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,78 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,79 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,80 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	DECFSZ      R11, 1, 1
	BRA         L_main12
	NOP
	NOP
;g_ACE_3.c,83 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,84 :: 		I2C1_Wr(ADW);                // 6C il manque les premier deux zeros pour wake-ups
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,85 :: 		I2C1_Wr(0x6C);               // bits 7 y 6
	MOVLW       108
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,86 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,87 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,88 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
	DECFSZ      R11, 1, 1
	BRA         L_main13
	NOP
	NOP
;g_ACE_3.c,91 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,92 :: 		I2C1_Wr(ADW);                // 1B    yes (18)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,93 :: 		I2C1_Wr(0x1B);
	MOVLW       27
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,94 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,95 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,96 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
	NOP
	NOP
;g_ACE_3.c,98 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,99 :: 		I2C1_Wr(ADW);                // 1C    yes    (18)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,100 :: 		I2C1_Wr(0x1C);
	MOVLW       28
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,101 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,102 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,103 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main15:
	DECFSZ      R13, 1, 1
	BRA         L_main15
	DECFSZ      R12, 1, 1
	BRA         L_main15
	DECFSZ      R11, 1, 1
	BRA         L_main15
	NOP
	NOP
;g_ACE_3.c,105 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,106 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main16:
	DECFSZ      R13, 1, 1
	BRA         L_main16
	DECFSZ      R12, 1, 1
	BRA         L_main16
	DECFSZ      R11, 1, 1
	BRA         L_main16
	NOP
	NOP
;g_ACE_3.c,107 :: 		I2C1_Wr(ADW);                //  38   Activar motion interrupt ( activa el bit (-))
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,108 :: 		I2C1_Wr(0x38);
	MOVLW       56
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,109 :: 		I2C1_Wr(0x40);
	MOVLW       64
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,110 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,111 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	DECFSZ      R11, 1, 1
	BRA         L_main17
	NOP
	NOP
;g_ACE_3.c,113 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,114 :: 		I2C1_Wr(ADW);                // Motion interrupt duration
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,115 :: 		I2C1_Wr(0x20);
	MOVLW       32
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,116 :: 		I2C1_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,117 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,118 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main18:
	DECFSZ      R13, 1, 1
	BRA         L_main18
	DECFSZ      R12, 1, 1
	BRA         L_main18
	DECFSZ      R11, 1, 1
	BRA         L_main18
	NOP
	NOP
;g_ACE_3.c,120 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,121 :: 		I2C1_Wr(ADW);                // interrupt data ready (INTERRUPT) STATUS
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,122 :: 		I2C1_Wr(0x3A);
	MOVLW       58
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,123 :: 		I2C1_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,124 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,125 :: 		delay_ms(100);
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
;g_ACE_3.c,136 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,137 :: 		I2C1_Wr(ADW);                // 1A   (0b00000111)  MOtion HPF HOLD    (07)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,138 :: 		I2C1_Wr(0x1A);
	MOVLW       26
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,139 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,140 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,141 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main20:
	DECFSZ      R13, 1, 1
	BRA         L_main20
	DECFSZ      R12, 1, 1
	BRA         L_main20
	DECFSZ      R11, 1, 1
	BRA         L_main20
	NOP
	NOP
;g_ACE_3.c,144 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,145 :: 		I2C1_Wr(ADW);                // 6C (2) il manque les premier deux zeros pour wake-ups
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,146 :: 		I2C1_Wr(0x6C);               // bits 7 y 6
	MOVLW       108
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,147 :: 		I2C1_Wr(0x60);
	MOVLW       96
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,148 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,149 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main21:
	DECFSZ      R13, 1, 1
	BRA         L_main21
	DECFSZ      R12, 1, 1
	BRA         L_main21
	DECFSZ      R11, 1, 1
	BRA         L_main21
	NOP
	NOP
;g_ACE_3.c,152 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,153 :: 		I2C1_Wr(ADW);                // 6B   activate cycle
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,154 :: 		I2C1_Wr(0x6B);
	MOVLW       107
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,155 :: 		I2C1_Wr(0x10);
	MOVLW       16
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,156 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,157 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 1
	BRA         L_main22
	DECFSZ      R12, 1, 1
	BRA         L_main22
	DECFSZ      R11, 1, 1
	BRA         L_main22
	NOP
	NOP
;g_ACE_3.c,170 :: 		delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main23:
	DECFSZ      R13, 1, 1
	BRA         L_main23
	DECFSZ      R12, 1, 1
	BRA         L_main23
	DECFSZ      R11, 1, 1
	BRA         L_main23
	NOP
	NOP
;g_ACE_3.c,174 :: 		while(1)
L_main24:
;g_ACE_3.c,440 :: 		uart1_write_text("go away");
	MOVLW       ?lstr12_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,441 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr13_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,443 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,444 :: 		I2C1_Wr(ADW);                                   // Address Device + Write
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,445 :: 		I2C1_Wr(0x3D);                                  // Address Pointer
	MOVLW       61
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,446 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;g_ACE_3.c,447 :: 		I2C1_Wr(ADR);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,448 :: 		buff = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVLW       0
	MOVWF       _buff+1 
;g_ACE_3.c,449 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,450 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main26:
	DECFSZ      R13, 1, 1
	BRA         L_main26
	DECFSZ      R12, 1, 1
	BRA         L_main26
	DECFSZ      R11, 1, 1
	BRA         L_main26
	NOP
	NOP
;g_ACE_3.c,452 :: 		inttostr(buff, txt);                            // primer byte
	MOVF        _buff+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _buff+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;g_ACE_3.c,453 :: 		uart1_write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,454 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr14_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,457 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,458 :: 		I2C1_Wr(ADW);                                   // Address Device + Write
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,459 :: 		I2C1_Wr(0x3E);                                  // Address Pointer
	MOVLW       62
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,460 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;g_ACE_3.c,461 :: 		I2C1_Wr(ADR);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,462 :: 		cofe =  I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _cofe+0 
	MOVLW       0
	MOVWF       _cofe+1 
;g_ACE_3.c,463 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,464 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main27:
	DECFSZ      R13, 1, 1
	BRA         L_main27
	DECFSZ      R12, 1, 1
	BRA         L_main27
	DECFSZ      R11, 1, 1
	BRA         L_main27
	NOP
	NOP
;g_ACE_3.c,466 :: 		inttostr(cofe, txt);
	MOVF        _cofe+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _cofe+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;g_ACE_3.c,467 :: 		uart1_write_text(txt);                           // second byte
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,468 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr15_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr15_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,469 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr16_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr16_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,470 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr17_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr17_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,473 :: 		buff=(buff<<8);
	MOVF        _buff+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVF        R1, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,474 :: 		buff=buff  | cofe;                              // deux bytes ensambles
	MOVF        _cofe+0, 0 
	IORWF       R0, 1 
	MOVF        _cofe+1, 0 
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVF        R1, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,476 :: 		buff=~buff;
	COMF        R0, 1 
	COMF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVF        R1, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,477 :: 		buff=(buff | (0x01));
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	IORWF       R3, 1 
	MOVF        R2, 0 
	MOVWF       _buff+0 
	MOVF        R3, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,479 :: 		if(buff>=32768)
	MOVLW       128
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVLW       0
	SUBWF       R2, 0 
L__main37:
	BTFSS       STATUS+0, 0 
	GOTO        L_main28
;g_ACE_3.c,480 :: 		buff= buff & (0xFFFF);
	MOVLW       255
	ANDWF       _buff+0, 1 
	MOVLW       255
	ANDWF       _buff+1, 1 
L_main28:
;g_ACE_3.c,483 :: 		inttostr(buff, txt);
	MOVF        _buff+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _buff+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;g_ACE_3.c,484 :: 		uart1_write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,485 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr18_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,486 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr19_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr19_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,487 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr20_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr20_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,490 :: 		finally=buff;
	MOVF        _buff+0, 0 
	MOVWF       R0 
	MOVF        _buff+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _finally+0 
	MOVF        R1, 0 
	MOVWF       _finally+1 
	MOVF        R2, 0 
	MOVWF       _finally+2 
	MOVF        R3, 0 
	MOVWF       _finally+3 
;g_ACE_3.c,491 :: 		finally= ((finally * 2)/16386);
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       4
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       141
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _finally+0 
	MOVF        R1, 0 
	MOVWF       _finally+1 
	MOVF        R2, 0 
	MOVWF       _finally+2 
	MOVF        R3, 0 
	MOVWF       _finally+3 
;g_ACE_3.c,494 :: 		FloatToStr(finally, txt);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;g_ACE_3.c,495 :: 		uart1_write_text("ACCEL Y: ");
	MOVLW       ?lstr21_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr21_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,496 :: 		uart1_write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,497 :: 		uart1_write_text("°C ");
	MOVLW       ?lstr22_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr22_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,498 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr23_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr23_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,499 :: 		delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main29:
	DECFSZ      R13, 1, 1
	BRA         L_main29
	DECFSZ      R12, 1, 1
	BRA         L_main29
	DECFSZ      R11, 1, 1
	BRA         L_main29
	NOP
;g_ACE_3.c,556 :: 		}
	GOTO        L_main24
;g_ACE_3.c,557 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
