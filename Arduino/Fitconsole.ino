// Fitconsole 
// Version 1.1 - December 2020
// 6 Fitbuttons
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

#include <Keyboard.h>

#define LED_ON       9 // LED indicates "on" meaning keys are transmitted to the PC
#define LED_SENSE   10 // Person available or person strikes a punch
#define ON_SWITCH   11 // Push button (on/off switch)

#define FITBUTTON1 1
#define FITBUTTON2 2
#define FITBUTTON3 3
#define FITBUTTON4 4
#define FITBUTTON5 5
#define FITBUTTON6 6

boolean IsOn = false;

void setup() { 
 delay(2000);  
 Serial.begin(115200);
 
 pinMode(FITBUTTON1, INPUT_PULLUP);
 pinMode(FITBUTTON2, INPUT_PULLUP);
 pinMode(FITBUTTON3, INPUT_PULLUP);
 pinMode(FITBUTTON4, INPUT_PULLUP);
 pinMode(FITBUTTON5, INPUT_PULLUP);
 pinMode(FITBUTTON6, INPUT_PULLUP);
 
 pinMode(ON_SWITCH, INPUT_PULLUP); 
 pinMode(LED_SENSE, OUTPUT);
 pinMode(LED_ON, OUTPUT);
 
 digitalWrite(LED_ON, LOW);
 digitalWrite(LED_SENSE, LOW);
  
 Keyboard.begin();    
 digitalWrite(LED_ON,HIGH); 
 IsOn=true;

 Serial.println("Ready");
 LEDShowOnStatus();
}

// Keypresses sent to the PC:
// Fitbutton1 = Cursor Left
// Fitbutton2 = Shift
// Fitbutton3 = Ctrl
// Fitbutton4 = Home
// Fitbutton5 = End
// Fitbutton6 = Cursor Right
void loop() {
 static boolean CtrlPressed=false,ShiftPressed=false, HomePressed=false, EndPressed=false;
 static boolean LeftPressed=false, RightPressed=false;
  
 if(digitalRead(ON_SWITCH)==LOW) {
  Serial.println("Aan/uit");
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
  if(HomePressed) Keyboard.release(KEY_HOME);
  if(LeftPressed) Keyboard.release(KEY_LEFT_ARROW);
  if(RightPressed) Keyboard.release(KEY_RIGHT_ARROW);

  digitalWrite(LED_SENSE,LOW);  
  delay(40);
  return; // Do nothing if the user has switched the console off
 }

 ProcessButton(FITBUTTON1, &LeftPressed, KEY_LEFT_ARROW);
 ProcessButton(FITBUTTON2, &ShiftPressed, KEY_RIGHT_SHIFT);
 ProcessButton(FITBUTTON3, &CtrlPressed, KEY_RIGHT_CTRL);
 ProcessButton(FITBUTTON4, &HomePressed, KEY_HOME);
 ProcessButton(FITBUTTON5, &EndPressed, KEY_END);
 ProcessButton(FITBUTTON6, &RightPressed, KEY_RIGHT_ARROW);

 digitalWrite(LED_SENSE,(
  LeftPressed||ShiftPressed||CtrlPressed||HomePressed||EndPressed||RightPressed
  )? HIGH:LOW);
}

void ProcessButton(int Fitbutton, boolean *KeyPressed, int KeyCode) {
 boolean KeyIsDown = digitalRead(Fitbutton) == LOW; 
 if(KeyIsDown && !*KeyPressed) {
  Keyboard.press(KeyCode);
  Serial.println(Fitbutton);
  *KeyPressed=true;
 }
 else if(!KeyIsDown && *KeyPressed) {
  Keyboard.release(KeyCode);
  *KeyPressed=false;
 }
}
 
 

void LEDShowOnStatus() {
 digitalWrite(LED_ON,IsOn? HIGH : LOW);
}
