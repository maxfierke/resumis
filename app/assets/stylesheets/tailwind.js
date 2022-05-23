const openColors = require('open-color/open-color.json');

const colors = {};

for (const color in openColors) {
  if (!['white', 'black'].includes(color)) {
    colors[color] = {};

    openColors[color].forEach((shade, idx) => {
      const shadeValue = idx * 100;
      colors[color][shadeValue] = shade;
    });
  };
}

module.exports = {
  theme: {
    extend: {
      colors
    }
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/assets/javascript/**/*.js'
  ],
  variants: {},
  plugins: [
    require('@tailwindcss/forms'),
  ]
};
