#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-}"
if [[ -z "${TAG}" ]]; then
  # fallback: use current ref/tag name if available
  TAG="${GITHUB_REF_NAME:-}"
fi
TAG="${TAG:-unreleased}"

# ---- readiness score (from site/index.html) ----
READINESS="unknown"
if [[ -f "site/index.html" ]]; then
  # matches: <div class="score">100 / 100</div>
  READINESS="$(grep -Eo '[0-9]{1,3} / 100' site/index.html | head -n 1 | awk '{print $1}' || true)"
  READINESS="${READINESS:-unknown}"
fi

# ---- artifacts (expected outputs) ----
ART_LIST=$(
  cat <<'EOF'
- ZH: `build/zh/book.pdf`, `build/zh/book.epub`, `build/zh/book.docx`
- EN: `build/en/book.pdf`, `build/en/book.epub`, `build/en/book.docx`
- Pages snapshot: `site/index.html`
EOF
)

# ---- change summary (previous tag -> current) ----
PREV_TAG=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  # try get previous tag (excluding current if already exists)
  PREV_TAG="$(git tag --sort=-creatordate | grep -E '^v[0-9]+' | grep -v "^${TAG}$" | head -n 1 || true)"
fi

CHANGES=""
if [[ -n "${PREV_TAG}" ]]; then
  CHANGES="$(git log --no-merges --pretty=format:'- %s (%h)' "${PREV_TAG}..HEAD" | head -n 60 || true)"
else
  CHANGES="$(git log --no-merges --pretty=format:'- %s (%h)' HEAD~60..HEAD | head -n 60 || true)"
fi
CHANGES="${CHANGES:-- (no changes detected)}"

# ---- write notes ----
cat > RELEASE_NOTES.md <<EOF
# ${TAG}

**Publication Readiness:** ${READINESS}/100

## Included artifacts
${ART_LIST}

## Changes
${CHANGES}

## Build metadata
- Commit: \`${GITHUB_SHA:-$(git rev-parse --short HEAD 2>/dev/null || echo unknown)}\`
- Workflow: \`${GITHUB_WORKFLOW:-local}\`
- Built at: \`$(date -u +'%Y-%m-%dT%H:%M:%SZ')\`
EOF

echo "==> wrote RELEASE_NOTES.md (tag=${TAG}, readiness=${READINESS})"
