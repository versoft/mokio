
#
# Creating simple actions for controllers, use in others with < Backend::CommonController
# 
# To override some actions just simply define them in your controller
#
# If you need to add something more but still use CommonController remeber to call 'super' in your controller action
# ex:
# class Backend::SamplesController < Backend::CommonController
#   def index
#     super
#     my_additional_action
#   end
# end
#
# Remember that CommonController uses variable named as your controller
# For samples_controller variable is @sample
# => See obj method in Common::Controller::Object lib
#
class Mokio::CommonController < Mokio::BaseController
  include Mokio::Concerns::Controllers::Common
end
