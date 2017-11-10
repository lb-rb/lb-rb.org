/**
 * PostCSS packages
 */
var cssimport = require("postcss-import");
var atImport = require("postcss-import");

module.exports = {
  plugins: [
    cssimport({
      // Add each @import as a dependency so the bundle is rebuilt
      // when imported files change.
      onImport: function (files) {
        files.forEach(this.addDependency);
      }.bind(this)
    }),
    require('postcss-cssnext')({
      map: false,
      compress: false
    }),
    // postcss-modules-values was renamed to postcss-icss-values
    // require('postcss-icss-values'),
    require('postcss-modules-values'),
    atImport
  ]
}
