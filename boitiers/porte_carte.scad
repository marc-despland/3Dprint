


module micro_sdcard() {
    cube([11,1,15]);
}

module sdcard() {
    cube([24,2.1,31]);
}

module usb() {
    cube([12,5,12]);
}

module rond_corner(deep) {
    difference() {
        cube([10,deep,10]);
        rotate([-90,0,0]) cylinder(deep, d=10,$fn=32);
    }
}

/*
difference() {
    height=20;
    width=4*12+3*10+2*8;
    deep=5*8+2*10+5+2*8;
    cube([width,deep,height]);
    translate([width-5,0,height-5]) rond_corner(deep);
    translate([width,deep-5,height-5]) rotate([0,0,90]) rond_corner(width);
    translate([5,deep,height-5]) rotate([0,0,180]) rond_corner(deep);
    translate([0,5,height-5]) rotate([0,0,270]) rond_corner(width);
    spacemicro=(width-16-5*11)/4;
    for (i=[0:4]) {
        translate([8+(i*(11+spacemicro)),8,height-8]) micro_sdcard();
    }
    for (i=[0:4]) {
        translate([8+(i*(11+spacemicro)),16,height-8]) micro_sdcard();
    }
    space=(width-16-3*24)/2;
    for (i=[0:2]) {
        for (j=[0:2]) {
            translate([8+(i*(24+space)),24+(8*j),height-15]) sdcard();
        }
    }
    for (i=[0:3]) {
        for (j=[0:2]) {
            translate([8+(i*(12+10)),48+(10*j),height-10]) usb();
        }
    }
}*/

difference() {
    cube([30,32,20]);
    translate([9.5,6,12]) micro_sdcard();
    translate([3,14,5]) sdcard();
    translate([9,22,10]) usb();
    
}

