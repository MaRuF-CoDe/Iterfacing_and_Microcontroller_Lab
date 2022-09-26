
_StartSignal:

;MyProjects.c,22 :: 		void StartSignal(){
;MyProjects.c,23 :: 		TRISD.F0 = 0;    //Configure RD0 as output
	BCF        TRISD+0, 0
;MyProjects.c,24 :: 		PORTD.F0 = 0;    //RD0 sends 0 to the sensor
	BCF        PORTD+0, 0
;MyProjects.c,25 :: 		delay_ms(18);
	MOVLW      117
	MOVWF      R12+0
	MOVLW      225
	MOVWF      R13+0
L_StartSignal0:
	DECFSZ     R13+0, 1
	GOTO       L_StartSignal0
	DECFSZ     R12+0, 1
	GOTO       L_StartSignal0
;MyProjects.c,26 :: 		PORTD.F0 = 1;    //RD0 sends 1 to the sensor
	BSF        PORTD+0, 0
;MyProjects.c,27 :: 		delay_us(30);
	MOVLW      49
	MOVWF      R13+0
L_StartSignal1:
	DECFSZ     R13+0, 1
	GOTO       L_StartSignal1
	NOP
	NOP
;MyProjects.c,28 :: 		TRISD.F0 = 1;    //Configure RD0 as input
	BSF        TRISD+0, 0
;MyProjects.c,29 :: 		}
L_end_StartSignal:
	RETURN
; end of _StartSignal

_GasLeakage:

;MyProjects.c,30 :: 		void GasLeakage(){
;MyProjects.c,32 :: 		trisd.f7 = 1;
	BSF        TRISD+0, 7
;MyProjects.c,33 :: 		TRISc = 0x00;
	CLRF       TRISC+0
;MyProjects.c,34 :: 		PORTc = 0x00;
	CLRF       PORTC+0
;MyProjects.c,36 :: 		if(PORTD.f7 == 1){
	BTFSS      PORTD+0, 7
	GOTO       L_GasLeakage2
;MyProjects.c,37 :: 		Portc.f1 = 1;
	BSF        PORTC+0, 1
;MyProjects.c,38 :: 		Portc.f7 = 1;
	BSF        PORTC+0, 7
;MyProjects.c,39 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_GasLeakage3:
	DECFSZ     R13+0, 1
	GOTO       L_GasLeakage3
	DECFSZ     R12+0, 1
	GOTO       L_GasLeakage3
	DECFSZ     R11+0, 1
	GOTO       L_GasLeakage3
	NOP
	NOP
;MyProjects.c,40 :: 		Portc.f7 = 0;
	BCF        PORTC+0, 7
;MyProjects.c,41 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_GasLeakage4:
	DECFSZ     R13+0, 1
	GOTO       L_GasLeakage4
	DECFSZ     R12+0, 1
	GOTO       L_GasLeakage4
	NOP
;MyProjects.c,42 :: 		}
	GOTO       L_GasLeakage5
L_GasLeakage2:
;MyProjects.c,43 :: 		else if(PORTD.f7 == 0){
	BTFSC      PORTD+0, 7
	GOTO       L_GasLeakage6
;MyProjects.c,44 :: 		Portc.f1 = 0;
	BCF        PORTC+0, 1
;MyProjects.c,45 :: 		Portc.f7 = 0;
	BCF        PORTC+0, 7
;MyProjects.c,46 :: 		}
L_GasLeakage6:
L_GasLeakage5:
;MyProjects.c,48 :: 		}
L_end_GasLeakage:
	RETURN
; end of _GasLeakage

_CheckResponse:

;MyProjects.c,50 :: 		void CheckResponse(){
;MyProjects.c,51 :: 		Check = 0;
	CLRF       _Check+0
;MyProjects.c,52 :: 		delay_us(40);
	MOVLW      66
	MOVWF      R13+0
L_CheckResponse7:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse7
	NOP
;MyProjects.c,53 :: 		if (PORTD.F0 == 0){
	BTFSC      PORTD+0, 0
	GOTO       L_CheckResponse8
;MyProjects.c,54 :: 		delay_us(80);
	MOVLW      133
	MOVWF      R13+0
L_CheckResponse9:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse9
;MyProjects.c,55 :: 		if (PORTD.F0 == 1)   Check = 1;   delay_us(40);}
	BTFSS      PORTD+0, 0
	GOTO       L_CheckResponse10
	MOVLW      1
	MOVWF      _Check+0
L_CheckResponse10:
	MOVLW      66
	MOVWF      R13+0
L_CheckResponse11:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse11
	NOP
L_CheckResponse8:
;MyProjects.c,56 :: 		}
L_end_CheckResponse:
	RETURN
; end of _CheckResponse

_ReadData:

;MyProjects.c,58 :: 		char ReadData(){
;MyProjects.c,60 :: 		for(j = 0; j < 8; j++){
	CLRF       R3+0
L_ReadData12:
	MOVLW      8
	SUBWF      R3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ReadData13
;MyProjects.c,61 :: 		while(!PORTD.F0); //Wait until PORTD.F0 goes HIGH
L_ReadData15:
	BTFSC      PORTD+0, 0
	GOTO       L_ReadData16
	GOTO       L_ReadData15
L_ReadData16:
;MyProjects.c,62 :: 		delay_us(30);
	MOVLW      49
	MOVWF      R13+0
L_ReadData17:
	DECFSZ     R13+0, 1
	GOTO       L_ReadData17
	NOP
	NOP
;MyProjects.c,63 :: 		if(PORTD.F0 == 0)
	BTFSC      PORTD+0, 0
	GOTO       L_ReadData18
;MyProjects.c,64 :: 		i&= ~(1<<(7 - j));  //Clear bit (7-b)
	MOVF       R3+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ReadData39:
	BTFSC      STATUS+0, 2
	GOTO       L__ReadData40
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ReadData39
L__ReadData40:
	COMF       R0+0, 1
	MOVF       R0+0, 0
	ANDWF      R2+0, 1
	GOTO       L_ReadData19
L_ReadData18:
;MyProjects.c,65 :: 		else {i|= (1 << (7 - j));  //Set bit (7-b)
	MOVF       R3+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ReadData41:
	BTFSC      STATUS+0, 2
	GOTO       L__ReadData42
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ReadData41
L__ReadData42:
	MOVF       R0+0, 0
	IORWF      R2+0, 1
;MyProjects.c,66 :: 		while(PORTD.F0);}  //Wait until PORTD.F0 goes LOW
L_ReadData20:
	BTFSS      PORTD+0, 0
	GOTO       L_ReadData21
	GOTO       L_ReadData20
L_ReadData21:
L_ReadData19:
;MyProjects.c,60 :: 		for(j = 0; j < 8; j++){
	INCF       R3+0, 1
;MyProjects.c,67 :: 		}
	GOTO       L_ReadData12
L_ReadData13:
;MyProjects.c,68 :: 		return i;
	MOVF       R2+0, 0
	MOVWF      R0+0
;MyProjects.c,69 :: 		}
L_end_ReadData:
	RETURN
; end of _ReadData

_main:

;MyProjects.c,72 :: 		void main() {
;MyProjects.c,73 :: 		TRISC = 0;    //Configure RC0 as output
	CLRF       TRISC+0
;MyProjects.c,74 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProjects.c,75 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjects.c,76 :: 		Lcd_Cmd(_LCD_CLEAR);             // clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjects.c,77 :: 		while(1){
L_main22:
;MyProjects.c,78 :: 		GasLeakage();
	CALL       _GasLeakage+0
;MyProjects.c,79 :: 		StartSignal();
	CALL       _StartSignal+0
;MyProjects.c,80 :: 		CheckResponse();
	CALL       _CheckResponse+0
;MyProjects.c,81 :: 		if(Check == 1){
	MOVF       _Check+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;MyProjects.c,82 :: 		RH_byte1 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _RH_byte1+0
;MyProjects.c,83 :: 		RH_byte2 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _RH_byte2+0
;MyProjects.c,84 :: 		T_byte1 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _T_byte1+0
;MyProjects.c,85 :: 		T_byte2 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _T_byte2+0
;MyProjects.c,86 :: 		Sum = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _Sum+0
	CLRF       _Sum+1
;MyProjects.c,87 :: 		if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF)){
	MOVF       _RH_byte2+0, 0
	ADDWF      _RH_byte1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte1+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte2+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	MOVLW      0
	ANDWF      R2+1, 1
	MOVF       _Sum+1, 0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main44
	MOVF       R2+0, 0
	XORWF      _Sum+0, 0
L__main44:
	BTFSS      STATUS+0, 2
	GOTO       L_main25
;MyProjects.c,88 :: 		Temp = T_byte1;
	MOVF       _T_byte1+0, 0
	MOVWF      _Temp+0
	CLRF       _Temp+1
;MyProjects.c,89 :: 		Temp = (Temp << 8) | T_byte2;
	MOVF       _Temp+0, 0
	MOVWF      _Temp+1
	CLRF       _Temp+0
	MOVF       _T_byte2+0, 0
	IORWF      _Temp+0, 1
	MOVLW      0
	IORWF      _Temp+1, 1
;MyProjects.c,90 :: 		RH = RH_byte1;
	MOVF       _RH_byte1+0, 0
	MOVWF      _RH+0
	CLRF       _RH+1
;MyProjects.c,91 :: 		Lcd_Cmd(_LCD_CLEAR);             // clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjects.c,92 :: 		RH = (RH << 8) | RH_byte2;
	MOVF       _RH+0, 0
	MOVWF      _RH+1
	CLRF       _RH+0
	MOVF       _RH_byte2+0, 0
	IORWF      _RH+0, 1
	MOVLW      0
	IORWF      _RH+1, 1
;MyProjects.c,93 :: 		Lcd_Out(1, 6, "Temp:   . C");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProjects+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjects.c,94 :: 		Lcd_Out(2, 2, "Humidity:   . %");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProjects+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjects.c,95 :: 		if (Temp > 0X8000){
	MOVF       _Temp+1, 0
	SUBLW      128
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVF       _Temp+0, 0
	SUBLW      0
L__main45:
	BTFSC      STATUS+0, 0
	GOTO       L_main26
;MyProjects.c,96 :: 		Lcd_Out(1, 11, "-");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProjects+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjects.c,97 :: 		Temp = Temp & 0X7FFF; }
	MOVLW      255
	ANDWF      _Temp+0, 1
	MOVLW      127
	ANDWF      _Temp+1, 1
L_main26:
;MyProjects.c,98 :: 		be=(48 + ((Temp / 100) % 10));//work for frist later of temperature like 2 than 22,,23,
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Temp+0, 0
	MOVWF      R0+0
	MOVF       _Temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _be+0
	MOVF       R0+1, 0
	MOVWF      _be+1
;MyProjects.c,99 :: 		LCD_Chr(1, 12, be);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProjects.c,100 :: 		me= (48 + ((Temp / 10) % 10));
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Temp+0, 0
	MOVWF      R0+0
	MOVF       _Temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _me+0
	MOVF       R0+1, 0
	MOVWF      _me+1
;MyProjects.c,101 :: 		LCD_Chr(1, 13, me);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProjects.c,102 :: 		ne=48 + (Temp % 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Temp+0, 0
	MOVWF      R0+0
	MOVF       _Temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _ne+0
	MOVF       R0+1, 0
	MOVWF      _ne+1
;MyProjects.c,103 :: 		LCD_Chr(1, 15, ne); //after (.) number
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProjects.c,106 :: 		h1=  48 + ((RH / 100) % 10);
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _RH+0, 0
	MOVWF      R0+0
	MOVF       _RH+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _h1+0
	MOVF       R0+1, 0
	MOVWF      _h1+1
;MyProjects.c,107 :: 		LCD_Chr(2, 12, h1);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProjects.c,108 :: 		h2= 48 + ((RH / 10) % 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _RH+0, 0
	MOVWF      R0+0
	MOVF       _RH+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _h2+0
	MOVF       R0+1, 0
	MOVWF      _h2+1
;MyProjects.c,109 :: 		LCD_Chr(2, 13, h2);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProjects.c,110 :: 		LCD_Chr(2, 15, 48 + (RH % 10));
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _RH+0, 0
	MOVWF      R0+0
	MOVF       _RH+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProjects.c,113 :: 		if(be==51 & me==55 & ne>53){ // more then 26*C   relay
	MOVLW      0
	XORWF      _be+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main46
	MOVLW      51
	XORWF      _be+0, 0
L__main46:
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	MOVLW      0
	XORWF      _me+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main47
	MOVLW      55
	XORWF      _me+0, 0
L__main47:
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ANDWF      R1+0, 1
	MOVF       _ne+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVF       _ne+0, 0
	SUBLW      53
L__main48:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_main27
;MyProjects.c,114 :: 		DELAY_MS(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	DECFSZ     R11+0, 1
	GOTO       L_main28
	NOP
;MyProjects.c,115 :: 		portc.f0=0;
	BCF        PORTC+0, 0
;MyProjects.c,117 :: 		}
L_main27:
;MyProjects.c,118 :: 		if(be<52 & me<56 & ne<52 ){  // less then 26*C
	MOVLW      0
	SUBWF      _be+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      52
	SUBWF      _be+0, 0
L__main49:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R1+0
	MOVLW      0
	SUBWF      _me+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVLW      56
	SUBWF      _me+0, 0
L__main50:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ANDWF      R1+0, 1
	MOVLW      0
	SUBWF      _ne+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      52
	SUBWF      _ne+0, 0
L__main51:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_main29
;MyProjects.c,119 :: 		portc.f0=1;
	BSF        PORTC+0, 0
;MyProjects.c,121 :: 		}
L_main29:
;MyProjects.c,122 :: 		if (h1>53 & h2>52)  // for humidity control relay
	MOVF       _h1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVF       _h1+0, 0
	SUBLW      53
L__main52:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R1+0
	MOVF       _h2+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVF       _h2+0, 0
	SUBLW      52
L__main53:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_main30
;MyProjects.c,124 :: 		portc.f1 =0;
	BCF        PORTC+0, 1
;MyProjects.c,125 :: 		}
L_main30:
;MyProjects.c,126 :: 		if(h1<54 & h2<49)
	MOVLW      0
	SUBWF      _h1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVLW      54
	SUBWF      _h1+0, 0
L__main54:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R1+0
	MOVLW      0
	SUBWF      _h2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      49
	SUBWF      _h2+0, 0
L__main55:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_main31
;MyProjects.c,128 :: 		portc.f1=1;
	BSF        PORTC+0, 1
;MyProjects.c,129 :: 		}
L_main31:
;MyProjects.c,131 :: 		}
	GOTO       L_main32
L_main25:
;MyProjects.c,133 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjects.c,134 :: 		Lcd_Cmd(_LCD_CLEAR);             // clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProjects.c,135 :: 		Lcd_Out(1, 1, "Check sum error");}
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProjects+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main32:
;MyProjects.c,136 :: 		}
	GOTO       L_main33
L_main24:
;MyProjects.c,138 :: 		Lcd_Out(1, 3, "No response");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProjects+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjects.c,139 :: 		Lcd_Out(2, 1, "from the sensor");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProjects+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProjects.c,140 :: 		}
L_main33:
;MyProjects.c,141 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	DECFSZ     R11+0, 1
	GOTO       L_main34
	NOP
;MyProjects.c,142 :: 		}
	GOTO       L_main22
;MyProjects.c,143 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
