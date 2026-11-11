#!/bin/sh
set -eu

hadolint Dockerfile
shellcheck .githooks/pre-commit scripts/check-infrastructure.sh
prettier --check README.md docs/ESTILO.md compose.yaml .github/workflows/ci.yaml .prettierrc.json

test "$(node --version)" = 'v26.13.0'
test "$(npm --version)" = '11.20.0'
ng version
