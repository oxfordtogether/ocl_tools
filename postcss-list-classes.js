let { writeFile } = require("fs").promises;

module.exports = (opts = {}) => {
  // Work with options here
  const dest = opts.dest || "./classlist.txt";

  return {
    postcssPlugin: "postcss-list-classes",
    prepare() {
      const classes = new Set();
      return {
        Rule(rule) {
          // .a , .b
          // .a.b.c
          // .a:b
          rule.selectors.forEach((selector) =>
            // .a.b .p-1/.5 -> ['.a', '.b', '.p-1.5']
            // dot-not-preceeded-by-slash then multiple slash-dot-OR-not-space-or-dot
            selector.match(/(?<!\/)\.(\\\.|[^\s\.])*/g)?.forEach((rawClass) => {
              // want to transform
              // .text-sm -> text-sm
              // .md/:text-sm -> md:text-sm
              // .focus/:text-red-400:focus -> focus:text-red-400
              // .hover/:text-red-400:hover -> hover:text-red-400
              // but also
              // p-1/.5 -> p-1.5
              let formattedClass = rawClass
                .replace(/(.*?)([^\\]):.*/, "$1$2") // strip off final :xxxx not preceded by \:
                .replace(/^\./, "") // strip . from the beginning
                .replace(/\\:/g, ":") // \: -> :
                .replace(/\\\./g, "."); // \. -> .
              classes.add(formattedClass);
            })
          );
        },
        OnceExit() {
          writeFile(dest, Array.from(classes).sort().join("\n"));
        },
      };
    },
  };
};
module.exports.postcss = true;
