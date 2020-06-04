# wasm-extension-template

This template allows you to generate a "Hello World" web extension running a Rust program compiled to WASM.  
**That readme is a draft**

## Generate a crate

First, install the needed tools:

```sh
cargo install cargo-generate
cargo install wasm-pack
```

Then, use cargo-generate to generate a new crate (modify the name at the end of the command):

```sh
cargo generate --git https://github.com/Mubelotix/wasm-extension-template --name amazing-extension
```

Your crate is now generated and is ready to be compiled.

## Compile the crate

You can use `wasm-pack` to build the crate.

```sh
wasm-pack build --target=web
```

Once compiled, the target files are ready to be used in the `pkg` folder.

## Use your crate

Web browsers allow developpers to test web extensions before publishment.
See your browser's specific instructions to do that.
The generated `manifest.json` file is located in the `pkg` folder.
By default, your extension will run only on example.com.
You should want to modify the manifest (see [the doc](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json)).
