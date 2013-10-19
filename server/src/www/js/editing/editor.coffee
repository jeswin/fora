class Editor
    
    constructor: (@typeDefinition) ->
        @editables = $('[data-field-type]')
                        

        
    editPage: =>
        @editables.highlight()        
    
        for e in @editables
            do (e) =>
                e =  $(e)
                switch e.data('field-type')                
                    when 'title'
                        @setupTextElement e
                                            
                    when 'text'            
                        @setupTextElement e
                                    
                        config = { 
                            toolbar: [ { name: 'basicstyles', items : [ 'Bold','Italic' ] } ]
                        }
                        
                        config.on = {
                            instanceReady: (evt) => 
                                evt.editor.focus()
                            focus: (evt) =>
                                setTimeout (=>
                                    editor = evt.editor
                                    range = editor.createRange()
                                    range.moveToElementEditStart editor.editable()
                                    range.select()
                                    range.scrollIntoView()), 100
                        }
                        
                        ckeditor = CKEDITOR.inline e[0], config        

                
    
    setupTextElement: (e) =>    
        e.attr 'contenteditable', true

        handleEmpty = =>
            if not e.text().trim() and e.data 'placeholder'
                e.addClass 'placeholder'
                e.html e.data 'placeholder'

        e.keypress =>
            if e.hasClass 'placeholder'
                e.removeClass 'placeholder'
                e.html ''
        
        e.blur =>
            handleEmpty e
            
        handleEmpty e
        
        
        
    update: (record) =>
        for e in @editables
            e =  $(e)
            switch e.data('field-type')                
                when 'title'
                    record[$('fieldname-title')] = e.text()
                when 'text'
                    record[$('fieldname-text')] = e.text()
                    
                    

CKEDITOR.disableAutoInline = true

window.Fora.Editing.Editor = Editor
