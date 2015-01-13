require 'spec_helper'

module Mokio

  describe Mokio::MovGalleriesController do

    # This should return the minimal set of attributes required to create a valid
    # Article. As you add validations to Article, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { { :title => "MyString" } }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # ArticlesController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    # describe "GET index" do
    #   it "assigns all articles as @article" do
    #     article = Article.all
    #     get :index, {}, valid_session
    #     assigns(:mov_gallery).should eq(article)
    #   end
    # end

    before(:each) do
      @routes = Mokio::Engine.routes
    end

    describe 'GET new' do
      before(:each) do
        get :new
      end

      it "assigns a new mov_gallery as @mov_gallery" do
        assigns(:mov_gallery).should be_a_new(MovGallery)
      end
    end

    describe 'POST create' do
      describe "with valid params" do
        it "creates a new MovGallery" do
          expect {
            post :create, {:mov_gallery => valid_attributes}, valid_session
          }.to change(MovGallery, :count).by(1)
        end

        it "assigns a newly created mov_gallery as @mov_gallery" do
          post :create, {:mov_gallery => valid_attributes}, valid_session
          assigns(:mov_gallery).should be_a(MovGallery)
          assigns(:mov_gallery).should be_persisted
        end

        it "redirects to the index" do
          post :create, {:mov_gallery => valid_attributes}, valid_session
          response.should redirect_to(edit_content_path(assigns(:mov_gallery).id))
        end

        it "has type param = 'MovGallery'" do
          post :create, {:mov_gallery => valid_attributes }, valid_session
          assigns(:mov_gallery).type.should == "Mokio::MovGallery"
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved article as @mov_gallery" do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          post :create, {:mov_gallery => { "title" => "" }}, valid_session
          assigns(:mov_gallery).should be_a_new(MovGallery)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          post :create, {:mov_gallery => { "title" => "" }}, valid_session
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested article" do
          gallery = MovGallery.create! valid_attributes
          # Assuming there are no other articles in the database, this
          # specifies that the Article created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          MovGallery.any_instance.should_receive(:update).with({ "title" => "MyString" })
          put :update, {:id => gallery.to_param, :mov_gallery => { "title" => "MyString" }}, valid_session
        end

        it "assigns the requested article as @article" do
          gallery = MovGallery.create! valid_attributes
          put :update, {:id => gallery.to_param, :mov_gallery => valid_attributes}, valid_session
          assigns(:mov_gallery).should eq(gallery)
        end

        it "redirects to the index" do
          gallery = MovGallery.create! valid_attributes
          put :update, {:id => gallery.to_param, :mov_gallery => valid_attributes}, valid_session
          response.should redirect_to(mov_galleries_path)
        end
      end

      describe "with invalid params" do
        it "assigns the article as @article" do
          gallery = MovGallery.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          MovGallery.any_instance.stub(:save).and_return(false)
          put :update, {:id => gallery.to_param, :mov_gallery => { "title" => "" }}, valid_session
          assigns(:mov_gallery).should eq(gallery)
        end

        it "re-renders the 'edit' template" do
          gallery = MovGallery.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          MovGallery.any_instance.stub(:save).and_return(false)
          put :update, {:id => gallery.to_param, :mov_gallery => { "title" => "" }}, valid_session
          response.should render_template("edit")
        end
      end
    end
  end
end