//difference(){
tube();
    
 /*   
translate([0,0,109.9])
    cylinder(25.5,18.7, 0, $fn=360);
}
*/

module tube(){
    post_radius = 2;     // radius of long hex posts
    shaft_radius = 7.3;  // radius of bottom shaft (fits 7.5 hole)
    shaft_length = 8.5*2;   // length of bottom shaft
    port_offset = 3;     // solid thickness before port openening at top and bottom
    shell_thickness = 2; // wall thickness of tube
    outter_shell = 20.7; // max radius (fits 21 hex)
    inner_shell = outter_shell - shell_thickness; // inner radius of hexagon
    a = inner_shell;
    height = 83;         // height of tube, not including post
    bushing_length = 8.5*2;
    buffer = 0.3;
    
    // make top printable
    difference(){
        // main body
        union(){
            translate([0,0,shaft_length])
            difference () {
                shell(outter_shell, shell_thickness, height, port_offset);
            
                port_tool(height, outter_shell, inner_shell-shell_thickness/2, port_offset,   post_radius);
            }
            
            
            // make top bushing
            translate([0,0,shaft_length+height-port_offset])
            difference(){
                length = bushing_length + port_offset;
                r = inner_shell-(shell_thickness/2) + 0.135;
                cylinder(length, r, r, $fn=360);
                
                r2 = inner_shell-(shell_thickness*3/2);
                translate([0,0,-1])
                cylinder(length+2, r2, r2, $fn=360);
            }
            
            // fill top gap
            translate([0,0,shaft_length+height-port_offset])
            difference(){
                cylinder(port_offset, outter_shell, outter_shell, $fn=360);
                
                translate([0,0,-1])
                cylinder(port_offset+2, inner_shell, inner_shell-shell_thickness, $fn=360);
                
                    
            }
            
            length = shaft_length + port_offset;
            r = inner_shell-(shell_thickness/2) + 0.135;
            // make bottom bushing
                cylinder(length, r, r, $fn=360);
            
         
        }
        // carve out slope to make it printable without support
            translate([0,0,height+shaft_length-port_offset-0.1])
            cylinder(port_offset*2, inner_shell, inner_shell-shell_thickness*1.6, $fn=360);
        
    }

    
}

module port_tool(height, r1, r2, top_offset, side_offset) {
    port_tool_width = r1*2.5; // more than the diameter
    port_width = r2-2*side_offset;
    port_height = height - top_offset*2;
    
    rotate([0,0,0])
    translate([-(port_width)/2,-port_tool_width/*/2*/,top_offset])
    cube([port_width,port_tool_width,port_height]);
    /*
    rotate([0,0,0])
    translate([-(port_width)/2,-port_tool_width/2,top_offset])
    cube([port_width,port_tool_width,port_height]);
    
    rotate([0,0,60])
    translate([-(port_width)/2,-port_tool_width/2,top_offset])
    cube([port_width,port_tool_width,port_height]);

    rotate([0,0,120])
    translate([-(port_width)/2,-port_tool_width/2,top_offset])
    cube([port_width,port_tool_width,port_height]);
    */
}

module shell(radius, thickness, height, offset) {
    union(){
    r = radius+thickness;
    linear_extrude(height = height, convexity = 10, twist = 0)
    difference() {
        circle(r-thickness, $fn=360);
    
        circle(r-thickness-thickness, $fn=360);
    }
    linear_extrude(height = offset, convexity = 10, twist = 0)
    circle(radius);
}
}

module hex_posts(a, height, r) {
    h = a*sqrt(3)/2;

    linear_extrude(height = height, convexity = 10, twist = 0)
    translate([a,0,0])
    cylinder(h = height, r1 = r, r2 = r, $fn=6);

    translate([a/2,h,0])
    cylinder(h = height, r1 = r, r2 = r, $fn=6);

    translate([-a/2,h,0])
    cylinder(h = height, r1 = r, r2 = r, $fn=6);

    translate([-a,0,0])
    cylinder(h = height, r1 = r, r2 = r, $fn=6);
    
    // These two are on the sides of the port
    translate([-a/2,-h,0])
    cylinder(h = height, r1 = r, r2 = r, $fn=6);

    translate([a/2,-h,0])
    cylinder(h = height, r1 = r, r2 = r, $fn=6);
}
module hexagon(a){
    h = a*sqrt(3)/2;
    polygon(
        points=[[a,0], [a/2,h], [-a/2,h], [-a,0], [-a/2,-h], [a/2,-h]]
    );
}