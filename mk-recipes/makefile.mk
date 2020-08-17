include config/config.mk

.DEFAULT_GOAL := deploy

-include env.mk
include config/composer.mk
include config/css.mk
include config/pages.mk

.PHONY : deploy
deploy : vendor pages css

.PHONY : watch
watch :
	while true; do $(MAKE) -q $(watch_targets) || notify-send "Make" "$$($(MAKE) $(watch_targets))"; sleep 1; done
