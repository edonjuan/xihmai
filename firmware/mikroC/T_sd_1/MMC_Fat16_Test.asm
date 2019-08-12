
_UART1_Write_Line:

;MMC_Fat16_Test.c,36 :: 		void UART1_Write_Line(char *uart_text) {
;MMC_Fat16_Test.c,37 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MMC_Fat16_Test.c,38 :: 		Lcd_Cmd (_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MMC_Fat16_Test.c,39 :: 		Lcd_Out(1,1,uart_text);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_UART1_Write_Line_uart_text+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        FARG_UART1_Write_Line_uart_text+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MMC_Fat16_Test.c,40 :: 		}
L_end_UART1_Write_Line:
	RETURN      0
; end of _UART1_Write_Line

_M_Create_New_File:

;MMC_Fat16_Test.c,43 :: 		void M_Create_New_File() {
;MMC_Fat16_Test.c,46 :: 		Mmc_Fat_Assign_B(&filename, 0xA0);          // Find existing file or create a new one
	MOVLW       _filename+0
	MOVWF       FARG_Mmc_Fat_Assign_B_filename+0 
	MOVLW       hi_addr(_filename+0)
	MOVWF       FARG_Mmc_Fat_Assign_B_filename+1 
	MOVLW       160
	MOVWF       FARG_Mmc_Fat_Assign_B_file_cre_attr+0 
	CALL        _Mmc_Fat_Assign_B+0, 0
;MMC_Fat16_Test.c,47 :: 		Mmc_Fat_Rewrite_B();                        // To clear file and start with new data
	CALL        _Mmc_Fat_Rewrite_B+0, 0
;MMC_Fat16_Test.c,49 :: 		Mmc_Fat_Write_B(file_contents, LINE_LEN-1);   // write data to the assigned file
	MOVLW       _file_contents+0
	MOVWF       FARG_Mmc_Fat_Write_B_fdata+0 
	MOVLW       hi_addr(_file_contents+0)
	MOVWF       FARG_Mmc_Fat_Write_B_fdata+1 
	MOVLW       42
	MOVWF       FARG_Mmc_Fat_Write_B_data_len+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Fat_Write_B_data_len+1 
	CALL        _Mmc_Fat_Write_B+0, 0
;MMC_Fat16_Test.c,51 :: 		}
L_end_M_Create_New_File:
	RETURN      0
; end of _M_Create_New_File

_M_Open_File_Append:

;MMC_Fat16_Test.c,56 :: 		void M_Open_File_Append() {
;MMC_Fat16_Test.c,58 :: 		Mmc_Fat_Assign_B(&filename, 0xA0);
	MOVLW       _filename+0
	MOVWF       FARG_Mmc_Fat_Assign_B_filename+0 
	MOVLW       hi_addr(_filename+0)
	MOVWF       FARG_Mmc_Fat_Assign_B_filename+1 
	MOVLW       160
	MOVWF       FARG_Mmc_Fat_Assign_B_file_cre_attr+0 
	CALL        _Mmc_Fat_Assign_B+0, 0
;MMC_Fat16_Test.c,60 :: 		Mmc_Fat_Append_B();                                    // Prepare file for append
	CALL        _Mmc_Fat_Append_B+0, 0
;MMC_Fat16_Test.c,61 :: 		Mmc_Fat_Write_B(file_contents2, 27);   // Write data to assigned file
	MOVLW       _file_contents2+0
	MOVWF       FARG_Mmc_Fat_Write_B_fdata+0 
	MOVLW       hi_addr(_file_contents2+0)
	MOVWF       FARG_Mmc_Fat_Write_B_fdata+1 
	MOVLW       27
	MOVWF       FARG_Mmc_Fat_Write_B_data_len+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Fat_Write_B_data_len+1 
	CALL        _Mmc_Fat_Write_B+0, 0
;MMC_Fat16_Test.c,62 :: 		Mmc_Fat_Write_B(file_contents1, 27);
	MOVLW       _file_contents1+0
	MOVWF       FARG_Mmc_Fat_Write_B_fdata+0 
	MOVLW       hi_addr(_file_contents1+0)
	MOVWF       FARG_Mmc_Fat_Write_B_fdata+1 
	MOVLW       27
	MOVWF       FARG_Mmc_Fat_Write_B_data_len+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Fat_Write_B_data_len+1 
	CALL        _Mmc_Fat_Write_B+0, 0
;MMC_Fat16_Test.c,63 :: 		}
L_end_M_Open_File_Append:
	RETURN      0
; end of _M_Open_File_Append

_main:

;MMC_Fat16_Test.c,68 :: 		void main() {
;MMC_Fat16_Test.c,70 :: 		ADCON1 |= 0x0F;                  // Configure AN pins as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;MMC_Fat16_Test.c,71 :: 		CMCON  |= 7;                     // Turn off comparators
	MOVLW       7
	IORWF       CMCON+0, 1 
;MMC_Fat16_Test.c,74 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;MMC_Fat16_Test.c,75 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MMC_Fat16_Test.c,76 :: 		Lcd_Cmd (_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MMC_Fat16_Test.c,77 :: 		Delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	NOP
;MMC_Fat16_Test.c,79 :: 		Lcd_Out(1,1,"PIC iniciado"); // PIC present report
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_MMC_Fat16_Test+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_MMC_Fat16_Test+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MMC_Fat16_Test.c,80 :: 		Delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
;MMC_Fat16_Test.c,82 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MMC_Fat16_Test.c,84 :: 		Lcd_Out(2,1,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _txt+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MMC_Fat16_Test.c,86 :: 		if (Mmc_Fat_Init_B() == 0) {
	CALL        _Mmc_Fat_Init_B+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;MMC_Fat16_Test.c,88 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MMC_Fat16_Test.c,92 :: 		M_Create_New_File();
	CALL        _M_Create_New_File+0, 0
;MMC_Fat16_Test.c,93 :: 		while (contador <15){
L_main3:
	MOVLW       128
	XORWF       _contador+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main11
	MOVLW       15
	SUBWF       _contador+0, 0 
L__main11:
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;MMC_Fat16_Test.c,94 :: 		contador++;
	INFSNZ      _contador+0, 1 
	INCF        _contador+1, 1 
;MMC_Fat16_Test.c,96 :: 		M_Open_File_Append();
	CALL        _M_Open_File_Append+0, 0
;MMC_Fat16_Test.c,97 :: 		Lcd_Cmd (_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MMC_Fat16_Test.c,98 :: 		Lcd_Out(1,1,"Wait");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_MMC_Fat16_Test+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_MMC_Fat16_Test+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MMC_Fat16_Test.c,99 :: 		delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
;MMC_Fat16_Test.c,100 :: 		}
	GOTO        L_main3
L_main4:
;MMC_Fat16_Test.c,104 :: 		UART1_Write_Line("Test finalizado.");
	MOVLW       ?lstr3_MMC_Fat16_Test+0
	MOVWF       FARG_UART1_Write_Line_uart_text+0 
	MOVLW       hi_addr(?lstr3_MMC_Fat16_Test+0)
	MOVWF       FARG_UART1_Write_Line_uart_text+1 
	CALL        _UART1_Write_Line+0, 0
;MMC_Fat16_Test.c,106 :: 		}
	GOTO        L_main6
L_main2:
;MMC_Fat16_Test.c,108 :: 		UART1_Write_Line(err_txt); // Note: Mmc_Fat_Init_B tries to initialize a card more than once.
	MOVLW       _err_txt+0
	MOVWF       FARG_UART1_Write_Line_uart_text+0 
	MOVLW       hi_addr(_err_txt+0)
	MOVWF       FARG_UART1_Write_Line_uart_text+1 
	CALL        _UART1_Write_Line+0, 0
;MMC_Fat16_Test.c,110 :: 		}
L_main6:
;MMC_Fat16_Test.c,112 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
