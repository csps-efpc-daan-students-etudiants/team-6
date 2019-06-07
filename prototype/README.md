# Install
Run the following to install the project dependencies:
```bash
npm install
```
# Local development
You can use the Webpack dev server for local development on your machine:
```bash
npm start
```

# Build production assets
If you want to build the CSS/JS assets to deploy to a server, use:
```bash
npm run build
```
The bundles and fonts will be put in the `./dist` folder.

# Dependencies
The prototype uses the following:

* [Bootstrap](https://getbootstrap.com/): front-end CSS/JS framework.
* [Chart.js](https://www.chartjs.org/): graphing JS library.
* [Webpack](https://webpack.js.org/): build tool for creating the CSS/JS bundles used by the web pages.