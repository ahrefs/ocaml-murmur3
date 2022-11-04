#VERSION=$(shell dune exec src/version.exe)
# dune-build-info 3.4.1 requires very recent dune version
# dune-build-info 3.2.0 returns version "n/a"
# low-tech ftw
VERSION=$(shell grep ^version murmur3.opam | tr -d '[a-z: "]')
NAME=ocaml-murmur3-$(VERSION)

all:
	@dune build @install

install: all
	@dune install

clean:
	@dune clean

doc:
	@dune build @doc

.PHONY: release
release:
	git tag -a -m "release $(VERSION)" v$(VERSION)
	git archive --prefix=$(NAME)/ v$(VERSION) | gzip > $(NAME).tar.gz

test:
	@dune runtest
