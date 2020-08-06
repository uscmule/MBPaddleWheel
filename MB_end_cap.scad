
rotate([0,180,0]) end_cap();

module end_cap() {
    clip_height = 21;
    clip_width = 11;
    clip_depth = 31.3;
    clip_wall = 3;
    clip_lip = 5.5;
    clip_lip_slope = 0.80;
    radius = clip_height;
    inner_radius = radius * sqrt(3)/2;

    translate([0, inner_radius, 0]) rotate([180,0,0])
    end_clip(clip_depth, clip_width, clip_height, clip_wall, clip_lip, clip_lip_slope);

    translate([-inner_radius*cos(30), inner_radius*cos(60), 0]) rotate([180,0,60])
    end_clip(clip_depth, clip_width, clip_height, clip_wall, clip_lip, clip_lip_slope);

    translate([-inner_radius*cos(30), -inner_radius*cos(60), 0]) rotate([180,0,120])
    end_clip(clip_depth, clip_width, clip_height, clip_wall, clip_lip, clip_lip_slope);

    translate([0, -inner_radius, 0]) rotate([180,0,180])
    end_clip(clip_depth, clip_width, clip_height, clip_wall, clip_lip, clip_lip_slope);

    translate([inner_radius*cos(30), -inner_radius*cos(60), 0]) rotate([180,0,240])
    end_clip(clip_depth, clip_width, clip_height, clip_wall, clip_lip, clip_lip_slope);

    translate([inner_radius*cos(30), inner_radius*cos(60), 0]) rotate([180,0,300])
    end_clip(clip_depth, clip_width, clip_height, clip_wall, clip_lip, clip_lip_slope);

    difference () {
        rotate([0,180,0]) linear_extrude(height = 11, center = false, convexity = 10, twist = 0) hexagon(radius+clip_wall);
        translate([0,0,1]) rotate([0,180,0]) linear_extrude(height = 13, center = false, convexity = 10, twist = 0) hexagon(radius);
    }
}


module end_clip(x, y, z, wall, lip, slope) {
    inner_x = x - (2*wall);
    inner_z = z - (2*wall);
    outter_x = x-wall;
    outter_z = z-wall;
    
    rotate([90,-1.4,90])
    translate([-x/2, y/2-0.1, 0])
    difference() {
        hull() {
            translate([-outter_x/2, -2,-outter_z/2+(wall/2)]) rotate([90,0,0])
            dowel(wall, y/2);
            translate([outter_x/2,0,-outter_z/2]) rotate([90,0,0])
            dowel(wall, y);
            translate([-outter_x/2,-2,outter_z/2-(wall/2)]) rotate([90,0,0])
            dowel(wall, y/2);
            translate([outter_x/2,0,outter_z/2]) rotate([90,0,0])
            dowel(wall, y);
            }
  
        translate([0, 0, 0])
        cube([inner_x, y, inner_z],center=true);
        translate([-wall-1,0,0]) cube([inner_x+1,y+wall,inner_z - (2*lip)],center=true);
        translate([-(x/2 -wall*1.5), -(y+1)/2, ((inner_z - (2*lip))/2)-0.1]) rotate([0,0,90]) prism(y+wall, y, y*slope);
        translate([-(x/2 - wall*1.5),  (y+1)/2, -((inner_z - (2*lip))/2)+0.1]) rotate([0,180,90]) prism(y+wall, y, y*slope);
    }
}

module dowel(w,h) {
    cylinder(h = h-w, r1 = w/2, r2 = w/2, center = true);
    translate([0,0,(h-w)/2])
    sphere(d = w);
    translate([0,0,-(h-w)/2])
    sphere(d = w);
}

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

module hexagon(a){
    h = a*sqrt(3)/2;
    polygon(
        points=[[a,0], [a/2,h], [-a/2,h], [-a,0], [-a/2,-h], [a/2,-h]]
    );
}