Kernel.load 'lib/sottolio/version.rb'

Gem::Specification.new { |s|
  s.name        = 'sottolio'
  s.version     = Sottolio::VERSION
  s.author      = 'Giovanni Capuano'
  s.email       = 'webmaster@giovannicapuano.net'
  s.homepage    = 'http://github.com/RoxasShadow/sottolio'
  s.description = 'Engine to make visual novel games to be run inside your web browser.'
  s.summary     = 'sottolio is a game engine to create visual novels with ease. These games run everywhere, you only need a decent internet browser.'
  s.license     = 'GPL-3'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'opal', '~> 0.8'

  s.add_development_dependency 'rake', '~> 10.4'
}
