// Extra grote Fitbutton
// December 2020

$fn=200;

Box=true;
Bottom=true;

if(Bottom) translate([0,0,-20]) {
 Bodem();
}

module Bodem() {
 difference() {
  translate([0,0,0])cylinder(d=100,h=2);
  translate([31,31,-1]) cylinder(d=2.6,h=6); 
  translate([-31,31,-1]) cylinder(d=2.6,h=6); 
  translate([31,-31,-1]) cylinder(d=2.6,h=6); 
  translate([-31,-31,-1]) cylinder(d=2.6,h=6); 
  translate([31,31,-1.8]) cylinder(d=4.6,h=3); 
  translate([-31,31,-1.8]) cylinder(d=4.6,h=3); 
  translate([31,-31,-1.8]) cylinder(d=4.6,h=3); 
  translate([-31,-31,-1.8]) cylinder(d=4.6,h=3); 
 }
}

if(Box) {
 W=100;
 difference() {
  union() {
   cylinder(d1=W,d2=W-10,h=25);
   translate([W-117,W-55-2,-2])cube([34,8,22]);
  }
  translate([0,0,-2]) Bodem();
  translate([0,0,-2])cylinder(d1=W-3,d2=W-13,h=25);  
  translate([0,W/2+3,9])rotate([90,0,0]) DINPlug();
  translate([0,W/2+9.6,9])rotate([90,0,0])DINPlug(true);
  // Button
  translate([0,0,20]) cylinder(d=30.4,h=10);
 }
 // Screws
 translate([31,31,0])difference() {cylinder(d1=12,d2=2,h=25);  translate([0,0,-1])cylinder(d=3.2,h=6); }
 translate([-31,31,0])difference() {cylinder(d1=12,d2=2,h=25);translate([0,0,-1])cylinder(d=3.2,h=6); }
 translate([31,-31,0])difference() {cylinder(d1=12,d2=2,h=25);translate([0,0,-1])cylinder(d=3.2,h=6); }
 translate([-31,-31,0])difference() {cylinder(d1=12,d2=2,h=25);translate([0,0,-1])cylinder(d=3.2,h=6); }
}


module DINPlug(Surrounding=false) {
 if(Surrounding) {
  hull() {
   cylinder(d=19.8,h=10);
   translate([11.1,0,0]) cylinder(d=8,h=10);
   translate([-11.1,0,0]) cylinder(d=8,h=10);
  }
 }
 else {
  cylinder(d=15.4,h=10);
  translate([11.1,0,0]) cylinder(d=3.1,h=10);
  translate([-11.1,0,0]) cylinder(d=3.1,h=10);
 }
}
