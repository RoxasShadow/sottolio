require 'bundler'
Bundler.require

desc 'Build our app to sottolio.js'
task :build do
  env = Opal::Environment.new
  env.append_path 'app'

  File.open('sottolio.js', 'w+') do |out|
    out << env['application'].to_s
  end
end