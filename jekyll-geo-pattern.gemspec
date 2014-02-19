Gem::Specification.new do |s|
  s.name                  = "jekyll-geo-pattern"
  s.version               = "0.2.1"
  s.summary               = "A liquid tag for Jekyll to generate an SVG/Base64 geo pattern"
  s.authors               = "Garen J. Torikian"
  s.homepage              = "https://github.com/gjtorikian/jekyll-geo-pattern"
  s.license               = "MIT"
  s.files                 = ["lib/jekyll-geo-pattern.rb"]

  s.add_dependency "jekyll"
  s.add_dependency "geo_pattern", "~> 1.1.0"
  s.add_development_dependency "rspec", "~> 2.13.0"
  s.add_development_dependency "rake"
end
