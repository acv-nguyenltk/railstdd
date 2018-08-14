require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '#index' do
    it 'gets a list of products' do
      products = FactoryBot.create_list(:product, 3)
      # products << Product.create(title: '123', description: "1234", price: 4)
      # products << Product.create(title: '123', description: "1234", price: 4)
      get :index
      expect(assigns(:products)).to eq products
    end
  end
end
