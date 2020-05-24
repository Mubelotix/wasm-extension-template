import('http://localhost:8001/{{crate_name}}.js').then((module) => {
    module.default();
});