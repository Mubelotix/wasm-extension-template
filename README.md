# WASM Extension Template

This template allows you to generate a "Hello World" web extension running a **Rust program compiled to WASM**.  
The program will be executed as a **content script**, without the need of being injected into the page.

![Demo image](https://media.discordapp.net/attachments/546761853297229825/919179215390261258/unknown.png?width=1080&height=181)

## Generate a crate

You can use `cargo-generate` to generate a new crate (modify the name at the end of the command):

```sh
cargo install cargo-generate
cargo generate --git https://github.com/Mubelotix/wasm-extension-template --name amazing-extension
```

Your crate is now generated and ready to be compiled.

## Compile your crate

You should use `wasm-pack` to build the crate.  
Be aware of the `target=no-modules` parameter as it wouldn't work without.

```sh
cargo install wasm-pack
wasm-pack build --target=no-modules
```

Once compiled, the target files are ready to be used in the `pkg` folder.

## Test your program

Web browsers allow developpers to test web extensions before publishment.
See your browser's specific instructions to do that.
The generated `manifest.json` file is located in the `pkg` folder.
By default, your extension will run on example.com and have no other permissions.
You should want to modify the manifest (see [the doc](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json)).
