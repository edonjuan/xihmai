
_th02Init:

;th02.h,4 :: 		void th02Init(void)
;th02.h,6 :: 		I2C2_Init(100000);         // Initialize I2C communication
	MOVLW       50
	MOVWF       SSP2ADD+0 
	CALL        _I2C2_Init+0, 0
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
;th02.h,8 :: 		}
L_end_th02Init:
	RETURN      0
; end of _th02Init

_getTemperature:

;th02.h,10 :: 		float getTemperature(void)
;th02.h,15 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;th02.h,16 :: 		I2C2_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,17 :: 		I2C2_Wr(0x03);                // Address Pointer
	MOVLW       3
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,18 :: 		I2C2_Wr(0x11);                // Register Data
	MOVLW       17
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,19 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
;th02.h,21 :: 		delay_ms(80);                 // Conversion time (MAX = 40ms)
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
;th02.h,23 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;th02.h,24 :: 		I2C2_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,25 :: 		I2C2_Wr(0x01);                // Address Pointer
	MOVLW       1
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,26 :: 		I2C2_Repeated_start();
	CALL        _I2C2_Repeated_Start+0, 0
;th02.h,27 :: 		I2C2_Wr(0x81);                // Address Device + Read
	MOVLW       129
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,28 :: 		buffer =  I2C2_Rd(1) << 8;
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       getTemperature_buffer_L0+1 
	CLRF        getTemperature_buffer_L0+0 
;th02.h,29 :: 		buffer |=  I2C2_Rd(0);
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	IORWF       getTemperature_buffer_L0+0, 1 
	MOVLW       0
	IORWF       getTemperature_buffer_L0+1, 1 
;th02.h,30 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
;th02.h,32 :: 		buffer >>= 2;                 // Equation from data sheet
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
;th02.h,33 :: 		temperature = buffer;
	CALL        _word2double+0, 0
;th02.h,34 :: 		temperature = (temperature/32)-50;
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
;th02.h,36 :: 		return temperature;
;th02.h,37 :: 		}
L_end_getTemperature:
	RETURN      0
; end of _getTemperature

_getHumidity:

;th02.h,39 :: 		float getHumidity(void)
;th02.h,44 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;th02.h,45 :: 		I2C2_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,46 :: 		I2C2_Wr(0x03);                // Address Pointer
	MOVLW       3
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,47 :: 		I2C2_Wr(0x01);                // Register Data
	MOVLW       1
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,48 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
;th02.h,50 :: 		delay_ms(80);                 // Conversion time (MAX = 40ms)
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
;th02.h,52 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;th02.h,53 :: 		I2C2_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,54 :: 		I2C2_Wr(0x01);                // Address Pointer
	MOVLW       1
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,55 :: 		I2C2_Repeated_start();
	CALL        _I2C2_Repeated_Start+0, 0
;th02.h,56 :: 		I2C2_Wr(0x81);                // Address Device + Read
	MOVLW       129
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;th02.h,57 :: 		buffer =  I2C2_Rd(1) << 8;
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       getHumidity_buffer_L0+1 
	CLRF        getHumidity_buffer_L0+0 
;th02.h,58 :: 		buffer |=  I2C2_Rd(0);
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	IORWF       getHumidity_buffer_L0+0, 1 
	MOVLW       0
	IORWF       getHumidity_buffer_L0+1, 1 
;th02.h,59 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
;th02.h,61 :: 		buffer >>= 4;                 // Equation from data sheet
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
;th02.h,63 :: 		if(buffer>1984)
	MOVF        R2, 0 
	SUBLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__getHumidity46
	MOVF        R1, 0 
	SUBLW       192
L__getHumidity46:
	BTFSC       STATUS+0, 0 
	GOTO        L_getHumidity3
;th02.h,64 :: 		humidity = 1984;
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
;th02.h,65 :: 		else if(buffer<384)
	MOVLW       1
	SUBWF       getHumidity_buffer_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getHumidity47
	MOVLW       128
	SUBWF       getHumidity_buffer_L0+0, 0 
L__getHumidity47:
	BTFSC       STATUS+0, 0 
	GOTO        L_getHumidity5
;th02.h,66 :: 		humidity = 384;
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
;th02.h,68 :: 		humidity = buffer;
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
;th02.h,69 :: 		humidity = (humidity/16)-24;
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
;th02.h,71 :: 		return humidity;
;th02.h,72 :: 		}
L_end_getHumidity:
	RETURN      0
; end of _getHumidity

_Accelconfig:

;accel.h,7 :: 		void Accelconfig(void)
;accel.h,10 :: 		I2C2_Start();                // Configuring MPU6050 and interruption
	CALL        _I2C2_Start+0, 0
;accel.h,11 :: 		I2C2_Wr(0xD2);                          // 19 x(4F)
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,12 :: 		I2C2_Wr(0x19);                           //D0
	MOVLW       25
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,13 :: 		I2C2_Wr(0x07);
	MOVLW       7
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,14 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,18 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,19 :: 		I2C2_Wr(ADW);                // 6B   yes (RESETS ALL)(new)
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,20 :: 		I2C2_Wr(0x6B);
	MOVLW       107
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,21 :: 		I2C2_Wr(0x00);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,22 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,26 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,27 :: 		I2C2_Wr(ADW);                // 6C il manque les premier deux zeros pour wake-ups
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,28 :: 		I2C2_Wr(0x6C);               // bits 7 y 6
	MOVLW       108
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,29 :: 		I2C2_Wr(0x00);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,30 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,34 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,35 :: 		I2C2_Wr(ADW);                // 1B    yes (18)
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,36 :: 		I2C2_Wr(0x1B);
	MOVLW       27
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,37 :: 		I2C2_Wr(0x00);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,38 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,41 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,42 :: 		I2C2_Wr(ADW);                // 1C    yes    (18)
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,43 :: 		I2C2_Wr(0x1C);
	MOVLW       28
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,44 :: 		I2C2_Wr(0x00);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,45 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,48 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
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
;accel.h,50 :: 		I2C2_Wr(ADW);                //  38   Activar motion interrupt ( activa el bit (-))
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,51 :: 		I2C2_Wr(0x38);
	MOVLW       56
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,52 :: 		I2C2_Wr(0x40);
	MOVLW       64
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,53 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,56 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,57 :: 		I2C2_Wr(ADW);                // Motion interrupt duration
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,58 :: 		I2C2_Wr(0x20);
	MOVLW       32
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,59 :: 		I2C2_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,60 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,63 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,64 :: 		I2C2_Wr(ADW);                // interrupt data ready (INTERRUPT) STATUS
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,65 :: 		I2C2_Wr(0x3A);
	MOVLW       58
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,66 :: 		I2C2_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,67 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,71 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,72 :: 		I2C2_Wr(ADW);                // 1F     Treshold = 100 320mg
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,73 :: 		I2C2_Wr(0x1F);               // 20=32mg=0x14
	MOVLW       31
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,74 :: 		I2C2_Wr(0x01);
	MOVLW       1
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,75 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,79 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,80 :: 		I2C2_Wr(ADW);                // 1A   (0b00000111)  MOtion HPF HOLD    (07)
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,81 :: 		I2C2_Wr(0x1A);
	MOVLW       26
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,82 :: 		I2C2_Wr(0xFF);
	MOVLW       255
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,83 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,87 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,88 :: 		I2C2_Wr(ADW);                // 6C (2) il manque les premier deux zeros pour wake-ups
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,89 :: 		I2C2_Wr(0x6C);               // bits 7 y 6
	MOVLW       108
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,90 :: 		I2C2_Wr(0x60);
	MOVLW       96
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,91 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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
;accel.h,95 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;accel.h,96 :: 		I2C2_Wr(ADW);                // 6B   activate cycle
	MOVLW       210
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,97 :: 		I2C2_Wr(0x6B);
	MOVLW       107
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,98 :: 		I2C2_Wr(0x10);
	MOVLW       16
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;accel.h,99 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
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

_interrupt:

;xihmai_v1.c,57 :: 		void interrupt()
;xihmai_v1.c,59 :: 		if(INTCON.F1)                     // External interrupt
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt21
;xihmai_v1.c,62 :: 		if(home)
	MOVF        _home+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt22
;xihmai_v1.c,64 :: 		modules();
	CALL        _modules+0, 0
;xihmai_v1.c,66 :: 		home = 0;
	CLRF        _home+0 
;xihmai_v1.c,67 :: 		sec=59;     //agregado
	MOVLW       59
	MOVWF       _sec+0 
	MOVLW       0
	MOVWF       _sec+1 
;xihmai_v1.c,68 :: 		min=RATE-1; //agregado
	CLRF        _min+0 
	CLRF        _min+1 
;xihmai_v1.c,71 :: 		filename[0] = EEPROM_Read(0) + 48;      // centenas
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _filename+0 
;xihmai_v1.c,72 :: 		filename[1] = EEPROM_Read(1) + 48;      // decenas
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _filename+1 
;xihmai_v1.c,73 :: 		filename[2] = EEPROM_Read(2) + 48;      // unidades
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _filename+2 
;xihmai_v1.c,75 :: 		filename[8] = 46;              //.
	MOVLW       46
	MOVWF       _filename+8 
;xihmai_v1.c,76 :: 		filename[9] = 67;              //C
	MOVLW       67
	MOVWF       _filename+9 
;xihmai_v1.c,77 :: 		filename[10] = 83;             //S
	MOVLW       83
	MOVWF       _filename+10 
;xihmai_v1.c,78 :: 		filename[11] = 86;             //V
	MOVLW       86
	MOVWF       _filename+11 
;xihmai_v1.c,80 :: 		filenumber = EEPROM_Read(0)*100 + EEPROM_Read(1)*10 + EEPROM_Read(2);
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVF        PRODH+0, 0 
	MOVWF       FLOC__interrupt+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FLOC__interrupt+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__interrupt+1, 1 
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__interrupt+0, 0 
	MOVWF       _filenumber+0 
	MOVLW       0
	ADDWFC      FLOC__interrupt+1, 0 
	MOVWF       _filenumber+1 
;xihmai_v1.c,87 :: 		M_Create_New_File();
	CALL        _M_Create_New_File+0, 0
;xihmai_v1.c,90 :: 		}
L_interrupt22:
;xihmai_v1.c,93 :: 		sec++;
	INFSNZ      _sec+0, 1 
	INCF        _sec+1, 1 
;xihmai_v1.c,94 :: 		if(sec>=60)
	MOVLW       0
	SUBWF       _sec+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt51
	MOVLW       60
	SUBWF       _sec+0, 0 
L__interrupt51:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt23
;xihmai_v1.c,96 :: 		sec=0;
	CLRF        _sec+0 
	CLRF        _sec+1 
;xihmai_v1.c,97 :: 		min++;
	INFSNZ      _min+0, 1 
	INCF        _min+1, 1 
;xihmai_v1.c,107 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;xihmai_v1.c,108 :: 		I2C2_Wr(ADDRESS_RTC);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;xihmai_v1.c,109 :: 		I2C2_Wr(0);        // Direccion de memoria
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;xihmai_v1.c,110 :: 		I2C2_Repeated_Start();
	CALL        _I2C2_Repeated_Start+0, 0
;xihmai_v1.c,111 :: 		I2C2_Wr(ADDRESS_RTC+1);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;xihmai_v1.c,114 :: 		for(i=0; i<6; i++)
	CLRF        _i+0 
L_interrupt25:
	MOVLW       128
	XORWF       _i+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       6
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt26
;xihmai_v1.c,116 :: 		rtcvalue[i]=I2C2_Rd(1);
	MOVLW       _rtcvalue+0
	MOVWF       FLOC__interrupt+0 
	MOVLW       hi_addr(_rtcvalue+0)
	MOVWF       FLOC__interrupt+1 
	MOVF        _i+0, 0 
	ADDWF       FLOC__interrupt+0, 1 
	MOVLW       0
	BTFSC       _i+0, 7 
	MOVLW       255
	ADDWFC      FLOC__interrupt+1, 1 
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVFF       FLOC__interrupt+0, FSR1
	MOVFF       FLOC__interrupt+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;xihmai_v1.c,114 :: 		for(i=0; i<6; i++)
	INCF        _i+0, 1 
;xihmai_v1.c,117 :: 		}
	GOTO        L_interrupt25
L_interrupt26:
;xihmai_v1.c,120 :: 		rtcvalue[i]=I2C2_Rd(0);
	MOVLW       _rtcvalue+0
	MOVWF       FLOC__interrupt+0 
	MOVLW       hi_addr(_rtcvalue+0)
	MOVWF       FLOC__interrupt+1 
	MOVF        _i+0, 0 
	ADDWF       FLOC__interrupt+0, 1 
	MOVLW       0
	BTFSC       _i+0, 7 
	MOVLW       255
	ADDWFC      FLOC__interrupt+1, 1 
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVFF       FLOC__interrupt+0, FSR1
	MOVFF       FLOC__interrupt+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;xihmai_v1.c,121 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
;xihmai_v1.c,123 :: 		msgSD[0] = ((Bcd2Dec(rtcvalue[4]))/10)+48;
	MOVF        _rtcvalue+4, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+0 
;xihmai_v1.c,124 :: 		msgSD[1] = ((Bcd2Dec(rtcvalue[4]))%10)+48;
	MOVF        _rtcvalue+4, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+1 
;xihmai_v1.c,125 :: 		msgSD[2] =  47;
	MOVLW       47
	MOVWF       _msgSD+2 
;xihmai_v1.c,126 :: 		msgSD[3] = ((Bcd2Dec(rtcvalue[5]))/10)+48;
	MOVF        _rtcvalue+5, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+3 
;xihmai_v1.c,127 :: 		msgSD[4] = ((Bcd2Dec(rtcvalue[5]))%10)+48;
	MOVF        _rtcvalue+5, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+4 
;xihmai_v1.c,128 :: 		msgSD[5] =  47;
	MOVLW       47
	MOVWF       _msgSD+5 
;xihmai_v1.c,129 :: 		msgSD[6] = ((Bcd2Dec(rtcvalue[6]))/10)+48;
	MOVF        _rtcvalue+6, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+6 
;xihmai_v1.c,130 :: 		msgSD[7] = ((Bcd2Dec(rtcvalue[6]))%10)+48;
	MOVF        _rtcvalue+6, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+7 
;xihmai_v1.c,131 :: 		msgSD[8] =  32;
	MOVLW       32
	MOVWF       _msgSD+8 
;xihmai_v1.c,132 :: 		msgSD[9] = ((Bcd2Dec(rtcvalue[2]))/10)+48;
	MOVF        _rtcvalue+2, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+9 
;xihmai_v1.c,133 :: 		msgSD[10] = ((Bcd2Dec(rtcvalue[2]))%10)+48;
	MOVF        _rtcvalue+2, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+10 
;xihmai_v1.c,134 :: 		msgSD[11]=  58;
	MOVLW       58
	MOVWF       _msgSD+11 
;xihmai_v1.c,135 :: 		msgSD[12] = ((Bcd2Dec(rtcvalue[1]))/10)+48;
	MOVF        _rtcvalue+1, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+12 
;xihmai_v1.c,136 :: 		msgSD[13] = ((Bcd2Dec(rtcvalue[1]))%10)+48;
	MOVF        _rtcvalue+1, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+13 
;xihmai_v1.c,137 :: 		msgSD[14]=  58;
	MOVLW       58
	MOVWF       _msgSD+14 
;xihmai_v1.c,138 :: 		msgSD[15] = ((Bcd2Dec(rtcvalue[0]))/10)+48;
	MOVF        _rtcvalue+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+15 
;xihmai_v1.c,139 :: 		msgSD[16] = ((Bcd2Dec(rtcvalue[0]))%10)+48;
	MOVF        _rtcvalue+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+16 
;xihmai_v1.c,141 :: 		msgSD[17]=  44;   //COMA
	MOVLW       44
	MOVWF       _msgSD+17 
;xihmai_v1.c,145 :: 		for(i=6; i>=0; i--)
	MOVLW       6
	MOVWF       _i+0 
L_interrupt28:
	MOVLW       128
	XORWF       _i+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt29
;xihmai_v1.c,147 :: 		rtcdata = Bcd2Dec(rtcvalue[i]);
	MOVLW       _rtcvalue+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_rtcvalue+0)
	MOVWF       FSR0H 
	MOVF        _i+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       _i+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _rtcdata+0 
;xihmai_v1.c,145 :: 		for(i=6; i>=0; i--)
	DECF        _i+0, 1 
;xihmai_v1.c,152 :: 		}
	GOTO        L_interrupt28
L_interrupt29:
;xihmai_v1.c,158 :: 		min = Bcd2Dec(rtcvalue[1]);
	MOVF        _rtcvalue+1, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _min+0 
	MOVLW       0
	MOVWF       _min+1 
;xihmai_v1.c,159 :: 		sec = Bcd2Dec(rtcvalue[0]);
	MOVF        _rtcvalue+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _sec+0 
	MOVLW       0
	MOVWF       _sec+1 
;xihmai_v1.c,165 :: 		temperature = getTemperature();
	CALL        _getTemperature+0, 0
	MOVF        R0, 0 
	MOVWF       _temperature+0 
	MOVF        R1, 0 
	MOVWF       _temperature+1 
	MOVF        R2, 0 
	MOVWF       _temperature+2 
	MOVF        R3, 0 
	MOVWF       _temperature+3 
;xihmai_v1.c,171 :: 		temperature=temperature*100;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__interrupt+1 
	MOVF        R2, 0 
	MOVWF       FLOC__interrupt+2 
	MOVF        R3, 0 
	MOVWF       FLOC__interrupt+3 
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       _temperature+0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       _temperature+1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       _temperature+2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       _temperature+3 
;xihmai_v1.c,172 :: 		msgSD[18] = ((int)(temperature/1000)%10)+48;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+18 
;xihmai_v1.c,173 :: 		msgSD[19] = ((int)(temperature/100)%10)+48;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+19 
;xihmai_v1.c,174 :: 		msgSD[20] = 46;
	MOVLW       46
	MOVWF       _msgSD+20 
;xihmai_v1.c,175 :: 		msgSD[21] =((int)(temperature/10)%10 )+48;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+21 
;xihmai_v1.c,176 :: 		msgSD[22] = ((int)(temperature/1)%10 )+48;
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+22 
;xihmai_v1.c,177 :: 		msgSD[23] = 44;
	MOVLW       44
	MOVWF       _msgSD+23 
;xihmai_v1.c,179 :: 		humidity = getHumidity();
	CALL        _getHumidity+0, 0
	MOVF        R0, 0 
	MOVWF       _humidity+0 
	MOVF        R1, 0 
	MOVWF       _humidity+1 
	MOVF        R2, 0 
	MOVWF       _humidity+2 
	MOVF        R3, 0 
	MOVWF       _humidity+3 
;xihmai_v1.c,184 :: 		humidity=humidity*100;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__interrupt+1 
	MOVF        R2, 0 
	MOVWF       FLOC__interrupt+2 
	MOVF        R3, 0 
	MOVWF       FLOC__interrupt+3 
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       _humidity+0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       _humidity+1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       _humidity+2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       _humidity+3 
;xihmai_v1.c,186 :: 		msgSD[24] = ((int)(humidity/1000)%10)+48;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+24 
;xihmai_v1.c,187 :: 		msgSD[25] = ((int)(humidity/100)%10)+48;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+25 
;xihmai_v1.c,188 :: 		msgSD[26] =  46;
	MOVLW       46
	MOVWF       _msgSD+26 
;xihmai_v1.c,189 :: 		msgSD[27] = ((int)(humidity/10)%10 )+48;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+27 
;xihmai_v1.c,190 :: 		msgSD[28] = ((int)(humidity/1)%10 )+48;
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+28 
;xihmai_v1.c,191 :: 		msgSD[29] = 44;
	MOVLW       44
	MOVWF       _msgSD+29 
;xihmai_v1.c,198 :: 		drops |=  (TMR0H << 8);
	MOVF        TMR0H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	IORWF       _drops+0, 1 
	MOVF        R1, 0 
	IORWF       _drops+1, 1 
;xihmai_v1.c,199 :: 		longtostr(goute,txt);
	MOVF        _goute+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _goute+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _goute+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _goute+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _txt+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;xihmai_v1.c,202 :: 		TMR0L = 0;
	CLRF        TMR0L+0 
;xihmai_v1.c,203 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;xihmai_v1.c,205 :: 		msgSD[30] = ((int)(goute/1000)%10)+48;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVF        _goute+0, 0 
	MOVWF       R0 
	MOVF        _goute+1, 0 
	MOVWF       R1 
	MOVF        _goute+2, 0 
	MOVWF       R2 
	MOVF        _goute+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+30 
;xihmai_v1.c,206 :: 		msgSD[31] = ((int)(goute/100)%10)+48;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        _goute+0, 0 
	MOVWF       R0 
	MOVF        _goute+1, 0 
	MOVWF       R1 
	MOVF        _goute+2, 0 
	MOVWF       R2 
	MOVF        _goute+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+31 
;xihmai_v1.c,207 :: 		msgSD[32] = ((int)(goute/10)%10 )+48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        _goute+0, 0 
	MOVWF       R0 
	MOVF        _goute+1, 0 
	MOVWF       R1 
	MOVF        _goute+2, 0 
	MOVWF       R2 
	MOVF        _goute+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+32 
;xihmai_v1.c,208 :: 		msgSD[33] = ((int)(goute/1)%10 )+48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _goute+0, 0 
	MOVWF       R0 
	MOVF        _goute+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _msgSD+33 
;xihmai_v1.c,209 :: 		msgSD[34] = 44;
	MOVLW       44
	MOVWF       _msgSD+34 
;xihmai_v1.c,210 :: 		msgSD[35] = 13;
	MOVLW       13
	MOVWF       _msgSD+35 
;xihmai_v1.c,213 :: 		goute=0;
	CLRF        _goute+0 
	CLRF        _goute+1 
	CLRF        _goute+2 
	CLRF        _goute+3 
;xihmai_v1.c,215 :: 		M_Open_File_Append() ;
	CALL        _M_Open_File_Append+0, 0
;xihmai_v1.c,216 :: 		}
L_interrupt23:
;xihmai_v1.c,218 :: 		INTCON.F1 = 0;
	BCF         INTCON+0, 1 
;xihmai_v1.c,219 :: 		}
L_interrupt21:
;xihmai_v1.c,220 :: 		}
L_end_interrupt:
L__interrupt50:
	RETFIE      1
; end of _interrupt

_main:

;xihmai_v1.c,223 :: 		void main()
;xihmai_v1.c,225 :: 		config();
	CALL        _config+0, 0
;xihmai_v1.c,228 :: 		while(1)
L_main31:
;xihmai_v1.c,230 :: 		drops = TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       _drops+0 
	MOVLW       0
	MOVWF       _drops+1 
;xihmai_v1.c,231 :: 		drops |=  (TMR0H << 8);
	MOVF        TMR0H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	IORWF       _drops+0, 0 
	MOVWF       R2 
	MOVF        _drops+1, 0 
	IORWF       R1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       _drops+0 
	MOVF        R3, 0 
	MOVWF       _drops+1 
;xihmai_v1.c,232 :: 		if(drops_b != drops)
	MOVF        _drops_b+1, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main53
	MOVF        R2, 0 
	XORWF       _drops_b+0, 0 
L__main53:
	BTFSC       STATUS+0, 2 
	GOTO        L_main33
;xihmai_v1.c,234 :: 		GREEN=1;
	BSF         LATB+0, 6 
;xihmai_v1.c,235 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main34:
	DECFSZ      R13, 1, 1
	BRA         L_main34
	DECFSZ      R12, 1, 1
	BRA         L_main34
	DECFSZ      R11, 1, 1
	BRA         L_main34
	NOP
	NOP
;xihmai_v1.c,236 :: 		GREEN=0;
	BCF         LATB+0, 6 
;xihmai_v1.c,237 :: 		goute++;
	MOVLW       1
	ADDWF       _goute+0, 1 
	MOVLW       0
	ADDWFC      _goute+1, 1 
	ADDWFC      _goute+2, 1 
	ADDWFC      _goute+3, 1 
;xihmai_v1.c,238 :: 		drops_b = TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       _drops_b+0 
	MOVLW       0
	MOVWF       _drops_b+1 
;xihmai_v1.c,239 :: 		drops_b |=  (TMR0H << 8);
	MOVF        TMR0H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	IORWF       _drops_b+0, 1 
	MOVF        R1, 0 
	IORWF       _drops_b+1, 1 
;xihmai_v1.c,240 :: 		}
L_main33:
;xihmai_v1.c,241 :: 		}
	GOTO        L_main31
;xihmai_v1.c,242 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;xihmai_v1.c,245 :: 		void config (void)
;xihmai_v1.c,248 :: 		ANSELA=0;
	CLRF        ANSELA+0 
;xihmai_v1.c,249 :: 		ANSELB=0;
	CLRF        ANSELB+0 
;xihmai_v1.c,250 :: 		ANSELC=0;
	CLRF        ANSELC+0 
;xihmai_v1.c,253 :: 		TRISB.F7=0;
	BCF         TRISB+0, 7 
;xihmai_v1.c,254 :: 		TRISB.F6=0;
	BCF         TRISB+0, 6 
;xihmai_v1.c,255 :: 		TRISB.F5=0;
	BCF         TRISB+0, 5 
;xihmai_v1.c,258 :: 		INTCON = 0XD0;
	MOVLW       208
	MOVWF       INTCON+0 
;xihmai_v1.c,259 :: 		INTCON.F1 = 0;          // FLAG
	BCF         INTCON+0, 1 
;xihmai_v1.c,260 :: 		INTCON2.F6 = 0;         // EDGE
	BCF         INTCON2+0, 6 
;xihmai_v1.c,261 :: 		TRISB.F0=1;
	BSF         TRISB+0, 0 
;xihmai_v1.c,264 :: 		T0CON = 0XA8;
	MOVLW       168
	MOVWF       T0CON+0 
;xihmai_v1.c,265 :: 		TMR0L = 0X00;
	CLRF        TMR0L+0 
;xihmai_v1.c,266 :: 		TMR0H = 0X00;
	CLRF        TMR0H+0 
;xihmai_v1.c,267 :: 		TRISA.F4 = 1;
	BSF         TRISA+0, 4 
;xihmai_v1.c,270 :: 		PORTA = 0;
	CLRF        PORTA+0 
;xihmai_v1.c,271 :: 		PORTB = 0;
	CLRF        PORTB+0 
;xihmai_v1.c,272 :: 		PORTC = 0;
	CLRF        PORTC+0 
;xihmai_v1.c,275 :: 		home = 1;
	MOVLW       1
	MOVWF       _home+0 
;xihmai_v1.c,276 :: 		for(i=0; i<6; i++)
	CLRF        _i+0 
L_config35:
	MOVLW       128
	XORWF       _i+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       6
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_config36
;xihmai_v1.c,278 :: 		time[i] = 0;
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _i+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _time+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_time+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;xihmai_v1.c,276 :: 		for(i=0; i<6; i++)
	INCF        _i+0, 1 
;xihmai_v1.c,279 :: 		}
	GOTO        L_config35
L_config36:
;xihmai_v1.c,280 :: 		}
L_end_config:
	RETURN      0
; end of _config

_modules:

;xihmai_v1.c,282 :: 		void modules (void)
;xihmai_v1.c,291 :: 		th02Init();
	CALL        _th02Init+0, 0
;xihmai_v1.c,292 :: 		Accelconfig();
	CALL        _Accelconfig+0, 0
;xihmai_v1.c,293 :: 		}
L_end_modules:
	RETURN      0
; end of _modules

_M_Create_New_File:

;xihmai_v1.c,295 :: 		void M_Create_New_File() {
;xihmai_v1.c,298 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;xihmai_v1.c,300 :: 		if (Mmc_Fat_Init_B() == 0) {
	CALL        _Mmc_Fat_Init_B+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_M_Create_New_File38
;xihmai_v1.c,302 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;xihmai_v1.c,311 :: 		Mmc_Fat_Assign_B(&filename, 0xA0);          // Find existing file or create a new one
	MOVLW       _filename+0
	MOVWF       FARG_Mmc_Fat_Assign_B_filename+0 
	MOVLW       hi_addr(_filename+0)
	MOVWF       FARG_Mmc_Fat_Assign_B_filename+1 
	MOVLW       160
	MOVWF       FARG_Mmc_Fat_Assign_B_file_cre_attr+0 
	CALL        _Mmc_Fat_Assign_B+0, 0
;xihmai_v1.c,318 :: 		filenumber++;
	INFSNZ      _filenumber+0, 1 
	INCF        _filenumber+1, 1 
;xihmai_v1.c,319 :: 		EEPROM_Write(0, (filenumber/100)%10);
	CLRF        FARG_EEPROM_Write_address+0 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _filenumber+0, 0 
	MOVWF       R0 
	MOVF        _filenumber+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;xihmai_v1.c,320 :: 		EEPROM_Write(1, (filenumber/10)%10);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _filenumber+0, 0 
	MOVWF       R0 
	MOVF        _filenumber+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;xihmai_v1.c,321 :: 		EEPROM_Write(2, (filenumber/1)%10);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _filenumber+0, 0 
	MOVWF       R0 
	MOVF        _filenumber+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;xihmai_v1.c,323 :: 		}
	GOTO        L_M_Create_New_File39
L_M_Create_New_File38:
;xihmai_v1.c,329 :: 		}
L_M_Create_New_File39:
;xihmai_v1.c,330 :: 		}
L_end_M_Create_New_File:
	RETURN      0
; end of _M_Create_New_File

_M_Open_File_Append:

;xihmai_v1.c,332 :: 		void M_Open_File_Append() {
;xihmai_v1.c,334 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;xihmai_v1.c,336 :: 		if (Mmc_Fat_Init_B() == 0) {
	CALL        _Mmc_Fat_Init_B+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_M_Open_File_Append40
;xihmai_v1.c,338 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;xihmai_v1.c,345 :: 		Mmc_Fat_Assign_B(filename, 0xA0);
	MOVLW       _filename+0
	MOVWF       FARG_Mmc_Fat_Assign_B_filename+0 
	MOVLW       hi_addr(_filename+0)
	MOVWF       FARG_Mmc_Fat_Assign_B_filename+1 
	MOVLW       160
	MOVWF       FARG_Mmc_Fat_Assign_B_file_cre_attr+0 
	CALL        _Mmc_Fat_Assign_B+0, 0
;xihmai_v1.c,346 :: 		Mmc_Fat_Append_B();                                    // Prepare file for append
	CALL        _Mmc_Fat_Append_B+0, 0
;xihmai_v1.c,347 :: 		Mmc_Fat_Write_B(msgSD, 36);   // Write data to assigned file
	MOVLW       _msgSD+0
	MOVWF       FARG_Mmc_Fat_Write_B_fdata+0 
	MOVLW       hi_addr(_msgSD+0)
	MOVWF       FARG_Mmc_Fat_Write_B_fdata+1 
	MOVLW       36
	MOVWF       FARG_Mmc_Fat_Write_B_data_len+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Fat_Write_B_data_len+1 
	CALL        _Mmc_Fat_Write_B+0, 0
;xihmai_v1.c,352 :: 		}
	GOTO        L_M_Open_File_Append41
L_M_Open_File_Append40:
;xihmai_v1.c,354 :: 		RED=1;
	BSF         LATB+0, 7 
;xihmai_v1.c,357 :: 		Delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_M_Open_File_Append42:
	DECFSZ      R13, 1, 1
	BRA         L_M_Open_File_Append42
	DECFSZ      R12, 1, 1
	BRA         L_M_Open_File_Append42
	DECFSZ      R11, 1, 1
	BRA         L_M_Open_File_Append42
	NOP
;xihmai_v1.c,358 :: 		RED=0;
	BCF         LATB+0, 7 
;xihmai_v1.c,359 :: 		}
L_M_Open_File_Append41:
;xihmai_v1.c,360 :: 		}
L_end_M_Open_File_Append:
	RETURN      0
; end of _M_Open_File_Append
