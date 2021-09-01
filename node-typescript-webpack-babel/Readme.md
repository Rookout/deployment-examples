# Quickstart for Webpack + TypeScript + Node + Rookout

A sample application for using Rookout + TypeScript + Node + Webpack.

## Typescript notes:

* Have `tsc` generate __sourcemaps__ and include them in the final deployment. We recommend this configuration for `tsconfig.json`:
    ```
    {
        "compilerOptions": {
            "inlineSourceMap": true,
            "inlineSources": true,
        }
    }
    ```
    
* In order to use require(), you must have the node types package installed:
    ```bash
    $ npm install --save @types/node
    ```

For a more in-depth explanation, see the [Node.JS + Rookout guide](https://docs.rookout.com/docs/node-setup/).

## Running this sample

1. Installing dependencies:
    ```bash
    $ npm install
    ```

2. Export organization token (found under Organization Settings -> Token)
    ```bash
    $ export ROOKOUT_TOKEN=<Your Rookout Token>
    ```

3. Build:
    ```bash
    $ npm run build
    ```

4. Run:
    ```bash
    $ npm start
    ```

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[npm]: https://www.npmjs.com/package/rookout


