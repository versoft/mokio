require 'spec_helper'

module Mokio

  describe Mokio::ArticlesController, type: :controller do
    render_views

    before :each do
      @routes = Mokio::Engine.routes
    end

    let(:data_config) {{
      active: {
        field_type: 'select',
        values: [['Aktywny', true], ['Nieaktywny', false]]
      },
      created_at: {
        field_type: 'date'
      },
      title: {
        field_type: 'text'
      }
    }}

    describe "GET index with method filter_index_config" do
      it "check are rendered valid filters" do
        allow(Mokio::Article).to receive(:filter_index_config).and_return(data_config)
        get :index
        expect(response.body).to include('select name="mokio_filters[active]')
        expect(response.body).to include('input type="text" name="mokio_filters[title]')
        expect(response.body).to include('input type="date" name="mokio_filters[created_at]')
      end

      it "check are rendered valid options in select filter" do
        allow(Mokio::Article).to receive(:filter_index_config).and_return(data_config)
        get :index
        expect(response.body).to have_selector(:css, "select[name='mokio_filters[active]'] > option:nth-child(1)[value='']")
        expect(response.body).to have_selector(:css, "select[name='mokio_filters[active]'] > option:nth-child(2)[value='true']")
        expect(response.body).to have_selector(:css, "select[name='mokio_filters[active]'] > option:nth-child(3)[value='false']")
        have_select('mokio_filters_active', options: ['', 'Aktywny', 'Nieaktywny'])
      end
    end

    describe "GET index with no method filter_index_config" do
      it "check are not rendered filters" do
        get :index
        expect(response.body).not_to include('select name="mokio_filters[active]')
        expect(response.body).not_to include('input type="text" name="mokio_filters[title]')
        expect(response.body).not_to include('input type="date" name="mokio_filters[created_at]')
      end
    end

    describe "GET index check data" do
      it "are filtered with mokio filters active on" do
        FactoryBot.create(:article_non_active)
        FactoryBot.create(:article_displayed_and_active)
        get :index, xhr: true, params: {mokio_filters: {active: true}}, format: :json
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["iTotalDisplayRecords"]).to eq(1)
        expect(parsed_body["aaData"].size).to eq(1)
      end

      it "are filtered with mokio filters active and created_at" do
        FactoryBot.create(:article_non_active)
        FactoryBot.create(:article_displayed_and_active)
        Mokio::Article.create!(title: "Test", active: true, created_at: Time.parse("2020-01-31 10:00:00"))

        params = {mokio_filters: {active: true, created_at: "2020-01-31"}}
        get :index, xhr: true, params: params, format: :json
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["iTotalDisplayRecords"]).to eq(1)
        expect(parsed_body["aaData"].size).to eq(1)
      end

      it "are not filtered" do
        FactoryBot.create(:article_non_active)
        FactoryBot.create(:article_non_active)
        FactoryBot.create(:article_displayed_and_active)
        get :index, xhr: true, format: :json
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["iTotalDisplayRecords"]).to eq(3)
        expect(parsed_body["aaData"].size).to eq(3)
      end
    end

  end
end
