class GamesAward < ApplicationRecord
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
