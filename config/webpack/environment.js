
const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const less_loader= {
  test: /\.less$/,
  use: ['css-loader', 'less-loader']
 };
 environment.loaders.append('less', less_loader)

const webpack = require('webpack')

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery'
  })
)

environment.loaders.append("jquery", {
  test: require.resolve("jquery"),
  use: [
    { loader: "expose-loader", options: { exposes: ["$", "jQuery"] } },
  ],
});

environment.loaders.prepend('erb', erb)
module.exports = environment
