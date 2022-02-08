slides: slides/.finished
slides/.finished: $(wildcard notebooks/**/*)
	bash scripts/generate_slides.sh
	touch slides/.finished

clean:
	rm -rf slides/
