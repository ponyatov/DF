# var
MODULE = $(notdir $(CURDIR))

# src
D += $(wildcard src/*.d)
J += dub.json
F += $(wildcard lib/*.df)

# all
.PHONY: all run
all: bin/$(MODULE)
run: $(F)
	dub run -- $^

# rule
bin/$(MODULE): $(D) $(J)
	dub build

# format
.PHONY: format
format: tmp/format_d
tmp/format_d: $(D)
	dub run dfmt -- -i $? && touch $@

# install
.PHONY: install update
install:
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.txt`
