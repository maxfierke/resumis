const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const RemoveEmptyScriptsPlugin = require('webpack-remove-empty-scripts');
const path    = require("path");
const webpack = require("webpack");

const mode = process.env.NODE_ENV === 'development' ? 'development' : 'production';

module.exports = {
  mode,
  devtool: "source-map",
  entry: {
    application: "./app/javascript/application.js",
    cv_pdf: "./app/javascript/cv_pdf.js",
    cv_screen: "./app/javascript/cv_screen.js",
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[name].[contenthash].js.map",
    path: path.resolve(__dirname, '..', '..', 'app/assets/builds')
  },
  module: {
    rules: [
      {
        test: /\.(js)$/,
        exclude: /node_modules/,
        use: ['babel-loader'],
      },
      {
        test: /\.css$/i,
        use: [MiniCssExtractPlugin.loader, 'css-loader'],
      },
      {
        test: /\.(png|jpe?g|gif|eot|woff2|woff|ttf|svg)$/i,
        use: 'file-loader',
      },
    ],
  },
  plugins: [
    new RemoveEmptyScriptsPlugin(),
    new MiniCssExtractPlugin(),
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ],
  resolve: {
    extensions: ['.js', '.css'],
  },
}
