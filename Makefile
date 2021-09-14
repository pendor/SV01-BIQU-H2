oscad		=	SV01-BIQUH2-dual-fan.scad
oscad_bin	=	/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
zip			= sv01-biqu-h2.zip

stl : nozzle-left nozzle-right shroud adapter

nozzle-left: files/sovol-biquh2-nozzle-left.stl
nozzle-right: files/sovol-biquh2-nozzle-right.stl
shroud: files/sovol-biquh2-shroud.stl
adapter: files/sovol-biquh2-adapter.stl

package: stl $(zip)

$(zip): DESCRIPTION.md LICENSE.txt README.txt
	rm -f $(zip)
	zip -r $(zip) files images DESCRIPTION.md LICENSE.txt README.txt

files/sovol-biquh2-%.stl : $(oscad)
	echo "Generating $@ ..."
	$(oscad_bin) -o $@ -D "build=true" -D "part=\"$*\"" $(oscad)
	echo "------------"
