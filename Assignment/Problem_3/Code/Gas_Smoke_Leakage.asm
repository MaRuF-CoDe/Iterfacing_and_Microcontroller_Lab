
_dht22_read_byte:

;Gas_Smoke_Leakage.c,26 :: 		uint8_t dht22_read_byte()
;Gas_Smoke_Leakage.c,28 :: 		uint8_t i = 8, dht22_byte = 0;
	MOVLW      8
	MOVWF      dht22_read_byte_i_L0+0
	CLRF       dht22_read_byte_dht22_byte_L0+0
;Gas_Smoke_Leakage.c,29 :: 		while(i--)
L_dht22_read_byte0:
	MOVF       dht22_read_byte_i_L0+0, 0
	MOVWF      R0+0
	DECF       dht22_read_byte_i_L0+0, 1
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_dht22_read_byte1
;Gas_Smoke_Leakage.c,31 :: 		while( !DHT22_PIN );
L_dht22_read_byte2:
	BTFSC      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_dht22_read_byte3
	GOTO       L_dht22_read_byte2
L_dht22_read_byte3:
;Gas_Smoke_Leakage.c,32 :: 		Delay_us(40);
	MOVLW      26
	MOVWF      R13+0
L_dht22_read_byte4:
	DECFSZ     R13+0, 1
	GOTO       L_dht22_read_byte4
	NOP
;Gas_Smoke_Leakage.c,33 :: 		if( DHT22_PIN )
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_dht22_read_byte5
;Gas_Smoke_Leakage.c,35 :: 		dht22_byte |= (1 << i);   // set bit i
	MOVF       dht22_read_byte_i_L0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__dht22_read_byte22:
	BTFSC      STATUS+0, 2
	GOTO       L__dht22_read_byte23
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__dht22_read_byte22
L__dht22_read_byte23:
	MOVF       R0+0, 0
	IORWF      dht22_read_byte_dht22_byte_L0+0, 1
;Gas_Smoke_Leakage.c,36 :: 		while( DHT22_PIN );
L_dht22_read_byte6:
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_dht22_read_byte7
	GOTO       L_dht22_read_byte6
L_dht22_read_byte7:
;Gas_Smoke_Leakage.c,37 :: 		}
L_dht22_read_byte5:
;Gas_Smoke_Leakage.c,38 :: 		}
	GOTO       L_dht22_read_byte0
L_dht22_read_byte1:
;Gas_Smoke_Leakage.c,39 :: 		return(dht22_byte);
	MOVF       dht22_read_byte_dht22_byte_L0+0, 0
	MOVWF      R0+0
;Gas_Smoke_Leakage.c,40 :: 		}
L_end_dht22_read_byte:
	RETURN
; end of _dht22_read_byte

_dht22_read:

;Gas_Smoke_Leakage.c,42 :: 		void dht22_read(uint16_t *dht22_humi, int16_t *dht22_temp)
;Gas_Smoke_Leakage.c,45 :: 		DHT22_PIN     = 0;   // connection pin output low
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
;Gas_Smoke_Leakage.c,46 :: 		DHT22_PIN_DIR = 0;   // configure connection pin as output
	BCF        TRISB1_bit+0, BitPos(TRISB1_bit+0)
;Gas_Smoke_Leakage.c,47 :: 		Delay_ms(25);        // wait 25 ms
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_dht22_read8:
	DECFSZ     R13+0, 1
	GOTO       L_dht22_read8
	DECFSZ     R12+0, 1
	GOTO       L_dht22_read8
	NOP
;Gas_Smoke_Leakage.c,48 :: 		DHT22_PIN     = 1;   // connection pin output high
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;Gas_Smoke_Leakage.c,49 :: 		Delay_us(30);        // wait 30 us
	MOVLW      19
	MOVWF      R13+0
L_dht22_read9:
	DECFSZ     R13+0, 1
	GOTO       L_dht22_read9
	NOP
	NOP
;Gas_Smoke_Leakage.c,50 :: 		DHT22_PIN_DIR = 1;   // configure connection pin as input
	BSF        TRISB1_bit+0, BitPos(TRISB1_bit+0)
;Gas_Smoke_Leakage.c,52 :: 		while( DHT22_PIN );
L_dht22_read10:
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_dht22_read11
	GOTO       L_dht22_read10
L_dht22_read11:
;Gas_Smoke_Leakage.c,53 :: 		while(!DHT22_PIN );
L_dht22_read12:
	BTFSC      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_dht22_read13
	GOTO       L_dht22_read12
L_dht22_read13:
;Gas_Smoke_Leakage.c,54 :: 		while( DHT22_PIN );
L_dht22_read14:
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_dht22_read15
	GOTO       L_dht22_read14
L_dht22_read15:
;Gas_Smoke_Leakage.c,56 :: 		*dht22_humi = dht22_read_byte();  // read humidity byte 1
	CALL       _dht22_read_byte+0
	MOVF       FARG_dht22_read_dht22_humi+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;Gas_Smoke_Leakage.c,57 :: 		*dht22_humi = (*dht22_humi << 8) | dht22_read_byte();  // read humidity byte 2
	MOVF       FARG_dht22_read_dht22_humi+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      FLOC__dht22_read+1
	CLRF       FLOC__dht22_read+0
	CALL       _dht22_read_byte+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FLOC__dht22_read+0, 0
	IORWF      R0+0, 1
	MOVF       FLOC__dht22_read+1, 0
	IORWF      R0+1, 1
	MOVF       FARG_dht22_read_dht22_humi+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Gas_Smoke_Leakage.c,58 :: 		*dht22_temp = dht22_read_byte();  // read temperature byte 1
	CALL       _dht22_read_byte+0
	MOVF       FARG_dht22_read_dht22_temp+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;Gas_Smoke_Leakage.c,59 :: 		*dht22_temp = (*dht22_temp << 8) | dht22_read_byte();  // read temperature byte 2
	MOVF       FARG_dht22_read_dht22_temp+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      FLOC__dht22_read+1
	CLRF       FLOC__dht22_read+0
	CALL       _dht22_read_byte+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FLOC__dht22_read+0, 0
	IORWF      R0+0, 1
	MOVF       FLOC__dht22_read+1, 0
	IORWF      R0+1, 1
	MOVF       FARG_dht22_read_dht22_temp+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Gas_Smoke_Leakage.c,60 :: 		dht22_read_byte();               // read checksum (skipped)
	CALL       _dht22_read_byte+0
;Gas_Smoke_Leakage.c,61 :: 		if(*dht22_temp & 0x8000)// if temperature is negative
	MOVF       FARG_dht22_read_dht22_temp+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R2+1
	BTFSS      R2+1, 7
	GOTO       L_dht22_read16
;Gas_Smoke_Leakage.c,63 :: 		*dht22_temp &= 0x7FFF;
	MOVF       FARG_dht22_read_dht22_temp+0, 0
	MOVWF      FSR
	MOVLW      255
	ANDWF      INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDLW      127
	MOVWF      R0+1
	MOVF       FARG_dht22_read_dht22_temp+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Gas_Smoke_Leakage.c,64 :: 		*dht22_temp *= -1;
	MOVF       FARG_dht22_read_dht22_temp+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVLW      255
	MOVWF      R4+0
	MOVLW      255
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       FARG_dht22_read_dht22_temp+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Gas_Smoke_Leakage.c,65 :: 		}
L_dht22_read16:
;Gas_Smoke_Leakage.c,66 :: 		}
L_end_dht22_read:
	RETURN
; end of _dht22_read

_main:

;Gas_Smoke_Leakage.c,70 :: 		void main()
;Gas_Smoke_Leakage.c,72 :: 		ADCON1 = 0x07;//ADC Off
	MOVLW      7
	MOVWF      ADCON1+0
;Gas_Smoke_Leakage.c,73 :: 		ADCON0 = 0x00;
	CLRF       ADCON0+0
;Gas_Smoke_Leakage.c,74 :: 		CMCON = 0x07;//comparator off
	MOVLW      7
	MOVWF      CMCON+0
;Gas_Smoke_Leakage.c,75 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Gas_Smoke_Leakage.c,76 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Gas_Smoke_Leakage.c,77 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Gas_Smoke_Leakage.c,78 :: 		Lcd_Out(1,1,"DHT22 WITH");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Gas_Smoke_Leakage+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Gas_Smoke_Leakage.c,79 :: 		Lcd_Out(2,1,"PIC16F877A");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Gas_Smoke_Leakage+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Gas_Smoke_Leakage.c,80 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	DECFSZ     R11+0, 1
	GOTO       L_main17
	NOP
;Gas_Smoke_Leakage.c,81 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Gas_Smoke_Leakage.c,82 :: 		while(1)
L_main18:
;Gas_Smoke_Leakage.c,84 :: 		dht22_read(&humidity, &temperature);
	MOVLW      _humidity+0
	MOVWF      FARG_dht22_read_dht22_humi+0
	MOVLW      _temperature+0
	MOVWF      FARG_dht22_read_dht22_temp+0
	CALL       _dht22_read+0
;Gas_Smoke_Leakage.c,85 :: 		Lcd_Out(1,1,"HUMIDITY:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Gas_Smoke_Leakage+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Gas_Smoke_Leakage.c,86 :: 		Lcd_Out(2,1,"TEMP:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Gas_Smoke_Leakage+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Gas_Smoke_Leakage.c,87 :: 		message[0] = humidity/100 + 48;
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _humidity+0, 0
	MOVWF      R0+0
	MOVF       _humidity+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _message+0
;Gas_Smoke_Leakage.c,88 :: 		message[1] = humidity/10%10 + 48;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _humidity+0, 0
	MOVWF      R0+0
	MOVF       _humidity+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _message+1
;Gas_Smoke_Leakage.c,89 :: 		message[3] = humidity%10 + 48;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _humidity+0, 0
	MOVWF      R0+0
	MOVF       _humidity+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _message+3
;Gas_Smoke_Leakage.c,90 :: 		Lcd_Out(1,11, message);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Gas_Smoke_Leakage.c,91 :: 		Lcd_Out(1,16,"%");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_Gas_Smoke_Leakage+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Gas_Smoke_Leakage.c,92 :: 		message[0] = temperature/100 + 48;
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _temperature+0, 0
	MOVWF      R0+0
	MOVF       _temperature+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _message+0
;Gas_Smoke_Leakage.c,93 :: 		message[1] = temperature/10%10 + 48;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _temperature+0, 0
	MOVWF      R0+0
	MOVF       _temperature+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _message+1
;Gas_Smoke_Leakage.c,94 :: 		message[3] = temperature%10 + 48;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _temperature+0, 0
	MOVWF      R0+0
	MOVF       _temperature+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _message+3
;Gas_Smoke_Leakage.c,95 :: 		Lcd_Out(2,11, message);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Gas_Smoke_Leakage.c,96 :: 		Lcd_Chr_CP(223);
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Gas_Smoke_Leakage.c,97 :: 		Lcd_Out(2,16,"C");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_Gas_Smoke_Leakage+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Gas_Smoke_Leakage.c,98 :: 		Delay_ms(1000);  // wait a second
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
	NOP
;Gas_Smoke_Leakage.c,99 :: 		}//while(1)
	GOTO       L_main18
;Gas_Smoke_Leakage.c,100 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
