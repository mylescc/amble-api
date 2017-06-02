require "rails_helper"

RSpec.describe User, type: :model do
  xdescribe "associations" do
    it { is_expected.to have_many(:step_days) }
    it { is_expected.to have_many(:walks) }
  end
end