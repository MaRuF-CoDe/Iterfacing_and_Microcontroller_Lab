/*******************************************************************************
Program for, "DHT11 interfacing with PIC16F877A"
Program written by_ Engr. Mithun K. Das
MCU: PIC16F877A; X-tal: 8MHz; mikroC pro for PIC v7.6.0
Date: 15-05-2020
*******************************************************************************/
// LCD module connections
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
// END of LCD initialization
// DHT22 pin connection (here data pin is connected to pin RB0)
#define DHT22_PIN         RB1_bit
#define DHT22_PIN_DIR     TRISB1_bit
#include <stdint.h>
// read one byte from sensor
uint8_t dht22_read_byte()
{
  uint8_t i = 8, dht22_byte = 0;
  while(i--)
  {
    while( !DHT22_PIN );
    Delay_us(40);
    if( DHT22_PIN )
    {
      dht22_byte |= (1 << i);   // set bit i
      while( DHT22_PIN );
    }
  }
  return(dht22_byte);
}
// read humidity (in hundredths rH%) and temperature (in hundredths °Celsius) from sensor
void dht22_read(uint16_t *dht22_humi, int16_t *dht22_temp)
{
  // send start signal
  DHT22_PIN     = 0;   // connection pin output low
  DHT22_PIN_DIR = 0;   // configure connection pin as output
  Delay_ms(25);        // wait 25 ms
  DHT22_PIN     = 1;   // connection pin output high
  Delay_us(30);        // wait 30 us
  DHT22_PIN_DIR = 1;   // configure connection pin as input
  // check sensor response
  while( DHT22_PIN );
  while(!DHT22_PIN );
  while( DHT22_PIN );
  // read data
  *dht22_humi = dht22_read_byte();  // read humidity byte 1
  *dht22_humi = (*dht22_humi << 8) | dht22_read_byte();  // read humidity byte 2
  *dht22_temp = dht22_read_byte();  // read temperature byte 1
  *dht22_temp = (*dht22_temp << 8) | dht22_read_byte();  // read temperature byte 2
  dht22_read_byte();               // read checksum (skipped)
  if(*dht22_temp & 0x8000)// if temperature is negative
  {
    *dht22_temp &= 0x7FFF;
    *dht22_temp *= -1;
  }
}
char message[] = "00.0";
int humidity, temperature;
// main function
void main()
{
  ADCON1 = 0x07;//ADC Off
  ADCON0 = 0x00;
  CMCON = 0x07;//comparator off
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
    Delay_ms(1000);  // wait a second
  }//while(1)
}
// end of code.








/*
void main() {
    trisd.f0 = 1;
    TRISB = 0x00;
    PORTB = 0x00;

    while(1){
       if(PORTD.f0 == 1){
           Portb.f0 = 1;
           delay_ms(10);
           Portb.f0 = 0;
           delay_ms(10);
           Portb.f1 = 1;
       }
       if(PORTD.f0 == 0){
           Portb.f0 = 0;
           Portb.f1 = 0;
       }
    }
}*/





