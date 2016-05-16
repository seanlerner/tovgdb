class GamesCommunity < ActiveRecord::Base
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
