include <BOSL2/std.scad>

// DIN USB HUB mount
// 
// Source: DIN rail clip from:
//   https://www.thingiverse.com/thing:3558498
// by espr14
// 
// CC - Attribution license
// 
// Thickness of the cable wrap
length=12;

// Thickness of the wall
wall=2;

// Tolernace
tolerance=0.1;

// Thickness of the clip
clipWall=1;

device_width=31;
device_depth=102;

/* [Hidden] */
clipL=10;
$fn = 64;
cut=true;

union() {
    mirror([1,0,0]) linear_extrude(length) dinRailClip(wall,clipWall,clipL,tolerance,cut);
    right(11) {
			diff() {
		    cuboid([wall,device_depth+wall*2,length], anchor=RIGHT+BOTTOM)
				{
				tag("remove") position(LEFT+FRONT) left(0.01) back(21) rotate([0,90,0]) cylinder(3, d=10, center = false);
				tag("remove") position(LEFT+BACK) left(0.01) fwd(21) rotate([0,90,0]) cylinder(3, d=10, center = false);
				position(FRONT+RIGHT) cuboid([device_width + wall,wall,length], anchor=FRONT+LEFT); 
			 	position(BACK+RIGHT) cuboid([device_width + wall,wall,length], anchor=BACK+LEFT)
					position(FRONT+RIGHT) cuboid([wall, device_depth, length], anchor=BACK+RIGHT);
				}
			}
    }
}

//%t([-7.5,0,0]) linear_extrude(length) dinRail();

module dinRail(){
	t([0,-27/2]) square([1,27]);
	
	t([0,-27/2]) square([7.5,1]);
	t([0,27/2-1]) square([7.5,1]);
	
	t([7.5-1,-27/2-5+1]) square([1,5]);
	t([7.5-1,27/2-1]) square([1,5]);
}

module dinRailClip(wall=2, clipWall=1, clipL=10, tolerance=0.1, cut=true){
	not=0.001;
	
	module p1(){t([0,-17.5-tolerance]) square([1+tolerance,1]);}
	module p2(){t([0,16.5]) square([1,1]);}
	module p3(){t([1,17.5]) square([not,wall]);}
	module p4(){t([3,16]) circle(1);}
	module p5(){t([3.5,17+wall]) circle(0.5);}
	module p6(){t([-clipL+1.5-wall,17+wall]) circle(0.5);}
	module p7(){t([-clipL+1.5-wall,-17-clipWall-tolerance]) circle(0.5);}
	module p8(){t([-clipL+1.5,-17-tolerance]) circle(0.5);}
	module p9(){t([5,-17-clipWall-tolerance]) circle(0.5);}
	
	difference(){
		union(){
			///positive
			hull(){		
				t([1.5+tolerance,-16-tolerance]) circle(0.5);
				p9();
				t([1.5+tolerance,-17-clipWall-tolerance]) circle(0.5);
			}
			
			hull(){
				t([1,17.5]) square([not,not]);
				p4();
				p5();
			}

			hull(){
				p3();
				p5();
			}

			hull(){
				p3();
				p6();
			}
			
			hull(){
				p1();
				p9();
				p7();
			}

			hull(){
				p1();
				p7();
				p6();
				p2();
			}
		}
	
		//negative
		hull(){
			p1();
			p2();
		}

		hull(){
			p1();
			p8();
		}
		
		if(cut){
			t([-clipL-clipWall-wall,-17.5-tolerance+1+wall]) square([clipL+clipWall,34+tolerance-wall]);
		}
	}
}

module t(v=[0,0,0]){translate(v) children();}
