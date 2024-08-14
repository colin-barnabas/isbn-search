##
# ISBN SEARCH
#
# @file
# @version 0.1


SHELL = /bin/zsh
.SHELLFLAGS = -o local_options -o rc_quotes -c

.PHONY: all
all: build

.SILENT: isbn-search
isbn-search: isbn-search.lisp
	ros run -Q \
		-s cl-ascii-table \
		-s cl-cookie \
		-s cl-ppcre \
		-s clingon \
		-s dexador \
		-s lquery \
		-s plump \
		-- \
		--load $< \
		--eval '(save-lisp-and-die "$@" :toplevel #''isbn:main :executable t :compression t)'

build: isbn-search

# end
