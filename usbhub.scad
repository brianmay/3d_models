$width = 120;
$depth = 85;
$height = 30;
$extra_height = 2;
$floor = 2;
$thickness = 2;
$tie_height = 2;
$tie_width = 3;
$tie_offset = 2;

$outer_width = $width + $thickness*2;
$outer_depth = $depth + $thickness*2;

difference() {

	group() {
		translate([0,0,$floor]) {
			// 1st x wall
			cube([$outer_width,$thickness,$height + $extra_height]);

			// 1st y wall
			cube([$thickness,$outer_depth,$height + $extra_height]);

			// 2nd x wall
			translate([0,$depth+$thickness,0])
			cube([$outer_width,$thickness,$height + $extra_height]);

			// 2nd y wall
			translate([$width+$thickness,0,0])
			cube([$thickness,$outer_depth,$height + $extra_height]);
		}

		// floor
		cube([$outer_width,$outer_depth, $floor]);
	}

	translate([0,0,$floor+$height]) {
		translate([$tie_offset + $thickness,-1,0])
		cube([$tie_width,$outer_depth+2,$tie_height]);
    
		translate([$outer_width-$thickness-$tie_width-$tie_offset,-1,0])
		cube([$tie_width,$outer_depth+2,$tie_height]);
	}

	translate([0,0,$floor]) {
		translate([$tie_offset + $thickness,-1,0])
		cube([$tie_width,$outer_depth+2,$tie_height]);
    
		translate([$outer_width-$thickness-$tie_width-$tie_offset,-1,0])
		cube([$tie_width,$outer_depth+2,$tie_height]);
	}
}
