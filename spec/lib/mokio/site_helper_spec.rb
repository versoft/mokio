require 'spec_helper'

describe Mokio::SiteHelper do
  before(:each) do
    @lib = Mokio::SiteHelper  
  end

  context "General configuration" do
    it "has config defined" do
      @lib.config.should_not be(nil)
    end

    it "has debug defined" do
      @lib.debug.should_not be(nil)
    end

    it "applies translation to site_helper key" do
      @lib::T.key("test").should == "site_helper.test"
    end

    it "returns hash for current path" do
      @lib.config = {
        "/backend" => {
          "1" => {},
          "2" => {}
        }
      }

      @lib.steps_for_url("/backend").should == {"1"=>{}, "2"=>{}}
    end
  end

  context "Default data" do
    it "has /backend inluded" do
      @lib.config.should include("/backend")
    end
  end
end