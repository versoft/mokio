require 'spec_helper'

describe Mokio do
  context 'mokio require' do
    it "requires core_extension" do
      require "mokio/core_extension"
    end

    it "requires engine" do
      require "mokio/engine"
    end

    it "requires exceptions" do
      require "mokio/exceptions"
    end

    it "requires simple-form-wrappers" do
      require "mokio/simple-form-wrappers"
    end

    it "requires uploader" do
      require "mokio/uploader"
    end

    it "requires solr_config" do
      require "mokio/solr_config"
    end

    it "requires site_helper" do
      require "mokio/site_helper"
    end

    it "requires concerns" do
      require "mokio/concerns"
    end

    it "requires frontend_helpers" do
      require "mokio/frontend_helpers"
    end

    it "requires logger" do
      require "mokio/logger"
    end

    it "requires template_renderer" do
      require "mokio/template_renderer"
    end
  end

  context 'gems require' do
    it "requires jquery-rails" do
      require 'jquery-rails'
    end

    it "requires jquery-ui-rails" do
      require 'jquery-ui-rails'
    end
    
    it "requires haml-rails" do
      require 'haml-rails'
    end
    
    it "requires simple_form" do
      require 'simple_form'
    end

    it "requires ckeditor" do
      require "ckeditor"
    end
    
    it "requires bootstrap-wysihtml5-rails" do
      require "bootstrap-wysihtml5-rails"
    end

    it "requires carrierwave" do
      require "carrierwave"
    end

    it "requires jquery-fileupload-rails" do
      require "jquery-fileupload-rails"
    end

    it "requires amoeba" do
      require 'amoeba'
    end

    it "requires fancybox2-rails" do
      require 'fancybox2-rails'
    end

    it "requires bootstrap-switch-rails" do
      require "bootstrap-switch-rails"
    end

    it "requires youtube_it" do
      require 'youtube_it'
    end

    it "requires ancestry" do
      require 'ancestry'
    end

    it "requires acts_as_list" do
      require 'acts_as_list'
    end
     
    it "requires jquery-datatables-rails" do
      require 'jquery-datatables-rails'
    end

    it "requires will_paginate" do
      require 'will_paginate'
    end

    it "requires sunspot_rails" do
      require 'sunspot_rails'
    end

    it "requires faraday" do
      require 'faraday'
    end

    it "requires validates" do
      require 'validates'
    end

    it "requires friendly_id" do
      require 'friendly_id'
    end

    it "requires video_info" do
      require 'video_info'
    end

    it "requires disqus" do
      require 'disqus'
    end

    it "requires devise" do
      require 'devise'
    end

    it "requires cancancan" do
      require 'cancancan'
    end

    it "requires role_model" do
      require 'role_model'
    end

    it "requires sass-rails" do
      require 'sass-rails'
    end

    it "requires slim" do
      require 'slim'
    end
  end
end