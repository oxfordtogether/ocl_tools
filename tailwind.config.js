const colors = require("tailwindcss/colors");

module.exports = {
  mode: "jit",
  purge: [
    "./app/**/*.html.erb",
    "./app/components/ocl_tools/*",
    "./app/helpers/ocl_tools/*",
  ],
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
