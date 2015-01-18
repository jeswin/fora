(function() {

    "use strict";

    var dataUtils = require('fora-lib-data-utils'),
        services = require('fora-lib-services');

    var extendRecord = function(Record) {

        Record.entitySchema = {
            collection: 'records',
            discriminator: function*(obj, schemaManager) {
                return yield* schemaManager.getEntitySchema(obj.type);
            },
            schema: {
                id: "record",
                type: 'object',
                properties: {
                    type: { type: 'string' },
                    recordType: { type: 'string' },
                    version: { type: 'string' },
                    versionMajor: { type: 'number' },
                    versionMinor: { type: 'number' },
                    versionRevision: { type: 'number' },
                    appId: { type: 'string' },
                    createdBy: { $ref: 'user-summary' },
                    meta: { type: 'array', items: { type: 'string' } },
                    tags: { type: 'array', items: { type: 'string' } },
                    stub: { type: 'string' },
                    state: { type: 'string', enum: ['draft','published'] },
                    savedAt: { type: 'integer' }
                },
                required: ['type', 'recordType', 'version', 'versionMajor', 'versionMinor', 'versionRevision',
                           'appId', 'createdBy', 'meta', 'tags', 'stub', 'state', 'savedAt']
            },
            indexes: [
                { 'state': 1, 'app.stub': 1 },
                { 'state': 1, 'appId': 1 },
                { 'state': 1, 'createdAt': 1, 'app.stub': 1 },
                { 'createdBy.id' : 1 },
                { 'createdBy.username': 1 }
            ],
            links: {
                app: { type: 'app', key: 'appId' }
            },
            autoGenerated: {
                createdAt: { event: 'created' },
                updatedAt: { event: 'updated' }
            },
            initialize: function*(record, raw, typeDef, schemaManager) {
                var clone = JSON.parse(JSON.stringify(raw));
                var original = yield* schemaManager.constructEntity(clone, typeDef, {}, true);
                this.getOriginal = function*() {
                    return original;
                };
            },
            logging: {
                onInsert: 'NEW_POST'
            }
        };


        var getCustomFields = function*(entitySchema, acc, prefix) {
            acc = acc || [];
            prefix = prefix || [];

            for (var field in entitySchema.schema.properties) {
                if (!entitySchema.ownProperties || entitySchema.ownProperties.indexOf(field) > -1) {
                    var def = entitySchema.schema.properties[field];
                    if (dataUtils.isPrimitiveType(def.type)) {
                        if (def.type === "array" && dataUtils.isCustomType(def.items.type)) {
                                prefix.push(field);
                                yield* getCustomFields(def.items.entitySchema, acc, prefix);
                                prefix.pop(field);
                        } else {
                            acc.push(prefix.concat(field).join('_'));
                        }
                    } else if (dataUtils.isCustomType(def.type)) {
                        prefix.push(field);
                        yield* getCustomFields(def.entitySchema, acc, prefix);
                        prefix.pop(field);
                    }
                }
            }

            return acc;
        };


        Record.prototype.getCustomFields = function*(entitySchema) {
            return yield* getCustomFields(entitySchema);
        };


        Record.new = function*(params) {
            var schemaManager = services.getSchemaManager();
            var entitySchema = yield* schemaManager.getEntitySchema(Record.entitySchema.schema.id);
            return yield* schemaManager.constructEntity(params, entitySchema);
        };


        Record.extend = function(items) {
            var ctor = function(params) {
                Record.call(this, params);
            };

            ctor.prototype = Object.create(Record.prototype);
            ctor.prototype.constructor = ctor;

            for (var key in items) {
                if (!/^my_/.test(key))
                    throw new Error("Custom functions in record/name/version/model.js must start with my_ prefix. Rename " + key + " as my_" + key + ".");
                ctor.prototype[key] = items[key];
            }

            return ctor;
        };
    };

    module.exports = {
        extendRecord: extendRecord
    };

})();
