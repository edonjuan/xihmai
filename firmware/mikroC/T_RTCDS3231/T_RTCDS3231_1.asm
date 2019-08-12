
_Interrupt:

;T_RTCDS3231_1.c,25 :: 		void Interrupt() {
;T_RTCDS3231_1.c,27 :: 		}
L_end_Interrupt:
L__Interrupt124:
	RETFIE      1
; end of _Interrupt

_DS3231_read:

;T_RTCDS3231_1.c,28 :: 		void DS3231_read(){                            // Read time & calendar data function
;T_RTCDS3231_1.c,29 :: 		I2C1_Start();                                // Start I2C protocol
	CALL        _I2C1_Start+0, 0
;T_RTCDS3231_1.c,30 :: 		I2C1_Wr(0xD0);                               // DS3231 address
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,31 :: 		I2C1_Wr(0);                                  // Send register address (seconds register)
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,32 :: 		I2C1_Repeated_Start();                       // Restart I2C
	CALL        _I2C1_Repeated_Start+0, 0
;T_RTCDS3231_1.c,33 :: 		I2C1_Wr(0xD1);                               // Initialize data read
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,34 :: 		second = I2C1_Rd(1);                         // Read seconds from register 0
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _second+0 
;T_RTCDS3231_1.c,35 :: 		minute = I2C1_Rd(1);                         // Read minutes from register 1
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _minute+0 
;T_RTCDS3231_1.c,36 :: 		hour   = I2C1_Rd(1);                         // Read hour from register 2
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _hour+0 
;T_RTCDS3231_1.c,37 :: 		day    = I2C1_Rd(1);                         // Read day from register 3
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _day+0 
;T_RTCDS3231_1.c,38 :: 		date   = I2C1_Rd(1);                         // Read date from register 4
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _date+0 
;T_RTCDS3231_1.c,39 :: 		month  = I2C1_Rd(1);                         // Read month from register 5
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _month+0 
;T_RTCDS3231_1.c,40 :: 		year   = I2C1_Rd(0);                         // Read year from register 6
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _year+0 
;T_RTCDS3231_1.c,41 :: 		I2C1_Stop();                                 // Stop I2C protocol
	CALL        _I2C1_Stop+0, 0
;T_RTCDS3231_1.c,42 :: 		}
L_end_DS3231_read:
	RETURN      0
; end of _DS3231_read

_alarms_read_display:

;T_RTCDS3231_1.c,43 :: 		void alarms_read_display(){                    // Read and display alarm1 and alarm2 data function
;T_RTCDS3231_1.c,46 :: 		I2C1_Start();                                 // Start I2C protocol
	CALL        _I2C1_Start+0, 0
;T_RTCDS3231_1.c,47 :: 		I2C1_Wr(0xD0);                                // DS3231 address
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,48 :: 		I2C1_Wr(0x08);                                // Send register address (alarm1 minutes register)
	MOVLW       8
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,49 :: 		i2c_restart();                                // Restart I2C
	CALL        _I2C_Restart+0, 0
;T_RTCDS3231_1.c,50 :: 		I2C1_Wr(0xD1);                                // Initialize data read
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,51 :: 		alarm1_minute = I2C1_Rd(1);                   // Read alarm1 minutes
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _alarm1_minute+0 
;T_RTCDS3231_1.c,52 :: 		alarm1_hour   = I2C1_Rd(1);                   // Read alarm1 hours
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _alarm1_hour+0 
;T_RTCDS3231_1.c,53 :: 		I2C1_Rd(1);                                   // Skip alarm1 day/date register
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
;T_RTCDS3231_1.c,54 :: 		alarm2_minute = I2C1_Rd(1);                   // Read alarm2 minutes
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _alarm2_minute+0 
;T_RTCDS3231_1.c,55 :: 		alarm2_hour   = I2C1_Rd(1);                   // Read alarm2 hours
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _alarm2_hour+0 
;T_RTCDS3231_1.c,56 :: 		I2C1_Rd(1);                                   // Skip alarm2 day/date register
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
;T_RTCDS3231_1.c,57 :: 		control_reg = I2C1_Rd(1);                     // Read the DS3231 control register
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       alarms_read_display_control_reg_L0+0 
;T_RTCDS3231_1.c,58 :: 		status_reg  = I2C1_Rd(1);                     // Read the DS3231 status register
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _status_reg+0 
;T_RTCDS3231_1.c,59 :: 		I2C1_Rd(1);                                   // Skip aging offset register
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
;T_RTCDS3231_1.c,60 :: 		temperature_msb = I2C1_Rd(1);                 // Read temperature MSB
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       alarms_read_display_temperature_msb_L0+0 
;T_RTCDS3231_1.c,61 :: 		temperature_lsb = I2C1_Rd(0);                 // Read temperature LSB
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       alarms_read_display_temperature_lsb_L0+0 
;T_RTCDS3231_1.c,62 :: 		I2C1_Stop();                                  // Stop I2C protocol
	CALL        _I2C1_Stop+0, 0
;T_RTCDS3231_1.c,64 :: 		alarm1_minute = (alarm1_minute >> 4) * 10 + (alarm1_minute & 0x0F);
	MOVF        _alarm1_minute+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _alarm1_minute+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__alarms_read_display+3 
	MOVF        FLOC__alarms_read_display+3, 0 
	MOVWF       _alarm1_minute+0 
;T_RTCDS3231_1.c,65 :: 		alarm1_hour   = (alarm1_hour   >> 4) * 10 + (alarm1_hour & 0x0F);
	MOVF        _alarm1_hour+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _alarm1_hour+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__alarms_read_display+2 
	MOVF        FLOC__alarms_read_display+2, 0 
	MOVWF       _alarm1_hour+0 
;T_RTCDS3231_1.c,66 :: 		alarm2_minute = (alarm2_minute >> 4) * 10 + (alarm2_minute & 0x0F);
	MOVF        _alarm2_minute+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _alarm2_minute+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__alarms_read_display+1 
	MOVF        FLOC__alarms_read_display+1, 0 
	MOVWF       _alarm2_minute+0 
;T_RTCDS3231_1.c,67 :: 		alarm2_hour   = (alarm2_hour   >> 4) * 10 + (alarm2_hour & 0x0F);
	MOVF        _alarm2_hour+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _alarm2_hour+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__alarms_read_display+0 
	MOVF        FLOC__alarms_read_display+0, 0 
	MOVWF       _alarm2_hour+0 
;T_RTCDS3231_1.c,69 :: 		alarm1[8]     = alarm1_minute % 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__alarms_read_display+3, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _alarm1+8 
;T_RTCDS3231_1.c,70 :: 		alarm1[7]     = alarm1_minute / 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__alarms_read_display+3, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _alarm1+7 
;T_RTCDS3231_1.c,71 :: 		alarm1[5]     = alarm1_hour   % 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__alarms_read_display+2, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _alarm1+5 
;T_RTCDS3231_1.c,72 :: 		alarm1[4]     = alarm1_hour   / 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__alarms_read_display+2, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _alarm1+4 
;T_RTCDS3231_1.c,73 :: 		alarm2[8]     = alarm2_minute % 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__alarms_read_display+1, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _alarm2+8 
;T_RTCDS3231_1.c,74 :: 		alarm2[7]     = alarm2_minute / 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__alarms_read_display+1, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _alarm2+7 
;T_RTCDS3231_1.c,75 :: 		alarm2[5]     = alarm2_hour   % 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__alarms_read_display+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _alarm2+5 
;T_RTCDS3231_1.c,76 :: 		alarm2[4]     = alarm2_hour   / 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__alarms_read_display+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _alarm2+4 
;T_RTCDS3231_1.c,77 :: 		alarm1_status = control_reg;              // Read alarm1 interrupt enable bit (A1IE) from DS3231 control register
	BTFSC       alarms_read_display_control_reg_L0+0, 0 
	GOTO        L__alarms_read_display127
	BCF         _alarm1_status+0, BitPos(_alarm1_status+0) 
	GOTO        L__alarms_read_display128
L__alarms_read_display127:
	BSF         _alarm1_status+0, BitPos(_alarm1_status+0) 
L__alarms_read_display128:
;T_RTCDS3231_1.c,78 :: 		alarm2_status = control_reg >> 1;         // Read alarm2 interrupt enable bit (A2IE) from DS3231 control register
	MOVF        alarms_read_display_control_reg_L0+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	BTFSC       R0, 0 
	GOTO        L__alarms_read_display129
	BCF         _alarm2_status+0, BitPos(_alarm2_status+0) 
	GOTO        L__alarms_read_display130
L__alarms_read_display129:
	BSF         _alarm2_status+0, BitPos(_alarm2_status+0) 
L__alarms_read_display130:
;T_RTCDS3231_1.c,79 :: 		if(temperature_msb < 0){
	MOVLW       128
	XORWF       alarms_read_display_temperature_msb_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_alarms_read_display0
;T_RTCDS3231_1.c,80 :: 		temperature_msb = abs(temperature_msb);
	MOVF        alarms_read_display_temperature_msb_L0+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVLW       0
	BTFSC       alarms_read_display_temperature_msb_L0+0, 7 
	MOVLW       255
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVF        R0, 0 
	MOVWF       alarms_read_display_temperature_msb_L0+0 
;T_RTCDS3231_1.c,81 :: 		temperature[2] = '-';
	MOVLW       45
	MOVWF       _temperature+2 
;T_RTCDS3231_1.c,82 :: 		}
	GOTO        L_alarms_read_display1
L_alarms_read_display0:
;T_RTCDS3231_1.c,84 :: 		temperature[2] = ' ';
	MOVLW       32
	MOVWF       _temperature+2 
L_alarms_read_display1:
;T_RTCDS3231_1.c,85 :: 		temperature_lsb >>= 6;
	MOVLW       6
	MOVWF       R0 
	MOVF        alarms_read_display_temperature_lsb_L0+0, 0 
	MOVWF       FLOC__alarms_read_display+0 
	MOVF        R0, 0 
L__alarms_read_display131:
	BZ          L__alarms_read_display132
	RRCF        FLOC__alarms_read_display+0, 1 
	BCF         FLOC__alarms_read_display+0, 7 
	ADDLW       255
	GOTO        L__alarms_read_display131
L__alarms_read_display132:
	MOVF        FLOC__alarms_read_display+0, 0 
	MOVWF       alarms_read_display_temperature_lsb_L0+0 
;T_RTCDS3231_1.c,86 :: 		temperature[4] = temperature_msb % 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        alarms_read_display_temperature_msb_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _temperature+4 
;T_RTCDS3231_1.c,87 :: 		temperature[3] = temperature_msb / 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        alarms_read_display_temperature_msb_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _temperature+3 
;T_RTCDS3231_1.c,88 :: 		if(temperature_lsb == 0 || temperature_lsb == 2){
	MOVF        FLOC__alarms_read_display+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__alarms_read_display106
	MOVF        alarms_read_display_temperature_lsb_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__alarms_read_display106
	GOTO        L_alarms_read_display4
L__alarms_read_display106:
;T_RTCDS3231_1.c,89 :: 		temperature[7] = '0';
	MOVLW       48
	MOVWF       _temperature+7 
;T_RTCDS3231_1.c,90 :: 		if(temperature_lsb == 0) temperature[6] = '0';
	MOVF        alarms_read_display_temperature_lsb_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_alarms_read_display5
	MOVLW       48
	MOVWF       _temperature+6 
	GOTO        L_alarms_read_display6
L_alarms_read_display5:
;T_RTCDS3231_1.c,91 :: 		else                     temperature[6] = '5';
	MOVLW       53
	MOVWF       _temperature+6 
L_alarms_read_display6:
;T_RTCDS3231_1.c,92 :: 		}
L_alarms_read_display4:
;T_RTCDS3231_1.c,93 :: 		if(temperature_lsb == 1 || temperature_lsb == 3){
	MOVF        alarms_read_display_temperature_lsb_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__alarms_read_display105
	MOVF        alarms_read_display_temperature_lsb_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__alarms_read_display105
	GOTO        L_alarms_read_display9
L__alarms_read_display105:
;T_RTCDS3231_1.c,94 :: 		temperature[7] = '5';
	MOVLW       53
	MOVWF       _temperature+7 
;T_RTCDS3231_1.c,95 :: 		if(temperature_lsb == 1) temperature[6] = '2';
	MOVF        alarms_read_display_temperature_lsb_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_alarms_read_display10
	MOVLW       50
	MOVWF       _temperature+6 
	GOTO        L_alarms_read_display11
L_alarms_read_display10:
;T_RTCDS3231_1.c,96 :: 		else                     temperature[6] = '7';
	MOVLW       55
	MOVWF       _temperature+6 
L_alarms_read_display11:
;T_RTCDS3231_1.c,97 :: 		}
L_alarms_read_display9:
;T_RTCDS3231_1.c,98 :: 		temperature[8]  = 223;                         // Degree symbol
	MOVLW       223
	MOVWF       _temperature+8 
;T_RTCDS3231_1.c,99 :: 		UART1_Write_Text( temperature);                   // Display temperature
	MOVLW       _temperature+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_temperature+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTCDS3231_1.c,101 :: 		Lcd_Out(3, 1, alarm1);                         // Display alarm1
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _alarm1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_alarm1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;T_RTCDS3231_1.c,102 :: 		UART1_Write_Text( alarm1);
	MOVLW       _alarm1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_alarm1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTCDS3231_1.c,104 :: 		if(alarm1_status)  UART1_Write_Text(  "ON ");      // If A1IE = 1 print 'ON'
	BTFSS       _alarm1_status+0, BitPos(_alarm1_status+0) 
	GOTO        L_alarms_read_display12
	MOVLW       ?lstr1_T_RTCDS3231_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_T_RTCDS3231_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_alarms_read_display13
L_alarms_read_display12:
;T_RTCDS3231_1.c,105 :: 		else               UART1_Write_Text(  "OFF");      // If A1IE = 0 print 'OFF'
	MOVLW       ?lstr2_T_RTCDS3231_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_T_RTCDS3231_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_alarms_read_display13:
;T_RTCDS3231_1.c,106 :: 		Lcd_Out(4, 1, alarm2);                         // Display alarm2
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _alarm2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_alarm2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;T_RTCDS3231_1.c,107 :: 		if(alarm2_status)  Lcd_Out(4, 18, "ON ");      // If A2IE = 1 print 'ON'
	BTFSS       _alarm2_status+0, BitPos(_alarm2_status+0) 
	GOTO        L_alarms_read_display14
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       18
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_alarms_read_display15
L_alarms_read_display14:
;T_RTCDS3231_1.c,108 :: 		else               Lcd_Out(4, 18, "OFF");      // If A2IE = 0 print 'OFF'
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       18
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_alarms_read_display15:
;T_RTCDS3231_1.c,109 :: 		}
L_end_alarms_read_display:
	RETURN      0
; end of _alarms_read_display

_day_display:

;T_RTCDS3231_1.c,110 :: 		void day_display(){                              // Day display function
;T_RTCDS3231_1.c,111 :: 		switch(day){
	GOTO        L_day_display16
;T_RTCDS3231_1.c,112 :: 		case 1:  Lcd_Out(2, 1, "Sun"); break;
L_day_display18:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_day_display17
;T_RTCDS3231_1.c,113 :: 		case 2:  Lcd_Out(2, 1, "Mon"); break;
L_day_display19:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_day_display17
;T_RTCDS3231_1.c,114 :: 		case 3:  Lcd_Out(2, 1, "Tue"); break;
L_day_display20:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_day_display17
;T_RTCDS3231_1.c,115 :: 		case 4:  Lcd_Out(2, 1, "Wed"); break;
L_day_display21:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_day_display17
;T_RTCDS3231_1.c,116 :: 		case 5:  Lcd_Out(2, 1, "Thu"); break;
L_day_display22:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_day_display17
;T_RTCDS3231_1.c,117 :: 		case 6:  Lcd_Out(2, 1, "Fri"); break;
L_day_display23:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_day_display17
;T_RTCDS3231_1.c,118 :: 		default: Lcd_Out(2, 1, "Sat"); break;
L_day_display24:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_day_display17
;T_RTCDS3231_1.c,119 :: 		}
L_day_display16:
	MOVF        _day+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_day_display18
	MOVF        _day+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_day_display19
	MOVF        _day+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_day_display20
	MOVF        _day+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_day_display21
	MOVF        _day+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_day_display22
	MOVF        _day+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_day_display23
	GOTO        L_day_display24
L_day_display17:
;T_RTCDS3231_1.c,120 :: 		}
L_end_day_display:
	RETURN      0
; end of _day_display

_DS3231_display:

;T_RTCDS3231_1.c,121 :: 		void DS3231_display(){
;T_RTCDS3231_1.c,123 :: 		second = (second >> 4) * 10 + (second & 0x0F);
	MOVF        _second+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _second+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__DS3231_display+5 
	MOVF        FLOC__DS3231_display+5, 0 
	MOVWF       _second+0 
;T_RTCDS3231_1.c,124 :: 		minute = (minute >> 4) * 10 + (minute & 0x0F);
	MOVF        _minute+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _minute+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__DS3231_display+4 
	MOVF        FLOC__DS3231_display+4, 0 
	MOVWF       _minute+0 
;T_RTCDS3231_1.c,125 :: 		hour   = (hour >> 4)   * 10 + (hour & 0x0F);
	MOVF        _hour+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _hour+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__DS3231_display+3 
	MOVF        FLOC__DS3231_display+3, 0 
	MOVWF       _hour+0 
;T_RTCDS3231_1.c,126 :: 		date   = (date >> 4)   * 10 + (date & 0x0F);
	MOVF        _date+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _date+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__DS3231_display+2 
	MOVF        FLOC__DS3231_display+2, 0 
	MOVWF       _date+0 
;T_RTCDS3231_1.c,127 :: 		month  = (month >> 4)  * 10 + (month & 0x0F);
	MOVF        _month+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _month+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__DS3231_display+1 
	MOVF        FLOC__DS3231_display+1, 0 
	MOVWF       _month+0 
;T_RTCDS3231_1.c,128 :: 		year   = (year >> 4)   * 10 + (year & 0x0F);
	MOVF        _year+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       _year+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       FLOC__DS3231_display+0 
	MOVF        FLOC__DS3231_display+0, 0 
	MOVWF       _year+0 
;T_RTCDS3231_1.c,130 :: 		time[7]     = second % 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+5, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _time+7 
;T_RTCDS3231_1.c,131 :: 		time[6]     = second / 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+5, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _time+6 
;T_RTCDS3231_1.c,132 :: 		time[4]     = minute % 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+4, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _time+4 
;T_RTCDS3231_1.c,133 :: 		time[3]     = minute / 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+4, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _time+3 
;T_RTCDS3231_1.c,134 :: 		time[1]     = hour   % 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+3, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _time+1 
;T_RTCDS3231_1.c,135 :: 		time[0]     = hour   / 10  + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+3, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _time+0 
;T_RTCDS3231_1.c,136 :: 		calendar[9] = year  % 10 + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _calendar+9 
;T_RTCDS3231_1.c,137 :: 		calendar[8] = year  / 10 + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _calendar+8 
;T_RTCDS3231_1.c,138 :: 		calendar[4] = month % 10 + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+1, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _calendar+4 
;T_RTCDS3231_1.c,139 :: 		calendar[3] = month / 10 + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+1, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _calendar+3 
;T_RTCDS3231_1.c,140 :: 		calendar[1] = date  % 10 + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+2, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _calendar+1 
;T_RTCDS3231_1.c,141 :: 		calendar[0] = date  / 10 + 48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__DS3231_display+2, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _calendar+0 
;T_RTCDS3231_1.c,142 :: 		Lcd_Out(1, 1, time);                           // Display time
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _time+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_time+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;T_RTCDS3231_1.c,143 :: 		day_display();                                 // Display day
	CALL        _day_display+0, 0
;T_RTCDS3231_1.c,144 :: 		Lcd_Out(2, 5, calendar);                       // Display calendar
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _calendar+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_calendar+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;T_RTCDS3231_1.c,145 :: 		}
L_end_DS3231_display:
	RETURN      0
; end of _DS3231_display

_blink:

;T_RTCDS3231_1.c,146 :: 		void blink(){
;T_RTCDS3231_1.c,147 :: 		char j = 0;
	CLRF        blink_j_L0+0 
;T_RTCDS3231_1.c,148 :: 		while(j < 10 && (PORTB.F3 || i >= 5) && PORTB.F4 && (PORTB.F5 || i < 5)){
L_blink25:
	MOVLW       10
	SUBWF       blink_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_blink26
	BTFSC       PORTB+0, 3 
	GOTO        L__blink109
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__blink109
	GOTO        L_blink26
L__blink109:
	BTFSS       PORTB+0, 4 
	GOTO        L_blink26
	BTFSC       PORTB+0, 5 
	GOTO        L__blink108
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__blink108
	GOTO        L_blink26
L__blink108:
L__blink107:
;T_RTCDS3231_1.c,149 :: 		j++;
	INCF        blink_j_L0+0, 1 
;T_RTCDS3231_1.c,150 :: 		delay_ms(25);
	MOVLW       163
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_blink33:
	DECFSZ      R13, 1, 1
	BRA         L_blink33
	DECFSZ      R12, 1, 1
	BRA         L_blink33
;T_RTCDS3231_1.c,151 :: 		}
	GOTO        L_blink25
L_blink26:
;T_RTCDS3231_1.c,152 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_edit:

;T_RTCDS3231_1.c,153 :: 		char edit(char parameter, char x, char y){
;T_RTCDS3231_1.c,154 :: 		while(!PORTB.F3 || !PORTB.F5);                      // Wait for button RB0 is release
L_edit34:
	BTFSS       PORTB+0, 3 
	GOTO        L__edit121
	BTFSS       PORTB+0, 5 
	GOTO        L__edit121
	GOTO        L_edit35
L__edit121:
	GOTO        L_edit34
L_edit35:
;T_RTCDS3231_1.c,155 :: 		while(1){
L_edit38:
;T_RTCDS3231_1.c,156 :: 		while(!PORTB.F4){                                 // If button RB2 is pressed
L_edit40:
	BTFSC       PORTB+0, 4 
	GOTO        L_edit41
;T_RTCDS3231_1.c,157 :: 		parameter++;
	INCF        FARG_edit_parameter+0, 1 
;T_RTCDS3231_1.c,158 :: 		if(((i == 0) || (i == 5)) && parameter > 23)    // If hours > 23 ==> hours = 0
	MOVF        _i+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__edit120
	MOVF        _i+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__edit120
	GOTO        L_edit46
L__edit120:
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       23
	BTFSC       STATUS+0, 0 
	GOTO        L_edit46
L__edit119:
;T_RTCDS3231_1.c,159 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit46:
;T_RTCDS3231_1.c,160 :: 		if(((i == 1) || (i == 6)) && parameter > 59)    // If minutes > 59 ==> minutes = 0
	MOVF        _i+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__edit118
	MOVF        _i+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__edit118
	GOTO        L_edit51
L__edit118:
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       59
	BTFSC       STATUS+0, 0 
	GOTO        L_edit51
L__edit117:
;T_RTCDS3231_1.c,161 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit51:
;T_RTCDS3231_1.c,162 :: 		if(i == 2 && parameter > 31)                    // If date > 31 ==> date = 1
	MOVF        _i+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_edit54
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       31
	BTFSC       STATUS+0, 0 
	GOTO        L_edit54
L__edit116:
;T_RTCDS3231_1.c,163 :: 		parameter = 1;
	MOVLW       1
	MOVWF       FARG_edit_parameter+0 
L_edit54:
;T_RTCDS3231_1.c,164 :: 		if(i == 3 && parameter > 12)                    // If month > 12 ==> month = 1
	MOVF        _i+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_edit57
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       12
	BTFSC       STATUS+0, 0 
	GOTO        L_edit57
L__edit115:
;T_RTCDS3231_1.c,165 :: 		parameter = 1;
	MOVLW       1
	MOVWF       FARG_edit_parameter+0 
L_edit57:
;T_RTCDS3231_1.c,166 :: 		if(i == 4 && parameter > 99)                    // If year > 99 ==> year = 0
	MOVF        _i+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_edit60
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       99
	BTFSC       STATUS+0, 0 
	GOTO        L_edit60
L__edit114:
;T_RTCDS3231_1.c,167 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit60:
;T_RTCDS3231_1.c,168 :: 		if(i == 7 && parameter > 1)                     // For alarms ON or OFF (1: alarm ON, 0: alarm OFF)
	MOVF        _i+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_edit63
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_edit63
L__edit113:
;T_RTCDS3231_1.c,169 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit63:
;T_RTCDS3231_1.c,170 :: 		if(i == 7){                                     // For alarms ON & OFF
	MOVF        _i+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_edit64
;T_RTCDS3231_1.c,171 :: 		if(parameter == 1)  Lcd_Out(y, x, "ON ");
	MOVF        FARG_edit_parameter+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_edit65
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        FARG_edit_x+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_edit66
L_edit65:
;T_RTCDS3231_1.c,172 :: 		else                Lcd_Out(y, x, "OFF");
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        FARG_edit_x+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_edit66:
;T_RTCDS3231_1.c,173 :: 		}
	GOTO        L_edit67
L_edit64:
;T_RTCDS3231_1.c,175 :: 		Lcd_Chr(y, x, parameter / 10 + 48);
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_edit_x+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_edit_parameter+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;T_RTCDS3231_1.c,176 :: 		Lcd_Chr(y, x + 1, parameter % 10 + 48);
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_edit_x+0, 0 
	ADDLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_edit_parameter+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;T_RTCDS3231_1.c,177 :: 		}
L_edit67:
;T_RTCDS3231_1.c,178 :: 		if(i >= 5){
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_edit68
;T_RTCDS3231_1.c,179 :: 		DS3231_read();                             // Read data from DS3231
	CALL        _DS3231_read+0, 0
;T_RTCDS3231_1.c,180 :: 		DS3231_display();                          // Display DS3231 time and calendar
	CALL        _DS3231_display+0, 0
;T_RTCDS3231_1.c,181 :: 		}
L_edit68:
;T_RTCDS3231_1.c,182 :: 		delay_ms(200);                               // Wait 200ms
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_edit69:
	DECFSZ      R13, 1, 1
	BRA         L_edit69
	DECFSZ      R12, 1, 1
	BRA         L_edit69
	DECFSZ      R11, 1, 1
	BRA         L_edit69
	NOP
	NOP
;T_RTCDS3231_1.c,183 :: 		}
	GOTO        L_edit40
L_edit41:
;T_RTCDS3231_1.c,184 :: 		Lcd_Out(y, x, "  ");                           // Print two spaces
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        FARG_edit_x+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;T_RTCDS3231_1.c,185 :: 		if(i == 7) Lcd_Out(y, x + 2, " ");             // Print space (for alarms ON & OFF)
	MOVF        _i+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_edit70
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	ADDWF       FARG_edit_x+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_edit70:
;T_RTCDS3231_1.c,186 :: 		blink();                                       // Call blink function
	CALL        _blink+0, 0
;T_RTCDS3231_1.c,187 :: 		if(i == 7){                                    // For alarms ON & OFF
	MOVF        _i+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_edit71
;T_RTCDS3231_1.c,188 :: 		if(parameter == 1)  Lcd_Out(y, x, "ON ");
	MOVF        FARG_edit_parameter+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_edit72
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        FARG_edit_x+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_edit73
L_edit72:
;T_RTCDS3231_1.c,189 :: 		else                Lcd_Out(y, x, "OFF");
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        FARG_edit_x+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_edit73:
;T_RTCDS3231_1.c,190 :: 		}
	GOTO        L_edit74
L_edit71:
;T_RTCDS3231_1.c,192 :: 		Lcd_Chr(y, x, parameter / 10 + 48);
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_edit_x+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_edit_parameter+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;T_RTCDS3231_1.c,193 :: 		Lcd_Chr(y, x + 1, parameter % 10 + 48);
	MOVF        FARG_edit_y+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_edit_x+0, 0 
	ADDLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_edit_parameter+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;T_RTCDS3231_1.c,194 :: 		}
L_edit74:
;T_RTCDS3231_1.c,195 :: 		blink();
	CALL        _blink+0, 0
;T_RTCDS3231_1.c,196 :: 		if(i >= 5){
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_edit75
;T_RTCDS3231_1.c,197 :: 		DS3231_read();
	CALL        _DS3231_read+0, 0
;T_RTCDS3231_1.c,198 :: 		DS3231_display();}
	CALL        _DS3231_display+0, 0
L_edit75:
;T_RTCDS3231_1.c,199 :: 		if((!PORTB.F3 && i < 5) || (!PORTB.F5 && i >= 5)){
	BTFSC       PORTB+0, 3 
	GOTO        L__edit112
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__edit112
	GOTO        L__edit110
L__edit112:
	BTFSC       PORTB+0, 5 
	GOTO        L__edit111
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__edit111
	GOTO        L__edit110
L__edit111:
	GOTO        L_edit82
L__edit110:
;T_RTCDS3231_1.c,200 :: 		i++;                                       // Increment 'i' for the next parameter
	INCF        _i+0, 1 
;T_RTCDS3231_1.c,201 :: 		return parameter;                          // Return parameter value and exit
	MOVF        FARG_edit_parameter+0, 0 
	MOVWF       R0 
	GOTO        L_end_edit
;T_RTCDS3231_1.c,202 :: 		}
L_edit82:
;T_RTCDS3231_1.c,203 :: 		}
	GOTO        L_edit38
;T_RTCDS3231_1.c,204 :: 		}
L_end_edit:
	RETURN      0
; end of _edit

_main:

;T_RTCDS3231_1.c,206 :: 		void main() {
;T_RTCDS3231_1.c,208 :: 		ADCON1 =0x0F;                      // Configure all PORTB pins as digital
	MOVLW       15
	MOVWF       ADCON1+0 
;T_RTCDS3231_1.c,209 :: 		PORTB = 0;                       // PORTB initial state
	CLRF        PORTB+0 
;T_RTCDS3231_1.c,210 :: 		TRISB = 0x0F;                    // Configure RB0 ~ 3 as input pins
	MOVLW       15
	MOVWF       TRISB+0 
;T_RTCDS3231_1.c,211 :: 		INTCON2.RBPU=0;                  // Pull-up resistors
	BCF         INTCON2+0, 7 
;T_RTCDS3231_1.c,212 :: 		I2C1_Init(100000);               // Initialize I2C communication
	MOVLW       50
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;T_RTCDS3231_1.c,213 :: 		Lcd_Init();                      // Initialize LCD module
	CALL        _Lcd_Init+0, 0
;T_RTCDS3231_1.c,214 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;T_RTCDS3231_1.c,215 :: 		Lcd_Cmd(_LCD_CLEAR);             // clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;T_RTCDS3231_1.c,217 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;T_RTCDS3231_1.c,218 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main83:
	DECFSZ      R13, 1, 1
	BRA         L_main83
	DECFSZ      R12, 1, 1
	BRA         L_main83
	DECFSZ      R11, 1, 1
	BRA         L_main83
	NOP
	NOP
;T_RTCDS3231_1.c,220 :: 		UART1_Write_Text("inicio");
	MOVLW       ?lstr18_T_RTCDS3231_1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_T_RTCDS3231_1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;T_RTCDS3231_1.c,221 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTCDS3231_1.c,222 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;T_RTCDS3231_1.c,225 :: 		while(1) {
L_main84:
;T_RTCDS3231_1.c,226 :: 		if(!PORTB.F3){                          // If RB3 button is pressed
	BTFSC       PORTB+0, 3 
	GOTO        L_main86
;T_RTCDS3231_1.c,227 :: 		i = 0;
	CLRF        _i+0 
;T_RTCDS3231_1.c,228 :: 		hour   = edit(hour, 1, 1);            // Edit hours
	MOVF        _hour+0, 0 
	MOVWF       FARG_edit_parameter+0 
	MOVLW       1
	MOVWF       FARG_edit_x+0 
	MOVLW       1
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	MOVF        R0, 0 
	MOVWF       _hour+0 
;T_RTCDS3231_1.c,229 :: 		minute = edit(minute, 4, 1);          // Edit minutes
	MOVF        _minute+0, 0 
	MOVWF       FARG_edit_parameter+0 
	MOVLW       4
	MOVWF       FARG_edit_x+0 
	MOVLW       1
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	MOVF        R0, 0 
	MOVWF       _minute+0 
;T_RTCDS3231_1.c,230 :: 		while(!PORTB.F3);                     // Wait for button RB0 release
L_main87:
	BTFSC       PORTB+0, 3 
	GOTO        L_main88
	GOTO        L_main87
L_main88:
;T_RTCDS3231_1.c,231 :: 		while(1){
L_main89:
;T_RTCDS3231_1.c,232 :: 		while(!PORTB.F4){                   // If button RB2 button is pressed
L_main91:
	BTFSC       PORTB+0, 4 
	GOTO        L_main92
;T_RTCDS3231_1.c,233 :: 		day++;                            // Increment day
	INCF        _day+0, 1 
;T_RTCDS3231_1.c,234 :: 		if(day > 7) day = 1;
	MOVF        _day+0, 0 
	SUBLW       7
	BTFSC       STATUS+0, 0 
	GOTO        L_main93
	MOVLW       1
	MOVWF       _day+0 
L_main93:
;T_RTCDS3231_1.c,235 :: 		day_display();
	CALL        _day_display+0, 0
;T_RTCDS3231_1.c,236 :: 		delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main94:
	DECFSZ      R13, 1, 1
	BRA         L_main94
	DECFSZ      R12, 1, 1
	BRA         L_main94
	DECFSZ      R11, 1, 1
	BRA         L_main94
	NOP
	NOP
;T_RTCDS3231_1.c,237 :: 		}
	GOTO        L_main91
L_main92:
;T_RTCDS3231_1.c,238 :: 		Lcd_Out(2, 1, "   ");                // Print 3 spaces
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr19_T_RTCDS3231_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_T_RTCDS3231_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;T_RTCDS3231_1.c,239 :: 		blink();
	CALL        _blink+0, 0
;T_RTCDS3231_1.c,240 :: 		day_display();
	CALL        _day_display+0, 0
;T_RTCDS3231_1.c,241 :: 		blink();                             // Call blink function
	CALL        _blink+0, 0
;T_RTCDS3231_1.c,242 :: 		if(!PORTB.F3)                        // If button RB1 is pressed
	BTFSC       PORTB+0, 3 
	GOTO        L_main95
;T_RTCDS3231_1.c,243 :: 		break;
	GOTO        L_main90
L_main95:
;T_RTCDS3231_1.c,244 :: 		}
	GOTO        L_main89
L_main90:
;T_RTCDS3231_1.c,245 :: 		date = edit(date, 5, 2);                   // Edit date
	MOVF        _date+0, 0 
	MOVWF       FARG_edit_parameter+0 
	MOVLW       5
	MOVWF       FARG_edit_x+0 
	MOVLW       2
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	MOVF        R0, 0 
	MOVWF       _date+0 
;T_RTCDS3231_1.c,246 :: 		month = edit(month, 8, 2);                 // Edit month
	MOVF        _month+0, 0 
	MOVWF       FARG_edit_parameter+0 
	MOVLW       8
	MOVWF       FARG_edit_x+0 
	MOVLW       2
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	MOVF        R0, 0 
	MOVWF       _month+0 
;T_RTCDS3231_1.c,247 :: 		year = edit(year, 13, 2);                  // Edit year
	MOVF        _year+0, 0 
	MOVWF       FARG_edit_parameter+0 
	MOVLW       13
	MOVWF       FARG_edit_x+0 
	MOVLW       2
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+1 
	MOVF        FLOC__main+1, 0 
	MOVWF       _year+0 
;T_RTCDS3231_1.c,249 :: 		minute = ((minute / 10) << 4) + (minute % 10);
	MOVLW       10
	MOVWF       R4 
	MOVF        _minute+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _minute+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FLOC__main+0, 0 
	MOVWF       _minute+0 
;T_RTCDS3231_1.c,250 :: 		hour = ((hour / 10) << 4) + (hour % 10);
	MOVLW       10
	MOVWF       R4 
	MOVF        _hour+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _hour+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FLOC__main+0, 0 
	MOVWF       _hour+0 
;T_RTCDS3231_1.c,251 :: 		date = ((date / 10) << 4) + (date % 10);
	MOVLW       10
	MOVWF       R4 
	MOVF        _date+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _date+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FLOC__main+0, 0 
	MOVWF       _date+0 
;T_RTCDS3231_1.c,252 :: 		month = ((month / 10) << 4) + (month % 10);
	MOVLW       10
	MOVWF       R4 
	MOVF        _month+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _month+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FLOC__main+0, 0 
	MOVWF       _month+0 
;T_RTCDS3231_1.c,253 :: 		year = ((year / 10) << 4) + (year % 10);
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__main+1, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _year+0 
	RLCF        _year+0, 1 
	BCF         _year+0, 0 
	RLCF        _year+0, 1 
	BCF         _year+0, 0 
	RLCF        _year+0, 1 
	BCF         _year+0, 0 
	RLCF        _year+0, 1 
	BCF         _year+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        FLOC__main+1, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _year+0, 1 
;T_RTCDS3231_1.c,256 :: 		I2C1_Start();                               // Start I2C protocol
	CALL        _I2C1_Start+0, 0
;T_RTCDS3231_1.c,257 :: 		I2C1_Wr(0xD0);                           // DS3231 address
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,258 :: 		I2C1_Wr(0);                              // Send register address (seconds address)
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,259 :: 		I2C1_Wr(0);                              // Reset seconds and start oscillator
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,260 :: 		I2C1_Wr(minute);                         // Write minute value to DS3231
	MOVF        _minute+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,261 :: 		I2C1_Wr(hour);                           // Write hour value to DS3231
	MOVF        _hour+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,262 :: 		I2C1_Wr(day);                            // Write day value
	MOVF        _day+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,263 :: 		I2C1_Wr(date);                           // Write date value to DS3231
	MOVF        _date+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,264 :: 		I2C1_Wr(month);                          // Write month value to DS3231
	MOVF        _month+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,265 :: 		I2C1_Wr(year);                           // Write year value to DS3231
	MOVF        _year+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,266 :: 		I2C1_Stop();                             // Stop I2C
	CALL        _I2C1_Stop+0, 0
;T_RTCDS3231_1.c,267 :: 		delay_ms(200);                           // Wait 200ms
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main96:
	DECFSZ      R13, 1, 1
	BRA         L_main96
	DECFSZ      R12, 1, 1
	BRA         L_main96
	DECFSZ      R11, 1, 1
	BRA         L_main96
	NOP
	NOP
;T_RTCDS3231_1.c,268 :: 		}
L_main86:
;T_RTCDS3231_1.c,269 :: 		if(!PORTB.F5){                             // If RB3 button is pressed
	BTFSC       PORTB+0, 5 
	GOTO        L_main97
;T_RTCDS3231_1.c,270 :: 		while(!PORTB.F5);                        // Wait until button RB3 released
L_main98:
	BTFSC       PORTB+0, 5 
	GOTO        L_main99
	GOTO        L_main98
L_main99:
;T_RTCDS3231_1.c,271 :: 		i = 5;
	MOVLW       5
	MOVWF       _i+0 
;T_RTCDS3231_1.c,272 :: 		alarm1_hour   = edit(alarm1_hour, 5, 3);
	MOVF        _alarm1_hour+0, 0 
	MOVWF       FARG_edit_parameter+0 
	MOVLW       5
	MOVWF       FARG_edit_x+0 
	MOVLW       3
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	MOVF        R0, 0 
	MOVWF       _alarm1_hour+0 
;T_RTCDS3231_1.c,273 :: 		alarm1_minute = edit(alarm1_minute, 8, 3);
	MOVF        _alarm1_minute+0, 0 
	MOVWF       FARG_edit_parameter+0 
	MOVLW       8
	MOVWF       FARG_edit_x+0 
	MOVLW       3
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	MOVF        R0, 0 
	MOVWF       _alarm1_minute+0 
;T_RTCDS3231_1.c,274 :: 		alarm1_status = edit(alarm1_status, 18, 3);
	MOVLW       0
	BTFSC       _alarm1_status+0, BitPos(_alarm1_status+0) 
	MOVLW       1
	MOVWF       FARG_edit_parameter+0 
	MOVLW       18
	MOVWF       FARG_edit_x+0 
	MOVLW       3
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	BTFSC       R0, 0 
	GOTO        L__main138
	BCF         _alarm1_status+0, BitPos(_alarm1_status+0) 
	GOTO        L__main139
L__main138:
	BSF         _alarm1_status+0, BitPos(_alarm1_status+0) 
L__main139:
;T_RTCDS3231_1.c,275 :: 		i = 5;
	MOVLW       5
	MOVWF       _i+0 
;T_RTCDS3231_1.c,276 :: 		alarm2_hour   = edit(alarm2_hour, 5, 4);
	MOVF        _alarm2_hour+0, 0 
	MOVWF       FARG_edit_parameter+0 
	MOVLW       5
	MOVWF       FARG_edit_x+0 
	MOVLW       4
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	MOVF        R0, 0 
	MOVWF       _alarm2_hour+0 
;T_RTCDS3231_1.c,277 :: 		alarm2_minute = edit(alarm2_minute, 8, 4);
	MOVF        _alarm2_minute+0, 0 
	MOVWF       FARG_edit_parameter+0 
	MOVLW       8
	MOVWF       FARG_edit_x+0 
	MOVLW       4
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	MOVF        R0, 0 
	MOVWF       _alarm2_minute+0 
;T_RTCDS3231_1.c,278 :: 		alarm2_status = edit(alarm2_status, 18, 4);
	MOVLW       0
	BTFSC       _alarm2_status+0, BitPos(_alarm2_status+0) 
	MOVLW       1
	MOVWF       FARG_edit_parameter+0 
	MOVLW       18
	MOVWF       FARG_edit_x+0 
	MOVLW       4
	MOVWF       FARG_edit_y+0 
	CALL        _edit+0, 0
	BTFSC       R0, 0 
	GOTO        L__main140
	BCF         _alarm2_status+0, BitPos(_alarm2_status+0) 
	GOTO        L__main141
L__main140:
	BSF         _alarm2_status+0, BitPos(_alarm2_status+0) 
L__main141:
;T_RTCDS3231_1.c,279 :: 		alarm1_minute = ((alarm1_minute / 10) << 4) + (alarm1_minute % 10);
	MOVLW       10
	MOVWF       R4 
	MOVF        _alarm1_minute+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _alarm1_minute+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FLOC__main+0, 0 
	MOVWF       _alarm1_minute+0 
;T_RTCDS3231_1.c,280 :: 		alarm1_hour   = ((alarm1_hour / 10) << 4) + (alarm1_hour % 10);
	MOVLW       10
	MOVWF       R4 
	MOVF        _alarm1_hour+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _alarm1_hour+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FLOC__main+0, 0 
	MOVWF       _alarm1_hour+0 
;T_RTCDS3231_1.c,281 :: 		alarm2_minute = ((alarm2_minute / 10) << 4) + (alarm2_minute % 10);
	MOVLW       10
	MOVWF       R4 
	MOVF        _alarm2_minute+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _alarm2_minute+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FLOC__main+0, 0 
	MOVWF       _alarm2_minute+0 
;T_RTCDS3231_1.c,282 :: 		alarm2_hour   = ((alarm2_hour / 10) << 4) + (alarm2_hour % 10);
	MOVLW       10
	MOVWF       R4 
	MOVF        _alarm2_hour+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	RLCF        FLOC__main+0, 1 
	BCF         FLOC__main+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        _alarm2_hour+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FLOC__main+0, 0 
	MOVWF       _alarm2_hour+0 
;T_RTCDS3231_1.c,284 :: 		I2C1_Start();                            // Start I2C
	CALL        _I2C1_Start+0, 0
;T_RTCDS3231_1.c,285 :: 		I2C1_Wr(0xD0);                           // DS3231 address
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,286 :: 		I2C1_Wr(7);                              // Send register address (alarm1 seconds)
	MOVLW       7
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,287 :: 		I2C1_Wr(0);                              // Write 0 to alarm1 seconds
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,288 :: 		I2C1_Wr(alarm1_minute);                  // Write alarm1 minutes value to DS3231
	MOVF        _alarm1_minute+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,289 :: 		I2C1_Wr(alarm1_hour);                    // Write alarm1 hours value to DS3231
	MOVF        _alarm1_hour+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,290 :: 		I2C1_Wr(0x80);                           // Alarm1 when hours, minutes, and seconds match
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,291 :: 		I2C1_Wr(alarm2_minute);                  // Write alarm2 minutes value to DS3231
	MOVF        _alarm2_minute+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,292 :: 		I2C1_Wr(alarm2_hour);                    // Write alarm2 hours value to DS3231
	MOVF        _alarm2_hour+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,293 :: 		I2C1_Wr(0x80);                           // Alarm2 when hours and minutes match
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,294 :: 		I2C1_Wr(4 | alarm1_status | (alarm2_status << 1));      // Write data to DS3231 control register (enable interrupt when alarm)
	CLRF        R0 
	BTFSC       _alarm1_status+0, BitPos(_alarm1_status+0) 
	INCF        R0, 1 
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CLRF        R3 
	BTFSC       _alarm2_status+0, BitPos(_alarm2_status+0) 
	INCF        R3, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	IORWF       FARG_I2C1_Wr_data_+0, 1 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,295 :: 		I2C1_Wr(0);                              // Clear alarm flag bits
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,296 :: 		I2C1_Stop();                             // Stop I2C
	CALL        _I2C1_Stop+0, 0
;T_RTCDS3231_1.c,297 :: 		delay_ms(200);                           // Wait 200ms
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main100:
	DECFSZ      R13, 1, 1
	BRA         L_main100
	DECFSZ      R12, 1, 1
	BRA         L_main100
	DECFSZ      R11, 1, 1
	BRA         L_main100
	NOP
	NOP
;T_RTCDS3231_1.c,298 :: 		}
L_main97:
;T_RTCDS3231_1.c,299 :: 		if(!PORTB.F4 && PORTB.F6){                 // When button B2 pressed with alarm (Reset and turn OFF the alarm)
	BTFSC       PORTB+0, 4 
	GOTO        L_main103
	BTFSS       PORTB+0, 6 
	GOTO        L_main103
L__main122:
;T_RTCDS3231_1.c,300 :: 		PORTB.F6 = 0;                            // Turn OFF the alarm indicator
	BCF         PORTB+0, 6 
;T_RTCDS3231_1.c,301 :: 		I2C1_Start();                            // Start I2C
	CALL        _I2C1_Start+0, 0
;T_RTCDS3231_1.c,302 :: 		I2C1_Wr(0xD0);                           // DS3231 address
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,303 :: 		I2C1_Wr(0x0E);                           // Send register address (control register)
	MOVLW       14
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,305 :: 		I2C1_Wr(4 | (!(status_reg & 1) & alarm1_status) | ((!((status_reg >> 1) & 1) & alarm2_status) << 1));
	MOVLW       1
	ANDWF       _status_reg+0, 0 
	MOVWF       R0 
	MOVF        R0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	CLRF        R0 
	BTFSC       _alarm1_status+0, BitPos(_alarm1_status+0) 
	INCF        R0, 1 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	MOVF        _status_reg+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       1
	ANDWF       R0, 1 
	MOVF        R0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	CLRF        R0 
	BTFSC       _alarm2_status+0, BitPos(_alarm2_status+0) 
	INCF        R0, 1 
	MOVF        R0, 0 
	ANDWF       R1, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	IORWF       FARG_I2C1_Wr_data_+0, 1 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,306 :: 		I2C1_Wr(0);                              // Clear alarm flag bits
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;T_RTCDS3231_1.c,307 :: 		I2C1_Stop();                             // Stop I2C
	CALL        _I2C1_Stop+0, 0
;T_RTCDS3231_1.c,308 :: 		}
L_main103:
;T_RTCDS3231_1.c,309 :: 		DS3231_read();                             // Read time and calendar parameters from DS3231 RTC
	CALL        _DS3231_read+0, 0
;T_RTCDS3231_1.c,310 :: 		alarms_read_display();                     // Read and display alarms parameters
	CALL        _alarms_read_display+0, 0
;T_RTCDS3231_1.c,311 :: 		DS3231_display();                          // Display time & calendar
	CALL        _DS3231_display+0, 0
;T_RTCDS3231_1.c,312 :: 		delay_ms(50);                              // Wait 50ms
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_main104:
	DECFSZ      R13, 1, 1
	BRA         L_main104
	DECFSZ      R12, 1, 1
	BRA         L_main104
	DECFSZ      R11, 1, 1
	BRA         L_main104
	NOP
	NOP
;T_RTCDS3231_1.c,313 :: 		}
	GOTO        L_main84
;T_RTCDS3231_1.c,314 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
