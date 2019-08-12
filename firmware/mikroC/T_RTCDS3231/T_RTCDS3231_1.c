
sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
// End LCD module connections

bit alarm1_status, alarm2_status;
char time[]     = "  :  :  ",
     calendar[] = "  /  /20  ",
     alarm1[]   = "A1:   :  :00", alarm2[]   = "A2:   :  :00",
     temperature[] = "T:   .   C";
char  i, second, minute, hour, day, date, month, year,
      alarm1_minute, alarm1_hour, alarm2_minute, alarm2_hour,
      status_reg;

void Interrupt() {

}
void DS3231_read(){                            // Read time & calendar data function
  I2C1_Start();                                // Start I2C protocol
  I2C1_Wr(0xD0);                               // DS3231 address
  I2C1_Wr(0);                                  // Send register address (seconds register)
  I2C1_Repeated_Start();                       // Restart I2C
  I2C1_Wr(0xD1);                               // Initialize data read
  second = I2C1_Rd(1);                         // Read seconds from register 0
  minute = I2C1_Rd(1);                         // Read minutes from register 1
  hour   = I2C1_Rd(1);                         // Read hour from register 2
  day    = I2C1_Rd(1);                         // Read day from register 3
  date   = I2C1_Rd(1);                         // Read date from register 4
  month  = I2C1_Rd(1);                         // Read month from register 5
  year   = I2C1_Rd(0);                         // Read year from register 6
  I2C1_Stop();                                 // Stop I2C protocol
}
void alarms_read_display(){                    // Read and display alarm1 and alarm2 data function
  char control_reg, temperature_lsb;
  short temperature_msb;
  I2C1_Start();                                 // Start I2C protocol
  I2C1_Wr(0xD0);                                // DS3231 address
  I2C1_Wr(0x08);                                // Send register address (alarm1 minutes register)
  i2c_restart();                                // Restart I2C
  I2C1_Wr(0xD1);                                // Initialize data read
  alarm1_minute = I2C1_Rd(1);                   // Read alarm1 minutes
  alarm1_hour   = I2C1_Rd(1);                   // Read alarm1 hours
  I2C1_Rd(1);                                   // Skip alarm1 day/date register
  alarm2_minute = I2C1_Rd(1);                   // Read alarm2 minutes
  alarm2_hour   = I2C1_Rd(1);                   // Read alarm2 hours
  I2C1_Rd(1);                                   // Skip alarm2 day/date register
  control_reg = I2C1_Rd(1);                     // Read the DS3231 control register
  status_reg  = I2C1_Rd(1);                     // Read the DS3231 status register
  I2C1_Rd(1);                                   // Skip aging offset register
  temperature_msb = I2C1_Rd(1);                 // Read temperature MSB
  temperature_lsb = I2C1_Rd(0);                 // Read temperature LSB
  I2C1_Stop();                                  // Stop I2C protocol
    // Convert BCD to decimal
  alarm1_minute = (alarm1_minute >> 4) * 10 + (alarm1_minute & 0x0F);
  alarm1_hour   = (alarm1_hour   >> 4) * 10 + (alarm1_hour & 0x0F);
  alarm2_minute = (alarm2_minute >> 4) * 10 + (alarm2_minute & 0x0F);
  alarm2_hour   = (alarm2_hour   >> 4) * 10 + (alarm2_hour & 0x0F);
    // End conversion
  alarm1[8]     = alarm1_minute % 10  + 48;
  alarm1[7]     = alarm1_minute / 10  + 48;
  alarm1[5]     = alarm1_hour   % 10  + 48;
  alarm1[4]     = alarm1_hour   / 10  + 48;
  alarm2[8]     = alarm2_minute % 10  + 48;
  alarm2[7]     = alarm2_minute / 10  + 48;
  alarm2[5]     = alarm2_hour   % 10  + 48;
  alarm2[4]     = alarm2_hour   / 10  + 48;
  alarm1_status = control_reg;              // Read alarm1 interrupt enable bit (A1IE) from DS3231 control register
  alarm2_status = control_reg >> 1;         // Read alarm2 interrupt enable bit (A2IE) from DS3231 control register
  if(temperature_msb < 0){
    temperature_msb = abs(temperature_msb);
    temperature[2] = '-';
  }
  else
    temperature[2] = ' ';
  temperature_lsb >>= 6;
  temperature[4] = temperature_msb % 10  + 48;
  temperature[3] = temperature_msb / 10  + 48;
  if(temperature_lsb == 0 || temperature_lsb == 2){
    temperature[7] = '0';
    if(temperature_lsb == 0) temperature[6] = '0';
    else                     temperature[6] = '5';
  }
  if(temperature_lsb == 1 || temperature_lsb == 3){
    temperature[7] = '5';
    if(temperature_lsb == 1) temperature[6] = '2';
    else                     temperature[6] = '7';
  }
  temperature[8]  = 223;                         // Degree symbol
  UART1_Write_Text( temperature);                   // Display temperature
  
  Lcd_Out(3, 1, alarm1);                         // Display alarm1
  UART1_Write_Text( alarm1);
  
  if(alarm1_status)  UART1_Write_Text(  "ON ");      // If A1IE = 1 print 'ON'
  else               UART1_Write_Text(  "OFF");      // If A1IE = 0 print 'OFF'
  Lcd_Out(4, 1, alarm2);                         // Display alarm2
  if(alarm2_status)  Lcd_Out(4, 18, "ON ");      // If A2IE = 1 print 'ON'
  else               Lcd_Out(4, 18, "OFF");      // If A2IE = 0 print 'OFF'
}
void day_display(){                              // Day display function
  switch(day){
    case 1:  Lcd_Out(2, 1, "Sun"); break;
    case 2:  Lcd_Out(2, 1, "Mon"); break;
    case 3:  Lcd_Out(2, 1, "Tue"); break;
    case 4:  Lcd_Out(2, 1, "Wed"); break;
    case 5:  Lcd_Out(2, 1, "Thu"); break;
    case 6:  Lcd_Out(2, 1, "Fri"); break;
    default: Lcd_Out(2, 1, "Sat"); break;
  }
}
void DS3231_display(){
  // Convert BCD to decimal
  second = (second >> 4) * 10 + (second & 0x0F);
  minute = (minute >> 4) * 10 + (minute & 0x0F);
  hour   = (hour >> 4)   * 10 + (hour & 0x0F);
  date   = (date >> 4)   * 10 + (date & 0x0F);
  month  = (month >> 4)  * 10 + (month & 0x0F);
  year   = (year >> 4)   * 10 + (year & 0x0F);
  // End conversion
  time[7]     = second % 10  + 48;
  time[6]     = second / 10  + 48;
  time[4]     = minute % 10  + 48;
  time[3]     = minute / 10  + 48;
  time[1]     = hour   % 10  + 48;
  time[0]     = hour   / 10  + 48;
  calendar[9] = year  % 10 + 48;
  calendar[8] = year  / 10 + 48;
  calendar[4] = month % 10 + 48;
  calendar[3] = month / 10 + 48;
  calendar[1] = date  % 10 + 48;
  calendar[0] = date  / 10 + 48;
  Lcd_Out(1, 1, time);                           // Display time
  day_display();                                 // Display day
  Lcd_Out(2, 5, calendar);                       // Display calendar
}
void blink(){
  char j = 0;
  while(j < 10 && (PORTB.F3 || i >= 5) && PORTB.F4 && (PORTB.F5 || i < 5)){
    j++;
    delay_ms(25);
  }
}
char edit(char parameter, char x, char y){
  while(!PORTB.F3 || !PORTB.F5);                      // Wait for button RB0 is release
  while(1){
    while(!PORTB.F4){                                 // If button RB2 is pressed
      parameter++;
      if(((i == 0) || (i == 5)) && parameter > 23)    // If hours > 23 ==> hours = 0
        parameter = 0;
      if(((i == 1) || (i == 6)) && parameter > 59)    // If minutes > 59 ==> minutes = 0
        parameter = 0;
      if(i == 2 && parameter > 31)                    // If date > 31 ==> date = 1
        parameter = 1;
      if(i == 3 && parameter > 12)                    // If month > 12 ==> month = 1
        parameter = 1;
      if(i == 4 && parameter > 99)                    // If year > 99 ==> year = 0
        parameter = 0;
      if(i == 7 && parameter > 1)                     // For alarms ON or OFF (1: alarm ON, 0: alarm OFF)
        parameter = 0;
      if(i == 7){                                     // For alarms ON & OFF
        if(parameter == 1)  Lcd_Out(y, x, "ON ");
        else                Lcd_Out(y, x, "OFF");
      }
      else{
        Lcd_Chr(y, x, parameter / 10 + 48);
        Lcd_Chr(y, x + 1, parameter % 10 + 48);
      }
      if(i >= 5){
        DS3231_read();                             // Read data from DS3231
        DS3231_display();                          // Display DS3231 time and calendar
      }
      delay_ms(200);                               // Wait 200ms
    }
    Lcd_Out(y, x, "  ");                           // Print two spaces
    if(i == 7) Lcd_Out(y, x + 2, " ");             // Print space (for alarms ON & OFF)
    blink();                                       // Call blink function
    if(i == 7){                                    // For alarms ON & OFF
      if(parameter == 1)  Lcd_Out(y, x, "ON ");
      else                Lcd_Out(y, x, "OFF");
    }
    else{
      Lcd_Chr(y, x, parameter / 10 + 48);
      Lcd_Chr(y, x + 1, parameter % 10 + 48);
    }
    blink();
    if(i >= 5){
      DS3231_read();
      DS3231_display();}
    if((!PORTB.F3 && i < 5) || (!PORTB.F5 && i >= 5)){
      i++;                                       // Increment 'i' for the next parameter
      return parameter;                          // Return parameter value and exit
    }
  }
}

void main() {

  ADCON1 =0x0F;                      // Configure all PORTB pins as digital
  PORTB = 0;                       // PORTB initial state
  TRISB = 0x0F;                    // Configure RB0 ~ 3 as input pins
  INTCON2.RBPU=0;                  // Pull-up resistors
  I2C1_Init(100000);               // Initialize I2C communication
  Lcd_Init();                      // Initialize LCD module
  Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
  Lcd_Cmd(_LCD_CLEAR);             // clear LCD

  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("inicio");
  UART1_Write(10);
  UART1_Write(13);


  while(1) {
    if(!PORTB.F3){                          // If RB3 button is pressed
      i = 0;
      hour   = edit(hour, 1, 1);            // Edit hours
      minute = edit(minute, 4, 1);          // Edit minutes
      while(!PORTB.F3);                     // Wait for button RB0 release
      while(1){
        while(!PORTB.F4){                   // If button RB2 button is pressed
          day++;                            // Increment day
          if(day > 7) day = 1;
          day_display();
          delay_ms(200);
        }
        Lcd_Out(2, 1, "   ");                // Print 3 spaces
        blink();
        day_display();
        blink();                             // Call blink function
        if(!PORTB.F3)                        // If button RB1 is pressed
          break;
      }
      date = edit(date, 5, 2);                   // Edit date
      month = edit(month, 8, 2);                 // Edit month
      year = edit(year, 13, 2);                  // Edit year
      // Convert decimal to BCD
      minute = ((minute / 10) << 4) + (minute % 10);
      hour = ((hour / 10) << 4) + (hour % 10);
      date = ((date / 10) << 4) + (date % 10);
      month = ((month / 10) << 4) + (month % 10);
      year = ((year / 10) << 4) + (year % 10);
      // End conversion
      // Write time & calendar data to DS3231 RTC
      I2C1_Start();                               // Start I2C protocol
      I2C1_Wr(0xD0);                           // DS3231 address
      I2C1_Wr(0);                              // Send register address (seconds address)
      I2C1_Wr(0);                              // Reset seconds and start oscillator
      I2C1_Wr(minute);                         // Write minute value to DS3231
      I2C1_Wr(hour);                           // Write hour value to DS3231
      I2C1_Wr(day);                            // Write day value
      I2C1_Wr(date);                           // Write date value to DS3231
      I2C1_Wr(month);                          // Write month value to DS3231
      I2C1_Wr(year);                           // Write year value to DS3231
      I2C1_Stop();                             // Stop I2C
      delay_ms(200);                           // Wait 200ms
    }
    if(!PORTB.F5){                             // If RB3 button is pressed
      while(!PORTB.F5);                        // Wait until button RB3 released
      i = 5;
      alarm1_hour   = edit(alarm1_hour, 5, 3);
      alarm1_minute = edit(alarm1_minute, 8, 3);
      alarm1_status = edit(alarm1_status, 18, 3);
      i = 5;
      alarm2_hour   = edit(alarm2_hour, 5, 4);
      alarm2_minute = edit(alarm2_minute, 8, 4);
      alarm2_status = edit(alarm2_status, 18, 4);
      alarm1_minute = ((alarm1_minute / 10) << 4) + (alarm1_minute % 10);
      alarm1_hour   = ((alarm1_hour / 10) << 4) + (alarm1_hour % 10);
      alarm2_minute = ((alarm2_minute / 10) << 4) + (alarm2_minute % 10);
      alarm2_hour   = ((alarm2_hour / 10) << 4) + (alarm2_hour % 10);
      // Write alarms data to DS3231
      I2C1_Start();                            // Start I2C
      I2C1_Wr(0xD0);                           // DS3231 address
      I2C1_Wr(7);                              // Send register address (alarm1 seconds)
      I2C1_Wr(0);                              // Write 0 to alarm1 seconds
      I2C1_Wr(alarm1_minute);                  // Write alarm1 minutes value to DS3231
      I2C1_Wr(alarm1_hour);                    // Write alarm1 hours value to DS3231
      I2C1_Wr(0x80);                           // Alarm1 when hours, minutes, and seconds match
      I2C1_Wr(alarm2_minute);                  // Write alarm2 minutes value to DS3231
      I2C1_Wr(alarm2_hour);                    // Write alarm2 hours value to DS3231
      I2C1_Wr(0x80);                           // Alarm2 when hours and minutes match
      I2C1_Wr(4 | alarm1_status | (alarm2_status << 1));      // Write data to DS3231 control register (enable interrupt when alarm)
      I2C1_Wr(0);                              // Clear alarm flag bits
      I2C1_Stop();                             // Stop I2C
      delay_ms(200);                           // Wait 200ms
    }
    if(!PORTB.F4 && PORTB.F6){                 // When button B2 pressed with alarm (Reset and turn OFF the alarm)
      PORTB.F6 = 0;                            // Turn OFF the alarm indicator
      I2C1_Start();                            // Start I2C
      I2C1_Wr(0xD0);                           // DS3231 address
      I2C1_Wr(0x0E);                           // Send register address (control register)
      // Write data to control register (Turn OFF the occurred alarm and keep the other as it is)
      I2C1_Wr(4 | (!(status_reg & 1) & alarm1_status) | ((!((status_reg >> 1) & 1) & alarm2_status) << 1));
      I2C1_Wr(0);                              // Clear alarm flag bits
      I2C1_Stop();                             // Stop I2C
    }
    DS3231_read();                             // Read time and calendar parameters from DS3231 RTC
    alarms_read_display();                     // Read and display alarms parameters
    DS3231_display();                          // Display time & calendar
    delay_ms(50);                              // Wait 50ms
  }
}
// End of code