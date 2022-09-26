#line 1 "I:/Varsity Resources/Tarun_Sir/Code/Assignment/Problem_3/Code/Gas_Smoke_Leakage.c"
#line 8 "I:/Varsity Resources/Tarun_Sir/Code/Assignment/Problem_3/Code/Gas_Smoke_Leakage.c"
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 26 "I:/Varsity Resources/Tarun_Sir/Code/Assignment/Problem_3/Code/Gas_Smoke_Leakage.c"
uint8_t dht22_read_byte()
{
 uint8_t i = 8, dht22_byte = 0;
 while(i--)
 {
 while( ! RB1_bit  );
 Delay_us(40);
 if(  RB1_bit  )
 {
 dht22_byte |= (1 << i);
 while(  RB1_bit  );
 }
 }
 return(dht22_byte);
}

void dht22_read(uint16_t *dht22_humi, int16_t *dht22_temp)
{

  RB1_bit  = 0;
  TRISB1_bit  = 0;
 Delay_ms(25);
  RB1_bit  = 1;
 Delay_us(30);
  TRISB1_bit  = 1;

 while(  RB1_bit  );
 while(! RB1_bit  );
 while(  RB1_bit  );

 *dht22_humi = dht22_read_byte();
 *dht22_humi = (*dht22_humi << 8) | dht22_read_byte();
 *dht22_temp = dht22_read_byte();
 *dht22_temp = (*dht22_temp << 8) | dht22_read_byte();
 dht22_read_byte();
 if(*dht22_temp & 0x8000)
 {
 *dht22_temp &= 0x7FFF;
 *dht22_temp *= -1;
 }
}
char message[] = "00.0";
int humidity, temperature;

void main()
{
 ADCON1 = 0x07;
 ADCON0 = 0x00;
 CMCON = 0x07;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"DHT22 WITH");
 Lcd_Out(2,1,"PIC16F877A");
 Delay_ms(2000);
 Lcd_Cmd(_LCD_CLEAR);
 while(1)
 {
 dht22_read(&humidity, &temperature);
 Lcd_Out(1,1,"HUMIDITY:");
 Lcd_Out(2,1,"TEMP:");
 message[0] = humidity/100 + 48;
 message[1] = humidity/10%10 + 48;
 message[3] = humidity%10 + 48;
 Lcd_Out(1,11, message);
 Lcd_Out(1,16,"%");
 message[0] = temperature/100 + 48;
 message[1] = temperature/10%10 + 48;
 message[3] = temperature%10 + 48;
 Lcd_Out(2,11, message);
 Lcd_Chr_CP(223);
 Lcd_Out(2,16,"C");
 Delay_ms(1000);
 }
}
