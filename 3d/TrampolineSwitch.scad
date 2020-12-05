$fn=100;

Lever=1;
Housing1=1;
Lid=1;

if(Lid) translate([-50,-20,15]) color("white") {   
 difference() {
  union() {
   hull() {
    translate([40.1,33,0])  cube([4,4,2]);
    translate([40.1,-2,0])  cube([4,4,2]);  
    translate([100,0,0]) cylinder(d=4,h=2);   
    translate([133,0,0]) cylinder(d=4,h=2); 
    translate([135,0,0]) cylinder(d=4,h=2); 
    translate([135,35,0]) cylinder(d=4,h=2); 
   }
   hull() {
    translate([133,-8,0]) cylinder(d=4,h=2);  
    translate([100,-8,0]) cylinder(d=4,h=2);  
    translate([133,0,0]) cylinder(d=4,h=2); 
    translate([100,0,0]) cylinder(d=4,h=2);   
   }
  }
  // Holes for screws
  translate([43,3,-1]) cylinder(d=2.6,h=10);
  translate([43,32,-1]) cylinder(d=2.6,h=10);
  translate([133,32,-1]) cylinder(d=2.6,h=10);
  translate([130,-5,-1]) cylinder(d=2.6,h=10);
  translate([43,3,0.8]) cylinder(d=4.8,h=10);
  translate([43,32,0.8]) cylinder(d=4.8,h=10);
  translate([133,32,0.8]) cylinder(d=4.8,h=10);
  translate([130,-5,0.8]) cylinder(d=4.8,h=10);
 }
}

if(Housing1) translate([-50,-20,-2]) {
 difference() {
  cube([40,36,30]);
  translate([20,42,12.5+2])rotate([90,0,0])cylinder(d=25,h=50);
  // Hole for bolt
  translate([20,17.5,-5])cylinder(d=4.2,h=60);
 }
 difference() {
  union() {
   hull() {
    cylinder(d=4,h=30);
    translate([0,35,0]) cylinder(d=4,h=30);  
    translate([40,0,0]) cylinder(d=4,h=30);
    translate([40,35,0]) cylinder(d=4,h=30);
   }
   hull() {
    cylinder(d=4,h=16);
    translate([110,0,0]) cylinder(d=4,h=16);       
    translate([135,0,0]) cylinder(d=4,h=16);
    translate([135,35,0]) cylinder(d=4,h=16);
    translate([0,35,0]) cylinder(d=4,h=16);  
   }   
   
   // Ridge for terminal block
   translate([50,-5,0])cube([18,4,2.4]);
   //translate([50,-5,2+15])#cube([18,4,2]);
   // Bulge for switch
   difference() {
    hull() {
     translate([100,-8,0]) cylinder(d=4,h=16);  
     translate([100,0,0]) cylinder(d=4,h=16);  
     translate([133,-8,0]) cylinder(d=4,h=16);  
     translate([133,0,0]) cylinder(d=4,h=16);  
    }
    hull() {
     translate([100+2,-6,2]) cylinder(d=4,h=50);  
     translate([100+2,3,2]) cylinder(d=4,h=50);  
     translate([133-2,-6,2]) cylinder(d=4,h=50);  
     translate([133-2,0,2]) cylinder(d=4,h=50);  
    }
   }
  }
  // Hole for terminal block
  translate([50+9,4,7.5])rotate([90,0,0]) cylinder(d=3.2,h=10);
  translate([70,-4,7.5-5/2])cube([2.4,10,5]);
  // Recess for switch compartment
  translate([100,-5,2]) cube([33,10,20]);
  // Lever out
  translate([125,11,2])cube([20,23,20]);
  // Hole for bolt
  translate([20,17.5,-5])cylinder(d=4.2,h=60);
  translate([2,2,2])hull() {
   translate([0,0,0])cylinder(d=4,h=30);
   translate([110,0,0]) cylinder(d=4,h=30);
   translate([135-4,0,0]) cylinder(d=4,h=30);
   translate([135-4,35-4,0]) cylinder(d=4,h=30);
   translate([0,35-4,0]) cylinder(d=4,h=30);  
  }
  
  translate([40,-5,16])cube([10,50,20]); // Straighten top so that lid fits
  
  translate([20,42,12.5+2])rotate([90,0,0])cylinder(d=25,h=50);
 }
 // Cyl's for mounting lid
 translate([43,3,2]) difference() {cylinder(d=8,h=14);translate([0,0,14-4]) cylinder(d=3,h=5);}
 translate([43,32,2]) difference() {cylinder(d=8,h=14);translate([0,0,14-4]) cylinder(d=3,h=5);}
 translate([133,32,2]) difference() {cylinder(d=8,h=14);translate([0,0,14-4]) cylinder(d=3,h=5);}
 translate([130,-5,2]) difference() {cylinder(d=8,h=14);translate([0,0,14-4]) cylinder(d=3,h=5);}
 
 // Pin to mount lever
 translate([87.5,20,2])
  cylinder(d=3.8,h=12);
 
 translate([106,14,2]) Switch();
}


if(Lever) color("brown") {
 difference() {
  union() {
   difference() {
    cylinder(d=15,h=10);
    translate([0,0,-1])cylinder(d=12,h=20);
   }
   hull() {
    translate([7.5,0,0])cylinder(d=9,h=10);
    translate([7.5+25,0,0])cylinder(d=7,h=10);
    translate([7.5+25,0,0])cylinder(d=7,h=10);
   }
   hull(){ 
    translate([7.5+25,0,0])cylinder(d=3,h=10);
    translate([7.5+25+45,0,0])cylinder(d=3,h=10);    
    translate([7.5+25+45+30,0,0])cylinder(d=3,h=10); 
   }
   translate([7.5+30,0,0]) difference() {
    cylinder(d=10,h=10);
    translate([0,0,-1])cylinder(d=4,h=20);
   }

   hull() {
   translate([7.5+25+45+30,0,0])cylinder(d=3,h=10);
   translate([7.5+25+45+25+30,10,0])cylinder(d=3,h=10);
   }

   hull() {
    translate([7.5+25+45+25+30,10,0])cylinder(d=3,h=10);
    translate([7.5+25+45+25+30+30,10+20,0])
     cylinder(d=2,h=10);
   }

   translate([7.5+25+45+25+30+30,10+20,5]) sphere(d=10);
   translate([7.5+25+45+25+30+30,10+20,0]) cylinder(d=4,h=4);
   translate([7.5+25+45+25+30+30,10+20,6]) cylinder(d=4,h=4);
  }
  translate([7.5+30,0,0])translate([0,0,-1])cylinder(d=4,h=20);
 } 
}

module Switch() {
 cylinder(d=3,h=10);
 translate([22,-10,0]) cylinder(d=3,h=10);
}
