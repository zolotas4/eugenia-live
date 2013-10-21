define [
  'models/property_set_expression'
  'models/literal_expression'
], (PropertySetExpression, LiteralExpression) ->

  class ExpressionFactory
    _types: [PropertySetExpression, LiteralExpression]
      
    expressionFor: (expression, propertySet) =>
      for type in @_types
        if type.appliesFor(expression)
          return new type(expression, propertySet)