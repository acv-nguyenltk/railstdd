require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) { FactoryBot.create(:product) }
  let(:product_attr) { FactoryBot.attributes_for(:product)}
  describe 'Get #index' do
    it 'get a list of products' do
      products = FactoryBot.create_list(:product, 3)
      # products << Product.create(title: '123', description: "1234", price: 4)
      # products << Product.create(title: '123', description: "1234", price: 4)
      get :index
      expect(assigns(:products)).to eq products
    end
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'Get #show' do
    before(:each) do |variable|
      get :show, params: { id: product.id }
    end
    it 'assigns the request product to @product' do
      expect(assigns(:product)).to eq product
    end
    it 'renders the #show view' do
      expect(response).to render_template :show
     end
  end

  describe 'Get #new' do
    it 'assigns the request product to @product' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'Post #create' do
    context 'with valid attributes' do
      it 'creates a new product' do
        expect{
          post :create, params: { product: product_attr }
        }.to change(Product, :count).by(1)
      end
      it 'redirects to the new product' do
        post :create, params: { product: product_attr }
        expect(response).to redirect_to products_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new product' do
        expect{
          post :create, params: { product: product_attr.merge(title: nil) }
        }.to_not change(Product,:count)
      end
      it 'renders the new method' do
        post :create, params: { product: product_attr.merge(title: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'Get #edit' do
    it 'assigns the requested product to @product' do
      get :edit, params: { id: product.id }
      expect(assigns(:product)).to eq product
    end
    it 'renders the :new template' do
      get :edit, params: { id: product.id }
      expect(response).to render_template :new
    end
  end

  describe 'Put #update' do
    context 'with valid attributes' do
      before (:each) do
        put :update, params: { id: product.id,
          product: product_attr.merge(title: 'aa') }
        product.reload
      end
      it 'updated' do
        expect(assigns(:product).title).to eq 'aa'
      end
      it 'redirect_to products_url' do
        expect(response).to redirect_to products_path
      end
    end
    # context 'with invalid attributes' do
    #   before (:each) do
    #     binding.pry
    #     put :update, params: { id: product.id,
    #       product: product }
    #     product.reload
    #   end
    #   it 'update not yet' do
    #     expect{ assigns(:product) }.to eq product
    #   end
    #   it 'redirect_to products_url' do
    #     expect(response).to redirect_to :new
    #   end
    # end
  end

  describe 'Delete #destroy' do
    it 'delete product' do
      expect{
        delete :destroy, params: { id: product.id }
      }.to change(Product, :count).by(0)
    end
    it 'redirects to the products_url' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to products_path
    end
  end
end
