// The Console - part of Fitconsole
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

Lid=1;
Box=1;
Foot=1;

if(Foot) translate([15,15,-5]) {
 cylinder(d=4,h=4,$fn=5);
 translate([0,0,-3])cylinder(d1=10,d2=12,h=5,$fn=10);
}

if(Box) {
 difference() {
  hull() {
   cube([10,10,30]);
   translate([10,80,0])cylinder(d=20,h=30);
   translate([150,0,0])cube([10,10,30]);
   translate([150,80,0])cylinder(d=20,h=30);
  }
  // Cut main inside
  hull() {
   translate([2,18,2])cube([10,10,30]);
   translate([12,78,2])cylinder(d=20,h=30);
   translate([150-2,18,2])cube([10,10,30]);
   translate([150-2,78,2])cylinder(d=20,h=30);
  }
  // Cut inside below brand bar (no supports need to be added by slicer)
  translate([2,2,2])cube([20,20,24]);
  translate([24,2,2])cube([35,20,24]);
  translate([61,2,2])cube([35,20,24]);
  translate([50,14,2])cube([35,20,24]);
  translate([98,2,2])cube([30,20,24]);
  translate([130,2,2])cube([28,20,24]);  
  // Mount for The Pole
  translate([120,0,4])SpeakerPanel();
  translate([40,5,13])rotate([90,0,0])DINPlug();
  
  // Holes to mount feet
  translate([15,15,-1]) cylinder(d=4,h=10,$fn=5);
  translate([160-15,15,-1]) cylinder(d=4,h=10,$fn=5);
  translate([160-15,90-15,-1]) cylinder(d=4,h=10,$fn=5);
  translate([15,90-15,-1]) cylinder(d=4,h=10,$fn=5);
    
  // Arduino PCB outline
  //translate([90,87,2])rotate([0,0,180])
  //#import("/media/marcel/4TB/ff/bumper_leonardo.stl");
  translate([70,86,5]) {
   // Arduino (Leonardo) holes
   translate([-0.5,0,0])cube([10,10,4]); // USB
   translate([-30.5,0,0])cube([11,10,12]); // Power      
   // Screw holes 
   translate([20,0,0]) {
    translate([-2.6,-14.2,-6]) cylinder(d=2.8,h=10);
    translate([-17.8,-14-51,-6]) cylinder(d=2.8,h=10);
    translate([-17.8-27.9,-14-51,-6]) cylinder(d=2.8,h=10);
    translate([-(53.3-2.5),-14+1.1,-6]) cylinder(d=2.8,h=10);
   }
  }
  
 }
 
 // Cyl's for screwing lid
 translate([8,22,0])difference(){cylinder(d=10,h=25);translate([0,0,25-4]) cylinder(d=3,h=5);}
 translate([160-8,22,0])difference(){cylinder(d=10,h=25);translate([0,0,25-4]) cylinder(d=3,h=5);}
 translate([160-8,83,0])difference(){cylinder(d=10,h=25);translate([0,0,25-4]) cylinder(d=3,h=5);}
 translate([8,83,0])difference(){cylinder(d=10,h=25);translate([0,0,25-4]) cylinder(d=3,h=5);}
 
 // Side ridges
 for(i=[1:8.25:80]) 
  color("grey")
   translate([-0.8,0.5+i,0])cube([1,4,30]);
 color("grey")
  translate([0.5,85,0])
   rotate([0,0,-37.5])
    cube([1,4,30]);
 for(i=[1:8.25:80]) 
  color("grey")
   translate([159.8,0.5+i,0])cube([1,4,30]); 
 color("grey")
  translate([158.5,85,0])
   rotate([0,0,41.5])
    cube([1,4,30]);
 // Brand text
 translate([80,8.8,30]) color("white")
 linear_extrude(height=0.8) text(
  halign="center",valign="center",text="FITCONSOLE",spacing=1.2,
  font="SF Atarian System:style=Regular");
}

module DINPlug() {
 cylinder(d=15.4,h=10);
 translate([11.1,0,0]) cylinder(d=3.1,h=10);
 translate([-11.1,0,0]) cylinder(d=3.1,h=10);
}

module SpeakerPanel() {
 translate([-45.2/2,0,0]) {
  // Inset
  translate([0,-9,0])cube([45.2,10,21.4]);
  // Screw holes
  translate([45/2-35/2,5,21.4/2])rotate([90,0,0])cylinder(d=3.2,h=10);
  translate([45/2+35/2,5,21.4/2])rotate([90,0,0])cylinder(d=3.2,h=10);
  // Wiring holes
  translate([45/2-27/2,-1,5])cube([27,10,14]);
 }
}

if(Lid) translate([0,0,40])  { 
 Ypos=53; // Pos. of push button
 Xpos=40; // Pos. of push button
 
 difference() {
  union() {
   color("silver") hull() {
    translate([2,18,1])cube([10,10,3]);
    translate([12,78,1])cylinder(d=20,h=3);
    translate([150-2,18,1])cube([10,10,3]);
    translate([150-2,78,1])cylinder(d=20,h=3);
   }  
   intersection() {
    color("gray") hull() {
     translate([2,18,2])cube([10,10,3]);
     translate([12,78,2])cylinder(d=20,h=3);
     translate([150-2,18,2])cube([10,10,3]);
     translate([150-2,78,2])cylinder(d=20,h=3);
    }
    // Ridges
    for(i=[1:8.25:70]) {
     translate([2,i+17,3]) color("silver") cube([156,4,2.8]);
    }
   }
 
  } // uniom
  // Cyl's for screwing lid
  translate([8,22,-1])cylinder(d=2.6,h=10);
  translate([160-8,22,-1])cylinder(d=2.6,h=10);
  translate([160-8,83,-1])cylinder(d=2.6,h=10);
  translate([8,83,0])cylinder(d=2.6,h=10);
  translate([8,22,2.4])cylinder(d=4.6,h=10);
  translate([160-8,22,2.4])cylinder(d=4.6,h=10);
  translate([160-8,83,2.4])cylinder(d=4.6,h=10);
  translate([8,83,2.4])cylinder(d=4.6,h=10);
  // Hole push button 
  translate([160-Xpos,Ypos,-1]) cylinder(d=30,h=10);  
  translate([160-Xpos,Ypos,3]) cylinder(d=34,h=10);  
  // space for ridge around push button
  translate([160-Xpos,Ypos,3]) cylinder(d=40,h=10);  
  // LED's bevel & holes
  translate([Xpos,Ypos,4]) cylinder(d=40,h=10);  
  translate([Xpos-8,Ypos-8,-1]) cylinder(d=5,h=10); 
  translate([Xpos+8,Ypos+8,-1]) cylinder(d=5,h=10); 
 } // difference
 // Ridge around push button
 color("grey") translate([Xpos,Ypos,3]) difference() {
  cylinder(d=44,h=2);  
  translate([0,0,-1])cylinder(d=36,h=20);  
 }
 // LED texts
 translate([Xpos+5,Ypos-8,4]) linear_extrude(height=1.6) text(
  halign="center",valign="center",text="sens",spacing=1,size=8.6,
  font="SF Atarian System:style=Regular");
 translate([Xpos-2,Ypos+8,4]) linear_extrude(height=1.6 ) text(
  halign="center",valign="center",text="on",spacing=1,size=8.6,
  font="SF Atarian System:style=Regular");
  
 
 // Ridge around LED's
 color("grey") translate([160-Xpos,Ypos,3]) difference() {     
  cylinder(d=44,h=2);  
  translate([0,0,-1])cylinder(d=36,h=20);  
 }
}




