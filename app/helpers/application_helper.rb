module ApplicationHelper
  def video_embed_code(video)
    video_code = video.code
    case video.platform
    when 'YouTube'
      %(<iframe
          src='http://www.youtube.com/embed/#{video_code}?showsearch=0&amp;modestbranding=1'
          width='425' height='319' frameborder='0' allowfullscreen='true'></iframe>).html_safe
    when 'Vimeo'

      %(<object width='425' height='319'>
          <param name='movie'
            value='http://vimeo.com/moogaloop.swf?clip_id=#{video_code}&amp;;server=vimeo.com&amp;fullscreen=0&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0'>
          </param>
          <param name='wmode' value='transparent'></param>
          <embed src='http://vimeo.com/moogaloop.swf?clip_id=#{video_code}&amp;;server=vimeo.com&amp;fullscreen=0&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0' type='application/x-shockwave-flash' wmode='transparent' width='425' height='319'>
          </embed>
        </object>).html_safe
    end
  end

  def properly_linked_address(link)
    if link.start_with?('http://', 'https://', 'mailto:')
      link
    elsif link =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      "mailto:#{link}"
    else
      "http://#{link}"
    end
  end

  def link_to_by_name(object, options = {})
    if object.class == Mode
      link_to_mode(object, options)
    else
      link_to object.name, object, options
    end
  end

  def link_to_by_names(objects, options = {})
    raw objects.map { |object| link_to_by_name(object, options) }.join " <span style='font-weight: normal'>&</span> "
  end

  def link_to_mode(object, options = {})
    link_to object.name, { id: object.id, action: :show, controller: :modes }, options
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'current' : ''

    content_tag(:li) do
      link_to link_text, link_path, class: class_name
    end
  end

  def comma_list(tags)
    sanitize(tags.map { |tag| link_to_by_name tag }.join(', ').html_safe)
  end
end
