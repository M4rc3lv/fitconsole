// The Pole - part of Fitconsole
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
$fn=200;

//LED's:
// 1 - On/off
// 2 - Trigger (buttons)
// 3 - Trigger (sensors?)
// - Button to switch on/off

Tripod=10;   // Mount for Hot Orange spools
Wirefeed=1;  // Sleeve to hide wires going in the tube
Extension=1; // Part to make a longer piece of pipe out of 2 shorter pieces
Polemount=1; // Base for the pole (connects to Tripod with M3 screws)

if(Extension) translate([80,0,0]) {
 difference() {
  union() {
   cylinder(d1=25,d2=24.4,h=40); 
   translate([0,0,-40])cylinder(d2=25,d1=24.4,h=40);
 
   difference() {
    cylinder(d=40,h=40);   
    translate([0,0,5])cylinder(d=32.2,h=40); 
   }
   translate([0,0,-40])difference() {
    cylinder(d=40,h=40);   
    translate([0,0,-1])cylinder(d=32.2,h=36);   
   }
  }
  translate([0,0,-61]) cylinder(d=16,h=150);
 }
}

if(Wirefeed) translate([-80,0,0]) {
 // Clamp around the pole to protect wire feed
 difference() {
  cylinder(d=40,h=20);
  translate([0,0,-1])cylinder(d=31,h=60);
  translate([-10,10,-1])cube([20,20,50]);
  // Wire hole
  translate([0,-5,10])
   rotate([90,0,0]) cylinder(d=6,h=20);
 }
}

if(Tripod) rotate([0,180,0]) translate([0,0,10]) {
 difference() {
  cylinder(d2=50,d1=52.4,h=50);  
 }
 translate([37,0,0]) cylinder(d1=11.6,d2=11.4,h=26);
 translate([-37,0,0]) cylinder(d1=11.6,d2=11.4,h=26);
 rotate([00,0,60])translate([-37,0,0]) cylinder(d1=11.6,d2=11.4,h=26);
 rotate([00,0,120])translate([-37,0,0]) cylinder(d1=11.6,d2=11.4,h=26);
 rotate([00,0,-120])translate([-37,0,0]) cylinder(d1=11.6,d2=11.4,h=26);
 rotate([00,0,-60])translate([-37,0,0]) cylinder(d1=11.6,d2=11.4,h=26);
 difference() {
  // Top
  cylinder(d=100,h=3); 
  // Screw holes
  rotate([0,0,-15])translate([26,26,-2])cylinder(d=3.2,h=10);
  rotate([0,0,-75])translate([26,26,-2])cylinder(d=3.2,h=10);
  rotate([0,0,-15])translate([-26,-26,-2])cylinder(d=3.2,h=10);
  rotate([0,0,15])translate([-26,26,-2])cylinder(d=3.2,h=10);
 }
}

module SpoelInsert() {
 cylinder(d1=25,d2=24.4,h=60); 
 difference() {
  cylinder(d=40,h=40);   
  translate([0,0,5])cylinder(d=32.2,h=40); 
 }
}

if(Polemount) translate([0,0,0]) {
 difference() {
  // Top
  cylinder(d=95,h=3); 
  // Screw holes
  rotate([0,0,-15])translate([26,26,-2])cylinder(d=3.2,h=10);
  rotate([0,0,-75])translate([26,26,-2])cylinder(d=3.2,h=10);
  rotate([0,0,-15])translate([-26,-26,-2])cylinder(d=3.2,h=10);
  rotate([0,0,15])translate([-26,26,-2])cylinder(d=3.2,h=10);
  
  translate([-44,84,4]) HolesLeonardo();
 }
 SpoelInsert();
  
   
}

module HolesLeonardo() {
 translate([14,-50.8,-5]) cylinder(d=2.8,h=10);
 translate([15.2,-2.6,-5]) cylinder(d=2.8,h=10);
 translate([66,-45.8,-5]) cylinder(d=2.8,h=10);
 translate([66,-17.8,-5]) cylinder(d=2.8,h=10);
 // Sunken heads
 translate([14,-50.8,-5]) cylinder(d=5,h=1.8);
 translate([15.2,-2.6,-5]) cylinder(d=5,h=1.8);
 translate([66,-45.8,-5]) cylinder(d=5,h=1.8);
 translate([66,-17.8,-5]) cylinder(d=5,h=1.8);
}

module Speakerterminal() {
 translate([5,21.4/2,0])cylinder(d=3.2,h=10);
 translate([40,21.4/2,0])cylinder(d=3.2,h=10);
 translate([0,0,5])cube([45.4,21.4,4]);
 translate([12,10,0])cube([22,10,40]);
}