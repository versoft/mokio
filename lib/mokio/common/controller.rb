module Mokio
  module Common
    require "mokio/common/controller/object"
    require "mokio/common/controller/functions"
    require "mokio/common/controller/translations"

    module Controller
      def self.included(base)
        base.send(:include, Mokio::Common::Controller::Object)
        base.send(:include, Mokio::Common::Controller::Functions)
        base.send(:include, Mokio::Common::Controller::Translations)
      end
    end
  end
end