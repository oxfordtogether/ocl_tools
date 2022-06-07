const colors = require("tailwindcss/colors");

module.exports = {
  content: ["./javascript/**/*", "./app/**/*"],
  theme: {
    extend: {
      colors: {
        primary: colors.violet,
        green: colors.emerald,
        yellow: colors.amber,
        purple: colors.violet,
      },
    },
  },
  plugins: [require("@tailwindcss/typography"), require("@tailwindcss/forms")],
};
