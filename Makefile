#SRC=$(wildcard *.ml)
SRC=src/main.ml
BIN=$(SRC:.ml=.exe)

.SECONDEXPANSION:

.PHONY: all
all: build
	dune exec ./src/main.exe

.PHONY: install
install:
	opam install . --deps-only
	make lock

.PHONY: install-prod
install-prod:
	opam install . --deps-only --lock

.PHONY: lock
lock:
	opam lock

.PHONY: clean
clean:
	dune clean
	rm -f $(BIN) $(SRC:.ml=.cmi) $(SRC:.ml=.cmo)

.PHONY: build
build:
	dune build $(BIN)

.PHONY: utop
utop:
	dune utop lib

.PHONY: test
test:
	dune exec test/test_minty.exe
