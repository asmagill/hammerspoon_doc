MODULE = doc
PREFIX ?= ~/.hammerspoon/hs/_asm

LUAFILE  = init.lua
DOC_FILE = hs._asm.$(MODULE).json

all:

install: install-lua

install-lua: $(LUAFILE)
	mkdir -p $(PREFIX)/$(MODULE)
	install -m 0644 $(LUAFILE) $(PREFIX)/$(MODULE)

docs: $(DOC_FILE)

install-docs: docs
	mkdir -p $(PREFIX)/$(MODULE)
	install -m 0644 $(DOC_FILE) $(PREFIX)/$(MODULE)

$(DOC_FILE): $(LUAFILE) $(OBJFILE)
	find . -type f \( -name '*.lua' -o -name '*.m' \) -not -name 'template.*' -not -path './_*' -exec cat {} + | __doc_tools/gencomments | __doc_tools/genjson > $@

clean:
	rm -fr $(DOC_FILE)

uninstall:
	rm -v -f $(PREFIX)/$(MODULE)/$(LUAFILE)
	rm -v -f $(PREFIX)/$(MODULE)/$(DOC_FILE)
	rmdir -p $(PREFIX)/$(MODULE) ; exit 0

.PHONY: all clean uninstall
