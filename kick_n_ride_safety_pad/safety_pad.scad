// kube 54x61x19
cube_width = 54;
cube_depth = 61;
cube_height = 19;

slisse_diam = 18.5;
slisse_height = 14;
slisse_depth = 33;

spor_tykkelse = 1.6;
spor_dybde = 3.8;

SlisseSpor_bredde = 5.5;

module Slisse (diam, height, depth) {
    cylinder(h = height, d = diam, center = true);
    translate([0, depth/2, 0]) {
        cube([diam, depth, height], center = true);
    }
    
};

module Spor (tykkelse, dybde) {
    translate_z = -(cube_height/2)-(tykkelse/2) + 0.1;
    translate_y = cube_depth/2 + (dybde/2) - 15.5;
    translate([0, translate_y, translate_z]) {
        cube([18.8, dybde, tykkelse], center = true);
    }
};

module SlisseSpor (bredde) {
    height = cube_height - slisse_height + 5;
    translate_y = cube_depth/2 - slisse_depth / 2;
    translate([0, bredde/2 + 0.3, -slisse_height/2]) {
        cylinder(h = height, d = bredde, center = true);
    }
    translate([0, translate_y, -slisse_height/2]) {
        cube([bredde, slisse_depth - 10, height], center = true);
    }
    translate([0, bredde/2 + slisse_depth - 10.5, -slisse_height/2]) {
        cylinder(h = height, d = bredde, center = true);
    }
};

module Cutaway(vinkel = 45, translate_y = 0, translate_z = 0, translate_x = 0, vector = [1,0,0]) {
    rotate(a=-vinkel, v=vector) {
        translate([translate_x, translate_y, translate_z]) {
            #cube([cube_width+10, cube_depth, 15], center = true);
        }    
    }
};


difference() {
    cube([cube_width, cube_depth, cube_height], center = true);
    translate([0, 0, ((cube_height - slisse_height) / 2) + 0.01]) {
        Slisse(slisse_diam, slisse_height, slisse_depth);
    }
    SlisseSpor(bredde = SlisseSpor_bredde);
    Cutaway(vinkel=15, translate_y = cube_depth / 2 - 20, translate_z = 12);
    Cutaway(vinkel=-45, translate_y = -40, translate_z = 34);
    Cutaway(translate_y = -30, translate_z = 30, translate_x = -10, vector = [0,1,0]);
    Cutaway(vinkel = -45, translate_y = -30, translate_z = 30, translate_x = 20, vector = [0,1,0]);
};
difference() {
   Spor(tykkelse = spor_tykkelse, dybde = spor_dybde);
    translate([0, 15, -10]) {
        cube([SlisseSpor_bredde,15,10], center = true);
    }
}

