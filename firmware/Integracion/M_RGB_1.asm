
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
;th02.h,8 :: 		}
L_end_th02Init:
	RETURN      0
; end of _th02Init

_getTemperature:

;th02.h,10 :: 		float getTemperature(void)
;th02.h,15 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;th02.h,16 :: 		I2C1_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,17 :: 		I2C1_Wr(0x03);                // Address Pointer
	MOVLW       3
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,18 :: 		I2C1_Wr(0x11);                // Register Data
	MOVLW       17
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,19 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
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
;th02.h,23 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;th02.h,24 :: 		I2C1_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,25 :: 		I2C1_Wr(0x01);                // Address Pointer
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,26 :: 		I2C1_Repeated_start();
	CALL        _I2C1_Repeated_Start+0, 0
;th02.h,27 :: 		I2C1_Wr(0x81);                // Address Device + Read
	MOVLW       129
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,28 :: 		buffer =  I2C1_Rd(1) << 8;
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       getTemperature_buffer_L0+1 
	CLRF        getTemperature_buffer_L0+0 
;th02.h,29 :: 		buffer |=  I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       getTemperature_buffer_L0+0, 1 
	MOVLW       0
	IORWF       getTemperature_buffer_L0+1, 1 
;th02.h,30 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
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
;th02.h,44 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;th02.h,45 :: 		I2C1_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,46 :: 		I2C1_Wr(0x03);                // Address Pointer
	MOVLW       3
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,47 :: 		I2C1_Wr(0x01);                // Register Data
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,48 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
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
;th02.h,52 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;th02.h,53 :: 		I2C1_Wr(0x80);                // Address Device + Write
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,54 :: 		I2C1_Wr(0x01);                // Address Pointer
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,55 :: 		I2C1_Repeated_start();
	CALL        _I2C1_Repeated_Start+0, 0
;th02.h,56 :: 		I2C1_Wr(0x81);                // Address Device + Read
	MOVLW       129
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;th02.h,57 :: 		buffer =  I2C1_Rd(1) << 8;
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       getHumidity_buffer_L0+1 
	CLRF        getHumidity_buffer_L0+0 
;th02.h,58 :: 		buffer |=  I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       getHumidity_buffer_L0+0, 1 
	MOVLW       0
	IORWF       getHumidity_buffer_L0+1, 1 
;th02.h,59 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
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
	GOTO        L__getHumidity61
	MOVF        R1, 0 
	SUBLW       192
L__getHumidity61:
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
	GOTO        L__getHumidity62
	MOVLW       128
	SUBWF       getHumidity_buffer_L0+0, 0 
L__getHumidity62:
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
;accel.h,10 :: 		I2C1_Start();                // Configuring MPU6050 and interruption
	CALL        _I2C1_Start+0, 0
;accel.h,11 :: 		I2C1_Wr(0xD2);                          // 19 x(4F)
	MOVLW       210
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;accel.h,12 :: 		I2C1_Wr(0x19);                           //D0
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
	MOVLW       210
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
	MOVLW       210
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
	MOVLW       210
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
	MOVLW       210
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
	MOVLW       210
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
	MOVLW       210
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
	MOVLW       210
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
	MOVLW       210
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
	MOVLW       210
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
	MOVLW       210
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
	MOVLW       210
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

_Escribir:

;metodos_ds1307.h,4 :: 		unsigned char dato){
;metodos_ds1307.h,5 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;metodos_ds1307.h,6 :: 		I2C1_Wr(direccion_esclavo);
	MOVF        FARG_Escribir_direccion_esclavo+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,7 :: 		I2C1_Wr(direccion_memoria);    // MEMORIA L
	MOVF        FARG_Escribir_direccion_memoria+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,8 :: 		I2C1_Wr(dato); // DATO
	MOVF        FARG_Escribir_dato+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,9 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;metodos_ds1307.h,10 :: 		}
L_end_Escribir:
	RETURN      0
; end of _Escribir

_Leer:

;metodos_ds1307.h,13 :: 		unsigned char direccion_memoria){
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
;metodos_ds1307.h,20 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;metodos_ds1307.h,21 :: 		I2C1_Wr(direccion_esclavo+1);
	MOVF        FARG_Leer_direccion_esclavo+0, 0 
	ADDLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;metodos_ds1307.h,25 :: 		LATB.F5 = 1;   //BLUE
	BSF         LATB+0, 5 
;metodos_ds1307.h,26 :: 		valor=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Leer_valor_L0+0 
	MOVLW       0
	MOVWF       Leer_valor_L0+1 
;metodos_ds1307.h,27 :: 		LATB.F5 = 0;
	BCF         LATB+0, 5 
;metodos_ds1307.h,28 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;metodos_ds1307.h,32 :: 		return valor;
	MOVF        Leer_valor_L0+0, 0 
	MOVWF       R0 
	MOVF        Leer_valor_L0+1, 0 
	MOVWF       R1 
;metodos_ds1307.h,33 :: 		}
L_end_Leer:
	RETURN      0
; end of _Leer

_set_Fecha_hora:

;metodos_ds1307.h,36 :: 		int dia_semana, int dia, int mes, int ano){
;metodos_ds1307.h,38 :: 		segundos   = Dec2Bcd(segundos);
	MOVF        FARG_set_Fecha_hora_segundos+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_segundos+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_segundos+1 
;metodos_ds1307.h,39 :: 		minutos    = Dec2Bcd(minutos);
	MOVF        FARG_set_Fecha_hora_minutos+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_minutos+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_minutos+1 
;metodos_ds1307.h,40 :: 		hora       = Dec2Bcd(hora);
	MOVF        FARG_set_Fecha_hora_hora+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_hora+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_hora+1 
;metodos_ds1307.h,41 :: 		dia_semana = Dec2Bcd(dia_semana);
	MOVF        FARG_set_Fecha_hora_dia_semana+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_dia_semana+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_dia_semana+1 
;metodos_ds1307.h,42 :: 		dia        = Dec2Bcd(dia);
	MOVF        FARG_set_Fecha_hora_dia+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_dia+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_dia+1 
;metodos_ds1307.h,43 :: 		mes        = Dec2Bcd(mes);
	MOVF        FARG_set_Fecha_hora_mes+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_mes+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_mes+1 
;metodos_ds1307.h,44 :: 		ano        = Dec2Bcd(ano);
	MOVF        FARG_set_Fecha_hora_ano+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_set_Fecha_hora_ano+0 
	MOVLW       0
	MOVWF       FARG_set_Fecha_hora_ano+1 
;metodos_ds1307.h,46 :: 		for(i=0; i<=6; i++){
	CLRF        set_Fecha_hora_i_L0+0 
	CLRF        set_Fecha_hora_i_L0+1 
L_set_Fecha_hora21:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       set_Fecha_hora_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora67
	MOVF        set_Fecha_hora_i_L0+0, 0 
	SUBLW       6
L__set_Fecha_hora67:
	BTFSS       STATUS+0, 0 
	GOTO        L_set_Fecha_hora22
;metodos_ds1307.h,47 :: 		switch(i){
	GOTO        L_set_Fecha_hora24
;metodos_ds1307.h,48 :: 		case 0: Escribir(0xD0,i,segundos)  ;break;
L_set_Fecha_hora26:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_segundos+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora25
;metodos_ds1307.h,49 :: 		case 1: Escribir(0xD0,i,minutos)   ;break;
L_set_Fecha_hora27:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_minutos+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora25
;metodos_ds1307.h,50 :: 		case 2: Escribir(0xD0,i,hora)      ;break;
L_set_Fecha_hora28:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_hora+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora25
;metodos_ds1307.h,51 :: 		case 3: Escribir(0xD0,i,dia_semana);break;
L_set_Fecha_hora29:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_dia_semana+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora25
;metodos_ds1307.h,52 :: 		case 4: Escribir(0xD0,i,dia)       ;break;
L_set_Fecha_hora30:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_dia+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora25
;metodos_ds1307.h,53 :: 		case 5: Escribir(0xD0,i,mes)       ;break;
L_set_Fecha_hora31:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_mes+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora25
;metodos_ds1307.h,54 :: 		case 6: Escribir(0xD0,i,ano)       ;break;
L_set_Fecha_hora32:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        set_Fecha_hora_i_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_set_Fecha_hora_ano+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_set_Fecha_hora25
;metodos_ds1307.h,55 :: 		}
L_set_Fecha_hora24:
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora68
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora68:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora26
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora69
	MOVLW       1
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora69:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora27
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora70
	MOVLW       2
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora70:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora28
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora71
	MOVLW       3
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora71:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora29
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora72
	MOVLW       4
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora72:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora30
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora73
	MOVLW       5
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora73:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora31
	MOVLW       0
	XORWF       set_Fecha_hora_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__set_Fecha_hora74
	MOVLW       6
	XORWF       set_Fecha_hora_i_L0+0, 0 
L__set_Fecha_hora74:
	BTFSC       STATUS+0, 2 
	GOTO        L_set_Fecha_hora32
L_set_Fecha_hora25:
;metodos_ds1307.h,46 :: 		for(i=0; i<=6; i++){
	INFSNZ      set_Fecha_hora_i_L0+0, 1 
	INCF        set_Fecha_hora_i_L0+1, 1 
;metodos_ds1307.h,56 :: 		}
	GOTO        L_set_Fecha_hora21
L_set_Fecha_hora22:
;metodos_ds1307.h,57 :: 		}
L_end_set_Fecha_hora:
	RETURN      0
; end of _set_Fecha_hora

_Alarmas:

;metodos_ds1307.h,60 :: 		int A2min, int A2hora, int A2dia, int conf){
;metodos_ds1307.h,62 :: 		A1seg =  Dec2Bcd(A1seg);
	MOVF        FARG_Alarmas_A1seg+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A1seg+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A1seg+1 
;metodos_ds1307.h,63 :: 		A1min =  Dec2Bcd(A1min);
	MOVF        FARG_Alarmas_A1min+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A1min+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A1min+1 
;metodos_ds1307.h,64 :: 		A1hora=  Dec2Bcd(A1hora);
	MOVF        FARG_Alarmas_A1hora+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A1hora+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A1hora+1 
;metodos_ds1307.h,65 :: 		A1dia =  Dec2Bcd(A1dia);
	MOVF        FARG_Alarmas_A1dia+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A1dia+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A1dia+1 
;metodos_ds1307.h,66 :: 		A2min =  Dec2Bcd(A2min);
	MOVF        FARG_Alarmas_A2min+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A2min+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A2min+1 
;metodos_ds1307.h,67 :: 		A2hora=  Dec2Bcd(A2hora);
	MOVF        FARG_Alarmas_A2hora+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A2hora+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A2hora+1 
;metodos_ds1307.h,68 :: 		A2dia =  Dec2Bcd(A2dia);
	MOVF        FARG_Alarmas_A2dia+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_A2dia+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_A2dia+1 
;metodos_ds1307.h,69 :: 		conf  =  Dec2Bcd(conf);
	MOVF        FARG_Alarmas_conf+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Alarmas_conf+0 
	MOVLW       0
	MOVWF       FARG_Alarmas_conf+1 
;metodos_ds1307.h,71 :: 		UART1_Write_Text("Configurando");
	MOVLW       ?lstr1_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;metodos_ds1307.h,72 :: 		UART1_Write_Text("\r\n   \r\n");
	MOVLW       ?lstr2_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;metodos_ds1307.h,73 :: 		for(t=7; t<=14; t++){
	MOVLW       7
	MOVWF       Alarmas_t_L0+0 
	MOVLW       0
	MOVWF       Alarmas_t_L0+1 
L_Alarmas33:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       Alarmas_t_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas76
	MOVF        Alarmas_t_L0+0, 0 
	SUBLW       14
L__Alarmas76:
	BTFSS       STATUS+0, 0 
	GOTO        L_Alarmas34
;metodos_ds1307.h,74 :: 		switch (t){
	GOTO        L_Alarmas36
;metodos_ds1307.h,75 :: 		case 7: Escribir(0xD0,t,A1seg)   ;break;
L_Alarmas38:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A1seg+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas37
;metodos_ds1307.h,76 :: 		case 8: Escribir(0xD0,t,A1min)   ;break;
L_Alarmas39:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A1min+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas37
;metodos_ds1307.h,77 :: 		case 9: Escribir(0xD0,t,A1hora)  ;break;
L_Alarmas40:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A1hora+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas37
;metodos_ds1307.h,78 :: 		case 10: Escribir(0xD0,t,A1dia)  ;break;
L_Alarmas41:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A1dia+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas37
;metodos_ds1307.h,79 :: 		case 11: Escribir(0xD0,t,A2min)  ;break;
L_Alarmas42:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A2min+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas37
;metodos_ds1307.h,80 :: 		case 12: Escribir(0xD0,t, A2hora);break;
L_Alarmas43:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A2hora+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas37
;metodos_ds1307.h,81 :: 		case 13: Escribir(0xD0,t, A2dia) ;break;
L_Alarmas44:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_A2dia+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas37
;metodos_ds1307.h,82 :: 		case 14: Escribir(0xD0,t, conf) ;break;
L_Alarmas45:
	MOVLW       208
	MOVWF       FARG_Escribir_direccion_esclavo+0 
	MOVF        Alarmas_t_L0+0, 0 
	MOVWF       FARG_Escribir_direccion_memoria+0 
	MOVF        FARG_Alarmas_conf+0, 0 
	MOVWF       FARG_Escribir_dato+0 
	CALL        _Escribir+0, 0
	GOTO        L_Alarmas37
;metodos_ds1307.h,83 :: 		}
L_Alarmas36:
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas77
	MOVLW       7
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas77:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas38
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas78
	MOVLW       8
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas78:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas39
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas79
	MOVLW       9
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas79:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas40
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas80
	MOVLW       10
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas80:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas41
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas81
	MOVLW       11
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas81:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas42
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas82
	MOVLW       12
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas82:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas43
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas83
	MOVLW       13
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas83:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas44
	MOVLW       0
	XORWF       Alarmas_t_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alarmas84
	MOVLW       14
	XORWF       Alarmas_t_L0+0, 0 
L__Alarmas84:
	BTFSC       STATUS+0, 2 
	GOTO        L_Alarmas45
L_Alarmas37:
;metodos_ds1307.h,73 :: 		for(t=7; t<=14; t++){
	INFSNZ      Alarmas_t_L0+0, 1 
	INCF        Alarmas_t_L0+1, 1 
;metodos_ds1307.h,84 :: 		}
	GOTO        L_Alarmas33
L_Alarmas34:
;metodos_ds1307.h,85 :: 		UART1_Write_Text("finish");
	MOVLW       ?lstr3_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;metodos_ds1307.h,86 :: 		UART1_Write_Text("\r\n   \r\n");
	MOVLW       ?lstr4_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;metodos_ds1307.h,87 :: 		}
L_end_Alarmas:
	RETURN      0
; end of _Alarmas

_interrupt:

;M_RGB_1.c,29 :: 		void interrupt()
;M_RGB_1.c,31 :: 		if(INTCON.F1)                     // External interrupt
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt46
;M_RGB_1.c,34 :: 		if(home)
	MOVF        _home+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt47
;M_RGB_1.c,36 :: 		modules();
	CALL        _modules+0, 0
;M_RGB_1.c,37 :: 		home = 0;
	CLRF        _home+0 
;M_RGB_1.c,38 :: 		}
L_interrupt47:
;M_RGB_1.c,41 :: 		sec++;
	INFSNZ      _sec+0, 1 
	INCF        _sec+1, 1 
;M_RGB_1.c,42 :: 		if(sec>=10)
	MOVLW       0
	SUBWF       _sec+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt87
	MOVLW       10
	SUBWF       _sec+0, 0 
L__interrupt87:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt48
;M_RGB_1.c,44 :: 		sec=0;
	CLRF        _sec+0 
	CLRF        _sec+1 
;M_RGB_1.c,46 :: 		temperature = getTemperature();
	CALL        _getTemperature+0, 0
	MOVF        R0, 0 
	MOVWF       _temperature+0 
	MOVF        R1, 0 
	MOVWF       _temperature+1 
	MOVF        R2, 0 
	MOVWF       _temperature+2 
	MOVF        R3, 0 
	MOVWF       _temperature+3 
;M_RGB_1.c,47 :: 		floattostr(temperature, txt);
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
;M_RGB_1.c,48 :: 		UART1_Write_Text("TEMPERATURE: ");
	MOVLW       ?lstr5_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,49 :: 		UART1_Write_Text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,50 :: 		uart1_write_text("°C\r\n");
	MOVLW       ?lstr6_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,54 :: 		humidity = getHumidity();
	CALL        _getHumidity+0, 0
	MOVF        R0, 0 
	MOVWF       _humidity+0 
	MOVF        R1, 0 
	MOVWF       _humidity+1 
	MOVF        R2, 0 
	MOVWF       _humidity+2 
	MOVF        R3, 0 
	MOVWF       _humidity+3 
;M_RGB_1.c,55 :: 		floattostr(humidity, txt);
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
;M_RGB_1.c,56 :: 		UART1_Write_Text("HUMEDAD: ");
	MOVLW       ?lstr7_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,57 :: 		UART1_Write_Text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,58 :: 		uart1_write_text("%\r\n");
	MOVLW       ?lstr8_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,62 :: 		UART1_Write_Text("Drops: ");
	MOVLW       ?lstr9_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,63 :: 		drops = TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       _drops+0 
	MOVLW       0
	MOVWF       _drops+1 
;M_RGB_1.c,64 :: 		drops |=  (TMR0H << 8);
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
;M_RGB_1.c,65 :: 		inttostr(drops, txt);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;M_RGB_1.c,66 :: 		UART1_Write_Text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,67 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr10_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,68 :: 		TMR0L = 0;
	CLRF        TMR0L+0 
;M_RGB_1.c,69 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;M_RGB_1.c,72 :: 		UART1_Write_Text("Time: ");
	MOVLW       ?lstr11_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,73 :: 		for(i=6; i>0; i--)
	MOVLW       6
	MOVWF       _i+0 
L_interrupt49:
	MOVF        _i+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt50
;M_RGB_1.c,75 :: 		time = Leer(ADDRESS_RTC,i);
	MOVLW       208
	MOVWF       FARG_Leer_direccion_esclavo+0 
	MOVF        _i+0, 0 
	MOVWF       FARG_Leer_direccion_memoria+0 
	CALL        _Leer+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
	MOVF        R1, 0 
	MOVWF       _time+1 
;M_RGB_1.c,77 :: 		time = Bcd2Dec(time);
	MOVF        R0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
	MOVLW       0
	MOVWF       _time+1 
;M_RGB_1.c,78 :: 		UART1_Write( (time/10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _time+0, 0 
	MOVWF       R0 
	MOVF        _time+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;M_RGB_1.c,79 :: 		UART1_Write( (time%10) + 48 );
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _time+0, 0 
	MOVWF       R0 
	MOVF        _time+1, 0 
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
;M_RGB_1.c,80 :: 		UART1_Write( ':' );
	MOVLW       58
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;M_RGB_1.c,73 :: 		for(i=6; i>0; i--)
	DECF        _i+0, 1 
;M_RGB_1.c,81 :: 		}
	GOTO        L_interrupt49
L_interrupt50:
;M_RGB_1.c,82 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr12_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,83 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr13_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,84 :: 		}
L_interrupt48:
;M_RGB_1.c,85 :: 		RED = ~ RED;              // Clear flag
	BTG         LATB+0, 7 
;M_RGB_1.c,86 :: 		INTCON.F1 = 0;
	BCF         INTCON+0, 1 
;M_RGB_1.c,87 :: 		}
L_interrupt46:
;M_RGB_1.c,88 :: 		}
L_end_interrupt:
L__interrupt86:
	RETFIE      1
; end of _interrupt

_main:

;M_RGB_1.c,91 :: 		void main()
;M_RGB_1.c,93 :: 		config();
	CALL        _config+0, 0
;M_RGB_1.c,96 :: 		while(1)
L_main52:
;M_RGB_1.c,98 :: 		drops = TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       _drops+0 
	MOVLW       0
	MOVWF       _drops+1 
;M_RGB_1.c,99 :: 		drops |=  (TMR0H << 8);
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
;M_RGB_1.c,100 :: 		if(drops_b != drops)
	MOVF        _drops_b+1, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main89
	MOVF        R2, 0 
	XORWF       _drops_b+0, 0 
L__main89:
	BTFSC       STATUS+0, 2 
	GOTO        L_main54
;M_RGB_1.c,102 :: 		drops_b = drops;
	MOVF        _drops+0, 0 
	MOVWF       _drops_b+0 
	MOVF        _drops+1, 0 
	MOVWF       _drops_b+1 
;M_RGB_1.c,103 :: 		GREEN = 1;
	BSF         LATB+0, 6 
;M_RGB_1.c,104 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main55:
	DECFSZ      R13, 1, 1
	BRA         L_main55
	DECFSZ      R12, 1, 1
	BRA         L_main55
	NOP
;M_RGB_1.c,105 :: 		GREEN = 0;
	BCF         LATB+0, 6 
;M_RGB_1.c,106 :: 		}
L_main54:
;M_RGB_1.c,107 :: 		delay_ms(20);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main56:
	DECFSZ      R13, 1, 1
	BRA         L_main56
	DECFSZ      R12, 1, 1
	BRA         L_main56
	NOP
	NOP
;M_RGB_1.c,108 :: 		}
	GOTO        L_main52
;M_RGB_1.c,109 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_config:

;M_RGB_1.c,112 :: 		void config (void)
;M_RGB_1.c,115 :: 		ANSELA=0;
	CLRF        ANSELA+0 
;M_RGB_1.c,116 :: 		ANSELB=0;
	CLRF        ANSELB+0 
;M_RGB_1.c,117 :: 		ANSELC=0;
	CLRF        ANSELC+0 
;M_RGB_1.c,120 :: 		TRISB.F7=0;
	BCF         TRISB+0, 7 
;M_RGB_1.c,121 :: 		TRISB.F6=0;
	BCF         TRISB+0, 6 
;M_RGB_1.c,122 :: 		TRISB.F5=0;
	BCF         TRISB+0, 5 
;M_RGB_1.c,125 :: 		INTCON = 0XD0;
	MOVLW       208
	MOVWF       INTCON+0 
;M_RGB_1.c,126 :: 		INTCON.F1 = 0;          // FLAG
	BCF         INTCON+0, 1 
;M_RGB_1.c,127 :: 		INTCON2.F6 = 0;         // EDGE
	BCF         INTCON2+0, 6 
;M_RGB_1.c,128 :: 		TRISB.F0=1;
	BSF         TRISB+0, 0 
;M_RGB_1.c,131 :: 		T0CON = 0XA8;
	MOVLW       168
	MOVWF       T0CON+0 
;M_RGB_1.c,132 :: 		TMR0L = 0X00;
	CLRF        TMR0L+0 
;M_RGB_1.c,133 :: 		TMR0H = 0X00;
	CLRF        TMR0H+0 
;M_RGB_1.c,134 :: 		TRISA.F4 = 1;
	BSF         TRISA+0, 4 
;M_RGB_1.c,137 :: 		PORTA = 0;
	CLRF        PORTA+0 
;M_RGB_1.c,138 :: 		PORTB = 0;
	CLRF        PORTB+0 
;M_RGB_1.c,139 :: 		PORTC = 0;
	CLRF        PORTC+0 
;M_RGB_1.c,141 :: 		home = 1;
	MOVLW       1
	MOVWF       _home+0 
;M_RGB_1.c,142 :: 		}
L_end_config:
	RETURN      0
; end of _config

_modules:

;M_RGB_1.c,144 :: 		void modules (void)
;M_RGB_1.c,147 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;M_RGB_1.c,148 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_modules57:
	DECFSZ      R13, 1, 1
	BRA         L_modules57
	DECFSZ      R12, 1, 1
	BRA         L_modules57
	DECFSZ      R11, 1, 1
	BRA         L_modules57
	NOP
	NOP
;M_RGB_1.c,150 :: 		UART1_Write_Text("Configuration init: ");
	MOVLW       ?lstr14_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,151 :: 		uart1_write_text("\r\n");
	MOVLW       ?lstr15_M_RGB_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr15_M_RGB_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;M_RGB_1.c,153 :: 		th02Init();
	CALL        _th02Init+0, 0
;M_RGB_1.c,154 :: 		Accelconfig();
	CALL        _Accelconfig+0, 0
;M_RGB_1.c,155 :: 		}
L_end_modules:
	RETURN      0
; end of _modules
