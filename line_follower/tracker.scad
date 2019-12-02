tracker_depth=9;
tracker_width=78;
tracker_height=1.5;
tracker_core_width=78-tracker_depth;
tracker_connector_depth=18-tracker_depth;
tracker_connector_width=29;
tracker_connector_hole=1.4;
tracker_hole_x=tracker_connector_depth+1.75;
tracker_hole_y=tracker_connector_depth-5.8;
sensor_width=5;
sensor_depth=6.5;
sensor_height=6.5;
sensor_distance=16;
security=0.20;

module tracker_board() {    
    translate([(tracker_core_width-(tracker_connector_width+tracker_connector_depth))/2,tracker_depth,0]){
        difference() {
            cube([tracker_connector_width+tracker_connector_depth,tracker_connector_depth,tracker_height]);
            translate([0,tracker_depth,0]){
                cylinder(tracker_height,tracker_depth, tracker_depth);
            }
            translate([tracker_connector_width+tracker_connector_depth,tracker_depth,0]){
                cylinder(tracker_height,tracker_depth, tracker_depth);
            }
            /*translate([tracker_hole_x,tracker_hole_y,0]){
                cylinder(tracker_height,tracker_connector_hole, tracker_connector_hole, $fn=16);
            }
            translate([tracker_connector_width+tracker_connector_depth-tracker_hole_x,tracker_hole_y,0]){
                cylinder(tracker_height,tracker_connector_hole, tracker_connector_hole, $fn=16);
            }*/
        }
    }
    cube([tracker_core_width,tracker_depth,tracker_height]);
    translate([0,tracker_depth/2,0]){
        cylinder(tracker_height,tracker_depth/2, tracker_depth/2);
    }
    translate([tracker_core_width,tracker_depth/2,0]){
        cylinder(tracker_height,tracker_depth/2, tracker_depth/2);
    }
}

module sensor() {
    cube([sensor_width,sensor_depth,sensor_height]);
}

module tracker() {
    translate([tracker_depth/2,0,sensor_height]) tracker_board();
    for(i=[0:4]) translate([(tracker_depth/2)+sensor_distance*i,(tracker_depth-sensor_depth)/2,]) sensor();
}


module mark() {
    linear_extrude(height = 2) {
        polygon([[0,0],[10,0],[5,10]]);
    }
}

module tracker_mask() {
    border=2;
    height=12;
    difference() {
        cube([(tracker_width-tracker_depth+2*sensor_distance)+2*border,sensor_distance*2+2*border,sensor_height+tracker_height+height]);
        translate([border,border,0]){
            cube([(tracker_width-tracker_depth+2*sensor_distance),sensor_distance*2,sensor_height+border+height]);
        }
    }
    translate([border,border,height]){
        difference() {
            translate([0,0,sensor_height-border]){
                cube([tracker_width-tracker_depth+2*sensor_distance,sensor_distance*2,tracker_height+border]);
            }
            translate([sensor_distance-(tracker_depth/2),(2*sensor_distance-tracker_depth)/2,0]){
                resize([tracker_width+2*security,0,0], auto=true) tracker();
            }
        }
    }
    for(i=[0:4]) {
        translate([border+sensor_distance+(i*(sensor_distance))-(10-sensor_width)/2,sensor_distance*2+2*border,0]){
            echo(border+sensor_distance+(i*(sensor_distance))-(10-sensor_width)/2);
            mark();
        }
    }
    for(i=[0:4]) {
        translate([border+sensor_distance+(i*(sensor_distance))+10-(10-sensor_width)/2,0,0]){
            rotate([0,0,180]) mark();
        }
    }
    translate([0,border+sensor_distance-5,0]){
        rotate([0,0,90]) mark();
    }
     translate([tracker_width-tracker_depth+2*sensor_distance+2*border,border+sensor_distance+5,0]){
        rotate([0,0,-90]) mark();
    }
   
}

rotate([180,0,0]) tracker_mask();