class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == 'Super Admin'
      can :manage, :all
    else
      can :read, ActiveAdmin::Page, name: 'Dashboard'
      can :manage, Game
    end
  end
end
