TypeUtils = require('../lib/data/typeutils')
fs = require 'fs'
path = require 'path'
thunkify = require 'thunkify'
readdir = thunkify fs.readdir
stat = thunkify fs.stat
readfile = thunkify fs.readFile

class ForaTypeUtils extends TypeUtils

    init: =>*
        yield @buildTypeCache()
        
        

    getCacheItems: =>*
        definitions = {}
        
        for defs in [yield @getModelTypeDefinitions(), yield @getTrustedUserTypes()]
            for name, def of defs
                definitions[name] ?= def    
        
        return definitions
        
    
    
    getModelTypeDefinitions: =>*
        #Get type definitions from models
        models = []

        fnAdd = (module) ->
            for name, model of module
                models.push model
                if model.childModels                    
                    fnAdd model.childModels

        for moduleName in ['./', './fields']
            fnAdd require moduleName

        
        definitions = {}
        
        for model in models            
            def = if typeof model.typeDefinition is "function" then model.typeDefinition() else model.typeDefinition
            def = @completeTypeDefinition(def, model)
            definitions[def.name] ?= def
        
        definitions
        
    
    
    getTrustedUserTypes: =>*
        definitions = {}
        
        Post = require('./post').Post
        postTypeDef = if typeof Post.typeDefinition is "function" then Post.typeDefinition() else Post.typeDefinition
        
        for userType in yield @getUserTypeDirectories path.join __dirname, '../type-definitions/posts'
            for version in yield @getUserTypeDirectories path.join __dirname, '../type-definitions/posts', userType
                def = JSON.parse yield readfile path.join __dirname, '../type-definitions/posts', userType, version, 'model.json'
                def.identifier = "posts/#{userType}/#{version}"
                def.name = userType
                def.version = version
                definitions["posts/#{userType}/#{version}"] ?= def

                def.extensionType = 'builtin'
                
                if def.type is 'post'
                    for field in ['collection', 'trackChanges', 'autoGenerated', 'logging']
                        def[field] = postTypeDef[field]

                    def.ctor = Post                

                    def.inheritedProperties = []
                    for k, v of postTypeDef.schema.properties
                        def.schema.properties[k] = v
                        def.inheritedProperties.push k

                    for req in postTypeDef.schema.required
                        if def.schema.required.indexOf(req) is -1
                            def.schema.required.push req        

        definitions



    getUserTypeDirectories: (dir) =>*
        dirs = []
        files = yield readdir dir
        for file, index in files
            filePath = "#{dir}/#{file}"
            entry = yield stat filePath
            if entry.isDirectory()
                dirs.push(file)
        dirs      

        
        
    resolveDynamicTypeDefinition: (name) =>*
        #TODO: make sure we dont allow special characters in name, like '..'
        for x, y of TypeUtils.typeCache
            console.log "Found " + x
        console.log "Missing " + JSON.stringify name
        
        
exports.ForaTypeUtils = ForaTypeUtils
