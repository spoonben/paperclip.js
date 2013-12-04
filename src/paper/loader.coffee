modifiers      = require "./modifiers"

FragmentWriter = require "./writers/fragment"
BlockWriter    = require "./writers/block"
TextWriter     = require "./writers/text"
ElementWriter  = require "./writers/element"
ParseWriter    = require "./writers/parse"

BindingCollection = require "./bindings/collection"
bindable = require "bindable"
loaf = require "loaf"

class Loader

  ###
  ###

  __isLoader: true
  
  ###
  ###

  constructor: (@template) ->

    # application is a replacement for DOM window
    @application = @template.application
    @nodeFactory = @application.nodeFactory
    @paper       = template.paper

    @bindings = new BindingCollection()

    # writers needed for access to the binding collection
    @_writers = 
      fragment : new FragmentWriter @
      block    : new BlockWriter @
      text     : new TextWriter @
      element  : new ElementWriter @
      parse    : new ParseWriter @


  ###
  ###

  load: (context = {}) ->

    unless context.__isBindable
      context = new bindable.Object context

    @context = context


    # writes the DOM
    node = @paper @_writers.fragment.write,
    @_writers.block.write,
    @_writers.element.write,
    @_writers.text.write,
    @_writers.parse.write,
    modifiers

    @section = loaf @nodeFactory
    @section.append node

    @

  ###
  ###

  bind:() ->
    @bindings.bind @context
    @

  ###
  ###

  render: () ->
    @section.show()
    @section

  ###
  ###

  remove: () ->
    @section.hide()
    @

  ###
  ###

  dispose: () ->
    @unbind()
    @section.dispose()
    @

  ###
  ###

  unbind: () -> 
    @bindings.unbind()
    @

  ###
  ###

  toFragment: () ->
    @section.toFragment()

  ###
  ###

  toString: () -> 

    if @nodeFactory.name is "string"
      return @section.toString()

    frag = @section.toFragment()

    div = document.createElement "div"
    div.appendChild frag.cloneNode true
    return div.innerHTML



module.exports = Loader
