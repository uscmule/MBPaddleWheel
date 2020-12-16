
//amplified_end_cap();

translate([0,0, 5])
rotate([0,90,0])
amp_post();


module amplified_end_cap() {
    cap_radius = 21;
    cap_height = 8.5;
    tube_hieght = 83;
    post_width = 3;
    post_depth = 6;
    post_hieght = tube_hieght+cap_height;
    wall = 3;
    r = cap_radius + wall;
    a = r*sqrt(3)/2;
    
    difference() {
        union() {
            difference() {
                translate([0,0,0])
                rotate([0,180,0]) end_cap(cap_radius, cap_height);
                
                translate([0,0,-1])
                linear_extrude(height = cap_height+2, center = false, convexity = 10, twist = 0) hexagon(cap_radius);
            }
            
            translate([r,0,post_hieght/2])
            rotate([0,0,0])
            socket(post_depth, post_width, post_hieght);
            
            translate([r/2,a,post_hieght/2])
            rotate([0,0,60])
            socket(post_depth, post_width, post_hieght);
            
            translate([-r/2,a,post_hieght/2])
            rotate([0,0,120])
            socket(post_depth, post_width, post_hieght);
            
            translate([-r,0,post_hieght/2])
            rotate([0,0,180])
            socket(post_depth, post_width, post_hieght);
            
            translate([-r/2,-a,post_hieght/2])
            rotate([0,0,240])
            socket(post_depth, post_width, post_hieght);
            
            translate([r/2,-a,post_hieght/2])
            rotate([0,0,300])
            socket(post_depth, post_width, post_hieght);
        }
    
        translate([r,0,4.25])
        rotate([0,0,0])
        socket_tool();
        
        translate([r/2,a,4.25])
        rotate([0,0,60])
        socket_tool();
        
        translate([-r/2,a,4.25])
        rotate([0,0,120])
        socket_tool();
        
        translate([-r,0,4.25])
        rotate([0,0,180])
        socket_tool();
        
        translate([-r/2,-a,4.25])
        rotate([0,0,240])
        socket_tool();
        
        translate([r/2,-a,4.25])
        rotate([0,0,300])
        translate([0,0,0])
        socket_tool();
    }
    
    
}

module amp_post() {
    buffer = 0.25;
    height = 83+(8.5*2);
    linear_extrude(height = height, center = true, convexity = 10, twist = 0)
    polygon(points=[[5 - buffer,3-buffer], [5-buffer,-3+buffer], [-2+buffer,-1.5+buffer], [-2+buffer,1.5-buffer]]);
    difference(){
        translate([-2,0,0])
        cube([6, 3-(2*buffer), 83], center=true);
        
        translate([-24.30,0,0])
        cylinder(height, 21, 21, center=true, $fn=360);
    }
}

module socket_tool() {
    linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
    polygon(points=[[5,3], [5,-3], [-2,-1.5], [-2,1.5]]);
}

module socket(post_depth, post_width, post_hieght) {
    hull() {
        
        //translate([0,0,-post_hieght/2 + 4.25])
        //linear_extrude(height = 8.5, center = true, convexity = 10, twist = 0)
        //polygon(points=[[6,4], [6,-4], [-3,-3], [-3,3]]);
        
        translate([7.6, 9.5,-post_hieght/2 + 4.25])
        dowel(2, 8.5);
        
        translate([7.6, -9.5,-post_hieght/2 + 4.25])
        dowel(2, 8.5);
        
        translate([-2, -3,-post_hieght/2 + 4.25])
        dowel(2, 8.5);
        
        translate([-2, 3,-post_hieght/2 + 4.25])
        dowel(2, 8.5);
    }
}

module open_end_cap() {
cap_radius = 21;
cap_height = 8.5;
/*
translate([70,0,0])
rotate([0,180,0]) end_cap(cap_radius, cap_height);
*/
    
difference() {
    translate([0,0,0])
    rotate([0,180,0]) end_cap(cap_radius, cap_height);
    
    translate([0,0,-1])
    linear_extrude(height = cap_height+2, center = false, convexity = 10, twist = 0) hexagon(cap_radius);
}
}

module end_cap(rad, height) {
    clip_height = rad;
    clip_width = height;
    clip_depth = 15;
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
        rotate([0,180,0]) linear_extrude(height = clip_width, center = false, convexity = 10, twist = 0) hexagon(radius+clip_wall);
        /*translate([0,0,1]) rotate([0,180,0]) linear_extrude(height = 13, center = false, convexity = 10, twist = 0) hexagon(radius);*/
        translate([0,0,1])
        rotate([0,180,0])
        cylinder(h = clip_width+20, r1 = 7.5, r2 = 7.5, $fn=36, center = false);
    }
}


module end_clip(x, y, z, wall, lip, slope) {
    inner_x = x - (2*wall);
    inner_z = z - (2*wall);
    outter_x = x-wall;
    outter_z = z-wall;
    gap = 8.0;
    
    rotate([90,0,90])
    translate([-x/2, y/2, 0])
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
    cylinder(h = h, r1 = w/2, r2 = w/2, $fn=36, center = true);
    /*translate([0,0,(h-w)/2])
    sphere(d = w, $fn=36);
    translate([0,0,-(h-w)/2])
    sphere(d = w, $fn=36);*/
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