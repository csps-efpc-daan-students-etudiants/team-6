# Prerequisite
You will need [Node.js with npm](https://nodejs.org/en/download/) installed to build and run the project.

# Install
Run the following to install the project dependencies:
```bash
# Downloads all required dependencies
npm install
```
# Local development
You can use the Webpack dev server for local development on your machine:
```bash
# Starts the Webpack dev server at http://localhost:8080
npm start
```

# Build production assets
If you want to build the CSS/JS assets to deploy to a server, use:
```bash
# Creates CSS/JS/font bundles in ./dist folder
npm run build
```

# Dependencies
The prototype uses the following:

* [Bootstrap](https://getbootstrap.com/): front-end CSS/JS framework.
* [Chart.js](https://www.chartjs.org/): graphing JS library.
* [Webpack](https://webpack.js.org/): build tool for creating the CSS/JS bundles used by the web pages.