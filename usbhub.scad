$width = 30;
$depth = 20;
$height = 10;
$floor = 2;
$thickness = 2;
$tie_height = 8;
$tie_width = 3;

$outer_width = $width + $thickness*2;
$outer_depth = $depth + $thickness*2;

difference() {

group() {
translate([0,0,$floor]) {
// 1st x wall
cube([$outer_width,$thickness,$height]);

// 1st y wall
cube([$thickness,$outer_depth,$height]);

// 2nd x wall
translate([0,$depth+$thickness,0])
cube([$outer_width,$thickness,$height]);

// 2nd y wall
translate([$width+$thickness,0,0])
cube([$thickness,$outer_depth,$height]);
}

// floor
cube([$outer_width,$outer_depth, $floor]);
}

translate([0,0,$floor+$tie_height]) {
translate([$thickness,-1,0])
cube([$tie_width,$outer_depth+2,1]);
    
translate([$outer_width-$thickness-$tie_width,-1,0])
cube([$tie_width,$outer_depth+2,1]);
}
}
