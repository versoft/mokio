require 'spec_helper'

describe Mokio::Backend::PhotosController do
  # let(:valid_attributes) { { :data_file => fixture_file_upload('/files/sample_image.jpg', "image/jpg"), :active => true, :content_id => 1 } }
   let(:valid_attributes) { { :data_file => Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, '/files/sample_image.jpg'), "image/jpg"), :active => true, :content_id => 1 } }
  
  let(:with_seq) { { :data_file => Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path,'/files/sample_image.jpg'), "image/jpg"), :active => true, :seq => 1, :content_id => 1} }
  let(:with_content_id2) { { :data_file => Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path,'/files/sample_image.jpg'), "image/jpg"), :active => true, :seq => 1, :content_id => 2} }
  let(:with_thumb) { { :data_file => Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path,'/files/sample_image.jpg'), "image/jpg"), :active => true, :seq => 1, :content_id => 1, 
   :thumb => Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path,'/files/sample_image.jpg'), "image/jpg")} }

 let(:valid_session) { {} }

  before :all do
    Content.delete_all
    FactoryGirl.create(:content_id1)
    FactoryGirl.create(:content_id2)
  end

  #
  # create
  #
  describe "POST create" do
    after(:each) do
      msg = { notice: CGI::escape(flash[:notice].to_str) } if flash[:notice]
      msg = { error: CGI::escape(flash[:error].to_str) } if flash[:error]
      response.headers['X-Flash-Messages'].should eq(msg.to_json)
    end

    context "flash notices" do
      before(:each) do
        xhr :post, :create, {:photo => valid_attributes}
      end

      it 'has flash notice' do
        flash[:notice].should_not be_nil
      end

      it 'has flash notice from i18n' do
        flash[:notice].should eq(I18n.t("photos.created", title: assigns(:photo).name))
      end
    end

    it "creates a new Photo" do
      expect {
        xhr :post, :create, {:photo => valid_attributes}
      }.to change(Photo, :count).by(1)
    end

    it "assigns photo to @photo" do
      xhr :post, :create, {:photo => valid_attributes}
      assigns(:photo).should be_a(Photo)
      assigns(:photo).should be_persisted
    end

    it "has name = filename" do
      xhr :post, :create, {:photo => valid_attributes}

      name_from_model_method = File.basename(assigns(:photo).data_file.filename, '.*').titleize
      name_from_fixture_file = File.basename(Rails.root + '/files/sample_image.jpg', '.*').titleize

      assigns(:photo).name.should eq(name_from_model_method)
      assigns(:photo).name.should eq(name_from_fixture_file)
    end

    context "sequence" do
      it "has seq 1" do
        xhr :post, :create, {:photo => valid_attributes}
        assigns(:photo).seq.should be(1)
      end

      it "has seq 2" do
        Photo.create(with_seq)

        xhr :post, :create, {:photo => valid_attributes}
        assigns(:photo).seq.should be(2)
      end

      it "should change seq to specific content id" do
        Photo.create(with_content_id2)

        xhr :post, :create, {:photo => valid_attributes}
        assigns(:photo).seq.should be(1)  
      end
    end
  end

  #
  # update
  #
  describe "PUT update" do
    after(:each) do
      msg = { notice: CGI::escape(flash[:notice].to_str) } if flash[:notice]
      msg = { error: CGI::escape(flash[:error].to_str) } if flash[:error]
      response.headers['X-Flash-Messages'].should eq(msg.to_json)
    end

    context "flash notices" do
      before(:each) do
        photo = Photo.create! valid_attributes
        xhr :put, :update, {:id => photo.to_param, :photo => valid_attributes}
      end

      it 'has flash notice' do
        flash[:notice].should_not be_nil
      end

      it 'has flash notice from i18n' do
        flash[:notice].should eq(I18n.t("photos.updated", title: assigns(:photo).name))
      end
    end

    context "update method" do
      before(:each) do
        photo = Photo.create! valid_attributes
        xhr :put, :update, {:id => photo.to_param, :photo => valid_attributes}     
      end

      it "assigns photo to @photo" do
        assigns(:photo).should be_a(Photo)
        assigns(:photo).should be_persisted
      end

      it "should render nothing" do
        response.body.should be_blank
      end
    end
  end

  #
  # destroy
  #
  describe "DELETE destroy" do
    it "destroys the requested photo" do
      photo = Photo.create! valid_attributes
      expect {
        xhr :delete, :destroy, {:id => photo.to_param}, valid_session
      }.to change(Photo, :count).by(-1)
    end

    context "assigns" do
      before(:each) do
        @photo = Photo.create! valid_attributes
        xhr :delete, :destroy, {:id => @photo.to_param}, valid_session
      end

      it "assigns photo to @photo" do
        assigns(:photo).should be_a(Photo)
      end

      it "assigns photo id to @id" do
        assigns(:id).should eq(@photo.id.to_s)
      end
    end

    context "flash notices" do
      before(:each) do
        photo = Photo.create! valid_attributes
        xhr :delete, :destroy, {:id => photo.to_param}, valid_session
      end

      it 'has flash notice' do
        flash[:notice].should_not be_nil
      end

      it 'has flash notice from i18n' do
        flash[:notice].should eq(I18n.t("photos.deleted", title: assigns(:photo).name))
      end
    end
  end

  #
  # get_thumb
  #
  describe "GET get_thumb" do
    it "assigns photo to @edited_photo" do
      photo = Photo.create! valid_attributes
      xhr :get, :get_thumb, {:id => photo.to_param}
      assigns(:edited_photo).should be_a(Photo)
      assigns(:edited_photo).should be_persisted
    end

    it "has no flash notice" do
      photo = Photo.create! valid_attributes
      xhr :get, :get_thumb, {:id => photo.to_param}
      flash[:notice].should be_nil
    end
  end

  #
  # get_photo
  #
  describe "GET get_photo" do
    it "assigns photo to @edited_photo" do
      photo = Photo.create! valid_attributes
      xhr :get, :get_photo, {:id => photo.to_param}
      assigns(:edited_photo).should be_a(Photo)
      assigns(:edited_photo).should be_persisted
    end

    it "has no flash notice" do
      photo = Photo.create! valid_attributes
      xhr :get, :get_photo, {:id => photo.to_param}
      flash[:notice].should be_nil
    end
  end

  #
  # update_thumb
  #
  describe "PATCH update_thumb" do
    after(:each) do
      msg = { notice: CGI::escape(flash[:notice].to_str) } if flash[:notice]
      msg = { error: CGI::escape(flash[:error].to_str) } if flash[:error]
      response.headers['X-Flash-Messages'].should eq(msg.to_json)
    end

    it "assigns photo to @edited_photo" do
      photo = Photo.create! with_thumb
      xhr :patch, :update_thumb, {:id => photo.to_param, :photo => with_thumb}
      assigns(:edited_photo).should be_a(Photo)
      assigns(:edited_photo).should be_persisted
    end

    it 'has thumb' do
      photo = Photo.create! with_thumb
      xhr :patch, :update_thumb, {:id => photo.to_param, :photo => with_thumb}
      assigns(:edited_photo).thumb.blank?.should eq(false)
    end

    context "flash notices" do
      before(:each) do
        photo = Photo.create! with_thumb
        xhr :patch, :update_thumb, {:id => photo.to_param, :photo => with_thumb}
      end

      it 'has flash notice' do
        flash[:notice].should_not be_nil
      end

      it 'has flash notice from i18n' do
        flash[:notice].should eq(I18n.t("photos.thumb_updated"))
      end
    end
  end

  #
  # remove_thumb
  #
  describe "DELETE remove_thumb" do
    after(:each) do
      msg = { notice: CGI::escape(flash[:notice].to_str) } if flash[:notice]
      msg = { error: CGI::escape(flash[:error].to_str) } if flash[:error]
      response.headers['X-Flash-Messages'].should eq(msg.to_json)
    end

    context "flash notices" do
      before(:each) do
        photo = Photo.create! valid_attributes
        xhr :delete, :remove_thumb, {:id => photo.to_param, :photo => valid_attributes}
      end

      it 'has flash notice' do
        flash[:notice].should_not be_nil
      end

      it 'has flash notice from i18n' do
        flash[:notice].should eq(I18n.t("photos.thumb_deleted", name: assigns[:edited_photo].name))
      end
    end

    it "assigns photo to @edited_photo" do
      photo = Photo.create! valid_attributes
      xhr :delete, :remove_thumb, {:id => photo.to_param, :photo => valid_attributes}
      assigns(:edited_photo).should be_a(Photo)
      assigns(:edited_photo).should be_persisted
    end

    it "removes thumb" do
      photo = Photo.create! valid_attributes
      xhr :delete, :remove_thumb, {:id => photo.to_param, :photo => valid_attributes}
      assigns(:edited_photo).thumb.should be_blank
    end
  end

  #
  # crop_thumb
  #
  describe "POST crop_thumb" do
    after(:each) do
      msg = { notice: CGI::escape(flash[:notice].to_str) } if flash[:notice]
      msg = { error: CGI::escape(flash[:error].to_str) } if flash[:error]
      response.headers['X-Flash-Messages'].should eq(msg.to_json)
    end

    it "assigns photo to @edited_photo" do
      photo = Photo.create! with_thumb
      controller.stub(:thumb_path).and_return( photo.thumb.url )
      xhr :post, :crop_thumb, {:id => photo.to_param, :w => 100, :h => 100, :x => 100, :y => 100}
      assigns(:edited_photo).should be_a(Photo)
      assigns(:edited_photo).should be_persisted
    end
  end

  #
  # rotate_thumb
  #
  describe "GET rotate_thumb" do
    after(:each) do
      msg = { notice: CGI::escape(flash[:notice].to_str) } if flash[:notice]
      msg = { error: CGI::escape(flash[:error].to_str) } if flash[:error]
      response.headers['X-Flash-Messages'].should eq(msg.to_json)
    end

    it "assigns photo to @edited_photo" do
      photo = Photo.create! with_thumb
      controller.stub(:thumb_path).and_return( photo.thumb.url )
      xhr :get, :rotate_thumb, {:id => photo.to_param}
      assigns(:edited_photo).should be_a(Photo)
      assigns(:edited_photo).should be_persisted
    end
  end

  # #
  # # crop_photo
  # #
  describe "POST crop_photo" do
    after(:each) do
      msg = { notice: CGI::escape(flash[:notice].to_str) } if flash[:notice]
      msg = { error: CGI::escape(flash[:error].to_str) } if flash[:error]
      response.headers['X-Flash-Messages'].should eq(msg.to_json)
    end

    it "assigns photo to @edited_photo" do
      photo = Photo.create! valid_attributes
      controller.stub(:edited_photo_path).and_return( photo.data_file.url(:normal) )
      xhr :post, :crop_photo, {:id => photo.to_param, :w => 100, :h => 100, :x => 100, :y => 100}
      assigns(:edited_photo).should be_a(Photo)
      assigns(:edited_photo).should be_persisted
    end
  end
end