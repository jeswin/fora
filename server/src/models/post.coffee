async = require '../common/async'
utils = require '../common/utils'
AppError = require('../common/apperror').AppError
BaseModel = require('./basemodel').BaseModel
mdparser = require('../common/markdownutil').marked

class Post extends BaseModel
    
    @_getMeta: ->
        articleModule = require('./article')
        userModule = require('./user')
        forumModule = require('./forum')
        {
            type: Post,
            typeConstructor: (obj) -> if obj.type is 'article' then new articleModule.Article(obj) else new Post(obj), 
            collection: 'posts',
            fields: {
                forum: { type: forumModule.Forum.Summary },
                createdBy: { type: userModule.User.Summary, validate: -> @createdBy.validate() },
                recommendations: { type: 'array', contents: userModule.User.Summary, validate: -> user.validate() for user in @recommendations },
                meta: { type: 'array', contents: 'string' },
                rating: 'number',
                createdAt: { autoGenerated: true, event: 'created' },
                updatedAt: { autoGenerated: true, event: 'updated' }
            },
            concurrency: 'optimistic',
            logging: {
                isLogged: true,
                onInsert: 'NEW_POST'
            }
        }



    @search: (criteria, settings, context, cb) =>
        limit = @getLimit settings.limit, 100, 1000
                
        params = {}
        for k, v of criteria
            params[k] = v
        
        Post.find params, ((cursor) -> cursor.sort(settings.sort).limit limit), context, cb        
        
        
    
    constructor: (params) ->
        @recommendations ?= []
        @meta ?= []
        @tags ?= []
        @rating ?= 1
        @createdAt = Date.now()
        super
        
        
    
    save: (context, cb) =>
        #If there is a stub, check if a post with the same stub already exists.
        if @stub
            Post.get { @stub }, {}, (err, post) =>
                if not post
                    super
                else
                    cb new AppError "Stub already exists", "STUB_EXISTS"
        else
            super

            
exports.Post = Post
