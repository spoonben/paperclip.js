class Parser

  ###
  ###

  constructor: (@_t) ->

  ###
  ###

  parse: (source) ->
    @_source = source
    @_t.source source
    @_parse()

  ###
  ###

  _parse: () ->
    # OVERRIDE ME

  ###
  ###

  _expectNextCode: (code) ->
    @_error() if @_t.next()[0] isnt code

  ###
  ###

  _expectCurrentCode: (code) ->
    @_error() if @_t.current[0] isnt code

  ###
  ###

  _nextCode: () -> @_t.next()?[0]

  ###
  ###

  _nextString: () -> @_t.next()?[1]

  ###
  ###

  _currentCode: () -> @_t.current?[0]

  ###
  ###

  _currentString: () -> @_t.current?[1]


  _error: () ->
    throw new Error "unexpected token in \"#{@_source}\""

module.exports = Parser
