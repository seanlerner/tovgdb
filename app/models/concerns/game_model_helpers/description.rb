module GameModelHelpers
  module Description
    include ActionView::Helpers::UrlHelper
    include SharedMethods

    def shortened_description
      return short_description if short_description?
      max_description_length = 200
      return long_description if long_description.size <= max_description_length
      return shorten_and_link_long_description(max_description_length: max_description_length) if long_description.size > max_description_length
    end

    def shorten_and_link_long_description(max_description_length:)
      raw "#{remove_last_word(long_description[0..max_description_length])} ... [#{link_to '<i>more</i>'.html_safe, Rails.application.routes.url_helpers.game_path(self)}]"
    end
  end
end
