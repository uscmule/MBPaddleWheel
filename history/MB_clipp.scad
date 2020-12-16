clip_height = 21;
clip_width = 8.5;
clip_depth = 15;
clip_wall = 3;
clip_lip = 5.5;
clip_lip_slope = 0.80;
radius = clip_height;
inner_radius = radius * sqrt(3)/2;

end_clip(clip_depth, clip_width, clip_height, clip_wall, clip_lip, clip_lip_slope);

module end_clip(x, y, z, wall, lip, slope) {
    inner_x = x - (2*wall);
    inner_z = z - (2*wall);
    outter_x = x-wall;
    outter_z = z-wall;
    gap = 8.0;
    
    rotate([90,0,90])
    translate([-x/2, y/2-0.1, 0])
    union() {
    difference() {
        hull() {
            translate([-outter_x/2, 0, -outter_z/2+(wall/2)]) rotate([90,0,0])
            dowel(wall, y);
            translate([outter_x/2, 0, -outter_z/2]) rotate([90,0,0])
            dowel(wall, y);
            translate([-outter_x/2, 0, outter_z/2-(wall/2)]) rotate([90,0,0])
            dowel(wall, y);
            translate([outter_x/2, 0, outter_z/2]) rotate([90,0,0])
            dowel(wall, y);
            }
  
        translate([0, 0, 0])
        cube([inner_x, y, inner_z],center=true);
        translate([-wall-1,0,0]) cube([inner_x+1,y+wall, gap],center=true);
            translate([-inner_x/2, -(y+1)/2, gap/2-0.1]) rotate([0,0,90]) prism(y+wall, y, y*slope);
        translate([-inner_x/2,  (y+1)/2, -gap/2+0.1]) rotate([0,180,90]) prism(y+wall, y, y*slope);
        }
        
    }
    
}

module dowel(w,h) {
    cylinder(h = h-w, r1 = w/2, r2 = w/2, $fn=36, center = true);
    translate([0,0,(h-w)/2])
    sphere(d = w, $fn=36);
    translate([0,0,-(h-w)/2])
    sphere(d = w, $fn=36);
}

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}
