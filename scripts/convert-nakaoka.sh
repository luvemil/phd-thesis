#!/bin/bash

perl -i -lnpe '
s/\\mathcal{X}/\\mathscr{C}/g or
s/\\mathcal{A}/\\mathscr{A}/g or
s/\\mathbb{t}/\\mathbbm{t}/g or
s/\\cref/\\ref/g or
s/\\H(?![a-zA-Z])/\\clH/g
' $1
