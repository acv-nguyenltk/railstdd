require 'rails_helper'

RSpec.describe Product, type: :model do
  fields = ['title', 'description', 'price']
  context "Validations" do
    context '1' do
    fields.each do |field|
      it { should validate_presence_of(field) }
    end
    context '2'
      it { should validate_numericality_of(:price) }
      # if { should have_many(:products) }
    end

  end
end
