const colors = require("tailwindcss/colors");

module.exports = {
  mode: "jit",
  purge: ["./app/**/*.html.erb", "./app/components/*", "./app/helpers/*"],
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
  plugins: [],
};
