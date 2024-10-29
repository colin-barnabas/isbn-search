##
# ISBN SEARCH
#
# @file
# @version 0.1


SHELL = /bin/zsh
.SHELLFLAGS = -o local_options -o rc_quotes -c
VPATH = ./src/:./

.PHONY: all
all: build

.SILENT: isbn-search
isbn.search: isbn.search.asd isbn.lisp
	ros run -- \
		--load $< \
		--eval '(ql:quickload :isbn.search)' \
		--eval '(asdf:make :isbn.search)' --eval '(quit)'

build: isbn.search

# end
