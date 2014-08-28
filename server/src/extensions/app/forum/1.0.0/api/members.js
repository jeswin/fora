(function() {
    "use strict";

    var _;
    var services = require('fora-app-services');
    

    var join = function*() {
        var app = this.routingContext.app;
        _ = yield* app.join(this.session.user, services.copy());
        this.body = { success: true };
    };


    var auth = require('fora-app-auth-service');
    module.exports = {
        join: auth({ session: 'user' }, join)
    };

})();