const path = require("path");
const webpack = require("webpack");
const CopyWebpackPlugin = require("copy-webpack-plugin");


module.exports = {
    entry: {
        index: "./src/js/render-index-page.jsx",
        generateRainbowTable: "./src/js/render-generate-rainbow-table-page.jsx",
        rainbowTablePage: "./src/js/render-rainbow-tables-page.jsx",
        searchRainbowTable: "./src/js/render-search-rainbow-table-page.jsx"
    },
    resolve: {
        extensions: [".js", ".jsx"]
    },
    output: {
        path: path.join(__dirname, "dist"),
        filename: "js/[name].bundle.js"
    },
    plugins: [
        new webpack.optimize.ModuleConcatenationPlugin(),
        new webpack.optimize.UglifyJsPlugin({minimize: true}),
        new CopyWebpackPlugin([
            {from: "src/version.json"},
            {from: "src/css", to: "css/"},
            {from: "src/favicons", to: "favicons/"},
            {from: "node_modules/react-table/react-table.css", to: "css/"}
        ])
    ],
    module: {
        rules: [
            {
                test: /\.jsx?$/,
                enforce: "pre",
                loader: "eslint-loader",
                exclude: /node_modules/
            }, {
                test: /\.jsx?$/,
                loader: "babel-loader",
                exclude: /node_modules/
            }, {
                test: /\.json$/,
                loader: "json-loader"
            }
        ]
    }
};
