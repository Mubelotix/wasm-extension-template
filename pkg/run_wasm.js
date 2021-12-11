async function run() {
    await wasm_bindgen(chrome.extension.getURL('{{crate_name}}_bg.wasm'));
}

run();