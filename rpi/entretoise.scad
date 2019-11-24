height=8.5;
radius_ext=3;
radius_int=1.3;


module entretoise() {
    difference() {
        cylinder(height,radius_ext,radius_ext,$fn=32);
        cylinder(height,radius_int,radius_int,$fn=32);
    }
}

for (i=[-1:1]) {
    for (j=[-1:1]) {
        translate([i*radius_ext*2.2,j*radius_ext*2.2,0]){
            entretoise();
        }
    }
}