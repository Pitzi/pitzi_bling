Gem::Specification.new do |s|
  s.name = "pitzi_bling"
  s.version = "0.0.1"
  s.date = "2011-09-29"
  s.summary = "integration gem"
  s.files = `git ls-files -z`.split("\x0")
    
  s.add_development_dependency 'rspec', '~> 3.0'

  s.require_paths = ["lib"]
end
