// Sensors library
// Accelerometer configuration program

#define ADW 0xD2                              // adress to write and read
#define ADR 0xD3

void Accelconfig(void)
{     

       I2C2_Start();                // Configuring MPU6050 and interruption
       I2C2_Wr(0xD2);                          // 19 x(4F)
       I2C2_Wr(0x19);                           //D0
       I2C2_Wr(0x07);
       I2C2_Stop();
       delay_ms(100);

                                            // être sure du Reset de touts les registers
       I2C2_Start();
       I2C2_Wr(ADW);                // 6B   yes (RESETS ALL)(new)
       I2C2_Wr(0x6B);
       I2C2_Wr(0x00);
       I2C2_Stop();
       delay_ms(100);


       I2C2_Start();
       I2C2_Wr(ADW);                // 6C il manque les premier deux zeros pour wake-ups
       I2C2_Wr(0x6C);               // bits 7 y 6
       I2C2_Wr(0x00);
       I2C2_Stop();
       delay_ms(100);


       I2C2_Start();
       I2C2_Wr(ADW);                // 1B    yes (18)
       I2C2_Wr(0x1B);
       I2C2_Wr(0x00);
       I2C2_Stop();
       delay_ms(100);

       I2C2_Start();
       I2C2_Wr(ADW);                // 1C    yes    (18)
       I2C2_Wr(0x1C);
       I2C2_Wr(0x00);
       I2C2_Stop();
       delay_ms(100);

       I2C2_Start();
       delay_ms(100);
       I2C2_Wr(ADW);                //  38   Activar motion interrupt ( activa el bit (-))
       I2C2_Wr(0x38);
       I2C2_Wr(0x40);
       I2C2_Stop();
       delay_ms(100);

       I2C2_Start();
       I2C2_Wr(ADW);                // Motion interrupt duration
       I2C2_Wr(0x20);
       I2C2_Wr(0x01);
       I2C2_Stop();
       delay_ms(100);

       I2C2_Start();
       I2C2_Wr(ADW);                // interrupt data ready (INTERRUPT) STATUS
       I2C2_Wr(0x3A);
       I2C2_Wr(0x01);
       I2C2_Stop();
       delay_ms(100);


       I2C2_Start();
       I2C2_Wr(ADW);                // 1F     Treshold = 100 320mg
       I2C2_Wr(0x1F);               // 20=32mg=0x14
       I2C2_Wr(0x01);
       I2C2_Stop();
       delay_ms(200);                // delay extra


       I2C2_Start();
       I2C2_Wr(ADW);                // 1A   (0b00000111)  MOtion HPF HOLD    (07)
       I2C2_Wr(0x1A);
       I2C2_Wr(0xFF);
       I2C2_Stop();
       delay_ms(100);


       I2C2_Start();
       I2C2_Wr(ADW);                // 6C (2) il manque les premier deux zeros pour wake-ups
       I2C2_Wr(0x6C);               // bits 7 y 6
       I2C2_Wr(0x60);
       I2C2_Stop();
       delay_ms(100);


       I2C2_Start();
       I2C2_Wr(ADW);                // 6B   activate cycle
       I2C2_Wr(0x6B);
       I2C2_Wr(0x10);
       I2C2_Stop();
       delay_ms(100);


       delay_ms(200);
}