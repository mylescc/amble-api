require "rails_helper"

RSpec.describe Route, type: :model do
  xdescribe "associations" do
    it { is_expected.to have_many(:walks) }
  end
end
