// Sensors library
// Temperature & humidity from TH02 (I2C)

void th02Init(void)
{
   I2C2_Init(100000);         // Initialize I2C communication
   delay_ms(100);
}

float getTemperature(void)
{
   float temperature;
   unsigned int buffer;
   
   I2C2_Start();
   I2C2_Wr(0x80);                // Address Device + Write
   I2C2_Wr(0x03);                // Address Pointer
   I2C2_Wr(0x11);                // Register Data
   I2C2_Stop();

   delay_ms(80);                 // Conversion time (MAX = 40ms)

   I2C2_Start();
   I2C2_Wr(0x80);                // Address Device + Write
   I2C2_Wr(0x01);                // Address Pointer
   I2C2_Repeated_start();
   I2C2_Wr(0x81);                // Address Device + Read
   buffer =  I2C2_Rd(1) << 8;
   buffer |=  I2C2_Rd(0);
   I2C2_Stop();

   buffer >>= 2;                 // Equation from data sheet
   temperature = buffer;
   temperature = (temperature/32)-50;
   
   return temperature;
}

float getHumidity(void)
{
   float humidity;
   unsigned int buffer;

   I2C2_Start();
   I2C2_Wr(0x80);                // Address Device + Write
   I2C2_Wr(0x03);                // Address Pointer
   I2C2_Wr(0x01);                // Register Data
   I2C2_Stop();

   delay_ms(80);                 // Conversion time (MAX = 40ms)

   I2C2_Start();
   I2C2_Wr(0x80);                // Address Device + Write
   I2C2_Wr(0x01);                // Address Pointer
   I2C2_Repeated_start();
   I2C2_Wr(0x81);                // Address Device + Read
   buffer =  I2C2_Rd(1) << 8;
   buffer |=  I2C2_Rd(0);
   I2C2_Stop();

   buffer >>= 4;                 // Equation from data sheet
   
   if(buffer>1984)
      humidity = 1984;
   else if(buffer<384)
      humidity = 384;
   else
      humidity = buffer;
   humidity = (humidity/16)-24;

   return humidity;
}