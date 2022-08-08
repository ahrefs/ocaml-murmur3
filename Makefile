VERSION=$(shell dune exec src/version.exe)
NAME=murmur3-$(VERSION)

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