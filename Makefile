IMAGESIN=$(wildcard notebooks/images/*)
IMAGESOUT=$(patsubst notebooks/%,slides/%,$(IMAGESIN))
NBFILES=$(wildcard notebooks/*-*.ipynb)
HTMLFILES=$(patsubst notebooks/%.ipynb,slides/%.slides.html,$(NBFILES))

slides: html

images: slides/images $(IMAGESOUT)

slides/images:
	mkdir -p slides/images

$(IMAGESOUT): slides/images/%: notebooks/images/%
	cp -a $< $@

html: images $(HTMLFILES)

$(HTMLFILES): slides/%.slides.html: notebooks/%.ipynb
	bash scripts/generate_slides.sh $<

clean:
	rm -rf slides/
