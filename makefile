files=testfiles/*.pdf

cpdf=tmp/cpdf-binaries-master/OSX-Intel/cpdf
itext=tmp/itext
installed=tmp/installed.txt

# compile itext Merge
CLASSPATH="tmp/itext/itextpdf-5.5.5.jar"

jc=javac -cp .:$(CLASSPATH) -Xlint:deprecation
j=java -cp .:$(CLASSPATH)


test: install Merge.class
	pdftk $(files) output tmp/output_preload.pdf # load files to memory for accurate result

	time pdftk $(files) output tmp/output_pdftk.pdf
	time $(cpdf) $(files) -o tmp/output_cpdf.pdf
	time $(j) Merge $(files) tmp/output_itext.pdf
	time qpdf --empty tmp/output_qpdf.pdf --pages $(files) 1-z --
	echo "ghostscript is really slow" # time gs -o tmp/output_gs.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress $(files)
	ruby check_page.rb

install: $(installed)

$(installed): $(cpdf) pdftk qpdf $(itext)
	touch $(installed)

pdftk:
	echo "Get pdftk from: https://www.pdflabs.com/tools/pdftk-server/"
qpdf:
	brew install qpdf
ghostscript:
	brew install ghostscript
$(cpdf):
	wget -O tmp/cpdf.zip https://codeload.github.com/coherentgraphics/cpdf-binaries/zip/master
	cd tmp && tar -xvvf cpdf.zip
$(itext):
	wget -O tmp/itext.zip http://downloads.sourceforge.net/project/itext/iText/iText5.5.5/itext-5.5.5.zip
	mkdir -p tmp/itext
	cd tmp && tar -xvvf itext.zip -C itext


%.class: %.java
	$(jc) $<

clean:
	rm -rf tmp/*.pdf
