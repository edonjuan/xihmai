#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/T_RTCDS3231/T_RTCDS3231_1.c"

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


bit alarm1_status, alarm2_status;
char time[] = "  :  :  ",
 calendar[] = "  /  /20  ",
 alarm1[] = "A1:   :  :00", alarm2[] = "A2:   :  :00",
 temperature[] = "T:   .   C";
char i, second, minute, hour, day, date, month, year,
 alarm1_minute, alarm1_hour, alarm2_minute, alarm2_hour,
 status_reg;

void Interrupt() {

}
void DS3231_read(){
 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(0);
 I2C1_Repeated_Start();
 I2C1_Wr(0xD1);
 second = I2C1_Rd(1);
 minute = I2C1_Rd(1);
 hour = I2C1_Rd(1);
 day = I2C1_Rd(1);
 date = I2C1_Rd(1);
 month = I2C1_Rd(1);
 year = I2C1_Rd(0);
 I2C1_Stop();
}
void alarms_read_display(){
 char control_reg, temperature_lsb;
 short temperature_msb;
 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(0x08);
 i2c_restart();
 I2C1_Wr(0xD1);
 alarm1_minute = I2C1_Rd(1);
 alarm1_hour = I2C1_Rd(1);
 I2C1_Rd(1);
 alarm2_minute = I2C1_Rd(1);
 alarm2_hour = I2C1_Rd(1);
 I2C1_Rd(1);
 control_reg = I2C1_Rd(1);
 status_reg = I2C1_Rd(1);
 I2C1_Rd(1);
 temperature_msb = I2C1_Rd(1);
 temperature_lsb = I2C1_Rd(0);
 I2C1_Stop();

 alarm1_minute = (alarm1_minute >> 4) * 10 + (alarm1_minute & 0x0F);
 alarm1_hour = (alarm1_hour >> 4) * 10 + (alarm1_hour & 0x0F);
 alarm2_minute = (alarm2_minute >> 4) * 10 + (alarm2_minute & 0x0F);
 alarm2_hour = (alarm2_hour >> 4) * 10 + (alarm2_hour & 0x0F);

 alarm1[8] = alarm1_minute % 10 + 48;
 alarm1[7] = alarm1_minute / 10 + 48;
 alarm1[5] = alarm1_hour % 10 + 48;
 alarm1[4] = alarm1_hour / 10 + 48;
 alarm2[8] = alarm2_minute % 10 + 48;
 alarm2[7] = alarm2_minute / 10 + 48;
 alarm2[5] = alarm2_hour % 10 + 48;
 alarm2[4] = alarm2_hour / 10 + 48;
 alarm1_status = control_reg;
 alarm2_status = control_reg >> 1;
 if(temperature_msb < 0){
 temperature_msb = abs(temperature_msb);
 temperature[2] = '-';
 }
 else
 temperature[2] = ' ';
 temperature_lsb >>= 6;
 temperature[4] = temperature_msb % 10 + 48;
 temperature[3] = temperature_msb / 10 + 48;
 if(temperature_lsb == 0 || temperature_lsb == 2){
 temperature[7] = '0';
 if(temperature_lsb == 0) temperature[6] = '0';
 else temperature[6] = '5';
 }
 if(temperature_lsb == 1 || temperature_lsb == 3){
 temperature[7] = '5';
 if(temperature_lsb == 1) temperature[6] = '2';
 else temperature[6] = '7';
 }
 temperature[8] = 223;
 UART1_Write_Text( temperature);

 Lcd_Out(3, 1, alarm1);
 UART1_Write_Text( alarm1);

 if(alarm1_status) UART1_Write_Text( "ON ");
 else UART1_Write_Text( "OFF");
 Lcd_Out(4, 1, alarm2);
 if(alarm2_status) Lcd_Out(4, 18, "ON ");
 else Lcd_Out(4, 18, "OFF");
}
void day_display(){
 switch(day){
 case 1: Lcd_Out(2, 1, "Sun"); break;
 case 2: Lcd_Out(2, 1, "Mon"); break;
 case 3: Lcd_Out(2, 1, "Tue"); break;
 case 4: Lcd_Out(2, 1, "Wed"); break;
 case 5: Lcd_Out(2, 1, "Thu"); break;
 case 6: Lcd_Out(2, 1, "Fri"); break;
 default: Lcd_Out(2, 1, "Sat"); break;
 }
}
void DS3231_display(){

 second = (second >> 4) * 10 + (second & 0x0F);
 minute = (minute >> 4) * 10 + (minute & 0x0F);
 hour = (hour >> 4) * 10 + (hour & 0x0F);
 date = (date >> 4) * 10 + (date & 0x0F);
 month = (month >> 4) * 10 + (month & 0x0F);
 year = (year >> 4) * 10 + (year & 0x0F);

 time[7] = second % 10 + 48;
 time[6] = second / 10 + 48;
 time[4] = minute % 10 + 48;
 time[3] = minute / 10 + 48;
 time[1] = hour % 10 + 48;
 time[0] = hour / 10 + 48;
 calendar[9] = year % 10 + 48;
 calendar[8] = year / 10 + 48;
 calendar[4] = month % 10 + 48;
 calendar[3] = month / 10 + 48;
 calendar[1] = date % 10 + 48;
 calendar[0] = date / 10 + 48;
 Lcd_Out(1, 1, time);
 day_display();
 Lcd_Out(2, 5, calendar);
}
void blink(){
 char j = 0;
 while(j < 10 && (PORTB.F3 || i >= 5) && PORTB.F4 && (PORTB.F5 || i < 5)){
 j++;
 delay_ms(25);
 }
}
char edit(char parameter, char x, char y){
 while(!PORTB.F3 || !PORTB.F5);
 while(1){
 while(!PORTB.F4){
 parameter++;
 if(((i == 0) || (i == 5)) && parameter > 23)
 parameter = 0;
 if(((i == 1) || (i == 6)) && parameter > 59)
 parameter = 0;
 if(i == 2 && parameter > 31)
 parameter = 1;
 if(i == 3 && parameter > 12)
 parameter = 1;
 if(i == 4 && parameter > 99)
 parameter = 0;
 if(i == 7 && parameter > 1)
 parameter = 0;
 if(i == 7){
 if(parameter == 1) Lcd_Out(y, x, "ON ");
 else Lcd_Out(y, x, "OFF");
 }
 else{
 Lcd_Chr(y, x, parameter / 10 + 48);
 Lcd_Chr(y, x + 1, parameter % 10 + 48);
 }
 if(i >= 5){
 DS3231_read();
 DS3231_display();
 }
 delay_ms(200);
 }
 Lcd_Out(y, x, "  ");
 if(i == 7) Lcd_Out(y, x + 2, " ");
 blink();
 if(i == 7){
 if(parameter == 1) Lcd_Out(y, x, "ON ");
 else Lcd_Out(y, x, "OFF");
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
 i++;
 return parameter;
 }
 }
}

void main() {

 ADCON1 =0x0F;
 PORTB = 0;
 TRISB = 0x0F;
 INTCON2.RBPU=0;
 I2C1_Init(100000);
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);

 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("inicio");
 UART1_Write(10);
 UART1_Write(13);


 while(1) {
 if(!PORTB.F3){
 i = 0;
 hour = edit(hour, 1, 1);
 minute = edit(minute, 4, 1);
 while(!PORTB.F3);
 while(1){
 while(!PORTB.F4){
 day++;
 if(day > 7) day = 1;
 day_display();
 delay_ms(200);
 }
 Lcd_Out(2, 1, "   ");
 blink();
 day_display();
 blink();
 if(!PORTB.F3)
 break;
 }
 date = edit(date, 5, 2);
 month = edit(month, 8, 2);
 year = edit(year, 13, 2);

 minute = ((minute / 10) << 4) + (minute % 10);
 hour = ((hour / 10) << 4) + (hour % 10);
 date = ((date / 10) << 4) + (date % 10);
 month = ((month / 10) << 4) + (month % 10);
 year = ((year / 10) << 4) + (year % 10);


 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(0);
 I2C1_Wr(0);
 I2C1_Wr(minute);
 I2C1_Wr(hour);
 I2C1_Wr(day);
 I2C1_Wr(date);
 I2C1_Wr(month);
 I2C1_Wr(year);
 I2C1_Stop();
 delay_ms(200);
 }
 if(!PORTB.F5){
 while(!PORTB.F5);
 i = 5;
 alarm1_hour = edit(alarm1_hour, 5, 3);
 alarm1_minute = edit(alarm1_minute, 8, 3);
 alarm1_status = edit(alarm1_status, 18, 3);
 i = 5;
 alarm2_hour = edit(alarm2_hour, 5, 4);
 alarm2_minute = edit(alarm2_minute, 8, 4);
 alarm2_status = edit(alarm2_status, 18, 4);
 alarm1_minute = ((alarm1_minute / 10) << 4) + (alarm1_minute % 10);
 alarm1_hour = ((alarm1_hour / 10) << 4) + (alarm1_hour % 10);
 alarm2_minute = ((alarm2_minute / 10) << 4) + (alarm2_minute % 10);
 alarm2_hour = ((alarm2_hour / 10) << 4) + (alarm2_hour % 10);

 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(7);
 I2C1_Wr(0);
 I2C1_Wr(alarm1_minute);
 I2C1_Wr(alarm1_hour);
 I2C1_Wr(0x80);
 I2C1_Wr(alarm2_minute);
 I2C1_Wr(alarm2_hour);
 I2C1_Wr(0x80);
 I2C1_Wr(4 | alarm1_status | (alarm2_status << 1));
 I2C1_Wr(0);
 I2C1_Stop();
 delay_ms(200);
 }
 if(!PORTB.F4 && PORTB.F6){
 PORTB.F6 = 0;
 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(0x0E);

 I2C1_Wr(4 | (!(status_reg & 1) & alarm1_status) | ((!((status_reg >> 1) & 1) & alarm2_status) << 1));
 I2C1_Wr(0);
 I2C1_Stop();
 }
 DS3231_read();
 alarms_read_display();
 DS3231_display();
 delay_ms(50);
 }
}
