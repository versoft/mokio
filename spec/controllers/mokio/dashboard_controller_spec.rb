require 'spec_helper'

module Mokio

  describe Mokio::DashboardController, type: :controller do
    # include Devise::Test::ControllerHelpers
    let(:valid_session) { {} }

    before :each do
      @routes = Mokio::Engine.routes
    end

    describe "GET show" do
      before(:each) do
        Content.delete_all
        Menu.delete_all
        FactoryBot.create(:lang_pl) #lang creates menu too
        @top_menu = FactoryBot.create(:top_pl)
        @loose_content_elt = FactoryBot.create(:article_displayed_and_active).becomes(Article)
        @invisible_content = FactoryBot.create(:article_non_displayed).becomes(Article)
        @empty_menu_elt = FactoryBot.create(:menu, :parent_id => @top_menu.id)
        @menu_with_invisible = FactoryBot.create(:menu, :parent_id => @top_menu.id)
        @menu_with_invisible.contents << @invisible_content
        @menu_with_invisible.save

        @menu_with_visible = FactoryBot.create(:menu, :parent_id => @top_menu.id)
        @content = FactoryBot.create(:article_displayed_and_active).becomes(Article)
        @menu_with_visible.contents << @content
        @menu_with_visible.save
      end

      it "displays loose content" do
        get :show
        if (!assigns(:more_loose_content))
          expect(assigns(:loose_content).include?(@loose_content_elt)).to be_truthy
        end
      end

      it "displays empty menu" do
        get :show
        if (!assigns(:more_empty_menu))
          expect(assigns(:empty_menu).include?(@empty_menu_elt)).to be_truthy
        end
      end

      it "displays invisible menu" do
        get :show
        if (!assigns(:more_empty_menu))
          expect(@menu_with_invisible.invisible_content).to be_truthy
          expect(assigns(:empty_menu).include?(@menu_with_invisible)).to be_truthy
        end
      end

      it 'does not display assigned content' do
        get :show
        expect(assigns(:loose_content).include?(@menu_with_invisible)).to be_falsey
      end

      it 'does not display menu with visible content' do
        get :show
        expect(assigns(:empty_menu).include?(@menu_with_visible)).to be_falsey
      end

      it "displays last created" do
        get :show
        expect(assigns(:last_created).include?(@content)).to be_truthy
      end

      it "displays last updated" do
        get :show
        expect(assigns(:last_updated).include?(@content)).to be_truthy
      end

    end
  end
end
