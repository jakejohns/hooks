
php                ?= php
composer           ?= composer
composer_url       ?= https://getcomposer.org/installer
composer_sum_url   ?= https://composer.github.io/installer.sha384sum
composer_installer ?= composer-setup.php
composer_sig       ?= $(composer_installer).sha384sum
download_new       ?= curl --silent --remote-time --output $(2) --time-cond $(2) $(1)

composer_ansi_opt    ?= --no-ansi
composer_install_opt ?= --no-dev \
		--no-interaction --no-plugins --no-progress \
		--no-scripts --no-suggest --optimize-autoloader

vendor : $(composer) composer.lock
	$(php) $(composer) $(composer_ansi_opt) validate
	$(php) $(composer) install $(composer_ansi_opt) $(composer_install_opt)
	@touch vendor

$(composer) : $(composer_sig)
	$(call download_new, $(composer_url), $(composer_installer))
	sha384sum --check $(composer_sig)
	$(php) $(composer_installer) $(composer_ansi_opt) --filename=$(composer)
	rm $(composer_installer)

$(composer_sig) : update_composer_sig

.PHONY : update_composer_sig
update_composer_sig :
	$(call download_new, $(composer_sum_url), $(composer_sig))

.PHONY : clean-composer
clean-composer :
	rm -rf $(composer) $(composer_installer) $(composer_sig)

.PHONY : clean-vendor
clean-vendor :
	rm -rf vendor
