
php ?= php

resource_dir ?= resources
style_dir    ?= $(resource_dir)/style
style_src    ?= $(style_dir)/style.scss

public_dir   ?= public
asset_dir    ?= $(public_dir)/assets
css_dir      ?= $(asset_dir)/css
css          ?= $(css_dir)/style.css

pscss    ?=vendor/bin/pscss
pcss_opt ?= --style compressed

watch_targets += css

.PHONY : css-vars
css-vars:
	@echo resource_dir: $(resource_dir)
	@echo styles_dir: $(style_dir)
	@echo style_src: $(style_src)

.PHONY : css
css : $(css)

$(css_dir) :
	mkdir -p $(css_dir)

$(css) : $(style_src) $(style_dir) | $(css_dir)
	$(php) $(pscss) $(pcss_opt) $< > $@
