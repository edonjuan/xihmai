#line 1 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_2.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdio.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
int max(int a, int b);
int min(int a, int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
#line 14 "C:/Users/UTEQ/Documents/GitHub/xihmai/firmware/mikroC/g_ACE_2.c"
void MPU6050_Init()
{
 MSdelay(150);
 I2C_Start_Wait(0xD0);
 I2C_Write(SMPLRT_DIV);
 I2C_Write(0x07);
 I2C_Stop();

 I2C_Start_Wait(0xD0);
 I2C_Write(PWR_MGMT_1);
 I2C_Write(0x01);
 I2C_Stop();

 I2C_Start_Wait(0xD0);
 I2C_Write(CONFIG);
 I2C_Write(0x00);
 I2C_Stop();

 I2C_Start_Wait(0xD0);
 I2C_Write(GYRO_CONFIG);
 I2C_Write(0x18);
 I2C_Stop();

 I2C_Start_Wait(0xD0);
 I2C_Write(INT_ENABLE);
 I2C_Write(0x01);
 I2C_Stop();
}

void MPU_Start_Loc()

{
 I2C_Start_Wait(0xD0);
 I2C_Write(ACCEL_XOUT_H);
 I2C_Repeated_Start(0xD1);
}

void main()

{
 char buffer[20];
 int Ax,Ay,Az,T,Gx,Gy,Gz;
 float Xa,Ya,Za,t,Xg,Yg,Zg;
 OSCCON = 0x72;
 I2C_Init();
 MPU6050_Init();
 USART_Init(9600);

 while(1)
 {
 MPU_Start_Loc();

 Ax = (((int)I2C_Read(0)<<8) | (int)I2C_Read(0));
 Ay = (((int)I2C_Read(0)<<8) | (int)I2C_Read(0));
 Az = (((int)I2C_Read(0)<<8) | (int)I2C_Read(0));
 T = (((int)I2C_Read(0)<<8) | (int)I2C_Read(0));
 Gx = (((int)I2C_Read(0)<<8) | (int)I2C_Read(0));
 Gy = (((int)I2C_Read(0)<<8) | (int)I2C_Read(0));
 Gz = (((int)I2C_Read(0)<<8) | (int)I2C_Read(1));
 I2C_Stop();



 Xa = (float)Ax/16384.0;
 Ya = (float)Ay/16384.0;
 Za = (float)Az/16384.0;
 Xg = (float)Gx/131.0;
 Yg = (float)Gy/131.0;
 Zg = (float)Gz/131.0;
 t = ((float)T/340.00)+36.53;



 sprintf(buffer," Ax = %.2f g\t",Xa);
 USART_SendString(buffer);

 sprintf(buffer," Ay = %.2f g\t",Ya);
 USART_SendString(buffer);

 sprintf(buffer," Az = %.2f g\t",Za);
 USART_SendString(buffer);


 sprintf(buffer," T = %.2f%cC\t",t,0xF8);
 USART_SendString(buffer);

 sprintf(buffer," Gx = %.2f%c/s\t",Xg,0xF8);
 USART_SendString(buffer);

 sprintf(buffer," Gy = %.2f%c/s\t",Yg,0xF8);
 USART_SendString(buffer);

 sprintf(buffer," Gz = %.2f%c/s\r\n",Zg,0xF8);
 USART_SendString(buffer);
 }
}
