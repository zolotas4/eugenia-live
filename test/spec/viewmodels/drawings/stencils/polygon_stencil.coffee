define [
  'paper'
  'viewmodels/drawings/stencils/polygon_stencil'
], (paper, PolygonStencil) ->

  describe 'PolygonStencil', ->  
    describe 'has sensible defaults', ->
      beforeEach ->
        @alwaysDefaultsPropertySet =
          resolve: (expression, defaultValue) =>
            defaultValue
      
      it 'defaults x to 0', ->
        result = createPolygonStencil(@alwaysDefaultsPropertySet)
        expect(result.position.x).toBe(0)
      
      it 'defaults y to 0', ->
        result = createPolygonStencil(@alwaysDefaultsPropertySet)
        expect(result.position.y).toBe(0)

      it 'defaults fillColor to white', ->
        result = createPolygonStencil(@alwaysDefaultsPropertySet)
        expect(result.fillColor.toCSS()).toEqual("rgb(255,255,255)")
    
      it 'defaults strokeColor to black', ->
        result = createPolygonStencil(@alwaysDefaultsPropertySet)
        expect(result.strokeColor.toCSS()).toEqual("rgb(0,0,0)")
        
        
    describe 'can use stencil specification', ->
      beforeEach ->
        @alwaysResolvesPropertySet =
          resolve: (expression, defaultValue) =>
            expression
      
      it 'sets position.x according to x option', ->
        result = createPolygonStencil(@alwaysResolvesPropertySet, { x: 5 })
        expect(result.position.x).toBe(5)
    
      it 'sets position.y according to y option', ->
        result = createPolygonStencil(@alwaysResolvesPropertySet, { y: 10 })
        expect(result.position.y).toBe(10)
    
      it 'sets fillColor according to fillColor option', ->
        result = createPolygonStencil(@alwaysResolvesPropertySet, { fillColor: 'red' } )
        expect(result.fillColor.toCSS()).toEqual("rgb(255,0,0)")

      it 'sets strokeColor according to borderColor option', ->
        result = createPolygonStencil(@alwaysResolvesPropertySet, { borderColor: 'blue' } )
        expect(result.strokeColor.toCSS()).toEqual("rgb(0,0,255)")


    describe 'position respects both stencil specification and node position', ->
      beforeEach ->
        @alwaysResolvesPropertySet =
          resolve: (expression, defaultValue) =>
            expression
      
      it 'positions according to x option and x position of node', ->
        result = createPolygonStencil(@alwaysResolvesPropertySet, { x: 5 }, { x : 1 })
        expect(result.position.x).toBe(5 + 1)
    
      it 'positions according to y option and y position of node', ->
        result = createPolygonStencil(@alwaysResolvesPropertySet, { y: 10 }, { y : 3 })
        expect(result.position.y).toBe(10 + 3)
        
    
    createPolygonStencil = (propertySet, stencilSpec = {}, position = {}) ->  
      paper = new paper.PaperScope()
      paper.project = new paper.Project()
      stencil = new FakePolygonStencil(stencilSpec)
      node = new FakeNode(propertySet, position)
      result = stencil.draw(node)      

    class FakePolygonStencil extends PolygonStencil
      createPath: (node) =>  
        new paper.Path.Rectangle(0, 0, 10, 20)

    class FakeNode
      constructor: (@properties, @position) ->
        @position.x or= 0
        @position.y or= 0