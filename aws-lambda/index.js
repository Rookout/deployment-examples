const rookout = require('rookout/lambda');

exports.handler = rookout.wrap((event, context, callback) => {
    callback(null, "Hello World");
});
