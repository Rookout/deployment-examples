const path = require('path');

module.exports = {
  entry: './index.ts',
  target: 'node',
  devtool: 'source-map',
  module : {
    rules: [
      {
        test: /\.m?[jt]sx?$/,
        use: 'babel-loader',
        exclude: /node_modules/,
      },
    ],
  },
  output: {
    filename: 'index.js',
    path: path.resolve(__dirname, 'dist')
  }
};
