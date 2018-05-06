process.traceDeprecation = true;

var webpack = require('webpack');
var path = require('path');

/**
 * Custom webpack plugins
 */
var Clean = require('clean-webpack-plugin');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var AssetsPlugin = require('assets-webpack-plugin');
 
module.exports = {
  // debug: true,
  // devtool: "source-map",
  mode: 'production',

  entry: {
    main: [
      './assets/javascripts/all.js',
      './assets/stylesheets/site.css.scss',
    ],
  },

  output: {
    path: __dirname + '/docs',
    filename: 'assets/javascripts/[name].bundle.js',
    // filename: 'assets/javascripts/[name]_[hash].bundle.js',
    publicPath: "../../"
  },

  // Plugin/loader specific-configuration
  plugins: [
    new webpack.DefinePlugin({
      DEVELOPMENT: true
    }),
    new ExtractTextPlugin("[name].css", {
      allChunks: true
    })
  ],

  resolve: {
    modules: [
      path.resolve(__dirname, 'assets/stylesheets'),
      path.resolve(__dirname, 'assets/javascripts'),
      path.resolve(__dirname, 'assets/images'),
      path.resolve(__dirname, 'assets/fonts'),
      path.join(__dirname, 'node_modules')
    ]
  },

  // Same issue, for loaders like babel
  resolveLoader: {
    modules: [path.join(__dirname, 'node_modules')]
  },

  module: {
    rules: [
      {
        test: /\.scss$/,
        exclude: /node_modules|\.tmp|vendor|docs/,
        loader: 'import-glob-loader',
        enforce: 'pre'
      },
      {
        test: /\.js?$/,
        exclude: /node_modules|docs/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              presets: ['es2015']
            }
          },
          // {
          //   loader: 'eslint-loader'
          // }
        ]
      },
      {
        test:/\.(png|jpe?g|gif)$/,
        exclude:/node_modules|docs/,
        use: {
          loader: 'url-loader',
          options: {
            limit: 1024,
            name: 'assets/images/[name].[ext]'
          }
        }
      },
      {
        test: /\.scss$/,
        exclude: /node_modules|\.tmp|vendor|docs/,
        use: ExtractTextPlugin.extract({
          use: [
            {
              loader: 'css-loader',
              options: {
                minimize: false,
                sourceMap: false
              }
            },
            {
              loader: 'sass-loader'
            },
            // {
            //   loader: 'postcss-loader',
            //   options: {
            //     plugins: [
            //       require('postcss-cssnext')({
            //         map: false,
            //         compress: false
            //       }),
            //       require('postcss-sass')
            //     ]
            //   }
            // }
          ]
        })
      },
      {
        test: /\.(css|mcss)$/,
        // The ExtractTextPlugin pulls all CSS out into static files
        // rather than inside the JavaScript/webpack bundle
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: 'css-loader',
              options: {
                minimize: false,
                sourceMap: false,
                modules: true,
                importLoaders: 2,
                localIdentName: '[name]__[local]___[hash:base64:5]'
              }
            },
            {
              loader: 'postcss-loader',
            }
          ]
        })
      },
      {
        test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
        use: {
          loader: 'url-loader',
          options: {
            limit: 10000,
            name: 'assets/fonts/[name].[ext]'
          }
        }
      },
      //{ test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url-loader?limit=10000&mimetype=application/font-woff" },
      //{ test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file-loader" }
      //{ test: /\.woff(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&mimetype=application/font-woff"},
      //{ test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&mimetype=application/font-woff"},
      //{ test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&mimetype=application/octet-stream"},
      //{ test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: "file"},
      //{ test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&mimetype=image/svg+xml"}
    ],
  },
  
  plugins: [
    // new Clean(['.tmp']),
    new ExtractTextPlugin('assets/stylesheets/[name].bundle.css', {
    // new ExtractTextPlugin('assets/stylesheets/[name]_[hash].bundle.css', {
      allChunks: true
    }),
    new CopyWebpackPlugin([{ from: 'assets/images', to: 'assets/images' }, { from: 'static' }]),
    new AssetsPlugin({fullPath: false})
  ],
};
