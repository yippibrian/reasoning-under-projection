# Top-level Makefile for the paper stack

SHELL := /bin/bash

LATEXMK := latexmk
LATEXMK_FLAGS := -pdf -interaction=nonstopmode -halt-on-error

# All canonical .tex entry points
TEX_FILES := \
	reasoning-under-projection.tex

PDF_FILES := $(TEX_FILES:.tex=.pdf)

.PHONY: all clean distclean list

all: $(PDF_FILES)

list:
	@printf "%s\n" $(TEX_FILES)

# Build each PDF in its own directory
%.pdf: %.tex
	@echo "Building $<"
	@cd $(dir $<) && $(LATEXMK) $(LATEXMK_FLAGS) $(notdir $<)

clean:
	@for f in $(TEX_FILES); do \
		d=$$(dirname $$f); \
		t=$$(basename $$f); \
		echo "Cleaning intermediate files in $$d"; \
		cd $$d && $(LATEXMK) -c $$(basename $$t) && cd - >/dev/null; \
	done

distclean: clean
	@for f in $(TEX_FILES); do \
		pdf="$${f%.tex}.pdf"; \
		echo "Removing $$pdf"; \
		rm -f "$$pdf"; \
	done
