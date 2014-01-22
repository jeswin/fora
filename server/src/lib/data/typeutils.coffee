utils = require '../utils'

class TypeUtils
    

    isPrimitiveType: (type) ->        
        ['string', 'number', 'integer', 'boolean', 'array'].indexOf(type) > -1   


    
    isCustomType: (type) ->
        not @isPrimitiveType type



    completeTypeDefinition: (def, ctor) =>
        def.ctor = ctor

        def.schema ?= {} 
        def.schema.properties ?= {}
        def.schema.required ?= []

        if def.autoGenerated
            for k, v of def.autoGenerated
                def.schema.properties[k] = { type: 'integer' }
                def.schema.required.push k
        
        def
        

    
    resolveReferences: =>*
        for name, def of TypeUtils.typeCache
            for property, value of def.schema.properties
                if value.type is 'array'
                    if value.items.$ref
                        def.schema.properties[property].items.typeDefinition = yield @getTypeDefinition value.items.$ref
                else
                    if value.$ref
                        def.schema.properties[property].typeDefinition = yield @getTypeDefinition value.$ref
                    else
                        
        return
        


    getTypeDefinition: (name, dynamicResolutionContext = {}) =>*
        #We must initialize the cache first.
        if not TypeUtils.typeCache
            TypeUtils.typeCache = {}
            
            if @getCacheItems
                items = @getCacheItems()

                for name, def of items                    
                    console.log name
                    TypeUtils.typeCache[name] = def        
            
                yield @resolveReferences()
        
        #First check if it resolves in type cache
        #Then check if it resolves in the context
        #Otherwise build
        TypeUtils.typeCache[name] ? dynamicResolutionContext[name] ? yield @resolveDynamicTypeDefinition(name, dynamicResolutionContext)

    

    resolveDynamicTypeDefinition: (name) =>*
        throw new Error "MUST_OVERRIDE"



exports.TypeUtils = TypeUtils
