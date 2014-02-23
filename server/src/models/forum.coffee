thunkify = require 'thunkify'
ForaModel = require('./foramodel').ForaModel
ForaDbModel = require('./foramodel').ForaDbModel
utils = require('../lib/utils')
models = require('./')

class Forum extends ForaDbModel

    class Settings extends ForaModel
        @typeDefinition: {
            name: "forum-settings",
            schema: {
                type: 'object',                    
                properties: {
                    commentsEnabled: { type: 'boolean' },
                    commentsOpened: { type: 'boolean' }
                }
            }
        }

    @Settings: Settings

    class Summary extends ForaModel
        @typeDefinition: {
            name: "forum-summary",
            schema: {
                type: 'object',        
                properties: {
                    id: { type: 'string' },                
                    network: { type: 'string' },
                    name: { type: 'string' },
                    stub: { type: 'string' },
                    createdBy: { $ref: "user-summary" }
                },
                required: ['id', 'network', 'name', 'stub', 'createdBy']
            }
        }    

    @Summary: Summary

    class Stats extends ForaModel   
        @typeDefinition: {
            name: "forum-stats",
            schema: {
                type: 'object',        
                properties: {
                    posts: { type: 'number' },
                    members: { type: 'number' },
                    lastPost: { type: 'number' }
                }
                required: ['posts', 'members', 'lastPost']
            }
        }
        
    @Stats: Stats

    @childModels: { Stats, Summary, Settings }

    @typeDefinition: -> {
        name: 'forum',
        collection: 'forums',
        schema: {
            type: 'object',        
            properties: {
                network: { type: 'string' },
                name: { type: 'string' },
                description: { type: 'string' },
                stub: { type: 'string' },
                type: { type: 'string', enum: ['public', 'protected', 'private'] },
                createdById: { type: 'string' }
                createdBy: { $ref: 'user-summary' },
                postTypes: { type: 'array', items: { type: 'string' }, minItems: 1 },
                settings: { $ref: 'forum-settings' },
                cover: { $ref: 'cover' },
                theme: { type: 'string' },
                cache: { 
                    type: 'object',
                    properties: {
                        posts: {
                            type: 'array',
                            items: {
                                type: 'object',
                                properties: {
                                    image: { type: 'string' },
                                    title: { type: 'string' },
                                    createdBy: { $ref: 'user-summary' }
                                    id: { type: 'string' },
                                    stub: { type: 'string' }                  
                                },
                                required: ['title', 'createdBy', 'id', 'stub']
                            }
                        }
                    }
                    required: ['posts']
                }
                stats: { $ref: 'forum-stats' },
            }
            required: ['network', 'name', 'description', 'stub', 'type', 'createdById', 'createdBy', 'postTypes', 'cache', 'stats']
        },
        indexes: [
            { 'createdById': 1, 'network': 1 },
            {'stub': 1, 'network': 1 }
        ],
        autoGenerated: {
            createdAt: { event: 'created' },
            updatedAt: { event: 'updated' }
        },
        mapping: {
            postTypes: { type: 'csv' },
        },
        links: {
            createdBy: { type: 'user-summary', key: 'createdById' }
            posts: { type: 'post', field: 'forumId' },
            info: { type: 'forum-info', field: 'forumId' }
        },
        logging: {
                onInsert: 'NEW_FORUM'
        }
    }
        
    
    
    save: (context, db) =>*
        { context, db } = @getContext context, db
        if not @_id
            @stats = new Stats {
                posts: 0,
                members: 1,
                lastPost: 0
            }
            @cache ?= { posts: [] }
        
        yield super(context, db)


        
    summarize: =>        
        summary = new Summary {
            id: @_id.toString(),
            network: @network,
            name: @name,
            stub: @stub,
            createdBy: @createdBy
        }
        
        
        
    getView: (name) =>*
        switch name
            when 'card'
                {
                    id: @_id.toString()
                    @network,
                    @name,
                    @description,
                    @stub,
                    @createdBy,
                    @cache,
                    image: @cover?.image?.small
                }



    join: (user, token, context, db) =>*
        { context, db } = @getContext context, db
        if @type is 'public'
            yield @addRole user, 'member', context, db
        else
            throw new Error "Access denied"
        
        
        
    addPost: (post, context, db) =>*
        { context, db } = @getContext context, db
        post.forumId = @_id.toString()
        post.forum = @summarize()
        yield post.save context, db
        


    getPosts: (limit, sort, context, db) =>*
        { context, db } = @getContext context, db
        yield models.Post.find({ 'forumId': @_id.toString(), state: 'published' },  { sort, limit }, context, db)
        

    
    addRole: (user, role, context, db) =>*
        { context, db } = @getContext context, db
        
        membership = yield models.Membership.get { 'forumId': @_id.toString(), 'user.username': user.username }, context, db
        if not membership
            membership = new (models.Membership) {
                forumId: @_id.toString(),
                forum: @summarize(),
                userId: user.id,
                user,
                roles: [role]
            }
        else
            if membership.roles.indexOf(role) is -1 
                membership.roles.push role
        yield membership.save context, db   
                


    removeRole: (user, role, context, db) =>*
        { context, db } = @getContext context, db
        
        membership = yield models.Membership.get { 'forumId': @_id.toString(), 'user.username': user.username }, context, db
        membership.roles = (r for r in membership.roles when r isnt role)
        yield if membership.roles.length then membership.save() else membership.destroy()
                
    
                                
    getMemberships: (roles, context, db) =>*
        { context, db } = @getContext context, db
        yield models.Membership.find { 'forumId': @_id.toString(), roles: { $in: roles } }, { sort: { id: -1 }, limit: 200 }, context, db
        
      
            
    refreshCache: (context, db) =>*
        { context, db } = @getContext context, db
        posts = yield @getPosts 10, { _id: -1 }, context, db
        @cache = { posts: [] }

        if posts.length 
            for p in posts
                @cache.posts.push yield p.getView("concise")

            @stats.posts = yield models.Post.count({ 'forumId': @_id.toString() , state: 'published' }, context, db)
            @stats.lastPost = posts[0].savedAt
            yield @save context, db

exports.Forum = Forum

