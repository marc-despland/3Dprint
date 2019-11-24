languette_width=10;
languette_depth=10;
languette_height=2;
languette_distance=5;
support_depth=0.1;
support_distance=5;

module languette(width, depth, height) {
    cube([width, depth, height]);
}

module support_languette(width, depth, height) {
    for(i=[1:depth/support_distance]) {
        translate([0,support_distance*i,0]){
            cube([width, support_depth, height]);
        }
    }
}

difference() {
    cube([languette_width*3/2,languette_depth*2+languette_distance*3, languette_height*3]);
    translate([languette_width*1/2,languette_distance*2+languette_depth, languette_height]){
        languette(languette_width,languette_depth,languette_height);
    }
}
translate([languette_width*1/2,languette_distance*2+languette_depth, languette_height]){
    support_languette(languette_width,languette_depth,languette_height);
}

translate([languette_width*3/2,languette_distance, languette_height]){
    languette(languette_width,languette_depth,languette_height);
}

