module Mokio
  module Concerns
    module Models
      #
      # Concern for User model
      #
      module User
        extend ActiveSupport::Concern

        included do
          include Mokio::Concerns::Models::Common
          include RoleModel

          before_destroy :last_one?

          attr_accessor :only_password
          attr_accessor :current_user
          attr_accessor :confirm_delete
          attr_accessor :recaptcha_token

          delegate :can?, :cannot?, to: :ability
          #
          # Table of roles for user
          #

          ROLES = ["admin", "content_editor", "menu_editor", "static_module_editor", "user_editor", "comment_approver", "reader", "super_admin"]

          devise :database_authenticatable, :rememberable, :recoverable, :trackable,
            :lockable, :timeoutable

          validates_presence_of   :email
          validates_uniqueness_of :email, case_sensitive: true, allow_blank: true, if: :email_changed?
          validates_format_of     :email, with: email_regexp, allow_blank: true, if: :email_changed?

          validates_presence_of     :password, if: :password_required?
          validates_confirmation_of :password, if: :password_required?
          validates_length_of       :password, within: password_length, allow_blank: true
          validate                  :password_complexity, if: :password_required?
          validate                  :only_one_super_admin

          # optionally set the integer attribute to store the roles in,
          # :roles_mask is the default

          roles_attribute :roles_mask

          # declare the valid roles -- do not change the order if you add more
          # roles later, always append them at the end!
          roles :admin, :content_editor, :menu_editor, :static_module_editor, :user_editor, :comment_approver, :reader, :super_admin

          # before_validation :add_default_role
          # belongs_to :market

          def ability
            @ability ||= Mokio::Ability.new(self)
          end

          if Mokio.solr_enabled
            searchable do
            ## Columns where Sunspot knows which data use to index
              text :email
            end
          end

          # Overwrite devise-3.4.1/lib/devise/models/recoverable.rb to force check password is filled
          def reset_password!(new_password, new_password_confirmation)
            self.only_password=true
            super
          end

          def cloneable?
            false
          end

          def only_one_super_admin
            # check amount of super_admins if update is by super_admin (current_user)
            if is_user_logged_in? && (self.id != self.current_user.id) && self.is_super_admin?
                if Mokio::User.where(roles_mask: Mokio::User.roles_mask_by_role(:super_admin)).size > 0
                  errors.add(:email, "can't be multiple users with super_admin role")
                end
            end
          end

          def is_user_logged_in?
            self.current_user.present?
          end

          def set_random_password
            generated_password = SecureRandom.base64(94)
            self.password = generated_password
            self.password_confirmation = generated_password
          end

          def set_pass_creation_token
            raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
            self.reset_password_token = enc
            self.reset_password_sent_at = Time.now.utc
            save(validate: false)
            raw
          end
        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            ["email", "name_view", "roles_view"]
          end

          def roles_mask_by_role(role)
            2**self::ROLES.index(role.to_s)
          end
        end

        #
        # Output for <b>roles</b> parameter, used in CommonController#index
        #
        def roles_view
          results = []
          self.roles.to_a.each do |role|
            trans = I18n.t("users.role_name." + role.to_s)
            if role == :super_admin
              results << "<b class='superadmin'>#{trans}</b>"
            else
              results << trans
            end
          end
          results.join(', ')
        end

        def is_super_admin?
          self.has_role? :super_admin
        end

        def disable_autocomplete_in_forms
          true
        end

        def editable #:nodoc:
          true
        end

        def deletable #:nodoc:
          false
        end

        def name_view
          result = [first_name, last_name].reject { |c| c.blank? }
          result = result.join(' ')
          result = email if result.blank?
          result
        end

        def name #:nodoc:
          email
        end

        def title #:nodoc:
          email
        end

        #
        # Specify what's showed in breadcrumb
        #
        def breadcrumb_name
          email
        end

        #
        # Output for <b>email</b> parameter, used in CommonController#index
        #
        def email_view
          html = ""
          html << (ActionController::Base.helpers.link_to self[:email], ApplicationController.helpers.edit_url(self.class.base_class, self))
          html.html_safe
        end

        def password_required?
          !persisted? || !password.blank? || !password_confirmation.blank? || only_password
        end

        def email_required?
          true
        end

        module ClassMethods
          Devise::Models.config(self, :email_regexp, :password_length)
        end

        private
          def last_one?
            errors.add(:base, "Cannot delete last user") if Mokio::User.count == 1
            errors.blank?
          end

          def password_complexity
            return if /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-\/\\=]).{8,128}$/.match(password)

            errors.add :password, :weak_password
          end
      end
    end
  end
end