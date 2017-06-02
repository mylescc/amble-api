require "rails_helper"

RSpec.describe Walk, type: :model do
  xdescribe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:route) }
  end
end
