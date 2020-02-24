module Mokio
  class Ability
    include CanCan::Ability

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
    def initialize(user)
      if user.has_role? :super_admin
        can :manage, :all
      end
      if user.has_role? :admin
        can :manage, :all
        cannot :manage, Mokio::User do |u|
          u.roles.include?(:super_admin)
        end
      end
      if user.has_role? :content_editor
        can :manage, [Mokio::Content]
      end
      if user.has_role? :menu_editor
        can :manage, [Mokio::Menu]
      end
      if user.has_role? :static_module_editor
        can :manage, [Mokio::StaticModule]
      end
      if user.has_role? :user_editor
        can :manage, [Mokio::User]
        cannot :manage, Mokio::User do |u|
          u.roles.include?(:super_admin)
        end
      end
      if user.has_role? :reader
        can :read, :all
      end

      can :edit_password, Mokio::User
      can :update_password, Mokio::User
    end
  end
end
