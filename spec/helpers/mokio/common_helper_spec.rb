require 'spec_helper'

module Mokio

  describe Mokio::Backend::CommonHelper do
    before(:each) do
      helper.extend Haml
      helper.extend Haml::Helpers
      helper.send :init_haml_helpers
      @routes = Mokio::Engine.routes
    end

    describe "buttons" do
      describe 'table_controls_edit_btn' do
        before(:each) do
          @btn = helper.table_controls_edit_btn("link")
        end

        it 'creates link' do
          @btn.should =~ /href="link"/
        end

        it 'has edit title' do
          title = helper.bt("edit")
          @btn.should match("title=\"#{title}\"")
        end

        it 'creates button' do
          @btn.should =~ /<a aria-describedby="qtip-2" class="tip" data-hasqtip="true" href="link" title="Edytuj"><span class="icon12 icomoon-icon-pencil" \/><\/a>/
        end
      end

      describe 'table_controls_delete_btn' do
        before(:each) do
          @btn = helper.table_controls_delete_btn("link")
        end

        it 'creates link' do
          @btn.should =~ /href="link"/
        end

        it 'has delete title' do
          title = helper.bt("delete")
          @btn.should match("title=\"#{title}\"")
        end

        it 'creates button' do
          @btn.should =~ /<a class="tip" data-confirm=".*" data-hasqtip="true" data-method="delete" href="link" rel="nofollow" title=".*"><span class="icon12 icomoon-icon-remove" \/><\/a>/
        end
      end

      describe 'table_controls_copy_btn' do
        before(:each) do
          @btn = helper.table_controls_copy_btn("link")
        end

        it 'creates link' do
          @btn.should =~ /href="link"/
        end

        it 'has copy title' do
          title = helper.bt("copy")
          @btn.should match("title=\"#{title}\"")
        end

        it 'creates button' do
          @btn.should =~ /<a aria-describedby="qtip-2" class="tip" data-hasqtip="true" href="link" title=".*"><span class="icon12 icomoon-icon-copy-2" \/><\/a>/
        end
      end

      describe 'btn_new' do
        before(:each) do
          @btn = helper.btn_new("name", "link")
        end

        it 'creates link' do
          @btn.should =~ /href="link"/
        end

        it 'creates button' do
          @btn.should =~ /<a href="link"><button class="btn btn-primary btn-mini">/
        end

        it 'place name inside button' do
          @btn.should =~ /[button].[name].[\/button]/
        end
      end

      describe 'btn_submit' do
        before(:each) do
          @btn = helper.btn_submit("name")
        end

        it 'is submit type' do
          @btn.should =~ /type="submit"/
        end

        it 'creates button' do
          @btn.should =~ /<button class="btn btn-primary"/
        end

        it 'place name inside button' do
          @btn.should =~ /[button].[name].[\/button]/
        end
      end

      describe 'btn_cancel' do
        before(:each) do
          @btn = helper.btn_cancel("link")
        end

        it 'creates link' do
          @btn.should =~ /href="link"/
        end

        it 'creates button' do
          @btn.should =~ /<a class="btn"/
        end

        it 'has cancel name' do
          name = helper.bt("cancel")
          @btn.should =~ /#{name}/
        end
      end

      describe 'active_button' do
        before(:each) do
          @btn = helper.active_button
        end

        it 'creates input' do
          @btn.should =~ /<input/
        end

        it 'is checked' do
          @btn.should =~ /checked="checked"/
        end
      end
    end
  end
end