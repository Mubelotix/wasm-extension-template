#!/bin/sh

rm -rf pkg
wasm-pack build --target=no-modules || exit 1

# Find value of argument --manifest-version
for arg in "$@"; do
  case "$arg" in
    --manifest-version=*)
      manifest_version="${arg#*=}"
      ;;
  esac
done

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
