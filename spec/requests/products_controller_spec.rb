require 'rails_helper'

RSpec.shared_context :login_user do
  let(:user) { create(:user) }
  before { sign_in user }
end

RSpec.describe ProductsController, type: :request do

  include_context :login_user

  let(:valid_attributes) { FactoryBot.create(:product) }
  let(:invalid_attributes) { FactoryBot.create(:invalid_product) }

  describe "GET #index" do
    context "valid params" do
      it "assigns all products as @products" do
        Product.create! valid_attributes
        get :index, params: {}
        expect(assigns(:products)).to eq([product])
      end

      it "should render the products/index template" do
        get "/products/index"
        expect(response).to render_template("products/index")
      end
    end

    context "invalid params" do
      it "should not render the products/index template" do
        get "/products/index"
        expect(response).to_not render_template("products/index")
      end
    end
  end

  describe "GET #show" do
    context "valid params" do
      it "should assign the selected product as @product" do
        Product.create! valid_attributes
        get :show, params: { id: product.to_param }
        expect(assigns(:product)).to eq(product)
      end
    end

    context "invalid params" do
      it "should not assign the selected product as @product" do
        Product.create! invalid_attributes
        get :show, params: { id: product.to_param }
        expect(assigns(:product)).not_to eq(product)
      end
    end
  end

  describe "GET #new" do
    context "valid params" do
      it "should render a products/new template" do
        get "/products/new"
        expect(response).to render_template(:new)
      end
    end

    context "invalid params" do
      it "should render a products/new template" do
        get "/products/new"
        expect(response).not_to render_template(:new)
      end
    end
  end

  describe "POST #create" do
    context "valid params" do
      it "should create a new product" do
        Product.create! valid_attributes
        expect { post :create, params: { product: valid_attributes } }.to change(Product, :count).by(1)
      end

      it "should assign a newly created product as @product" do
        Product.create! valid_attributes
        post :create, params: {}
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it "redirects to the new product" do
        Product.create! valid_attributes
        post :create, params: valid_attributes
        expect(response).to redirect_to(Product.last)
      end
    end

    context "invalid params" do
      it "should not create a new product" do
        Product.create! invalid_attributes
        expect { post :create, params: { product: valid_attributes } }.to change(Product, :count).by(0)
      end
    end
  end

  describe "GET #edit" do
    context "valid params" do
      it "should assign product as @product" do
        Product.create! valid_attributes
        get :edit, params: { id: product.to_param }
        expect(assigns(:product)).to eq(product)
      end

      it "renders the edit template" do
        get "/products/edit"
        expect(response).to render_template("products/edit")
      end
    end
  end

  describe "PATCH #update" do
    context "valid params" do
      it "updates the requested product" do
        patch :update
        expect(product.reload.name).to eq "New name"
      end
    end
  end

  describe "DELETE #destroy" do
    context "valid params" do
      it "should delete the requested product" do
        Product.create! valid_attributes
        expect { delete :destroy, params: { id: product.to_param } }.to change(Product, :count).by(-1)
      end

      it "should redirect to the products path" do
        Product.create! valid_attributes
        delete :destroy, params: { id: product.to_param }
        expect(response).to redirect_to(products_path)
        expect(response.status).to eq 303
      end
    end
  end
end
