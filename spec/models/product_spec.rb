require 'rails_helper'

RSpec.describe Product, type: :model do
  context "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:price) }
  end
end
