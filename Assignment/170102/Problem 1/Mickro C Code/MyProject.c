// Code By Md Maruf Bangabashi - 170102

char CA[]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};

void main() {

    int i=0,leftD=0, rightD=0,j,p,r,s=0;
    //Port B Configuration
    TRISB=0x00;
    PORTB=0x00;

    //Port C Configuration
    TRISC = 0x00;
    PORTC = 0x00; //Initialize PortC

  //Port D Configuration
    TRISD = 0xff;
    PORTD = 0x00;  //Initialize PortD
    while(1){

    if(portd.f4==1){

    //Program mode

    portc.f5=0;
    portc.f6=0;
    portc.f7=0;
    i=0;
    j=0;
    p=0;
    s=1;
    while(1){
         if(portd.f6==1)
         {
            if(i<100)
             i++;
             p++;
         }
         if(portd.f7==1)
         {
           if(i>=0)
             i--;
             p--;
          }

         leftD=i/10;
         rightD=i%10;
         for(j=0;j<10;j++)
         {
           portc.f0=1;
           portb=CA[leftD];
           delay_ms(10);
           portc.f0=0;


           portc.f1=1;
           portb=CA[rightD];
           delay_ms(10);
           portc.f1=0;
         }
         if(portd.f4==0)
         {
           break;
         }
      }
    }
   else if(portd.f4==0) {
       //run mode
       portc.f5=1;
       leftD=0;
       rightD=0;
       for(j=0;j<10;j++)
         {
           portc.f0=1;
           portb=CA[leftD];
           delay_ms(10);
           portc.f0=0;


           portc.f1=1;
           portb=CA[rightD];
           delay_ms(10);
           portc.f1=0;
         }
         i=0;
         j=0;
         r=0;
         while(1){
          if(portd.f6==1)
         {
            if(i<100)
             i++;
             r++;
         }
         if(portd.f7==1)
         {
           if(i>=0)
             i--;
             r--;
          }

         leftD=i/10;
         rightD=i%10;
         for(j=0;j<10;j++)
         {
           portc.f0=1;
           portb=CA[leftD];
           delay_ms(10);
           portc.f0=0;


           portc.f1=1;
           portb=CA[rightD];
           delay_ms(10);
           portc.f1=0;
         }
         if(p==r && s==1)
          {

           while(1)
           {
            portc.f5=0;
            portc.f6=1;
            delay_ms(2000);
            portc.f6 =0;
            portc.f7=1;
            delay_ms(2000);
            portc.f7 =0;
            portc.f5=1;
            delay_ms(2000);
            if(portd.f4 == 1) break;
           }

          }
       }

   }
   }
}