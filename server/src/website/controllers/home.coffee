React = require 'react'
conf = require '../../conf'
db = require('../app').db
models = require '../../models'
utils = require('../../lib/utils')
auth = require '../../app-lib/web/auth'
ExtensionLoader = require '../../app-lib/extensions/loader'
loader = new ExtensionLoader()


exports.index = auth.handler ->*
    editorsPicks = yield models.Post.find { meta: 'pick', 'forum.network': @network.stub }, { sort: db.setRowId({}, -1) , limit: 1 }, {}, db
    featured = yield models.Post.find { meta: 'featured', 'forum.network': @network.stub }, { sort: db.setRowId({}, -1) , limit: 12 }, {}, db
    featured = (f for f in featured when (db.getRowId(x) for x in editorsPicks).indexOf(db.getRowId(f)) is -1)

    for post in editorsPicks.concat(featured)
        extension = yield loader.load yield post.getTypeDefinition()
        template = yield extension.getTemplate 'list'
        component = template { post: post, forum: post.forum, author: post.createdBy }
        post.html = React.renderComponentToString component
        
    coverContent = "<h1>Editor's Picks</h1>
                    <p>Fora is a place to share ideas. To Discuss and to debate. Everything on Fora is free. Right?</p>"

    yield @renderPage 'home/index', { 
        pageName: 'home-page',
        editorsPicks,
        featured,
        coverInfo: {
            cover: {
                image: { src: '/images/cover.jpg' },
            },
            content: coverContent
        }
    }
    
    
    
exports.login = ->*
    yield @renderPage 'home/login', { 
        pageName: 'login-page'
    }
