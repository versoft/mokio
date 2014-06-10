require 'spec_helper'

describe Mokio::Backend::DashboardController do
  # include Devise::TestHelpers
  let(:valid_session) { {} }

  describe "GET show" do
    before(:all) do
      Content.delete_all
      Menu.delete_all
      @root_pl_menu = FactoryGirl.create(:root_pl)
      @top_menu = FactoryGirl.create(:top_pl)
      @loose_content_elt = FactoryGirl.create(:article_displayed_and_active).becomes(Article)
      @invisible_content = FactoryGirl.create(:article_non_displayed).becomes(Article)
      @empty_menu_elt = FactoryGirl.create(:menu, :parent_id => @top_menu.id)
      @menu_with_invisible = FactoryGirl.create(:menu, :parent_id => @top_menu.id)
      @menu_with_invisible.contents << @invisible_content
      @menu_with_invisible.save

      @menu_with_visible = FactoryGirl.create(:menu, :parent_id => @top_menu.id)
      @content = FactoryGirl.create(:article_displayed_and_active).becomes(Article)
      @menu_with_visible.contents << @content
      @menu_with_visible.save
    end

    it "displays loose content" do
      get :show, {}, valid_session
      if (!assigns(:more_loose_content))
        expect(assigns(:loose_content).include?(@loose_content_elt)).to be_true
      end
    end

    it "displays empty menu" do
      get :show, {}, valid_session
      if (!assigns(:more_empty_menu))
        expect(assigns(:empty_menu).include?(@empty_menu_elt)).to be_true
      end
    end

    it "displays invisible menu" do
      get :show, {}, valid_session
      if (!assigns(:more_empty_menu))
        expect(@menu_with_invisible.invisible_content).to be_true
        expect(assigns(:empty_menu).include?(@menu_with_invisible)).to be_true
      end
    end

    it 'does not display assigned content' do
      get :show, {}, valid_session
      expect(assigns(:loose_content).include?(@menu_with_invisible)).to be_false
    end

    it 'does not display menu with visible content' do
      get :show, {}, valid_session
      expect(assigns(:empty_menu).include?(@menu_with_visible)).to be_false
    end

    it "displays last created" do
      get :show, {}, valid_session
      expect(assigns(:last_created).include?(@content)).to be_true
    end

    it "displays last updated" do
      get :show, {}, valid_session
      expect(assigns(:last_updated).include?(@content)).to be_true
    end

  end
end