module.exports = {
  plugins: [
    require("tailwindcss"),
    require("./postcss-list-classes")({
      dest: "./dist/classlist.txt",
    }),
    require("autoprefixer"),
  ],
};
