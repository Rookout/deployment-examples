# Quickstart for debugging a google cloud function + NodeJS using Rookout  

A sample application for debugging a google cloud function + NodeJS using Rookout

Before following this guide we recommend reading the basic [Node + Rookout] guide

## Rookout Integration Explained

To integrate Rookout into your google function, follow these steps:

1. Edit the package.json and add Rookout as project dependency
2. Set your Rookout Token as the ROOKOUT_TOKEN environment variable
3. Call to rook start function in the begening of your index.js file:
``` js
const rook = require('rookout');
rook.start();
```
4. Go to [app.rookout.com](https://app.rookout.com/) and start debugging !

[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[npm]: https://www.npmjs.com/package/rookout
