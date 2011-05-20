$:.push File.expand_path('../lib', __FILE__)
require 'questionable'

Gem::Specification.new do |s|
  s.name        = 'questionable'
  s.version     = Questionable::VERSION
  s.author      = 'Lee Jarvis'
  s.email       = 'lee@jarvis.co'
  s.homepage    = 'http://github.com/injekt/questionable'
  s.summary     = 'Question your objects!'
  s.description = 'Easily add method helpers for testing instance variables'
  s.files       = `git ls-files`.split('\n')
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split('\n')
end
