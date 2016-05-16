class ModesController < InheritedResources::Base
  include Tag

  def show
    @mode = Mode.find(params[:id].to_sym)
  end
end
