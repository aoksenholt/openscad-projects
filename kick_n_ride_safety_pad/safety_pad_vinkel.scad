bredde = 18.4;
hoyde = 9;
diameter = 16;
diameter_hull = 5;

module Base() {
    translate([0, -diameter/3+0.65, 0]) {
        #cube([diameter, diameter/2, hoyde], center = true);
    }
    difference() {
        cylinder(h = hoyde, d = diameter, center = true);
    }
}

module Hull() {
    translate([0, (diameter / 2) - 6.5, 0]) {
        cylinder(h = hoyde + 0.5, d = diameter_hull, center=true);
    }

}

module Cutaway() {
        translate([0, 2, 5]) {
        rotate([-30, 0, 0]) {
            cube([bredde, bredde, hoyde], center = true);
        }
        
    }
}

difference() {
    Base();
    Hull();
    Cutaway();
}

