require 'role_model'

# class User < ActiveRecord::Base
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :trackable, :validatable
#   include RoleModel

#    # optionally set the integer attribute to store the roles in,
#   # :roles_mask is the default
#   roles_attribute :roles_mask

#   # declare the valid roles -- do not change the order if you add more
#   # roles later, always append them at the end!
#   roles :admin, :content_editor, :menu_editor, :static_module_editor, :user_editor, :comment_approver, :reader

# end

# require 'role_model'
module Mokio
  class User < ActiveRecord::Base
    include Mokio::Concerns::Models::User

    # def admin_view
    #   html = ""
    #   if has_role? :admin
    #     html << "<span class=\"icon12 icomoon-icon-checkmark\"></span>"
    #   else
    #     html << "<span class=\"icon12 icomoon-icon-cancel-3\"></span>"
    #   end
    #   html.html_safe
    # end

    # def last_name_view
    #   html = ""
    #   html << (ActionController::Base.helpers.link_to self[:last_name], ApplicationController.helpers.edit_url(self.class.base_class, self))
    #   html.html_safe
    # end

    # def email_required?
    #   false
    # end

    # def email_changed?
    #   false
    # end

    # def add_default_role
    #   roles << ["editor"]
    # end

    # def forem_name
    #   name
    # end

    # def can_read_forem_category?(category)
    #   persisted?
    # end
    # def can_read_forem_forums?
    #   persisted?
    # end
    # def can_read_forem_forum?(forum)
    #   persisted?
    # end
    # def can_create_forem_topics?(forum)
    #   persisted?
    # end
    # def can_read_forem_topic?(topic)
    #   persisted?
    # end
    # def can_reply_to_forem_topic?(topic)
    #   persisted?
    # end
    # def can_edit_forem_posts?(forum)
    #   persisted?
    # end
  end
end