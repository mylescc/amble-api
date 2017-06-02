require "rails_helper"

RSpec.describe StepDay, type: :model do
  xdescribe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
