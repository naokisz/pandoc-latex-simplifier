#!/bin/bash

pandoc --wrap=preserve -f markdown $1 -t latex \
	| sed -e '/^\\hypertarget/d' \
	| sed -e 's/\\label.*$//g' \
	| sed -e '/\\tightlist/d' \
	| sed -e '/^$/d' \
	| sed -z -e 's/\\item\n\s*/\\item /g' \
	| sed -e '/^\\subsection/{x;p;x;G}' \
	| sed -e '/^\\section/{x;p;x;G}' \
	| sed -z -e 's/\n\n\n/\n\n/g' \
	| sed -e 's/\\section/\\paragraph/g' \
	| sed -E 's/\\(sub)+section/\\subparagraph/g' \
	| sed -e "s/\\\(/\$/g" \
	| sed -e "s/\\\)/\$/g" \
	| sed -e '/\\def/d' \
	| unexpand -t 2 \
	| latexindent -
