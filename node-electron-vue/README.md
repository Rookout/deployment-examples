# Quickstart for debugging an Electron vue app using Rookout

A sample application for debugging an Electron Vue app using Rookout

Before following this guide we recommend completing the basic [Node.JS + Rookout tutorial](https://github.com/Rookout/tutorial-nodejs).

## Rookout Integration Explained

Follow these simple steps to integrate Rookout into your existing Node-Electron application:

1. Adding the Rookout SDK to `package.json` available on [npm]:
    ```bash
    $ npm install --save rookout
    ```
	
2. Export Organization Token:
    ```bash
	$ export ROOKOUT_TOKEN=<Your-Token>
    ```

3. Adding a require statement to the project entry file (src/main/index.js):
    ```js
    const rookout = require('rookout')
    rookout.start()
    ```

4. Modify all webpack .config.js files (.electron-vue/webpack. [main, renderer, web] .config.js) by changing the way webpack is packed:
	```
	devtool: 'inline-source-map',
	```
	
	in `.electron-vue/webpack.main.config.js` change the webConfig as following:
	```javascript
    let webConfig = {
    devtool: 'inline-source-map',
    entry: {
     web: path.join(__dirname, '../src/renderer/main.js')
    },
   .........
    ```
	
5. Build your electron application


[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[npm]: https://www.npmjs.com/package/rookout
