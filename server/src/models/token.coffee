ForaDbModel = require('./foramodel').ForaDbModel
models = require('./')

class Token extends ForaDbModel

    @typeDefinition: {
        type: @,
        name: "token",
        collection: 'tokens',
        fields: {
            type: 'string',
            key: 'string',
            value: '',
            createdAt: { autoGenerated: true, event: 'created' },
            updatedAt: { autoGenerated: true, event: 'updated' }
        },
    }
        
    
exports.Token = Token
