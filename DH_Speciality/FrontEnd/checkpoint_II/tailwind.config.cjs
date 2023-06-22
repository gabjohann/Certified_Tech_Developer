/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        lineColor: '#d0d0d0',
        disableColor: '#80868c',
        enableColor: '#0a4d9d',
      },
    },
  },
  plugins: [],
};
