
knob(38, 2, 20.7, 9);

module knob(mic_radius, shell_thickness, outter_radius, shaft_length) {
    inner_radius = outter_radius -(shell_thickness*3/2) + 0.245;
    z = 0.5;

    difference(){
        union() {
            disc(mic_radius, shell_thickness);
            r = inner_radius + shell_thickness;
            
            translate([0,0,z])
            cylinder(shaft_length, r, r, $fn=360);
        }

        translate([0,0,z-2])
        cylinder(shaft_length + mic_radius, inner_radius, inner_radius, $fn=360);
    }
}

module disc(radius, thickness) {
    r = radius+thickness;
    height = 35;
    difference() {
        union() {
            difference() {
                resize([2*r,2*r, height])
                sphere(r, $fn=360);
                
                t = r/3;
                h = r*sqrt(3)/2;
                
                translate([r, 0, 0])
                rotate([0,0,90])
                grip_tool(t);
                
            }
            
            // center nub
            translate([r-10.2, 0, 0])
            sphere(2, $fn=360);
        }
        
        translate([0,0,-r-(12)])
        cube(2*r, center=true);
    }
}

module grip_tool(r, h) {
    resize([3.5*r,r*1.56, 80])
    cylinder(80, r, r, center = true, $fn=360);
}