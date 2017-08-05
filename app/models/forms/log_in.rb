module Forms
  class LogIn < Base
    ATTRIBUTES = %i[password email].freeze

    attr_accessor(*ATTRIBUTES)

    validates :password, :email, presence: true
  end
end
