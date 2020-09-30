
sm57b_cup(20.7, 2);

module sm57b_cup(outter_radius, shell_thickness) {
    shaft_length = 9;
    inner_radius = outter_radius -(shell_thickness*3/2) + 0.155;
    z = 24;

    difference(){
        union() {
            
            r = inner_radius + shell_thickness;
            hollow_sm57b(r, shell_thickness);
            translate([0,0,z])
            cylinder(shaft_length, r, r, $fn=360);
        }

        translate([0,0,z-1])
        cylinder(shaft_length + 2, inner_radius, inner_radius, $fn=360);
    }
}


module hollow_sm57b(radius, thickness) {
    height = 24;
    r1 = radius;
    r2 = 22 + thickness;
    
    difference() {
        cylinder(height, r2, r1, $fn=360);
        
        translate([0,0,-1])
        cylinder(height+2, r2-thickness, r1-thickness, $fn=360);
    }
}

module hollow_hemi(radius, thickness) {
    r = radius+thickness;
    difference() {
        sphere(r, $fn=360);
        
        translate([0,0,-radius])
        cube(2*r, center=true);
        
        sphere(radius, $fn=360);
    }
}