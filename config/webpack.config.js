var path = require("path")

module.exports = {
  entry: {
    app: [__dirname + "/../src/index.js"]
  },

  output: {
    path: path.resolve(__dirname + "/../build"),
    filename: "[name].js"
  },

  module: {
    rules: [
      {
        test: /\.(css|scss)$/,
        use: ["style-loader", "css-loader"]
      },
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: "file-loader?name=[name].[ext]"
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: "elm-webpack-loader?verbose=true&warn=true"
      }
    ],

    noParse: /\.elm$/
  },

  devServer: {
    inline: true,
    stats: { colors: true }
  }
}
