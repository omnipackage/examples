#!/usr/bin/env bash
# Release every example (or a subset) against the local on-disk repo.
# Generates an ephemeral GPG key and TOP_SECRET_KEY per run; no external secrets.
#
# Usage:
#   ./release_examples.sh                              # all examples, all distros
#   ./release_examples.sh --example go                 # one example, all distros
#   ./release_examples.sh --distro debian_12           # all examples, one distro
#   ./release_examples.sh --example go --distro debian_12
#   ./release_examples.sh --build-dir /tmp/omp-build   # custom build dir
#   ./release_examples.sh --fail-fast                  # stop on first failure

set -euo pipefail

ALL_EXAMPLES=(c_makefile c_with_secrets crystal electron go python ruby rust tauri)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

example=""
distro=""
build_dir=""
fail_fast=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --example)    example="$2"; shift 2 ;;
    --distro)     distro="$2"; shift 2 ;;
    --build-dir)  build_dir="$2"; shift 2 ;;
    --fail-fast)  fail_fast=1; shift ;;
    -h|--help)    sed -n '2,12p' "$0"; exit 0 ;;
    *)            echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

if [[ -n "$example" ]]; then
  examples=("$example")
else
  examples=("${ALL_EXAMPLES[@]}")
fi

echo ">> generating ephemeral GPG key and TOP_SECRET_KEY"
gpg_key=$(omnipackage gpg generate --name "OmniPackage Examples CI" --email "ci@omnipackage.org" --format base64)
top_secret_key=$(openssl rand -hex 16)

failures=()

for ex in "${examples[@]}"; do
  ex_dir="$SCRIPT_DIR/$ex"
  if [[ ! -d "$ex_dir" ]]; then
    echo "!! no such example: $ex" >&2
    exit 2
  fi

  printf 'GPG_KEY=%s\nTOP_SECRET_KEY=%s\n' "$gpg_key" "$top_secret_key" > "$ex_dir/.env"

  args=(release .)
  [[ -n "$distro" ]]    && args+=(--distros "$distro")
  [[ -n "$build_dir" ]] && args+=(--build-dir "$build_dir")

  echo ">> $ex ${distro:+($distro)}"
  if ( cd "$ex_dir" && omnipackage "${args[@]}" ); then
    echo ">> $ex: OK"
  else
    echo "!! $ex ${distro:+($distro)}: FAILED" >&2
    failures+=("$ex${distro:+/$distro}")
    if [[ $fail_fast -eq 1 ]]; then
      break
    fi
  fi
done

if (( ${#failures[@]} > 0 )); then
  echo
  echo "FAILED: ${failures[*]}" >&2
  exit 1
fi

echo
echo "all good"
