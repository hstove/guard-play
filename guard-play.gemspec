# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Hank Stoever"]
  gem.email         = ["hstove@gmail.com"]
  gem.description   = %q{A Guard plugin for watching and running Play Framework tests}
  gem.summary       = %q{Runs play tests when files are changed.}
  gem.homepage      = "https://github.com/hstove"
  gem.add_dependency("faraday")

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "guard-play"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.1"
end
