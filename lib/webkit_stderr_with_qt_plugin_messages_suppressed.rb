Capybara::Webkit.configure(&:block_unknown_urls)

class WebkitStderrWithQtPluginMessagesSuppressed
  IGNOREABLE = Regexp.new([
    # 'CoreText performance',
    # 'userSpaceScaleFactor',
    # 'Internet Plug-Ins',
    # 'is implemented in bo'
  ].join('|'))

  def write(message)
    if message =~ IGNOREABLE
      0
    else
      puts(message)
      1
    end
  end
end

Capybara.register_driver :webkit_with_qt_plugin_messages_suppressed do |app|
  Capybara::Webkit::Driver.new(
    app,
    Capybara::Webkit::Configuration.to_hash.merge( # <------ maintain configuration set in Capybara::Webkit.configure block
      stderr: WebkitStderrWithQtPluginMessagesSuppressed.new
    )
  )
end

Capybara.javascript_driver = :webkit_with_qt_plugin_messages_suppressed
