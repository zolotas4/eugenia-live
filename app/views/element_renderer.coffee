class ElementRenderer
  constructor: (item) ->
    @item = item
    @item.bind("update", @render)
    @item.bind("destroy", @remove)

  render: =>
    console.log("rendering " + @item)
    old_el = @el
    
    @draw()
    
    if old_el
      @el.selected = old_el.selected
      old_el.remove()
          
  draw: =>
    throw "No draw method has been defined for: #{@item}"
        
  remove: =>
    @el.remove()
    
module.exports = ElementRenderer