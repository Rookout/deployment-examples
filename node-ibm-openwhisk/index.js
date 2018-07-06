const rookout = require('rookout/openwhisk');

rookout.connect('cloud.agent.rookout.com', 443, ORG_TOKEN);

function myAction(args) {
    const leftPad = require("left-pad")
    const lines = args.lines || [];
    return { padded: lines.map(l => leftPad(l, 30, ".")) }
}

exports.main = rookout.wrap(myAction);