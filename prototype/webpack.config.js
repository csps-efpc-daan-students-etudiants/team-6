const path = require('path');
const webpack = require('webpack');

module.exports = {
  entry: [
    './css/app.scss',
    './js/app.js'
  ],
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
  module: {
    rules: [
      {
        test: /\.(scss)$/,
        use: [
          {
            // Pipes the extracted CSS into a bundle.css file
            loader: 'file-loader',
            options: {
              name: 'bundle.css',
            }
          },
          { 
            // Extracts the Bootstrap CSS
            loader: 'extract-loader' 
          },    
          {
            // Interprets `@import` and `url()` like `import/require()` and will resolve them
            loader: 'css-loader'
          },
          {
            // Loader for webpack to process CSS with PostCSS
            loader: 'postcss-loader',
            options: {
              plugins: function () {
                return [
                  require('autoprefixer')
                ];
              }
            }
          },
          {
            // Loads a SASS/SCSS file and compiles it to CSS
            loader: 'sass-loader'
          }
        ]
      },
      {
        test: /\.(ttf|eot|woff|woff2)$/,
        use: {
          loader: "file-loader",
          options: {
            name: "fonts/[name].[ext]",
          },
        },
      },      
    ]
  },
  plugins: [
    // Only load the English/French locales for Chart.js
    new webpack.ContextReplacementPlugin(/moment[\/\\]locale$/, /en|fr/)
  ]  
};