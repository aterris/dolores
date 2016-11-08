module <%= @module_name %>
  module Actions
    class GetForecast

      def perform(request)
        context = request['context']
        entities = request['entities']
        location = entity_value(entities['location'])

        if location
          context['forecast'] = 'sunny'
        else
          context['missingLocation'] = true
          context.delete 'forecast'
        end

        return context
      end

      private
      def entity_value(entity, index: 0)
        return if entity.nil?

        value = entity[index]['value']
        return value.is_a?(Hash) ? value['value'] : value
      end

    end
  end
end