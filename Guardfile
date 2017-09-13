# HAML
HAML_COMMAND = "RUBYOPT='-W0' haml-lint app/views/".freeze

# haml: on startup
module ::Guard
  class StartChecks < Plugin
    def start
      puts 'Checking haml'
      system(HAML_COMMAND)
      puts 'Checking scss'
      system('scss-lint')
      puts 'Security check'
      system('bundle-audit')
    end
  end
end
guard('start-checks')

# create CSS files on change
guard 'process', name: 'Sass Loader', command: 'sass --watch app/assets/stylesheets/'

# haml: on file save
guard 'kjell', cmd: HAML_COMMAND do
  watch(%r{^app/views/(.+)\.haml$})
end

# scss: on file save
guard 'kjell', cmd: 'scss-lint' do
  watch(%r{^app/assets/stylesheets/(.+)\.scss$})
end

# reek: on startup
guard 'process', name: 'Reek', command: 'reek -s'

# reek: on file save
guard 'kjell', cmd: 'reek -s', exclude: 'tovgdb.rake', all_on_start: true do
  watch(%r{^lib/(.+)\.rb$})
  watch(%r{^app/(.+)\.rb$})
  watch('.reek')
end

# rubocop
guard :rubocop, cli: '-F -D -S' do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

# rails best practices
guard 'guard-railsbp', exclude: 'tovgdb.rake'

# load guardfile on gem change bundler
guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new
  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }
  files.each { |file| watch(helper.real_path(file)) }
end

# security check gems
guard 'bundler_audit', run_on_start: true do
  watch('Gemfile.lock')
end

# refresh browser
guard 'livereload' do
  extensions = {
    css: :css,
    scss: :css,
    sass: :css,
    js: :js,
    coffee: :js,
    html: :html,
    png: :png,
    gif: :gif,
    jpg: :jpg,
    jpeg: :jpeg
  }

  rails_view_exts = %w[erb haml slim]
  compiled_exts = extensions.values.uniq
  watch(%r{public/.+\.(#{compiled_exts * '|'})})

  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/assets/#{path}.#{type}"
    end
  end

  watch(%r{app/views/.+\.(#{rails_view_exts * '|'})$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{config/locales/.+\.yml})
end

# tests
guard :rspec, cmd: 'bundle exec rspec' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w[erb haml slim])
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [rspec.spec.call("routing/#{m[1]}_routing"),
     rspec.spec.call("controllers/#{m[1]}_controller"),
     rspec.spec.call("acceptance/#{m[1]}")]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs)     { |m| rspec.spec.call("features/#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.call("features/#{m[1]}") }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance'
  end
end
