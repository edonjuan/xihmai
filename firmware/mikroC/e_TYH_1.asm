
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
	GOTO        L__getHumidity10
	MOVF        R1, 0 
	SUBLW       192
L__getHumidity10:
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
	GOTO        L__getHumidity11
	MOVLW       128
	SUBWF       getHumidity_buffer_L0+0, 0 
L__getHumidity11:
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

_main:

;e_TYH_1.c,3 :: 		void main() {
;e_TYH_1.c,4 :: 		th02Init();
	CALL        _th02Init+0, 0
;e_TYH_1.c,5 :: 		getTemperature();
	CALL        _getTemperature+0, 0
;e_TYH_1.c,7 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
