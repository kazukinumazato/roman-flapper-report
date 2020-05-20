###########################################################
# Thesis Generator for Creative Informatics
# Author: Yuki Furuta <furushchev@jsk.imi.i.u-tokyo.ac.jp>
# Date: 2015/11/12
###########################################################

TARGET := main

OS := $(shell uname -s)
VERSION := $(shell lsb_release -rs 2> /dev/null)
LATEXMK := $(shell command -v latexmk 2> /dev/null)
LATEXMK_OPTION := -time -recorder -rules
LATEXMK_EXEC := latexmk $(LATEXMK_OPTION)

.PHONY: all install preview clean wipe

all: install
	$(LATEXMK_EXEC) $(TARGET)

preview: install
	$(LATEXMK_EXEC) -pv $(TARGET)

clean: install
	$(LATEXMK_EXEC) -c

wipe: install clean
	$(LATEXMK_EXEC) -C
	git clean -X -f -i -e '.tex' -e '.tex.orig'

install:
ifndef LATEXMK
	@echo 'installing components...'
ifeq ($(OS), Linux)
ifeq ($(VERSION), 14.04)
	sudo apt install -y -qq texlive texlive-lang-cjk texlive-science texlive-fonts-recommended texlive-fonts-extra xdvik-ja dvipsk-ja gv latexmk
else
	sudo apt install -y -qq texlive texlive-lang-cjk texlive-lang-japanese texlive-science texlive-fonts-recommended texlive-fonts-extra xdvik-ja gv latexmk
endif
endif
ifeq ($(OS), Darwin)
	brew tap caskroom/cask && brew cask install -v mactex && sudo tlmgr update --self --all
endif
endif
