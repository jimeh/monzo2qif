# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'monzo2qif/version'

Gem::Specification.new do |spec|
  spec.name = 'monzo2qif'
  spec.version = Monzo2QIF::VERSION
  spec.authors = ['Jim Myhrberg']
  spec.email = ['contact@jimeh.me']

  spec.summary = 'Super-hacky and quickly thrown together Monzo to ' \
                 'QIF exporter'
  spec.description = 'Super-hacky and quickly thrown together Monzo to ' \
                     'QIF exporter'
  spec.homepage = 'https://github.com/jimeh/monzo2qif'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.47.1'

  spec.add_runtime_dependency 'activesupport', '~> 5.0.2' # required by mondo
  spec.add_runtime_dependency 'mondo', '~> 0.5.0'
  spec.add_runtime_dependency 'qif', '~> 1.2.0'
  spec.add_runtime_dependency 'trollop', '~> 2.1.2'
end
