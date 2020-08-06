
height = 100;
outter_shell = 20.7;
shell_thickness = 1;
inner_shell = outter_shell - shell_thickness;
post_radius = 1.5;
port_width = inner_shell-2*post_radius;
port_offset = 15;
port_height = height - port_offset*2;
a = inner_shell - post_radius;
port_tool_width = outter_shell*2.5;


difference () {
    union () {
        hex_posts(a, height);
        shell(outter_shell, shell_thickness, height);
    }

    port_tool();
}

module port_tool() {
    rotate([0,0,0])
    translate([-(port_width)/2,-port_tool_width/2,port_offset])
    cube([port_width,port_tool_width,port_height]);
    
    rotate([0,0,60])
    translate([-(port_width)/2,-port_tool_width/2,port_offset])
    cube([port_width,port_tool_width,port_height]);

    rotate([0,0,120])
    translate([-(port_width)/2,-port_tool_width/2,port_offset])
    cube([port_width,port_tool_width,port_height]);
}

module shell(radius, thickness, height) {
    linear_extrude(height = height, convexity = 10, twist = 0)
    difference() {
        hexagon(radius);
    
        hexagon(radius-thickness);
    }
}

module hex_posts(a, height) {
    h = a*sqrt(3)/2;
    translate([a,0,0])
    cylinder(h = height, r1 = post_radius, r2 = post_radius, $fn=6);

    translate([a/2,h,0])
    cylinder(h = height, r1 = post_radius, r2 = post_radius, $fn=6);

    translate([-a/2,h,0])
    cylinder(h = height, r1 = post_radius, r2 = post_radius, $fn=6);

    translate([-a,0,0])
    cylinder(h = height, r1 = post_radius, r2 = post_radius, $fn=6);

    translate([-a/2,-h,0])
    cylinder(h = height, r1 = post_radius, r2 = post_radius, $fn=6);

    translate([a/2,-h,0])
    cylinder(h = height, r1 = post_radius, r2 = post_radius, $fn=6);
}
module hexagon(a){
    h = a*sqrt(3)/2;
    polygon(
        points=[[a,0], [a/2,h], [-a/2,h], [-a,0], [-a/2,-h], [a/2,-h]]
    );
}