
difference() {
    cylinder(13,d=15,$fn=128);
    translate([0,0,-7.5]) difference() {
        sphere(22);
        sphere(20,$fn=128);
    }
    #translate([0,0,9.7]) cube([3.2,2.2,3.4], true);
    translate([0,0,4]) cube([9,9,8], true);
}