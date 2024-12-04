
_main:

;tp8.c,17 :: 		void main()
;tp8.c,19 :: 		TRISB = 0;
	CLRF       TRISB+0
;tp8.c,20 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;tp8.c,21 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;tp8.c,22 :: 		ADCON0 = 0x41;
	MOVLW      65
	MOVWF      ADCON0+0
;tp8.c,23 :: 		ADCON1 = 0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;tp8.c,24 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;tp8.c,25 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;tp8.c,26 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;tp8.c,27 :: 		while(1)
L_main0:
;tp8.c,29 :: 		adcValue = ADC_READ(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adcValue+0
	MOVF       R0+1, 0
	MOVWF      _adcValue+1
;tp8.c,30 :: 		voltage = (adcValue*5.0)/1023.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _voltage+0
	MOVF       R0+1, 0
	MOVWF      _voltage+1
	MOVF       R0+2, 0
	MOVWF      _voltage+2
	MOVF       R0+3, 0
	MOVWF      _voltage+3
;tp8.c,31 :: 		Lcd_Out(1, 1, "Voltage = ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_tp8+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;tp8.c,32 :: 		Lcd_Chr_Cp((unsigned int)voltage + 0x30);
	MOVF       _voltage+0, 0
	MOVWF      R0+0
	MOVF       _voltage+1, 0
	MOVWF      R0+1
	MOVF       _voltage+2, 0
	MOVWF      R0+2
	MOVF       _voltage+3, 0
	MOVWF      R0+3
	CALL       _double2word+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;tp8.c,33 :: 		Lcd_Chr_Cp('.');
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;tp8.c,34 :: 		Lcd_Chr_Cp((voltage - (unsigned int)voltage) * 10 + 0x30);
	MOVF       _voltage+0, 0
	MOVWF      R0+0
	MOVF       _voltage+1, 0
	MOVWF      R0+1
	MOVF       _voltage+2, 0
	MOVWF      R0+2
	MOVF       _voltage+3, 0
	MOVWF      R0+3
	CALL       _double2word+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       _voltage+0, 0
	MOVWF      R0+0
	MOVF       _voltage+1, 0
	MOVWF      R0+1
	MOVF       _voltage+2, 0
	MOVWF      R0+2
	MOVF       _voltage+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      64
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;tp8.c,35 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;tp8.c,36 :: 		Lcd_Chr_Cp('V');
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;tp8.c,37 :: 		if(voltage > 2.5)
	MOVF       _voltage+0, 0
	MOVWF      R4+0
	MOVF       _voltage+1, 0
	MOVWF      R4+1
	MOVF       _voltage+2, 0
	MOVWF      R4+2
	MOVF       _voltage+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      32
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;tp8.c,38 :: 		Lcd_Out(2,1, "Grand");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_tp8+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main3
L_main2:
;tp8.c,40 :: 		Lcd_Out(2,1, "Petit");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_tp8+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main3:
;tp8.c,41 :: 		}
	GOTO       L_main0
;tp8.c,42 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
