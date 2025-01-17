$fn = 100;
diam=15;
magnet=30;
dist=10;
length=10;
base_height=4;
diam_fix=4;
difference() {
    union() {
        difference() {
            rotate_extrude(convexity = 10, $fn = 100)
                translate([magnet/2+dist, 0, 0])
                    circle(r = diam/2);
            translate([0,-(magnet/2+diam/2+dist),-diam]) cube([magnet/2+diam/2+dist,2*(magnet/2+diam/2+dist),2*diam]);
        }
                
        translate([-2*(magnet/2+diam/2+dist)/3,magnet/2+dist,0]) rotate([0,90,0]) cylinder(d=diam,h=length+2*(magnet/2+diam/2+dist)/3);
        translate([-2*(magnet/2+diam/2+dist)/3,-(magnet/2+dist),0]) rotate([0,90,0]) cylinder(d=diam,h=length+2*(magnet/2+diam/2+dist)/3);
        translate([length-base_height,magnet/2+dist,0]) rotate([0,90,0]) cylinder(d=magnet,h=base_height);
        translate([length-base_height,-(magnet/2+dist),0]) rotate([0,90,0]) cylinder(d=magnet,h=base_height);
    }
    #translate([-(magnet/2+diam/2+dist),magnet/2+dist,0]) rotate([0,90,0]) cylinder(d=diam,h=(magnet/2+diam/2+dist)/3);
     translate([-(magnet/2+diam/2+dist),-(magnet/2+dist),0]) rotate([0,90,0]) cylinder(d=diam,h=(magnet/2+diam/2+dist)/3);
    translate([-2*(magnet/2+diam/2+dist)/3,magnet/2+dist,0]) rotate([0,90,0]) cylinder(d=diam_fix,h=length+2*(magnet/2+diam/2+dist)/3);
        translate([-2*(magnet/2+diam/2+dist)/3,-(magnet/2+dist),0]) rotate([0,90,0]) cylinder(d=diam_fix,h=length+2*(magnet/2+diam/2+dist)/3);
}
