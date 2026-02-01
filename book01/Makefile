# -----------------------------
# ACRE: normalize book language
# -----------------------------
# System locale may be LANG=en_US.UTF-8 etc. Our pipeline only accepts: zh|en
BOOK_LANG ?= $(LANG)

# Common locale -> book lang
ifeq ($(BOOK_LANG),en_US.UTF-8)
  BOOK_LANG := en
endif
ifeq ($(BOOK_LANG),C.UTF-8)
  BOOK_LANG := en
endif
ifeq ($(BOOK_LANG),zh_CN.UTF-8)
  BOOK_LANG := zh
endif
ifeq ($(BOOK_LANG),zh_TW.UTF-8)
  BOOK_LANG := zh
endif

# Fallback: if still not zh/en, default to zh
ifneq ($(filter zh en,$(BOOK_LANG)),$(BOOK_LANG))
  BOOK_LANG := zh
endif

\
SHELL := /usr/bin/env bash

ROOT := $(CURDIR)
LANG ?= zh

MANUSCRIPT := $(ROOT)/manuscript/$(LANG)
BUILD := $(ROOT)/build/$(LANG)

META := $(ROOT)/metadata/book.$(LANG).yml
CSS := $(ROOT)/metadata/style.css
TEX := $(ROOT)/templates/book.tex
DOCX_REF := $(ROOT)/templates/reference.docx

MERGED := $(BUILD)/book_merged.md
PDF := $(BUILD)/book.pdf
EPUB := $(BUILD)/book.epub
DOCX := $(BUILD)/book.docx

.PHONY: all clean merge qa qa-strict pdf epub docx

all: qa-strict pdf epub docx

clean:
	rm -rf $(ROOT)/build

$(BUILD):
	mkdir -p $(BUILD)

merge: $(BUILD)
	@echo "==> Merging chapters (LANG=$(BOOK_LANG))..."
	@python3 scripts/build.py --lang $(BOOK_LANG) --merge-only

qa: merge
	@echo "==> QA (L1) (LANG=$(BOOK_LANG))..."
	@python3 scripts/qa.py --input $(MERGED)

qa-strict: qa pdf epub
	@echo "==> QA_STRICT (L1+L2) (LANG=$(BOOK_LANG))..."
	@python3 scripts/qa_strict.py --lang $(BOOK_LANG) --config config/qa_rules.yml

pdf: merge
	@echo "==> Building PDF (LANG=$(BOOK_LANG))..."
	@pandoc $(MERGED) \
		--metadata-file $(META) \
		--pdf-engine=xelatex \
             --no-highlight \
             --include-in-header=config/pandoc_highlighting.tex \
		--template $(TEX) \
		--output $(PDF)

epub: merge
	@echo "==> Building EPUB (LANG=$(BOOK_LANG))..."
	@pandoc $(MERGED) \
		--metadata-file $(META) \
		--css $(CSS) \
		--toc --toc-depth=3 \
		--output $(EPUB)

docx: merge
	@echo "==> Building DOCX (LANG=$(BOOK_LANG))..."
	@pandoc $(MERGED) \
		--metadata-file $(META) \
		--reference-doc $(DOCX_REF) \
		--output $(DOCX)

.PHONY: baseline-init
baseline-init: qa pdf epub
	@echo "==> Baseline init (LANG=$(BOOK_LANG))..."
	@python3 scripts/qa_engine.py --lang $(BOOK_LANG) --config config/qa_rules.yml --json build/$(BOOK_LANG)/qa_report.json
	@cp -f build/$(BOOK_LANG)/qa_report.json build/$(BOOK_LANG)/qa_baseline.json
	@echo "==> baseline saved: build/$(BOOK_LANG)/qa_baseline.json"

.PHONY: dashboard
dashboard:
	@python3 scripts/dashboard.py

.PHONY: release
release: qa-strict dashboard
	@python3 scripts/release.py


.PHONY: apple-books-package apple-books-verify apple-books-upload
apple-books-package: epub
	@python3 scripts/apple_books_package.py

apple-books-verify: apple-books-package
	@ACRE_APPLE_MODE=verify python3 scripts/apple_books_transporter.py

apple-books-upload: apple-books-package
	@ACRE_APPLE_MODE=upload python3 scripts/apple_books_transporter.py

.PHONY: help
help:
	@echo "ACRE Publishing OS targets:"
	@echo ""
	@awk -F: ' \
	  /^[A-Za-z0-9][A-Za-z0-9_.\/-]*:([^=]|$$)/ { \
	    t=$$1; \
	    if (t !~ /^(\.PHONY|\.SUFFIXES|\.DEFAULT|\.PRECIOUS|\.INTERMEDIATE|\.SECONDARY)$$/) print "  - " t \
	  }' Makefile | sort -u

# Friendly aliases
.PHONY: docs site publish verify

docs: dashboard
site-old: dashboard

publish: release

verify: qa qa-strict

# -----------------------------
# Pages/site output (stable)
# -----------------------------
.PHONY: site
site: dashboard ## Build Pages site into ./site
	@mkdir -p site
	@cp -f build/readiness.html site/index.html
	@mkdir -p site/assets
	@cp -rf assets/* site/assets/ 2>/dev/null || true
	@echo "==> site generated: site/index.html"

# -----------------------------
# Quality gate
# -----------------------------
.PHONY: readiness-gate
readiness-gate-old: dashboard ## Fail if readiness score != 100
	@S=$$(python scripts/dashboard.py 2>/dev/null | sed -n 's/^Readiness score: //p' | tail -n 1); \
	if [ "$$S" != "100" ]; then \
	  echo "Readiness gate failed: $$S (expected 100)"; \
	  exit 1; \
	fi; \
	echo "Readiness gate passed: $$S"

# -----------------------------
# Quality gate
# -----------------------------
.PHONY: readiness-gate
readiness-gate: dashboard ## Fail if readiness score != 100
	@S=$$(python scripts/dashboard.py 2>/dev/null | sed -n 's/^Readiness score: //p' | tail -n 1); \
	if [ "$$S" != "100" ]; then \
	  echo "Readiness gate failed: $$S (expected 100)"; \
	  exit 1; \
	fi; \
	echo "Readiness gate passed: $$S"
