module GameHasManyTagJoin
  extend ActiveSupport::Concern

  # Class Methods
  def tag_model_as_symbol
    to_s.sub('Games', '').downcase.to_sym
  end

  # Instance Methods
  included do
    # Associations
    belongs_to :game, counter_cache: true
    belongs_to tag_model_as_symbol, counter_cache: true
  end
end
