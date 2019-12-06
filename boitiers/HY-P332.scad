width=32;
deep=30;
height=1.5;
reserve=20;
size=2;

connector_width=8;
connector_deep=6;
connector_height=8.6;
security=0.3;


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
    size=7;
    translate([mask ? -security: 0,mask ? -security: 0,0]) cube([mask ? size+2*security: size, mask ? size+2*security: size, mask ? size+2*security: size]);
    if (mask) {
        translate([3.5,3.5,7]) {
            cylinder(reserve-10.5,d=7.4+2*security,$fn=32);
        }
        /*translate([3.5,3.5,10.5]) {
            cylinder(reserve-10.5,d=5.4+2*security,$fn=16);
        }*/
    }
}


module button() {
    difference() {
        union() {
            cylinder(6,d=7,$fn=32);
            //translate([0,0,1]) cylinder(5,d=5,$fn=16);
        }
        translate([-1, -1.75,0]) cube([2,3.5,4]);
    }
}
    
module input(mask=false) {
    translate([0,0,mask ? 13-4.5: 12-4]) rotate([0,90,0]) cylinder(mask ? 12: 11,d=mask ? 9: 8);
    translate([0,mask ? -4.5 - security : -4.5,height]) cube([11,,mask ? 9+2*security: 9,6.5]);
    #translate([11,mask ? -4.5 - security : -4.5,height]) cube([3.5,mask ? 9+2*security: 9,mask ? 11+security: 11]);
}
module board(mask=false) {
    translate([mask ? -security: 0, mask ? -security: 0,mask ? -security: 0]) cube([mask ? width+2*security:width, mask ? deep+2*security:deep, mask ? height+security:height]);
    
    connector(2.5,1.5,height,mask);
    connector(11.5,1.5,height,mask);
    connector(20.5,1.5,height,mask);
    
    translate([22,10,height]) #onoff(mask);
    
    translate([20,23,0]) input(mask);
    
    //top electronics
    translate([3,deep-21,height]) cube([16,21,2]);
 
    //bootom electronics
    translate([(width-26)/2,1,-2]) cube([26,6,2]);
    translate([width-13,0,-2]) cube([11,deep,2]);
    
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
    translate([size/2,mask ? deep+2*size-size/2:  deep+2*size-(size/2-security),1]) rotate([0,90,0]) cylinder(width+size,d=mask ? 1+security: 1-security,$fn=16);
}

difference() {
    cube([width+2*size, deep+2*size, 13]);
    #translate([4,10,0]) cube([28,21.5,9]);
    translate([size,size,-height]) board(true);
    translate([0,0,5]) cube([width+2*size,9.5,10]);
    border(true);
}
translate([7+size, deep-2+size,12]) cylinder(1,d=4,$fn=16);
translate([13.5,10,6.5]) rotate([90,0,0]) linear_extrude(height=1) text("3.3", size=4);
translate([7,10,6.5]) rotate([90,0,0]) linear_extrude(height=1) text("5", size=4);
translate([23.5,10,6.5]) rotate([90,0,0]) linear_extrude(height=1) text("12", size=4);
translate([width+2*size,12,6.5]) rotate([90,0,90]) linear_extrude(height=0.5) text("12", size=4);

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

translate([-10,0,6]) rotate([180,0,0]) button();