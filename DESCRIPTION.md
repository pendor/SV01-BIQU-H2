This thing allows mounting a BIQU-H2 extruder to a Sovol SV-01 original gantry plate with dual rear-mounted part cooling fans and an integrated BLTouch mount.  I created this because I found when I installed the excellent [Hero Yourself kit by FullmoonCat](https://www.thingiverse.com/thing:4870742), my PLA curling issues were fixed as if by magic.  The extra cooling of two well-targeted 5015 fans fixed my print.  Switching to an H2 extruder, I wasn't able to find a dual-fan solution which fit the SV-01.  

I initially found [thro42's adapter for the H2 on an SV-01](https://www.thingiverse.com/thing:4890363), and that worked pretty well.  Losing the extra cooling however put me back in PLA curling territory.  The fan duct blocked a lot of visibility and access for calibration.  The BLTouch felt like a sitting duck way out in front.

Then I found [windischb's H2 mount for the Ender 6](https://www.thingiverse.com/thing:4762042), and I started to salivate.  Dual fans, mounted up high and ducted down so they don't block visibility, integrated (and I'd dare to call it "armored") BLTouch mounting that was super close to the extruder point and fully protected by plastic on all sides.  Only problem is I don't have an Ender 6.  What's to do but fire up OpenSCAD and proceed to make a mockery of thro42 & windischb'2 elegant designs...

I used OpenSCAD to nip & tuck the original STL's rather than try to get them both functional in FreeCAD or sell my soul to Autodesk.  I'm not proud of the process, but the result works...  Also used were a [dummy model of the BIQU H2 by 3D_LC](https://www.thingiverse.com/thing:4740224) and the [SV-01 gantry plate by MadHatter3D](https://www.thingiverse.com/thing:4070979).  Those aren't included in the final rendered model, only used for alignment during design.

This upload contains only the final STL files for this design.  The full "source" including STL's from the several remixed things and OpenSCAD source are available in [Github](https://github.com/pendor/SV01-BIQU-H2).  I didn't include all of that here since Thingiverse's upload format seems to limit what can be included.  

The rendered pieces include:

    * sovol-biquh2-adapter.stl - A modified version of thro42's mounting plate
    * sovol-biquh2-shroud.stl - The fan ducting which attaches between the adapter and the H2
    * sovol-biquh2-nozzle-{left|right}.stl - Left & right ducts which are attached with screws to the main shroud.  Printed separately because the thing already needs more than enough supports to print...

So why the two-layer adapter plate?  I'm lazy & it worked.  The duct locations in windischb's Ender mount don't line up well with the original mounting screws on the SV-01 gantry.  Using that mount directly would require either re-working the duct locations or driving screws right through the air ducts.  The two-piece approach also allows mounting the H2 and zip-tying all the wiring down nice and neat with the shroud as a separate part you can work on more easily.  Once everything is in place and bundled up tight, four screws, and you're done.  No trying to tuck wiring into the right place as you're contorting yourself around the printer and carefully tightening screws to not pinch anything.

The main changes I made to windischb's mount are:

    * Added some zip tie points to cinch down wiring.
    * Thickened some parts for reinforcement.  My first print started separating along the thinnest part.
    * Moved the screws around to meet up with exposed spots on the adapter plate.
    * Added sloping ramps up to some of the protrusions on the back so as to print with fewer supports.
    * Designed new fan nozzles that get closer to the part and put more air where it needs to be.  I don't have the skill to do any kind of flow analysis on these, so I'm just guessing / making it up.
    
The changes to thro42's adapter plate were much simpler.  I added additional screw holes (and filled some I didn't need) to enable inserting threaded inserts to match the shroud.  I also added some forked alignment tabs to the bottom edge of both pieces to keep things a little tighter even with all the screw points relatively high up on the model.

All told, this works pretty well.  It went together easily, cools my parts, and I'm really happy with it.

Print Settings:

See Cura screenshots for best orientation.  You'll need to rotate the adapter plate and cooling ducts.

Material: ABS

Supports: Yes.  You'll probably need some blockers on the bottom of the shroud to prevent the duct mounting & screws from getting filled up.  Also on the top of the shroud to prevent generated supports that aren't needed with the sloping build up to the screw pedestals.  Tree supports touching build plate only in Cura worked well for me.  

Infill: 40% Gyroid