class CreatorsController < InheritedResources::Base
  def index
    @creators = Creator.published
  end

  def show
    @creator = Creator.published.find(params[:id])
  end
end
