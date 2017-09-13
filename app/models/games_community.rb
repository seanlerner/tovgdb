class GamesCommunity < ApplicationRecord
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
