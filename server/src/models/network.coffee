ForaDbModel = require('./foramodel').ForaDbModel
models = require('./')

class Network extends ForaDbModel

    @typeDefinition: {
        name: "network",
        collection: 'networks',
        schema: {
            type: 'object',        
            properties: {
                name: { type: 'string' },
                stub: { type: 'string' },
                domains: { type: 'array', items: 'string' },
            },
            required: ['name', 'stub', 'domains']
        },
        autoGenerated: {
            createdAt: { event: 'created' },
            updatedAt: { event: 'updated' }
        },        
        logging: {
            onInsert: 'NEW_USER'
        }
    }


    constructor: (params) ->
        @templates = {}
        super
            

exports.Network = Network
