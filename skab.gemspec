spec = Gem::Specification.new do |s|
  s.name              = "skab"
  s.version           = "0.1.1"
  s.summary           = "A/B testing statistical analysis utility"
  s.author            = "Vivien Barousse"
  s.email             = "vivien@songkick.com"
  s.homepage          = "http://github.com/songkick/skab"

  s.extra_rdoc_files  = %w(README.rdoc)
  s.rdoc_options      = %w(--main README.rdoc)

  s.files             = %w(README.rdoc) + Dir.glob("{bin,lib}/**/*")
  s.require_paths     = ["lib"]
  
  s.executables       = Dir.glob("bin/**").map { |f| File.basename(f) }
end

