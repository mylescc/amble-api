module Walks
  class Error < StandardError
    class RouteNotFound < Error; end
    class RouteAlreadyCompleted < Error; end
    class RouteAlreadyInProgress < Error; end
  end
end
