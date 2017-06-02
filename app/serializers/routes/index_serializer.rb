module Routes
  class IndexSerializer
    attr_reader :routes

    def initialize(routes)
      @routes = routes
    end

    def as_json(_options = {})
      routes.map { |r| single_serializer.new(r).as_json }
    end

    private

    def single_serializer
      SingleSerializer
    end
  end
end
