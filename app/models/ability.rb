class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == 'Super Admin'
      can :manage, :all
    else
      can :read, ActiveAdmin::Page, name: 'Dashboard'
      can :manage, :all
      ([Game, Creator, DistributionChannel, LinkType] + Game::TAGS).each do |tovgdb_model|
        can :manage, tovgdb_model
      end
    end
  end
end
