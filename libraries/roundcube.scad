


module rond_corner(rayon,deep) {
    difference() {
        cube([rayon,deep,rayon]);
        rotate([-90,0,0]) cylinder(deep, r=rayon,$fn=32);
    }
}


module rondcube(rayon,width,deep, height, top=true, bottom=true, side=true) {
    difference() {
        cube([width, deep, height]);
        if (top) {
            translate([width-rayon,0,height-rayon]) rond_corner(rayon,deep);
            translate([width,deep-rayon,height-rayon]) rotate([0,0,90]) rond_corner(rayon,width);
            translate([rayon,deep,height-rayon]) rotate([0,0,180]) rond_corner(rayon,deep);
            translate([0,rayon,height-rayon]) rotate([0,0,270]) rond_corner(rayon,width);
        }
        if (side) {
            translate([width-rayon,rayon,0]) rotate([90,0,0]) rond_corner(rayon,height);
            translate([width-rayon,deep-rayon,0]) rotate([90,0,90]) rond_corner(rayon,height);
            translate([rayon,deep-rayon,0]) rotate([90,0,180]) rond_corner(rayon,height);
            translate([rayon,rayon,0]) rotate([90,0,270]) rond_corner(rayon,height);
        }
        if (bottom) {
            translate([width-rayon,0,rayon]) rotate([0,90,0]) rond_corner(rayon,deep);
            translate([width,deep-rayon,rayon]) rotate([0,90,90]) rond_corner(rayon,width);
            translate([rayon,deep,rayon]) rotate([0,90,180]) rond_corner(rayon,deep);
            translate([0,rayon,rayon]) rotate([0,90,270]) rond_corner(rayon,width);
        }
    }
}

rondcube(2, 30, 20, 15);