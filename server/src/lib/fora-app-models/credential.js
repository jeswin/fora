(function() {
    "use strict";

    var thunkify = require('fora-node-thunkify'),
        hasher = require('fora-app-hasher'),
        randomizer = require('fora-app-randomizer'),
        models = require('./'),
        services = require('fora-app-services'),
        DbConnector = require('fora-app-db-connector'),
        dataUtils = require('fora-data-utils'),
        Parser = require('fora-request-parser');

    var typesService = services.get('typesService'),
        conf = services.get('configuration');

    var emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    var Credential = function(params) {
        dataUtils.extend(this, params);
    };

    var credentialStore = new DbConnector(Credential);

    Credential.typeDefinition = {
        name: 'credential',
        collection: 'credentials',
        schema: {
            type: 'object',
            properties: {
                email: { type: 'string' },
                emailIsVerified: { type: 'boolean' },
                preferences: {
                    type: 'object',
                    schema: {
                        properties: {
                            canEmail: { type: 'boolean' }
                        }
                    }
                },
                builtin: {
                    type: 'object',
                    schema: {
                        properties: {
                            hash: { type: 'string' },
                            salt: { type: 'string' }
                        },
                        required: [ 'hash', 'salt' ]
                    }
                },
                twitter: {
                    type: 'object',
                    schema: {
                        properties: {
                            id: { type: 'string' },
                            username: { type: 'string' },
                            accessToken: { type: 'string' },
                            accessTokenSecret: { type: 'string' }
                        },
                        required: [ 'id', 'username', 'accessToken', 'accessTokenSecret' ]
                    }
                },
                facebook: {
                    type: 'object',
                    schema: {
                        properties: {
                            id: { type: 'string' },
                            username: { type: 'string' },
                            accessToken: { type: 'string' }
                        },
                        required: [ 'id', 'username', 'accessToken' ]
                    }
                }
            }
        },
        autoGenerated: {
            createdAt: { event: 'created' },
            updatedAt: { event: 'updated' }
        },
        indexes: [
            { 'type': 1, 'email': 1 },
        ],
        links: {
            users: { type: 'user', field: 'credentialId' }
        },
        validate: function*(fields) {
            if (this.email && !emailRegex.test(this.email))
                return ['Invalid email'];
        }
    };


    Credential.createViaRequest = function*(request) {
        var typesService = services.get('typesService');
        var parser = new Parser(request, typesService);

        if ((yield* parser.body('secret')) === conf.services.auth.adminkeys.default) {
            var type = yield* parser.body('type');

            var credential = new Credential(
                {
                    email: yield* parser.body('email'),
                    preferences: { canEmail: true }
                }
            );

            var username;
            switch(type) {
                case 'builtin':
                    username = yield* parser.body('username');
                    var password = yield* parser.body('password');
                    credential = yield* credential.addBuiltin(username, password);
                    break;
                case 'twitter':
                    var id = yield* parser.body('id');
                    username = yield* parser.body('username');
                    var accessToken = yield* parser.body('accessToken');
                    var accessTokenSecret = yield* parser.body('accessTokenSecret');
                    credential = yield* credential.addTwitter(id, username, accessToken, accessTokenSecret);
                    break;
            }

            return credential;
        }
    };


    Credential.prototype.save = function*() {
        return yield* credentialStore.save(this);
    };


    /*
        Create a credential token.
        This can be used to upgrade to a user token, which is then used for login.
    */
    Credential.prototype.createSession = function*() {
        var typesService = services.get('typesService');
        var session = new models.Session(
            {
                credentialId: DbConnector.getRowId(this),
                token: randomizer.uniqueId(24)
            }
        );
        return yield* session.save();
    };


    Credential.prototype.addBuiltin = function*(username, password) {
        var existing = yield* credentialStore.findOne({ "builtin.username": username });
        if (!existing) {
            var hashed = yield* thunkify(hasher)({ plaintext: password });
            this.builtin = {
                method: 'PBKDF2',
                username: username,
                salt: hashed.salt.toString('hex'),
                hash: hashed.key.toString('hex')
            };
            return yield* this.save();
        } else {
            throw new Error("Built-in credential with the same username already exists");
        }
    };


    Credential.prototype.addTwitter = function*(id, username, accessToken, accessTokenSecret) {
        var existing = yield* credentialStore.findOne({ "twitter.id": id });
        if (!existing) {
            this.twitter = {
                id: id,
                username: username,
                accessToken: accessToken,
                accessTokenSecret: accessTokenSecret
            };
            return yield* this.save();
        } else {
            throw new Error("Twitter credential with the same id already exists");
        }
    };


    exports.Credential = Credential;

})();
