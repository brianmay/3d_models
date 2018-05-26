thickness=2;
width=14;
padding=0;
height=10;
extrusion=20;
gap=4;

m_padding=padding;
t_width=width;
t_padding=padding;
b_width=width;
b_padding=padding;

//m_padding=6;
//t_width=10;
//t_padding=6;
//b_width=width;
//b_padding=6;

r_do = true;
t_do = true;
l_do = true;
b_do = true;


align=(width+2*thickness)/2;

t_align=(t_width+2*thickness)/2;
b_align=(b_width+2*thickness)/2;

// MIDDLE
translate([-align,-align, 0]) {
    cube([width+2*thickness,width+2*thickness,thickness+m_padding]);

    translate([0,0,thickness]) {
        cube([thickness, width+2*thickness, height+m_padding]);

        cube([width+2*thickness, thickness, height+m_padding]);

        translate([0,width+thickness,0])
        cube([width+2*thickness, thickness, height+m_padding]);

        translate([width+thickness,0,0])
        cube([thickness, width+2*thickness, height+m_padding]);
    }
};

// RIGHT
if (r_do)
translate([width+2*thickness-align,0-align,0])
union() {
    cube([extrusion,width+2*thickness,thickness+padding]);
    translate([0,0,thickness]) {
        cube([extrusion, thickness, height+padding]);

        translate([0,width+thickness,0])
        cube([extrusion, thickness, height+padding]);
    }
}

// TOP
if (t_do)
translate([0-t_align,width+2*thickness-align,0])
union() {
    cube([t_width+2*thickness,extrusion,thickness+t_padding]);
    translate([0,0,thickness]) {
        cube([thickness, extrusion, height+t_padding]);

        translate([t_width+thickness,0,0])
        cube([thickness, extrusion, height+t_padding]);
    }
}

// LEFT
if (l_do)
translate([-extrusion-align,0-align,0])
union() {
    cube([extrusion,width+2*thickness,thickness+padding]);
    translate([0,0,thickness]) {

        cube([extrusion, thickness, height+padding]);

        translate([0,width+thickness,0])
        cube([extrusion, thickness, height+padding]);
    }
}

// BOTTOM
if (b_do)
translate([0-b_align,-extrusion-gap-align,0])
union() {
    cube([b_width+2*thickness,extrusion+gap,thickness+b_padding]);
    translate([0,0,thickness]) {
        cube([thickness, extrusion+gap, height+b_padding]);

        translate([0,extrusion,0])
        cube([b_width+2*thickness, thickness, height+b_padding]);

        translate([b_width+thickness,0,0])
        cube([thickness, extrusion+gap, height+b_padding]);
    }
}
