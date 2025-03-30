include <BOSL2/std.scad>
include <BOSL2/screws.scad>


thickness = 8;
hook_height = 60;
hook_width = 50;
depth = 20;

translate([-thickness,0,0]) cuboid([hook_width + thickness*2, depth, thickness], anchor=BOTTOM+LEFT);

translate([+hook_width,0,0]) cuboid([thickness, depth, hook_height], anchor=TOP+LEFT);


diff() {
	translate([-thickness,0,0]) cuboid([thickness, depth, hook_height], anchor=TOP+LEFT) 

	tag("remove")
		position(BOTTOM+RIGHT)
		right(0.01)
		up(20) {
			fwd(5)
		  rotate([0,270,0])
			screw_hole("M4,8.01",counterbore=false, $fn=32, anchor=BOTTOM)
		  position(BOT) nut_trap_inline(3, "M4");

			back(5)
		  rotate([0,270,0])
			screw_hole("M4,8.01",counterbore=false, $fn=32, anchor=BOTTOM)
		  position(BOT) nut_trap_inline(3, "M4");
		}

}
