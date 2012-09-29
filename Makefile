# See LICENSE for licensing information.

PROJECT = erlexec

DIALYZER = dialyzer
REBAR = rebar

all:
	@$(REBAR) compile

clean:
	@$(REBAR) clean

docs: all clean-docs
	@$(REBAR) doc skip_deps=true

clean-docs:
	rm -f doc/*.{css,html,png} doc/edoc-info

gitdocs:
	git checkout gh-pages
	git checkout master src include c_src Makefile
	make docs
	make clean
	git rm -fr ebin src include c_src Makefile
	mv doc/* .
	rmdir doc
	if git commit -a; then ; git push origin; else ; ret=1; git reset --hard; fi; git checkout master

