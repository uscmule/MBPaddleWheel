
mic_cup(43.25/2, 2, 20.7, 9);

module mic_cup(mic_radius, shell_thickness, outter_radius, shaft_length) {
    inner_radius = outter_radius - shell_thickness;
    z = sqrt(pow(mic_radius+shell_thickness, 2) - pow(outter_radius, 2));

    difference(){
        union() {
            hollow_hemi(mic_radius, shell_thickness);

            translate([0,0,z])
            cylinder(shaft_length, outter_radius, outter_radius, $fn=360);
        }

        translate([0,0,z-2])
        cylinder(shaft_length + 4, inner_radius+0.1, inner_radius+0.1, $fn=360);
    }
}

module hollow_hemi(radius, thickness) {
    difference() {
        r = radius+thickness;
        sphere(r, $fn=360);
        
        translate([0,0,-radius])
        cube(2*r, center=true);
        sphere(radius, $fn=360);
    }
}