
_th02Init:

;th02.h,4 :: 		void th02Init(void)
;th02.h,6 :: 		I2C1_Init(100000);         // Initialize I2C communication
	MOVLW       50
	MOVWF       SSP1ADD+0 
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
	GOTO        L__getHumidity29
	MOVF        R1, 0 
	SUBLW       192
L__getHumidity29:
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
	GOTO        L__getHumidity30
	MOVLW       128
	SUBWF       getHumidity_buffer_L0+0, 0 
L__getHumidity30:
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

_Accelconfig:

;accel.h,7 :: 		void Accelconfig(void)
;accel.h,10 :: 		I2C1_Start();                // Configuring MPU6050 and interruption
	CALL        _I2C1_Start+0, 0
;accel.h,11 :: 		I2C1_Wr(0xD0);                          // 19 x(4F)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,12 :: 		I2C1_Wr(0x19);
	MOVLW       25
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,13 :: 		I2C1_Wr(0x07);
	MOVLW       7
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,14 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,15 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig7:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig7
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig7
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig7
	NOP
	NOP
;accel.h,18 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,19 :: 		I2C1_Wr(ADW);                // 6B   yes (RESETS ALL)(new)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,20 :: 		I2C1_Wr(0x6B);
	MOVLW       107
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,21 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,22 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,23 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig8:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig8
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig8
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig8
	NOP
	NOP
;accel.h,26 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,27 :: 		I2C1_Wr(ADW);                // 6C il manque les premier deux zeros pour wake-ups
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,28 :: 		I2C1_Wr(0x6C);               // bits 7 y 6
	MOVLW       108
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,29 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,30 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,31 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig9:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig9
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig9
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig9
	NOP
	NOP
;accel.h,34 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,35 :: 		I2C1_Wr(ADW);                // 1B    yes (18)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,36 :: 		I2C1_Wr(0x1B);
	MOVLW       27
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,37 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,38 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,39 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig10:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig10
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig10
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig10
	NOP
	NOP
;accel.h,41 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,42 :: 		I2C1_Wr(ADW);                // 1C    yes    (18)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,43 :: 		I2C1_Wr(0x1C);
	MOVLW       28
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,44 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,45 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,46 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig11:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig11
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig11
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig11
	NOP
	NOP
;accel.h,48 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,49 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig12:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig12
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig12
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig12
	NOP
	NOP
;accel.h,50 :: 		I2C1_Wr(ADW);                //  38   Activar motion interrupt ( activa el bit (-))
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,51 :: 		I2C1_Wr(0x38);
	MOVLW       56
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,52 :: 		I2C1_Wr(0x40);
	MOVLW       64
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,53 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,54 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig13:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig13
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig13
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig13
	NOP
	NOP
;accel.h,56 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,57 :: 		I2C1_Wr(ADW);                // Motion interrupt duration
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,58 :: 		I2C1_Wr(0x20);
	MOVLW       32
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,59 :: 		I2C1_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,60 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,61 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig14:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig14
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig14
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig14
	NOP
	NOP
;accel.h,63 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,64 :: 		I2C1_Wr(ADW);                // interrupt data ready (INTERRUPT) STATUS
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,65 :: 		I2C1_Wr(0x3A);
	MOVLW       58
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,66 :: 		I2C1_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,67 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,68 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig15:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig15
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig15
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig15
	NOP
	NOP
;accel.h,71 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,72 :: 		I2C1_Wr(ADW);                // 1F     Treshold = 100 320mg
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,73 :: 		I2C1_Wr(0x1F);               // 20=32mg=0x14
	MOVLW       31
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,74 :: 		I2C1_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,75 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,76 :: 		delay_ms(200);                // delay extra
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Accelconfig16:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig16
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig16
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig16
	NOP
	NOP
;accel.h,79 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,80 :: 		I2C1_Wr(ADW);                // 1A   (0b00000111)  MOtion HPF HOLD    (07)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,81 :: 		I2C1_Wr(0x1A);
	MOVLW       26
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,82 :: 		I2C1_Wr(0xFF);
	MOVLW       255
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,83 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,84 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig17:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig17
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig17
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig17
	NOP
	NOP
;accel.h,87 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,88 :: 		I2C1_Wr(ADW);                // 6C (2) il manque les premier deux zeros pour wake-ups
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,89 :: 		I2C1_Wr(0x6C);               // bits 7 y 6
	MOVLW       108
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,90 :: 		I2C1_Wr(0x60);
	MOVLW       96
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,91 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,92 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig18:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig18
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig18
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig18
	NOP
	NOP
;accel.h,95 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;accel.h,96 :: 		I2C1_Wr(ADW);                // 6B   activate cycle
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,97 :: 		I2C1_Wr(0x6B);
	MOVLW       107
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,98 :: 		I2C1_Wr(0x10);
	MOVLW       16
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,99 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;accel.h,100 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Accelconfig19:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig19
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig19
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig19
	NOP
	NOP
;accel.h,103 :: 		delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Accelconfig20:
	DECFSZ      R13, 1, 1
	BRA         L_Accelconfig20
	DECFSZ      R12, 1, 1
	BRA         L_Accelconfig20
	DECFSZ      R11, 1, 1
	BRA         L_Accelconfig20
	NOP
	NOP
;accel.h,104 :: 		}
L_end_Accelconfig:
	RETURN      0
; end of _Accelconfig

_main:

;M_TH02_1.c,21 :: 		void main()
;M_TH02_1.c,23 :: 		config();
	CALL        _config+0, 0
;M_TH02_1.c,26 :: 		while(1)
L_main21:
;M_TH02_1.c,30 :: 		temperature = getTemperature();
	CALL        _getTemperature+0, 0
	MOVF        R0, 0 
	MOVWF       _temperature+0 
	MOVF        R1, 0 
	MOVWF       _temperature+1 
	MOVF        R2, 0 
	MOVWF       _temperature+2 
	MOVF        R3, 0 
	MOVWF       _temperature+3 
;M_TH02_1.c,31 :: 		floattostr(temperature, txt);
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
;M_TH02_1.c,32 :: 		UART1_Write_Text("TEMPERATURE: ");
	MOVLW       ?lstr1_M_TH02_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_M_TH02_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,33 :: 		UART1_Write_Text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,34 :: 		uart1_write_text("°C\r\n");
	MOVLW       ?lstr2_M_TH02_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_M_TH02_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,36 :: 		humidity = getHumidity();
	CALL        _getHumidity+0, 0
	MOVF        R0, 0 
	MOVWF       _humidity+0 
	MOVF        R1, 0 
	MOVWF       _humidity+1 
	MOVF        R2, 0 
	MOVWF       _humidity+2 
	MOVF        R3, 0 
	MOVWF       _humidity+3 
;M_TH02_1.c,37 :: 		floattostr(humidity, txt);
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
;M_TH02_1.c,38 :: 		UART1_Write_Text("HUMEDAD: ");
	MOVLW       ?lstr3_M_TH02_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_M_TH02_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,39 :: 		UART1_Write_Text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,40 :: 		uart1_write_text("%\r\n");
	MOVLW       ?lstr4_M_TH02_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_M_TH02_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,42 :: 		delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main23:
	DECFSZ      R13, 1, 1
	BRA         L_main23
	DECFSZ      R12, 1, 1
	BRA         L_main23
	DECFSZ      R11, 1, 1
	BRA         L_main23
	NOP
;M_TH02_1.c,44 :: 		UART1_Write_Text("Drops: ");
	MOVLW       ?lstr5_M_TH02_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_M_TH02_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,45 :: 		drops = TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       _drops+0 
	MOVLW       0
	MOVWF       _drops+1 
;M_TH02_1.c,46 :: 		drops |=  (TMR0H << 8);
	MOVF        TMR0H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _drops+0, 0 
	IORWF       R0, 1 
	MOVF        _drops+1, 0 
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       _drops+0 
	MOVF        R1, 0 
	MOVWF       _drops+1 
;M_TH02_1.c,47 :: 		inttostr(drops, txt);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;M_TH02_1.c,48 :: 		UART1_Write_Text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,49 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr6_M_TH02_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_M_TH02_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,50 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr7_M_TH02_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_M_TH02_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_TH02_1.c,51 :: 		delay_ms(400);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
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
;M_TH02_1.c,52 :: 		}
	GOTO        L_main21
;M_TH02_1.c,53 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;M_TH02_1.c,56 :: 		void config (void)
;M_TH02_1.c,64 :: 		T0CON = 0XA8;
	MOVLW       168
	MOVWF       T0CON+0 
;M_TH02_1.c,65 :: 		TMR0L = 0X00;
	CLRF        TMR0L+0 
;M_TH02_1.c,66 :: 		TMR0H = 0X00;
	CLRF        TMR0H+0 
;M_TH02_1.c,67 :: 		TRISA.F4 = 1;
	BSF         TRISA+0, 4 
;M_TH02_1.c,69 :: 		ANSELC=0;
	CLRF        ANSELC+0 
;M_TH02_1.c,70 :: 		ANSELA=0;
	CLRF        ANSELA+0 
;M_TH02_1.c,71 :: 		TRISC =0;
	CLRF        TRISC+0 
;M_TH02_1.c,72 :: 		TRISA =0;
	CLRF        TRISA+0 
;M_TH02_1.c,75 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;M_TH02_1.c,76 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_config25:
	DECFSZ      R13, 1, 1
	BRA         L_config25
	DECFSZ      R12, 1, 1
	BRA         L_config25
	DECFSZ      R11, 1, 1
	BRA         L_config25
	NOP
	NOP
;M_TH02_1.c,78 :: 		th02Init();
	CALL        _th02Init+0, 0
;M_TH02_1.c,79 :: 		Accelconfig();
	CALL        _Accelconfig+0, 0
;M_TH02_1.c,82 :: 		}
L_end_config:
	RETURN      0
; end of _config
