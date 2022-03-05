#!/bin/sh

rm -rf pkg
wasm-pack build --target=no-modules || exit 1
cp manifest.json pkg/manifest.json
printf "async function run() {\n\tawait wasm_bindgen(chrome.extension.getURL('{{crate_name}}_bg.wasm'));\n}\n\nrun();" >> pkg/run_wasm.js
