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
            selector.match(/\.[^.\s]*/g)?.forEach((rawClass) => {
              // want to transform
              // .text-sm -> text-sm
              // .md/:text-sm -> md:text-sm
              // .focus/:text-red-400:focus -> focus:text-red-400
              // .hover/:text-red-400:hover -> hover:text-red-400
              let formattedClass = rawClass
                .replace(/(.*?)([^\\]):.*/, "$1$2") // strip off final :xxxx not preceded by \:
                .replace(/[\.\\]/g, ""); // get rid of . and \: -> :
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
