require 'rails_helper'

RSpec.describe Product, type: :model do
  fields = ['title', 'description', 'price']
  before(:each) do
  @product = Product.create(title: 'AAA', description: '<h1> Desciption <h1>', price: 12)
  end

    describe 'Association'  do
      it { should belong_to(:category) }
      it 'scrip_html' do
        expect(@product.description).to eq ' Desciption '
      end
      it 'lower_case' do
        expect(@product.title).to eq 'aaa'
      end
    end

    describe 'Validate' do
      it 'title_is_shorter_than_description' do
        @product.title = '<h1> Desciption <h1>AAA'
        expect(@product.save).to eq false
        expect(@product.errors.full_messages).to include 'Title have to be shorter than Desciption'
      end
      fields.each do |field|
        it { should validate_presence_of(field) }
      end

    describe 'Numericality' do

      it { should validate_numericality_of(:price) }
      it { should validate_numericality_of(:price).is_greater_than(0) }
    end
  end
end
