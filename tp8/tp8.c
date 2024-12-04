sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

unsigned int adcValue = 0;
float voltage = 0;

void main()
{
  TRISB = 0;
  PORTB = 0xFF;
  TRISA = 0xFF;
  ADCON0 = 0x41;
  ADCON1 = 0x80;
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);
  while(1)
  {
    adcValue = ADC_READ(0);
    voltage = (adcValue*5.0)/1023.0;
    Lcd_Out(1, 1, "Voltage = ");
    Lcd_Chr_Cp((unsigned int)voltage + 0x30);
    Lcd_Chr_Cp('.');
    Lcd_Chr_Cp((voltage - (unsigned int)voltage) * 10 + 0x30);
    Lcd_Chr_Cp(' ');
    Lcd_Chr_Cp('V');
    if(voltage > 2.5)
               Lcd_Out(2,1, "Grand");
    else
            Lcd_Out(2,1, "Petit");
  }
}