const colors = require("tailwindcss/colors");

module.exports = {
  mode: "jit",
  purge: ["./javascript/**/*", "./app/**/*"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        primary: colors.violet,
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [require("@tailwindcss/typography"), require("@tailwindcss/forms")],
};
