
_main:

;MyProject.c,3 :: 		void main() {
;MyProject.c,5 :: 		int i=0,leftD=0, rightD=0,j,p,r,s=0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
	CLRF       main_leftD_L0+0
	CLRF       main_leftD_L0+1
	CLRF       main_rightD_L0+0
	CLRF       main_rightD_L0+1
	CLRF       main_s_L0+0
	CLRF       main_s_L0+1
;MyProject.c,7 :: 		TRISB=0x00;
	CLRF       TRISB+0
;MyProject.c,8 :: 		PORTB=0x00;
	CLRF       PORTB+0
;MyProject.c,11 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;MyProject.c,12 :: 		PORTC = 0x00; //Initialize PortC
	CLRF       PORTC+0
;MyProject.c,15 :: 		TRISD = 0xff;
	MOVLW      255
	MOVWF      TRISD+0
;MyProject.c,16 :: 		PORTD = 0x00;  //Initialize PortD
	CLRF       PORTD+0
;MyProject.c,17 :: 		while(1){
L_main0:
;MyProject.c,19 :: 		if(portd.f4==1){
	BTFSS      PORTD+0, 4
	GOTO       L_main2
;MyProject.c,23 :: 		portc.f5=0;
	BCF        PORTC+0, 5
;MyProject.c,24 :: 		portc.f6=0;
	BCF        PORTC+0, 6
;MyProject.c,25 :: 		portc.f7=0;
	BCF        PORTC+0, 7
;MyProject.c,26 :: 		i=0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;MyProject.c,27 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,28 :: 		p=0;
	CLRF       main_p_L0+0
	CLRF       main_p_L0+1
;MyProject.c,29 :: 		s=1;
	MOVLW      1
	MOVWF      main_s_L0+0
	MOVLW      0
	MOVWF      main_s_L0+1
;MyProject.c,30 :: 		while(1){
L_main3:
;MyProject.c,31 :: 		if(portd.f6==1)
	BTFSS      PORTD+0, 6
	GOTO       L_main5
;MyProject.c,33 :: 		if(i<100)
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVLW      100
	SUBWF      main_i_L0+0, 0
L__main45:
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;MyProject.c,34 :: 		i++;
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
L_main6:
;MyProject.c,35 :: 		p++;
	INCF       main_p_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_p_L0+1, 1
;MyProject.c,36 :: 		}
L_main5:
;MyProject.c,37 :: 		if(portd.f7==1)
	BTFSS      PORTD+0, 7
	GOTO       L_main7
;MyProject.c,39 :: 		if(i>=0)
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main46
	MOVLW      0
	SUBWF      main_i_L0+0, 0
L__main46:
	BTFSS      STATUS+0, 0
	GOTO       L_main8
;MyProject.c,40 :: 		i--;
	MOVLW      1
	SUBWF      main_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_i_L0+1, 1
L_main8:
;MyProject.c,41 :: 		p--;
	MOVLW      1
	SUBWF      main_p_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_p_L0+1, 1
;MyProject.c,42 :: 		}
L_main7:
;MyProject.c,44 :: 		leftD=i/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_leftD_L0+0
	MOVF       R0+1, 0
	MOVWF      main_leftD_L0+1
;MyProject.c,45 :: 		rightD=i%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_rightD_L0+0
	MOVF       R0+1, 0
	MOVWF      main_rightD_L0+1
;MyProject.c,46 :: 		for(j=0;j<10;j++)
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
L_main9:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main47
	MOVLW      10
	SUBWF      main_j_L0+0, 0
L__main47:
	BTFSC      STATUS+0, 0
	GOTO       L_main10
;MyProject.c,48 :: 		portc.f0=1;
	BSF        PORTC+0, 0
;MyProject.c,49 :: 		portb=CA[leftD];
	MOVF       main_leftD_L0+0, 0
	ADDLW      _CA+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,50 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	NOP
;MyProject.c,51 :: 		portc.f0=0;
	BCF        PORTC+0, 0
;MyProject.c,54 :: 		portc.f1=1;
	BSF        PORTC+0, 1
;MyProject.c,55 :: 		portb=CA[rightD];
	MOVF       main_rightD_L0+0, 0
	ADDLW      _CA+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,56 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	NOP
;MyProject.c,57 :: 		portc.f1=0;
	BCF        PORTC+0, 1
;MyProject.c,46 :: 		for(j=0;j<10;j++)
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,58 :: 		}
	GOTO       L_main9
L_main10:
;MyProject.c,59 :: 		if(portd.f4==0)
	BTFSC      PORTD+0, 4
	GOTO       L_main14
;MyProject.c,61 :: 		break;
	GOTO       L_main4
;MyProject.c,62 :: 		}
L_main14:
;MyProject.c,63 :: 		}
	GOTO       L_main3
L_main4:
;MyProject.c,64 :: 		}
	GOTO       L_main15
L_main2:
;MyProject.c,65 :: 		else if(portd.f4==0) {
	BTFSC      PORTD+0, 4
	GOTO       L_main16
;MyProject.c,67 :: 		portc.f5=1;
	BSF        PORTC+0, 5
;MyProject.c,68 :: 		leftD=0;
	CLRF       main_leftD_L0+0
	CLRF       main_leftD_L0+1
;MyProject.c,69 :: 		rightD=0;
	CLRF       main_rightD_L0+0
	CLRF       main_rightD_L0+1
;MyProject.c,70 :: 		for(j=0;j<10;j++)
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
L_main17:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVLW      10
	SUBWF      main_j_L0+0, 0
L__main48:
	BTFSC      STATUS+0, 0
	GOTO       L_main18
;MyProject.c,72 :: 		portc.f0=1;
	BSF        PORTC+0, 0
;MyProject.c,73 :: 		portb=CA[leftD];
	MOVF       main_leftD_L0+0, 0
	ADDLW      _CA+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,74 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	NOP
;MyProject.c,75 :: 		portc.f0=0;
	BCF        PORTC+0, 0
;MyProject.c,78 :: 		portc.f1=1;
	BSF        PORTC+0, 1
;MyProject.c,79 :: 		portb=CA[rightD];
	MOVF       main_rightD_L0+0, 0
	ADDLW      _CA+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,80 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	NOP
;MyProject.c,81 :: 		portc.f1=0;
	BCF        PORTC+0, 1
;MyProject.c,70 :: 		for(j=0;j<10;j++)
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,82 :: 		}
	GOTO       L_main17
L_main18:
;MyProject.c,83 :: 		i=0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;MyProject.c,84 :: 		j=0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;MyProject.c,85 :: 		r=0;
	CLRF       main_r_L0+0
	CLRF       main_r_L0+1
;MyProject.c,86 :: 		while(1){
L_main22:
;MyProject.c,87 :: 		if(portd.f6==1)
	BTFSS      PORTD+0, 6
	GOTO       L_main24
;MyProject.c,89 :: 		if(i<100)
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      100
	SUBWF      main_i_L0+0, 0
L__main49:
	BTFSC      STATUS+0, 0
	GOTO       L_main25
;MyProject.c,90 :: 		i++;
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
L_main25:
;MyProject.c,91 :: 		r++;
	INCF       main_r_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_r_L0+1, 1
;MyProject.c,92 :: 		}
L_main24:
;MyProject.c,93 :: 		if(portd.f7==1)
	BTFSS      PORTD+0, 7
	GOTO       L_main26
;MyProject.c,95 :: 		if(i>=0)
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVLW      0
	SUBWF      main_i_L0+0, 0
L__main50:
	BTFSS      STATUS+0, 0
	GOTO       L_main27
;MyProject.c,96 :: 		i--;
	MOVLW      1
	SUBWF      main_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_i_L0+1, 1
L_main27:
;MyProject.c,97 :: 		r--;
	MOVLW      1
	SUBWF      main_r_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_r_L0+1, 1
;MyProject.c,98 :: 		}
L_main26:
;MyProject.c,100 :: 		leftD=i/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_leftD_L0+0
	MOVF       R0+1, 0
	MOVWF      main_leftD_L0+1
;MyProject.c,101 :: 		rightD=i%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_rightD_L0+0
	MOVF       R0+1, 0
	MOVWF      main_rightD_L0+1
;MyProject.c,102 :: 		for(j=0;j<10;j++)
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
L_main28:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      10
	SUBWF      main_j_L0+0, 0
L__main51:
	BTFSC      STATUS+0, 0
	GOTO       L_main29
;MyProject.c,104 :: 		portc.f0=1;
	BSF        PORTC+0, 0
;MyProject.c,105 :: 		portb=CA[leftD];
	MOVF       main_leftD_L0+0, 0
	ADDLW      _CA+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,106 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	NOP
;MyProject.c,107 :: 		portc.f0=0;
	BCF        PORTC+0, 0
;MyProject.c,110 :: 		portc.f1=1;
	BSF        PORTC+0, 1
;MyProject.c,111 :: 		portb=CA[rightD];
	MOVF       main_rightD_L0+0, 0
	ADDLW      _CA+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,112 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	NOP
;MyProject.c,113 :: 		portc.f1=0;
	BCF        PORTC+0, 1
;MyProject.c,102 :: 		for(j=0;j<10;j++)
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;MyProject.c,114 :: 		}
	GOTO       L_main28
L_main29:
;MyProject.c,115 :: 		if(p==r && s==1)
	MOVF       main_p_L0+1, 0
	XORWF      main_r_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVF       main_r_L0+0, 0
	XORWF      main_p_L0+0, 0
L__main52:
	BTFSS      STATUS+0, 2
	GOTO       L_main35
	MOVLW      0
	XORWF      main_s_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVLW      1
	XORWF      main_s_L0+0, 0
L__main53:
	BTFSS      STATUS+0, 2
	GOTO       L_main35
L__main43:
;MyProject.c,118 :: 		while(1)
L_main36:
;MyProject.c,120 :: 		portc.f5=0;
	BCF        PORTC+0, 5
;MyProject.c,121 :: 		portc.f6=1;
	BSF        PORTC+0, 6
;MyProject.c,122 :: 		delay_ms(2000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main38:
	DECFSZ     R13+0, 1
	GOTO       L_main38
	DECFSZ     R12+0, 1
	GOTO       L_main38
	DECFSZ     R11+0, 1
	GOTO       L_main38
	NOP
	NOP
;MyProject.c,123 :: 		portc.f6 =0;
	BCF        PORTC+0, 6
;MyProject.c,124 :: 		portc.f7=1;
	BSF        PORTC+0, 7
;MyProject.c,125 :: 		delay_ms(2000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	DECFSZ     R12+0, 1
	GOTO       L_main39
	DECFSZ     R11+0, 1
	GOTO       L_main39
	NOP
	NOP
;MyProject.c,126 :: 		portc.f7 =0;
	BCF        PORTC+0, 7
;MyProject.c,127 :: 		portc.f5=1;
	BSF        PORTC+0, 5
;MyProject.c,128 :: 		delay_ms(2000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	DECFSZ     R11+0, 1
	GOTO       L_main40
	NOP
	NOP
;MyProject.c,129 :: 		if(portd.f4 == 1) break;
	BTFSS      PORTD+0, 4
	GOTO       L_main41
	GOTO       L_main37
L_main41:
;MyProject.c,130 :: 		}
	GOTO       L_main36
L_main37:
;MyProject.c,132 :: 		}
L_main35:
;MyProject.c,133 :: 		if(portd.f4==1)
	BTFSS      PORTD+0, 4
	GOTO       L_main42
;MyProject.c,135 :: 		break;
	GOTO       L_main23
;MyProject.c,136 :: 		}
L_main42:
;MyProject.c,137 :: 		}
	GOTO       L_main22
L_main23:
;MyProject.c,139 :: 		}
L_main16:
L_main15:
;MyProject.c,140 :: 		}
	GOTO       L_main0
;MyProject.c,141 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
