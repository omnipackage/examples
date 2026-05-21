#!/usr/bin/env bash
# Release every example (or a subset) against the local on-disk repo.
# Generates an ephemeral GPG key and TOP_SECRET_KEY per run; no external secrets.
# Runs every example to completion regardless of failures and prints a summary
# at the end (also appended to $GITHUB_STEP_SUMMARY when set).

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

example=""
distro=""
build_dir=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --example)   example="$2"; shift 2 ;;
    --distro)    distro="$2"; shift 2 ;;
    --build-dir) build_dir="$2"; shift 2 ;;
    *)           echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

if [[ -n "$example" ]]; then
  examples=("$example")
else
  mapfile -t examples < <(find "$SCRIPT_DIR" -mindepth 1 -maxdepth 1 -type d -not -name '.*' -printf '%f\n' | sort)
fi

gpg_key=$(omnipackage gpg generate --name "OmniPackage Examples CI" --email "ci@omnipackage.org" --format base64)
top_secret_key=$(openssl rand -hex 16)

declare -A results

for ex in "${examples[@]}"; do
  printf 'GPG_KEY=%s\nTOP_SECRET_KEY=%s\n' "$gpg_key" "$top_secret_key" > "$SCRIPT_DIR/$ex/.env"

  args=(release .)
  [[ -n "$distro" ]]    && args+=(--distros "$distro")
  [[ -n "$build_dir" ]] && args+=(--build-dir "$build_dir")

  echo ">> $ex ${distro:+($distro)}"
  if ( cd "$SCRIPT_DIR/$ex" && omnipackage "${args[@]}" ); then
    results[$ex]=OK
  else
    results[$ex]=FAIL
  fi
done

summary="## Release summary${distro:+ - \`$distro\`}"$'\n\n| Example | Result |\n|---|---|\n'
failed=0
for ex in "${examples[@]}"; do
  summary+="| $ex | ${results[$ex]} |"$'\n'
  [[ "${results[$ex]}" != "OK" ]] && failed=1
done

echo
echo "$summary"
[[ -n "${GITHUB_STEP_SUMMARY:-}" ]] && echo "$summary" >> "$GITHUB_STEP_SUMMARY"

exit $failed
