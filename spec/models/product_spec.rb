require 'rails_helper'

RSpec.describe Product, type: :model do
  fields = ['title', 'description', 'price']
  product = Product.create(title: 'AAA', description: '<h1> Desciption <h1>', price: 12)
    describe 'Presence' do
      fields.each do |field|
        it { should validate_presence_of(field) }
      end
    describe 'Numericality' do
      it { should validate_numericality_of(:price) }
    end

    describe 'Association'  do
      it { should belong_to(:category) }
      it 'scrip_html' do
        expect(product.description).to eq ' Desciption '
      end
      it 'lower_case' do
        expect(product.title).to eq 'aaa'
      end
      it 'title_is_shorter_than_description' do
        product.title = '<h1> Desciption <h1>AAA'
        expect(product.save).to eq false
        expect(product.errors.full_messages).to include 'Title have to be shorter than Desciption'
      end
    end
  end
end
