// Fitconsole 
// Version 1 - December 2020
// This version supports:
// 1 trampoline
// 2 push buttons (left and right)
// 1 pole "The Pole"
/*
Copyright 2020 Marcel Veldhuizen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.*/

#include <Wire.h>
#include <Keyboard.h>
#include <Adafruit_VL53L0X.h>

Adafruit_VL53L0X lox = Adafruit_VL53L0X();

#define HANDPRESENT_CM  11 // Punch detection distance
#define HUMANPRESENT_CM 60 // Person detected distance

#define LED_ON       9 // LED indicates "on" meaning keys are transmitted to the PC
#define LED_SENSE   10 // Person available or person strikes a punch
#define ON_SWITCH   11 // Push button (on/off switch)
#define TRAMPOLINE  12 // Trampoline jump detector

#define LEFT_BUTTON  7
#define LEFT_LED     8

#define RIGHT_BUTTON 5
#define RIGHT_LED    6

boolean IsOn = false, SensorOK=false;

void setup() { 
 delay(2000);  
 Serial.begin(115200);
 
 pinMode(TRAMPOLINE, INPUT_PULLUP);
 pinMode(ON_SWITCH, INPUT_PULLUP); 
 pinMode(LED_SENSE, OUTPUT);
 pinMode(LED_ON, OUTPUT);

 pinMode(LEFT_BUTTON, INPUT_PULLUP);
 pinMode(LEFT_LED, OUTPUT);

 pinMode(RIGHT_BUTTON, INPUT_PULLUP);
 pinMode(RIGHT_LED, OUTPUT);

 digitalWrite(LED_ON, LOW);
 digitalWrite(LED_SENSE, LOW);
  
 Keyboard.begin();    
 digitalWrite(LED_ON,HIGH);
 if (!lox.begin()) {    
  Serial.println("The Pole not connected");
  for(int i=0; i<20; i++) {
   // Error Vl530L0X sensor (it may be not connected)
   digitalWrite(LED_ON,HIGH); delay(100);
   digitalWrite(LED_ON,LOW); delay(100);
  }
 }  

 Serial.println("Ready");
 LEDShowOnStatus();
}

// Keypresses sent to the PC:
// Trampoline down = Ctrl
// Human present before sensor = Shift
// Hand present before sensor = End
// Right push button = Right cursor key
// Left push button = Left cursor key
void loop() {
 static boolean CtrlPressed=false,ShiftPressed=false, EndPressed=false;
 static boolean HandPresent=false, HumanPresent=false;
 static boolean LeftPressed=false, RightPressed=false;
 
 if(digitalRead(ON_SWITCH)==LOW) {
  IsOn = !IsOn;
  LEDShowOnStatus();
  delay(20);
  while(digitalRead(ON_SWITCH)==LOW) {
   // Debouncing
   delay(20);
  }  
 }
 
 if(!IsOn) {
  if(CtrlPressed) Keyboard.release(KEY_RIGHT_CTRL);
  if(ShiftPressed) Keyboard.release(KEY_RIGHT_SHIFT);
  if(EndPressed) Keyboard.release(KEY_END);
  if(LeftPressed) Keyboard.release(KEY_LEFT_ARROW);
  if(RightPressed) Keyboard.release(KEY_RIGHT_ARROW);

  digitalWrite(LED_SENSE,LOW);  
  delay(40);
  return; // Do nothing if the user has switched the console off
 }
    
 // Read trampoline switch
 boolean TrampolineDown = digitalRead(TRAMPOLINE) == LOW; 
 if(TrampolineDown && !CtrlPressed) {
  Keyboard.press(KEY_RIGHT_CTRL);  
  CtrlPressed=true;
 }
 else if(!TrampolineDown && CtrlPressed) {
  Keyboard.release(KEY_RIGHT_CTRL);
  CtrlPressed=false;
 }

 // Read push buttons L and R
 boolean LeftDown = digitalRead(LEFT_BUTTON) == LOW; 
 if(LeftDown && !LeftPressed) {
  Keyboard.press(KEY_LEFT_ARROW);
  LeftPressed=true;
 }
 else if(!LeftDown && LeftPressed) {
  Keyboard.release(KEY_LEFT_ARROW);
  LeftPressed=false;
 }
 boolean RightDown = digitalRead(RIGHT_BUTTON) == LOW; 
 if(RightDown && !RightPressed) {
  Keyboard.press(KEY_RIGHT_ARROW);
  RightPressed=true;
 }
 else if(!RightDown && RightPressed) {
  Keyboard.release(KEY_RIGHT_ARROW);
  RightPressed=false;
 }

 if(SensorOK) {
  VL53L0X_RangingMeasurementData_t measure;
  int cm;
  lox.getSingleRangingMeasurement(&measure); 
  if(measure.RangeStatus != 4) {   
   cm = measure.RangeMilliMeter/10;   
 
   Serial.println(String(cm)+" - "+String(measure.RangeStatus));
   
   HandPresent = cm>=2 && cm<=HANDPRESENT_CM;  
   HumanPresent = cm>=2 && (HandPresent || cm<=HUMANPRESENT_CM);
 
   if(measure.RangeStatus!=0) HandPresent=false; // Voorkomt false-positives als je bukt en weer omhoog komt
  }
   
  if(HumanPresent && !ShiftPressed) {
   //digitalWrite(LED_SENSE,HIGH); may comment in if you want the LED to lit when person is present
   Keyboard.press(KEY_RIGHT_SHIFT);
   ShiftPressed=true;
  }
  else if(!HumanPresent && ShiftPressed) {
   //digitalWrite(LED_SENSE,LOW); may comment in if you want the LED to lit when person is present
   Keyboard.release(KEY_RIGHT_SHIFT);
   ShiftPressed=false;
  }
 
  if(HandPresent && !EndPressed) {
   Keyboard.press(KEY_END);   
   EndPressed=true;  
  }
  else if(!HandPresent && EndPressed) {   
   Keyboard.release(KEY_END);
   EndPressed=false;
  }
 }//if(SensorOK)

 // Trampoline triggers sensor LED when person jumps (contact = Off!)
 digitalWrite(LED_SENSE,(!CtrlPressed || ShiftPressed || EndPressed
  || HandPresent || HumanPresent || LeftPressed || RightPressed)?HIGH:LOW); 
}

void LEDShowOnStatus() {
 digitalWrite(LED_ON,IsOn? HIGH : LOW);
}
