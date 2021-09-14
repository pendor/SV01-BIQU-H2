// Higher definition curves
//$fs = 0.01;


build=false;
part="all";

if(!build) {
  $fn=16;
  
  // Show the original SV-01 gantry plate
  //translate([-50, 0, -60]) rotate([90,0,0]) import("imports/Sovol_SV01_Carriage_Bracket.stl");

  // Show the BIQU-H2 extruder
  translate([10,-14.5,0]) extruder();

  adapter();
  shroud();
  nozzles("both");
//  wireguide();
  
} else {
  $fn=64;
  if(part == "adapter") {
    adapter();
  } else if(part == "shroud") {
    shroud();
  } else if(part == "nozzle-left") {
    nozzles("left");
  } else if(part == "nozzle-right") {
    nozzles("right");
  } else if(part == "wireguide") {
    wireguide();
  } else {
    echo("Unknown part:");
    echo(part);
  }
}

nozzle_z_min = -1.4;
nozzle_height = 3;
nozzle_width = 14;
duct_fitting_height = 3.5;

lduct_size = [15.8, 9.2, 5];
lduct_pos = [42.9, -45.2, 5.8];

lnoz_size = [1, nozzle_width, nozzle_height];
lnoz_pos = [52, -72, nozzle_z_min];

lnoz_rot = [0,20,0];


rduct_size = lduct_size;
rduct_pos = [85.3, -45.2, 5.8];

rnoz_size = lnoz_size;
rnoz_pos = [93, -72, nozzle_z_min];

rnoz_rot = [0,-20,0];

mounting_size = [7,11,4];

module nozzles(side) {
  if(side == "right" || side == "both") {
    minkduct(duct_fitting_height, rduct_size, rduct_pos, rnoz_size, rnoz_pos, rnoz_rot, 1);
  }


  if(side == "left" || side == "both") {
    minkduct(duct_fitting_height, lduct_size, lduct_pos, lnoz_size, lnoz_pos, lnoz_rot, 0);
  }
}

module wireguide() {
  translate([33, -46.8, 83.2]) {
    
    difference() {
    import("imports/BIQU_H2_Kabelhalter_für_B.W._sein_Halter_reducedfaces_repaired.3mf");
    translate([27,15,-8]) cube([26, 12, 30]);
    }
    // This might be a problem for an XT-60 connector...    
    //translate([32,30.5,4.5]) cube([16, 2, 50]);
  }
}

module minkduct(dheight, in_size, in_pos, out_size, out_pos, noz_rot, noz_on_left) {
  
  difference() {
    union() {
      minkowski() {
        translate([0,0,dheight])
        translate(in_pos)
        cube(in_size);
        sphere(.6);
      }
      
       // Alignment on the screw tab
       translate([(noz_on_left ? in_size[0]  : - mounting_size[0]), 
      3.8, 1.1])
      translate(in_pos)
      cube([7,5.9,7]);
      
      // Tab for mounting screw
      difference() {
        translate([
          (noz_on_left ? in_size[0]  : - mounting_size[0]), 
          -1.3, 
          1.1]
        )
        translate(in_pos)
        cube(mounting_size);
      translate([(noz_on_left ? in_size[0] + 2.6 : -2.6), in_size[1] - 7.5, 4])
        translate(in_pos)
        cylinder(r=3/2+.1, h=mounting_size[2]+3, center=true);
        
      }
    
      difference() {
        minkowski() {
          hullduct(in_size, in_pos, out_size, out_pos, noz_rot);
          sphere(1);
        }
        hullduct(in_size, in_pos, out_size, out_pos, noz_rot);
        
        translate(noz_on_left ? [-3,0,-1] : [0,0,0])
        translate(out_pos) 
        rotate(noz_rot)
        cube([3, nozzle_width, nozzle_height]);
        
      }
    }
    
    scale([1,1,1.5])
    translate([0,0,dheight-4.2])
    translate(in_pos)
    cube(in_size);
  }
}



module hullduct(in_size, in_pos, out_size, out_pos, noz_rot) {
  hull() {
    translate(in_pos)
    cube(in_size);
  
    translate(out_pos)
    rotate(noz_rot)
    cube(out_size);
  }
}


module adapter() {
  union() {  
    difference() {  
      //  color("blue")  
      union() {
        translate([-50, 0, -60])
        rotate([90,0,0])
        import("imports/BIQU-AdapterPlatte.stl");

        translate([61.7,-31.5,35])
        roundedcube(size=[28,6,56], radius=1);
        
        // Fill in existing H2 mounts
        translate([81,-31.5,22])
        cube([8,6,8]);
        
        // Alignment forks for the Ender plate
        translate([34, -31.5, 22]) cube([4,6,12]);
        translate([43.4, -31.5, 22]) cube([4,6,12]);
        translate([98, -31.5, 28.1]) cube([12,6,4]);
        translate([92, -31.5, 18.8]) cube([18,6,4]);
      } 

      translate([83.6, -16.5, 85.1]) threadedInsert(3);
      translate([62.1, -16.5, 85.1]) threadedInsert(3);
      
      translate([36.9, -15.3, 59.85])threadedInsert(3);
      translate([72.1, -15.3, 59.85]) threadedInsert(3);
    }
  }
}


// Move it into position then right by 10 to miss SV01 adapter's mounts
module shroud() {
  translate([10,-14.5,0]) 
  union() {
  difference() {
    //color("red")
      translate([23,-32,3.2])
    difference() {
      union() {
        import("imports/BIQU_H2_Halterung_repaired.3mf");
        
        // Pedestals for higher screws
        translate([-.5, 5, 52.8]) cube([8,10,7.5]);
        translate([67, 5, 52.8]) cube([8,10,7.5]);
                
        // Ramps up to pedestals
        translate([-.5, 15, 52.8]) rotate([180,0,0]) prism(8, 5.4, 4);
        translate([67, 15, 52.8]) rotate([180,0,0]) prism(8, 5.4, 4);

        // Zip tie points (back)
        translate([2.5, 13, 60]) rotate([0,0,90]) tiedown();

        translate([32, 9.4, 45.6]) tiedown();  
        translate([46, 9.4, 45.6]) tiedown();

        translate([39, 6.8, 80.4]) tiedown();

        translate([76.9, 8, 50.5]) rotate([0,0,90]) tiedown();

        // Zip tie points (front)
//        translate([39, -1.7, 70]) rotate([0,90,0]) tiedown();
        
        // Fill in existing lower mounting holes
        translate([28, 0, 34.35]) cube([8,15,9]);
        translate([42, 0, 34.35]) cube([8,15,9]);
        
        // Tounges to go into the alignment forks 
        // (Note .2 smaller than matching slot)
        translate([5.3,4.9,19.7]) cube([4.8, 16, 8]);
        translate([68,4.9,19.65]) cube([8, 16, 4.8]);
        
        
        // Extra bracketing on both edges
        translate([-2.9, 1, 7.85]) cube([5, 7, 40]);        
        translate([75.4, 2, 7.85]) cube([4.5, 8, 40]);
        
        
        // Add thickness to back middle wall
        translate([25, 5, 34]) cube([28, 2, 44]);
        
        
        // Add thickness & support ramp to fan side wall
        translate([-2.9,5,19.5]) cube([13.5, 4.9, 37]);
        translate([-2.9, 9.9, 19.5]) rotate([180,0,0]) prism(13.1, 5, 4.23);
        
        // Add thickness to extruder side wall
        translate([66.7, 5, 19.65]) cube([9, 4.9, 28]);        
        translate([66.7, 5, 47]) cube([8.2, 4.9, 2]);
        translate([67.7, 9.9, 19.5]) rotate([180,0,0]) prism(10, 5, 4.23);
        
        
  
        // Ramps up to top screw holes for less support
        translate([24, 5, 76.5]) cube([10, 10, 3.5]);
        translate([24, 15, 76.5]) rotate([180,0,0]) prism(10, 8, 4);
  
        translate([45.5, 5, 76.5]) cube([10, 10, 3.5]);
        translate([45.5, 15, 76.5]) rotate([180,0,0]) prism(10, 8, 4);
  
  
        
        // Original ducts for height reference
        //import("imports/Luft_Düse_Rechts.stl");
        //import("imports/Luft_Düse_Links.stl");

        
        // Screws break preview, but work in full
        // render.  So show as green stubs in preview
        // but difference them out properly for render.
        if(!build) {
          translate([4, 27.9, 56.8]) screw(3);
          translate([71, 27.9, 56.8]) screw(3);
        } 
      }
      // New higher screw holes      
      if(build) {
        translate([4, 27.9, 56.8]) screw(3);
        translate([71, 27.9, 56.8]) screw(3);
      }
    }
  }
}

}

module tiedown() {
  rotate([0,90,0])
  difference() {
    roundedcube([7,6,4], center=true);
    roundedcube([5,4,4.2], center=true);
  }
}

module extruder() {
  color("green")
  translate([110.3,-32,53.3])
  rotate([0,-90,0])
  rotate([0,0,-90])
  translate([0,-60,0])
  union() {
    import("imports/h2model/Biqu_H2_-_Biqu_H2_Motor-1.STL");
    import("imports/h2model/Biqu_H2_-_Biqu_H2_Interface_Moteur-1.STL");
    import("imports/h2model/Biqu_H2_-_Biqu_H2_Heatsink-1.STL");
    import("imports/h2model/Biqu_H2_-_Phaetus_HB-1.STL");
    import("imports/h2model/Biqu_H2_-_HeatBreak-1.STL");
    import("imports/h2model/Biqu_H2_-_Silicone_Sock-1.STL");    
    import("imports/h2model/Biqu_H2_-_3511_Fan-1.STL");
    import("imports/h2model/Biqu_H2_-_Biqu_H2_Bras-1.STL");
    import("imports/h2model/Biqu_H2_-_E3D_V6_Nozzle_0.4mm-1.STL");

    // Plane for the bed for testing:
    // rotate([90,0,0]) cube([100,100,1]);
  }
}

// Hole for inserting a threaded insert
module threadedInsert(screw_dia) {
  color("green")
  rotate([90,0,0])  
  cylinder(h=28, r=((screw_dia + 1)/2) + .2);
}

// Screw with a countersunk hole
module screw(screw_dia) {
  color("green")
  rotate([90,0,0])  
  union() {
    cylinder(h=28, r=(screw_dia + .2)/2);
    translate([0,0,26]) 
    cylinder(h=2, r=(screw_dia + .6));
  }
}

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}

 module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
       
       }
