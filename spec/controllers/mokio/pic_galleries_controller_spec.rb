require 'spec_helper'

module Mokio

  describe Mokio::PicGalleriesController, type: :controller do

    before(:each) do
      @routes = Mokio::Engine.routes
    end

    # This should return the minimal set of attributes required to create a valid
    # Article. As you add validations to Article, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { { :title => "MyString"} }

    # describe "GET index" do
    #   it "assigns all articles as @article" do
    #     article = Article.all
    #     get :index, {}, valid_session
    #     assigns(:pic_gallery).should eq(article)
    #   end
    # end

    describe 'GET new' do
      before(:each) do
        get :new
      end

      it "assigns a new pic_gallery as @pic_gallery" do
        assigns(:pic_gallery).should be_a_new(PicGallery)
      end
    end

    describe 'POST create' do
      describe "with valid params" do
        it "creates a new PicGallery" do
          expect {
            post :create, params: {:pic_gallery => valid_attributes, :save_and_new => 1}
          }.to change(PicGallery, :count).by(1)
        end

        it "assigns a newly created pic_gallery as @pic_gallery" do
          post :create, params: {:pic_gallery => valid_attributes, :save_and_new => 1}
          assigns(:pic_gallery).should be_a(PicGallery)
          assigns(:pic_gallery).should be_persisted
        end

        it "redirects to the index" do
          post :create, params: {:pic_gallery => valid_attributes}
          response.should redirect_to(edit_content_path(assigns(:pic_gallery).id))
        end

        it "has type param = 'PicGallery'" do
          post :create, params: {:pic_gallery => valid_attributes, :save_and_new => 1 }
          assigns(:pic_gallery).type.should == "Mokio::PicGallery"
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved article as @pic_gallery" do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          post :create, params: {:pic_gallery => { "title" => "" }, :save_and_new => 1}
          assigns(:pic_gallery).should be_a_new(PicGallery)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          post :create, params: {:pic_gallery => { "title" => "" }, :save_and_new => 1}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested article" do
          gallery = PicGallery.create! valid_attributes
          # Assuming there are no other articles in the database, this
          # specifies that the Article created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          PicGallery.any_instance.should_receive(:update).with({ "title" => "MyString" })
          put :update, params: {:id => gallery.to_param, :pic_gallery => { "title" => "MyString" }, :save_and_new => 1}
        end

        it "assigns the requested article as @article" do
          gallery = PicGallery.create! valid_attributes
          put :update, params: {:id => gallery.to_param, :pic_gallery => valid_attributes, :save_and_new => 1}
          assigns(:pic_gallery).should eq(gallery)
        end

        it "redirects to the index" do
          gallery = PicGallery.create! valid_attributes
          put :update, params: {:id => gallery.to_param, :pic_gallery => valid_attributes}
          response.should redirect_to(pic_galleries_path)
        end
      end

      describe "with invalid params" do
        it "assigns the article as @article" do
          gallery = PicGallery.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          PicGallery.any_instance.stub(:save).and_return(false)
          put :update, params: {:id => gallery.to_param, :pic_gallery => { "title" => "" }, :save_and_new => 1}
          assigns(:pic_gallery).should eq(gallery)
        end

        it "re-renders the 'edit' template" do
          gallery = PicGallery.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          PicGallery.any_instance.stub(:save).and_return(false)
          put :update, params: {:id => gallery.to_param, :pic_gallery => { "title" => "" }, :save_and_new => 1}
          response.should render_template("edit")
        end
      end
    end
  end
end