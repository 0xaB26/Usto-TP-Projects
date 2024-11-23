#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);
unsigned char pins[] = {7,8,9};
const int lm35Pin = A0;
float temperatureC = 0.0;

void setup() {
  lcd.init();
  lcd.backlight();
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("PRESENTED BY : ");
  lcd.setCursor(0,1);
  lcd.print("DALI ABDELLATIF");
  delay(2000);
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("USTO M2 ESE");
  delay(2000);
  lcd.clear();
  lcd.print("WAIT FOR TEMP ..");
  delay(2000);
  lcd.clear();
  for(unsigned char i = 0; i < 3; ++i)
    pinMode(pins[i], OUTPUT);
  //analogReference(INTERNAL);
  Serial.begin(9600);
}

void loop() {
  temperatureC = readTemperature(); 
  if(temperatureC >= 0.0 && temperatureC <= 15.0) // IF TEMPERATURE IS BETWEEN [0, 10], WHITE LED ON
  {
    digitalWrite(pins[0], LOW);
    digitalWrite(pins[1], LOW);
    digitalWrite(pins[2], HIGH);
  }
  else if(temperatureC > 15.0 && temperatureC <= 30.0) // IF TEMPERATURE IS BETWEEN [11, 20], GREEN LED ON
  {
    digitalWrite(pins[0], LOW);
    digitalWrite(pins[1], HIGH);
    digitalWrite(pins[2], LOW);
  }
  else        // IF TEMPERATURE >= 21, RED LED ON
  {
    digitalWrite(pins[0], HIGH);
    digitalWrite(pins[1], LOW);
    digitalWrite(pins[2], LOW);
  }
  lcd.setCursor(0, 0);
  lcd.print("Temp: ");
  lcd.print(temperatureC, 1); 
  lcd.print(" C ");
  Serial.println(temperatureC);
  delay(1000);
  
}

float readTemperature()
{
  const int numReadings = 10; 
  float total = 0;

  for (int i = 0; i < numReadings; i++) 
  {
    int analogValue = analogRead(lm35Pin);       
    float voltage = analogValue * (5.0 / 1024.0); 
    total += voltage * 100;                      
    delay(50);                                   
  }

  return total / numReadings; // Return average temperature
}
