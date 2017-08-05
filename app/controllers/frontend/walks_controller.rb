module Frontend
  class WalksController < BaseController
    def index
      @walks = current_user.walks

    end
  end
end
