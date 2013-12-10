define [
  'controllers/tool'
  'models/node'
  'models/commands/move_node'
], (Tool, Node, MoveNode) ->

  class SelectTool extends Tool
    parameters: {}
  
    onMouseDown: (event) =>
      @clearSelection()
      @select(@hitTester.nodeOrLinkAt(event.point))
      @current = event.point
      @start = event.point
      
    onMouseDrag: (event) =>
      for item in @selection() when item instanceof Node
        @run(new MoveNode(item, event.point.subtract(@current)), undoable: false)
        @current = event.point
  
    onMouseUp: (event) =>
      for item in @selection() when item instanceof Node
        @commander.add(new MoveNode(item, event.point.subtract(@start)))