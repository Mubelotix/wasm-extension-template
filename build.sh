#!/bin/sh

command -v cargo >/dev/null 2>&1 || { echo >&2 "Installing cargo..."; curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh; }
command -v wasm-pack >/dev/null 2>&1 || { echo >&2 "Installing wasm-pack..."; cargo install wasm-pack; }

rm -rf pkg

# Find value of argument --manifest-version
for arg in "$@"; do
  case "$arg" in
    --manifest-version=*)
      manifest_version="${arg#*=}"
      ;;
  esac
done

# Find whether release was passed
for arg in "$@"; do
  case "$arg" in
    --release)
      release=true
      ;;
  esac
done

# Build for release or debug
if [ "$release" = true ]; then
  wasm-pack build --target=no-modules --release || exit 1
else
  wasm-pack build --target=no-modules --dev || exit 1
fi

# Copy manifest.json to pkg
if [ "$manifest_version" = "v3" ] || [ "$manifest_version" = "3" ]; then
  cp manifest_v3.json pkg/manifest.json
else if [ "$manifest_version" = "v2" ] || [ "$manifest_version" = "2" ]; then
  cp manifest_v2.json pkg/manifest.json
else
  echo "Packaging with manifest version v2. Pass --manifest-version=v3 to package with manifest version 3."
  cp manifest_v2.json pkg/manifest.json
  fi
fi

printf "
const runtime = chrome.runtime || browser.runtime;

async function run() {
  await wasm_bindgen(runtime.getURL('{{crate_name}}_bg.wasm'));
}

run();
" >> pkg/run_wasm.js
