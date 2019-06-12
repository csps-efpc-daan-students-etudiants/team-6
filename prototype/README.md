[![circleci](https://img.shields.io/circleci/build/github/csps-efpc-daan-students-etudiants/team-6.svg)](https://circleci.com/gh/csps-efpc-daan-students-etudiants/team-6)

# Prerequisite
You will need [Node.js with npm](https://nodejs.org/en/download/) installed to build and run the project.

# Install
Run the following to install the project dependencies:
```bash
# Downloads all required dependencies
npm install
```

# Local dev
You can use the Webpack dev server for local development on your machine:
```bash
# Starts the Webpack dev server at http://localhost:8080
npm start
```

# Test
Visual regression and accessibility testing is being done with [cucumber-puppeteer](https://github.com/patheard/cucumber-puppeteer) using the [`./features/visual/prototype.feature`](https://github.com/csps-efpc-daan-students-etudiants/team-6/blob/master/prototype/features/visual/prototype.feature) gherkin file.  You can run the tests with:
```bash
npm test
```
If you make changes to the screen layouts or CSS, you'll need to update the reference screenshots in:
```bash
./features/screenshots/ref
```
The easiest way to do this is delete the reference screenshot and re-run the tests, which will cause a new reference screenshot to be created.

# Build
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
