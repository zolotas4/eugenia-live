require = window.require

describe 'Toolbox', ->
  Toolbox = require('controllers/toolbox')

  beforeEach -> @t = new Toolbox()

  it 'switches to NodeTool when initialised', ->
    expect(@t.currentTool).toBe(@t.tools.node)
  
  it 'activates specified tool after switching', ->
    @t.switchTo('select')
    expect(@t.currentTool).toBe(@t.tools.select)

  it 'errors when switching to an unknown tool', ->
    expect( => @t.switchTo('detonator')).toThrow("There is no tool named 'detonator'")
    
  it 'adds configuration values to the parameters of the current tool', ->
    expect(@t.currentTool.parameters.foo).toBeUndefined()
    @t.configureCurrentToolWith("foo", "bar")
    expect(@t.currentTool.parameters.foo).toEqual("bar")