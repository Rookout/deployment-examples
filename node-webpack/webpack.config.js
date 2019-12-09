const path = require('path');

module.exports = {
  entry: './index.js',
  target: 'node',
  devtool: 'eval-source-map',
  output: {
    filename: 'index.js',
    path: path.resolve(__dirname, 'dist')
  }
};
