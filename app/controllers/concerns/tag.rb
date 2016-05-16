module Tag
  extend ActiveSupport::Concern

  def index
    @tag_class = controller_path.classify.constantize
  end
end
