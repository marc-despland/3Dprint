width=32;
deep=30;
height=1.5;
reserve=20;
size=2;

connector_width=8;
connector_deep=5;
connector_height=8.6;
security=0.2;


module connector(x, y, z, mask=false) {
    translate([mask ? x-security: x,mask ? y-security: y,mask ? z-security: z]) {
        h = (mask) ? reserve : connector_height;
        w = (mask) ? connector_width+2*security : connector_width;
        d = (mask) ? connector_deep+2*security : connector_deep;
        cube([w, d, h]);
    }
}

module onoff(mask=false) {
    //debattement 3->5.5
    cube([7, 7, 7]);
    if (mask) {
        translate([3.5,3.5,7]) {
            cylinder(3.5,d=6+2*security,$fn=16);
        }
        translate([3.5,3.5,10.5]) {
            cylinder(reserve-10.5,d=4+2*security,$fn=16);
        }
    }
}


module button() {
    difference() {
        union() {
            cylinder(1,d=6,$fn=16);
            translate([0,0,1]) cylinder(4,d=4,$fn=16);
        }
        translate([-1, -1.5,0]) cube([2,3,4]);
    }
}
    
module input(mask=false) {
    translate([0,0,12-4]) rotate([0,90,0]) cylinder(11,d=8);
    translate([0,-4.5,height]) cube([11,9,6.5]);
    translate([11,mask ? -4.5 - security : -4.5,height]) cube([3.5,mask ? 9+2*security: 9,mask ? 11+security: 11]);
}
module board(mask=false) {
    translate([mask ? -security: 0, mask ? -security: 0,mask ? -security: 0]) cube([mask ? width+2*security:width, mask ? deep+2*security:deep, mask ? height+security:height]);
    
    connector(2.5,1.5,height,mask);
    connector(11.5,1.5,height,mask);
    connector(20.5,1.5,height,mask);
    
    translate([21,10,height]) onoff(mask);
    
    translate([20,23,0]) input();
    
    //top electronics
    translate([3,deep-21,height]) cube([16,21,2]);
 
    //bootom electronics
    translate([(width-26)/2,1,-2]) cube([26,6,2]);
    translate([3,0,-2]) cube([10,deep,2]);
    
    if (mask) {
        //powerled
        translate([7,deep-2,0]) cylinder(reserve,d=4,$fn=16);
    }
}

module border(mask=false) {
    difference() {
        cube([width+2*size, deep+2*size, 2]);
        translate([size/2, mask ? size/2+security: size/2,0]) cube([width+size, mask ? deep+size-2*security: deep+size, 2]);
    }
    translate([size/2,mask ? size/2:  size/2-security,1]) rotate([0,90,0]) cylinder(width+size,d=mask ? 1+security: 1-security,$fn=16);
    #translate([size/2,mask ? deep+2*size-size/2:  deep+2*size-(size/2-security),1]) rotate([0,90,0]) cylinder(width+size,d=mask ? 1+security: 1-security,$fn=16);
}

difference() {
    cube([width+2*size, deep+2*size, 12]);
    translate([size,size,-height]) board(true);
    translate([0,0,5]) cube([width+2*size,10,10]);
    border(true);
}
translate([13.5,10,6.5]) rotate([90,0,0]) linear_extrude(height=0.5) text("3.3", size=4);
translate([7,10,6.5]) rotate([90,0,0]) linear_extrude(height=0.5) text("5", size=4);
translate([23.5,10,6.5]) rotate([90,0,0]) linear_extrude(height=0.5) text("12", size=4);
#translate([width+2*size,12,6.5]) rotate([90,0,90]) linear_extrude(height=0.5) text("12", size=4);

bottom_height=4;
translate([0,-(deep+2*size+5),0]) {
    difference() {
        union() {
            cube([width+2*size, deep+2*size, bottom_height]);
            translate([0,0,bottom_height]) border();
        }
        translate([size,size,bottom_height-height]) board(true);
    }
}

translate([-10,0,5]) rotate([180,0,0]) button();