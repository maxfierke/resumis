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
  variants: {},
  plugins: [
    require('@tailwindcss/custom-forms'),
  ]
};
