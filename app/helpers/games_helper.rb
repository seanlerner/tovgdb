module GamesHelper
  def join_creators_with_ampersand(creators_to_join:)
    creators_to_join
      .map { |creator| link_to creator.name, creator_path(creator) }
      .join(' &amp; ').html_safe
  end

  def jan_1?(date)
    date.month == 1 && date.day == 1
  end

  def specificity_format_date(date)
    year = date.year
    return year if jan_1?(date)

    day = date.day
    month = Date::MONTHNAMES[date.month]
    if month != 1 && day == 1
      "#{month}, #{year}"
    else
      "#{month} #{day}, #{year}"
    end
  end
end
