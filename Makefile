JAVA = java
CLOSURE_COMPILER = $(JAVA) -jar ~/.bin/compiler.jar
FILES_JS = src/*.js
PORT = 8080

help: ## Show this help.
		@echo "\
		<desctiption>\n\
		\n\
		Usage: make [options] [target] ...\n\
		Targets:"; \
		fgrep -h '##' Makefile | awk -F'##|:' '{printf "%40s %s\n", $$1, $$3}' | fgrep -v 'fgrep'

task\:watch\:js: build/main.js ## Watching changes in javascript
	@sh -c "trap exit TERM;tail -f $(FILES_JS) | while read line; \
		do \
			$(CLOSURE_COMPILER) --js_output_file build/main.js $(FILES_JS); \
		done"

run:
	@sh -c "trap exit TERM;python -m SimpleHTTPServer $(PORT) build/"

.PONY: help
