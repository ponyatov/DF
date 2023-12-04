# var
MODULE  = $(notdir $(CURDIR))
module  = $(shell echo $(MODULE) | tr A-Z a-z)
OS      = $(shell uname -o|tr / _)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
CORES  ?= $(shell grep processor /proc/cpuinfo | wc -l)

# tool
CURL = curl -L -o

# src
D += $(wildcard src/*.d)
J += dub.json
F += $(wildcard lib/*.df)

# all
.PHONY: all run
all: bin/$(module)
run: $(F)
	dub run -- $^

# rule
bin/$(module): $(D) $(J)
	dub build

# format
.PHONY: format
format: tmp/format_d
tmp/format_d: $(D)
	dub run dfmt -- -i $? && touch $@

# doc
doc: doc/yazyk_programmirovaniya_d.pdf doc/Programming_in_D.pdf \
     doc/BuildWebAppsinVibe.pdf doc/BuildTimekeepWithVibe.pdf

doc/yazyk_programmirovaniya_d.pdf:
	$(CURL) $@ https://www.k0d.cc/storage/books/D/yazyk_programmirovaniya_d.pdf
doc/Programming_in_D.pdf:
	$(CURL) $@ http://ddili.org/ders/d.en/Programming_in_D.pdf
doc/BuildWebAppsinVibe.pdf:
	$(CURL) $@ https://raw.githubusercontent.com/reyvaleza/vibed/main/BuildWebAppsinVibe.pdf
doc/BuildTimekeepWithVibe.pdf:
	$(CURL) $@ https://raw.githubusercontent.com/reyvaleza/vibed/main/BuildTimekeepWithVibe.pdf

# install
.PHONY: install update
install: doc
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.txt`

# merge
MERGE += Makefile LICENSE apt.txt $(D) $(J) $(F)
MERGE += .clang-format .editorconfig
MERGE += .gitattributes .gitignore .stignore
MERGE += bin doc lib inc src tmp

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)
#	$(MAKE) doxy ; git add -f docs

.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	git pull -v

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) shadow

ZIP = tmp/$(MODULE)_$(NOW)_$(REL)_$(BRANCH).zip
zip:
	git archive --format zip --output $(ZIP) HEAD
