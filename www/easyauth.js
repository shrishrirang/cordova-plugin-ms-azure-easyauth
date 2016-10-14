var exec = require('cordova/exec');

exports.login = function(arg0, success, error) {
    exec(success, error, "easyauth", "login", [arg0]);
};
