



// Crea un nuevo archivo y le escribe algunos datos.
void M_Create_New_File() {
  Mmc_Fat_Assign_B(&filename, 0xA0);          // Find existing file or create a new one
  Mmc_Fat_Rewrite_B();                        // To clear file and start with new data
  Mmc_Fat_Write_B(file_contents, LINE_LEN-1);   // write data to the assigned file
}


 // Abre un archivo existente y le agrega datos
//               (and alters the date/time stamp)
void M_Open_File_Append() {
   //filename[7] = 'A';
   Mmc_Fat_Assign_B(&filename, 0xA0);

   Mmc_Fat_Append_B();                                    // Prepare file for append
   Mmc_Fat_Write_B(file_contents2, 27);   // Write data to assigned file
    Mmc_Fat_Write_B(file_contents1, 27);
}



// Main. Uncomment the function(s) to test the desired operation(s)
void save (void){
  //#define COMPLETE_EXAMPLE         // comment this line to make simpler/smaller example
  //ADCON1 |= 0x0F;                  // Configure AN pins as digital
  //CMCON  |= 7;                     // Turn off comparators
  
  //Delay_ms(500);
  // Initializar modulo SPI1
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

  //Lcd_Out(2,1,txt);
  // use el formato rápido fat16 en lugar de la rutina init si se necesita un formateo
  if (Mmc_Fat_Init_B() == 0) {
    // reinitialize spi at higher speed
    SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
    //--- Test start
    UART1_Write_Text("iniciar SD.");
    //--- Test routines. Uncomment them one-by-one to test certain features
      M_Create_New_File();  
      M_Open_File_Append();

    //#endif
    UART1_Write_Text("finaliza SD.");

  }
  else {
    UART1_Write_Text(err_txt); // Note: Mmc_Fat_Init_B tries to initialize a card more than once.
                               //       If card is not present, initialization may last longer (depending on clock speed)
  }
}