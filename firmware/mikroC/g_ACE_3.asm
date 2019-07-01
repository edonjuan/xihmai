
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
	GOTO        L__getHumidity30
	MOVF        R1, 0 
	SUBLW       192
L__getHumidity30:
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
	GOTO        L__getHumidity31
	MOVLW       128
	SUBWF       getHumidity_buffer_L0+0, 0 
L__getHumidity31:
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
;g_ACE_3.c,66 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,67 :: 		delay_ms(100);
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
;g_ACE_3.c,68 :: 		I2C1_Wr(ADW);                // 19 x(4F)
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
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	DECFSZ      R11, 1, 1
	BRA         L_main12
	NOP
	NOP
;g_ACE_3.c,74 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,75 :: 		I2C1_Wr(ADW);                // 1A   (0b00000111)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,76 :: 		I2C1_Wr(0x1A);
	MOVLW       26
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,77 :: 		I2C1_Wr(0b00000000);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,78 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,79 :: 		delay_ms(100);
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
;g_ACE_3.c,81 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,82 :: 		I2C1_Wr(ADW);                // 6B   yes (RESETS ALL)(new)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,83 :: 		I2C1_Wr(0x6B);
	MOVLW       107
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,84 :: 		I2C1_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,85 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,86 :: 		delay_ms(100);
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
;g_ACE_3.c,88 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,89 :: 		I2C1_Wr(ADW);                // 1B    yes (18)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,90 :: 		I2C1_Wr(0x1B);
	MOVLW       27
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,91 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,92 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,93 :: 		delay_ms(100);
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
;g_ACE_3.c,95 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,96 :: 		I2C1_Wr(ADW);                // 1C    yes    (18)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,97 :: 		I2C1_Wr(0x1C);
	MOVLW       28
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,98 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,99 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,100 :: 		delay_ms(100);
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
;g_ACE_3.c,109 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,110 :: 		I2C1_Wr(ADW);                // interrupt data ready (INTERRUPT) STATUS
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,111 :: 		I2C1_Wr(0x3A);
	MOVLW       58
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,112 :: 		I2C1_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,113 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,114 :: 		delay_ms(100);
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
;g_ACE_3.c,137 :: 		delay_ms(100);
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
;g_ACE_3.c,139 :: 		while(1)
L_main19:
;g_ACE_3.c,141 :: 		uart1_write_text("GO ON");
	MOVLW       ?lstr12_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,142 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr13_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,358 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,359 :: 		I2C1_Wr(ADW);                                   // Address Device + Write
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,360 :: 		I2C1_Wr(0x3B);                                  // Address Pointer
	MOVLW       59
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,361 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;g_ACE_3.c,362 :: 		I2C1_Wr(ADR);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,363 :: 		buff = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVLW       0
	MOVWF       _buff+1 
;g_ACE_3.c,364 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,365 :: 		delay_ms(100);
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
;g_ACE_3.c,372 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,373 :: 		I2C1_Wr(ADW);                                   // Address Device + Write
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,374 :: 		I2C1_Wr(0x3C);                                  // Address Pointer
	MOVLW       60
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,375 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;g_ACE_3.c,376 :: 		I2C1_Wr(ADR);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,377 :: 		cofe =  I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _cofe+0 
	MOVLW       0
	MOVWF       _cofe+1 
;g_ACE_3.c,378 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,379 :: 		delay_ms(100);
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
;g_ACE_3.c,388 :: 		buff=(buff<<8);
	MOVF        _buff+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVF        R1, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,389 :: 		buff=buff  | cofe;                              // deux bytes ensambles
	MOVF        _cofe+0, 0 
	IORWF       R0, 1 
	MOVF        _cofe+1, 0 
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVF        R1, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,398 :: 		finally=buff;
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _finally+0 
	MOVF        R1, 0 
	MOVWF       _finally+1 
	MOVF        R2, 0 
	MOVWF       _finally+2 
	MOVF        R3, 0 
	MOVWF       _finally+3 
;g_ACE_3.c,399 :: 		finally= ((finally * 2)/16386);
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
;g_ACE_3.c,402 :: 		FloatToStr(finally, txt);
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
;g_ACE_3.c,403 :: 		uart1_write_text("ACCEL X: ");
	MOVLW       ?lstr14_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,404 :: 		uart1_write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,405 :: 		uart1_write_text("°C ");
	MOVLW       ?lstr15_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr15_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,406 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr16_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr16_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,411 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,412 :: 		I2C1_Wr(ADW);                                   // Address Device + Write
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,413 :: 		I2C1_Wr(0x3D);                                  // Address Pointer
	MOVLW       61
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,414 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;g_ACE_3.c,415 :: 		I2C1_Wr(ADR);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,416 :: 		buff = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVLW       0
	MOVWF       _buff+1 
;g_ACE_3.c,417 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,418 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
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
;g_ACE_3.c,425 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,426 :: 		I2C1_Wr(ADW);                                   // Address Device + Write
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,427 :: 		I2C1_Wr(0x3E);                                  // Address Pointer
	MOVLW       62
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,428 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;g_ACE_3.c,429 :: 		I2C1_Wr(ADR);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,430 :: 		cofe =  I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _cofe+0 
	MOVLW       0
	MOVWF       _cofe+1 
;g_ACE_3.c,431 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,432 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main24:
	DECFSZ      R13, 1, 1
	BRA         L_main24
	DECFSZ      R12, 1, 1
	BRA         L_main24
	DECFSZ      R11, 1, 1
	BRA         L_main24
	NOP
	NOP
;g_ACE_3.c,441 :: 		buff=(buff<<8);
	MOVF        _buff+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVF        R1, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,442 :: 		buff=buff  | cofe;                              // deux bytes ensambles
	MOVF        _cofe+0, 0 
	IORWF       R0, 1 
	MOVF        _cofe+1, 0 
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVF        R1, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,451 :: 		finally=buff;
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _finally+0 
	MOVF        R1, 0 
	MOVWF       _finally+1 
	MOVF        R2, 0 
	MOVWF       _finally+2 
	MOVF        R3, 0 
	MOVWF       _finally+3 
;g_ACE_3.c,452 :: 		finally= ((finally * 2)/16386);
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
;g_ACE_3.c,455 :: 		FloatToStr(finally, txt);
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
;g_ACE_3.c,456 :: 		uart1_write_text("ACCEL Y: ");
	MOVLW       ?lstr17_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr17_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,457 :: 		uart1_write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,458 :: 		uart1_write_text("°C ");
	MOVLW       ?lstr18_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,459 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr19_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr19_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,464 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,465 :: 		I2C1_Wr(ADW);                                   // Address Device + Write
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,466 :: 		I2C1_Wr(0x3F);                                  // Address Pointer
	MOVLW       63
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,467 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;g_ACE_3.c,468 :: 		I2C1_Wr(ADR);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,469 :: 		buff = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVLW       0
	MOVWF       _buff+1 
;g_ACE_3.c,470 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,471 :: 		delay_ms(10000);
	MOVLW       254
	MOVWF       R11, 0
	MOVLW       167
	MOVWF       R12, 0
	MOVLW       101
	MOVWF       R13, 0
L_main25:
	DECFSZ      R13, 1, 1
	BRA         L_main25
	DECFSZ      R12, 1, 1
	BRA         L_main25
	DECFSZ      R11, 1, 1
	BRA         L_main25
	NOP
	NOP
;g_ACE_3.c,478 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;g_ACE_3.c,479 :: 		I2C1_Wr(ADW);                                   // Address Device + Write
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,480 :: 		I2C1_Wr(0x40);                                  // Address Pointer
	MOVLW       64
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,481 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;g_ACE_3.c,482 :: 		I2C1_Wr(ADR);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;g_ACE_3.c,483 :: 		cofe =  I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _cofe+0 
	MOVLW       0
	MOVWF       _cofe+1 
;g_ACE_3.c,484 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;g_ACE_3.c,485 :: 		delay_ms(100);
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
;g_ACE_3.c,494 :: 		buff=(buff<<8);
	MOVF        _buff+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVF        R1, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,495 :: 		buff=buff  | cofe;                              // deux bytes ensambles
	MOVF        _cofe+0, 0 
	IORWF       R0, 1 
	MOVF        _cofe+1, 0 
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       _buff+0 
	MOVF        R1, 0 
	MOVWF       _buff+1 
;g_ACE_3.c,504 :: 		finally=buff;
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _finally+0 
	MOVF        R1, 0 
	MOVWF       _finally+1 
	MOVF        R2, 0 
	MOVWF       _finally+2 
	MOVF        R3, 0 
	MOVWF       _finally+3 
;g_ACE_3.c,505 :: 		finally= ((finally * 2)/16386);
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
;g_ACE_3.c,508 :: 		FloatToStr(finally, txt);
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
;g_ACE_3.c,509 :: 		uart1_write_text("ACCEL Z: ");
	MOVLW       ?lstr20_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr20_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,510 :: 		uart1_write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,511 :: 		uart1_write_text("°C ");
	MOVLW       ?lstr21_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr21_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,512 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr22_g_ACE_3+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr22_g_ACE_3+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;g_ACE_3.c,524 :: 		}
	GOTO        L_main19
;g_ACE_3.c,525 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
