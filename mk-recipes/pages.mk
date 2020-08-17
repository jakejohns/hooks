php ?= php

resource_dir ?= resources
views_dir    ?= $(resource_dir)/views
pages_dir    ?= $(views_dir)/pages
page_tpls    ?= $(wildcard $(pages_dir)/*.php)

public_dir ?= public
pages      ?= $(patsubst $(pages_dir)/%.php,$(public_dir)/%.html,$(page_tpls))

bin_dir ?= bin
render  ?= $(bin_dir)/render.php

watch_targets += pages

.PHONY : page-vars
page-vars:
	@echo resource_dir: $(resource_dir)
	@echo views_dir: $(views_dir)
	@echo pages_dir: $(pages_dir)
	@echo page_tpls: $(page_tpls)

.PHONY : pages
pages : $(pages)

$(public_dir)/%.html : $(pages_dir)/%.php $(wildcard $(views_dir)/*)
	$(php) $(render) $(patsubst $(pages_dir)/%,%,$<) > $@

.PHONY : clean-pages
clean-pages :
	rm -f $(pages)
