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

class User < ActiveRecord::Base
  ROLES = ["admin", "content_editor", "menu_editor", "static_module_editor", "user_editor", "comment_approver", "reader"]
  include Mokio::Common::Model
  include Mokio::SolrConfig
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :recoverable, :trackable #, :validatable # :registerable,
  include RoleModel
  validates :email, uniqueness: true
  validates :password, length: {in: 6..12}, unless: "password.blank?"
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, :on => :create
  validates :password, presence: true, :on => :create
 

  # optionally set the integer attribute to store the roles in,
  # :roles_mask is the default
  roles_attribute :roles_mask

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :admin, :content_editor, :menu_editor, :static_module_editor, :user_editor, :comment_approver, :reader
  # before_validation :add_default_role
  belongs_to :market

  def self.columns_for_table
    ["email", "roles"]
  end

  def roles_view
    self.roles.to_a.map{|m| I18n.t("users.role_name." + m.to_s)}.join(', ')
  end

  def editable
    true
  end

  def deletable
    true
  end

  # def admin_view
  #   html = ""
    
  #   if has_role? :admin
  #     html << "<span class=\"icon12 icomoon-icon-checkmark\"></span>"
  #   else
  #     html << "<span class=\"icon12 icomoon-icon-cancel-3\"></span>"
  #   end
  #   html.html_safe
  # end
  
  def name
    email
  end
  
  def title
    email
  end

  def email_view
    html = ""
    html << (ActionController::Base.helpers.link_to self[:email], ApplicationController.helpers.edit_url(self.class.base_class, self))
    html.html_safe
  end

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

  if Mokio::SolrConfig.enabled
    searchable do
    ## Columns where Sunspot knows which data use to index
      text :email
    end
  end
end
