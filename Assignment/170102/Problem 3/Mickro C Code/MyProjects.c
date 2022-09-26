// Code By Md Maruf Bangabashi - 170102

 sbit LCD_RS at RB0_bit;
 sbit LCD_EN at RB1_bit;
 sbit LCD_D4 at RB2_bit;
 sbit LCD_D5 at RB3_bit;
 sbit LCD_D6 at RB4_bit;
 sbit LCD_D7 at RB5_bit;
 sbit LCD_RS_Direction at TRISB0_bit;
 sbit LCD_EN_Direction at TRISB1_bit;
 sbit LCD_D4_Direction at TRISB2_bit;
 sbit LCD_D5_Direction at TRISB3_bit;
 sbit LCD_D6_Direction at TRISB4_bit;
 sbit LCD_D7_Direction at TRISB5_bit;
 // End LCD module connections

 unsigned char  Check, T_byte1, T_byte2, RH_byte1, RH_byte2, Ch ;
 unsigned Temp, RH, Sum ;
 unsigned be, me,ne, Sum2,h1,h2 ;

//////////////////////////////
 void StartSignal(){
 TRISD.F0 = 0;    //Configure RD0 as output
 PORTD.F0 = 0;    //RD0 sends 0 to the sensor
 delay_ms(18);
 PORTD.F0 = 1;    //RD0 sends 1 to the sensor
 delay_us(30);
 TRISD.F0 = 1;    //Configure RD0 as input
  }
void GasLeakage(){
//Configuration for gas leakage
trisd.f7 = 1;
TRISc = 0x00;
PORTc = 0x00;
// gas leakage
if(PORTD.f7 == 1){
Portc.f1 = 1;
Portc.f7 = 1;
delay_ms(100);
Portc.f7 = 0;
delay_ms(10);
}
else if(PORTD.f7 == 0){
Portc.f1 = 0;
Portc.f7 = 0;
}
       // gas leakage end
}
 //////////////////////////////
 void CheckResponse(){
 Check = 0;
 delay_us(40);
 if (PORTD.F0 == 0){
 delay_us(80);
 if (PORTD.F0 == 1)   Check = 1;   delay_us(40);}
 }
 //////////////////////////////
 char ReadData(){
 char i, j;
 for(j = 0; j < 8; j++){
 while(!PORTD.F0); //Wait until PORTD.F0 goes HIGH
 delay_us(30);
 if(PORTD.F0 == 0)
       i&= ~(1<<(7 - j));  //Clear bit (7-b)
 else {i|= (1 << (7 - j));  //Set bit (7-b)
 while(PORTD.F0);}  //Wait until PORTD.F0 goes LOW
 }
 return i;
 }
 //////////////////////////////

 void main() {
 TRISC = 0;    //Configure RC0 as output
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
 Lcd_Cmd(_LCD_CLEAR);             // clear LCD
 while(1){
  GasLeakage();
  StartSignal();
  CheckResponse();
  if(Check == 1){
  RH_byte1 = ReadData();
  RH_byte2 = ReadData();
  T_byte1 = ReadData();
  T_byte2 = ReadData();
  Sum = ReadData();
  if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF)){
  Temp = T_byte1;
  Temp = (Temp << 8) | T_byte2;
  RH = RH_byte1;
  Lcd_Cmd(_LCD_CLEAR);             // clear LCD
  RH = (RH << 8) | RH_byte2;
  Lcd_Out(1, 6, "Temp:   . C");
  Lcd_Out(2, 2, "Humidity:   . %");
  if (Temp > 0X8000){
  Lcd_Out(1, 11, "-");
  Temp = Temp & 0X7FFF; }
  be=(48 + ((Temp / 100) % 10));//work for frist later of temperature like 2 than 22,,23,
  LCD_Chr(1, 12, be);
  me= (48 + ((Temp / 10) % 10));
  LCD_Chr(1, 13, me);
  ne=48 + (Temp % 10);
  LCD_Chr(1, 15, ne); //after (.) number

 //for humidity
  h1=  48 + ((RH / 100) % 10);
  LCD_Chr(2, 12, h1);
  h2= 48 + ((RH / 10) % 10);
  LCD_Chr(2, 13, h2);
  LCD_Chr(2, 15, 48 + (RH % 10));
  /////////////////////////////////////////////////

    if(be==51 & me==55 & ne>53){ // more then 26*C   relay
    DELAY_MS(500);
     portc.f0=0;

      }
    if(be<52 & me<56 & ne<52 ){  // less then 26*C
     portc.f0=1;

    }
    if (h1>53 & h2>52)  // for humidity control relay
    {
    portc.f1 =0;
    }
    if(h1<54 & h2<49)
    {
    portc.f1=1;
    }

   }
  else {
  Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
  Lcd_Cmd(_LCD_CLEAR);             // clear LCD
  Lcd_Out(1, 1, "Check sum error");}
  }
  else {
  Lcd_Out(1, 3, "No response");
  Lcd_Out(2, 1, "from the sensor");
  }
  delay_ms(1000);
  }
  }