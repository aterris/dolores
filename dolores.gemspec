require File.expand_path('../lib/dolores/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name        = 'dolores'
  spec.version     = Dolores::VERSION
  spec.licenses    = ['MIT']
  spec.summary     = "Build Chatbots with Wit.ai"
  spec.description = "0 to a chatbot real quick"
  spec.authors     = ["Andrew Terris"]
  spec.email       = 'atterris@gmail.com'
  spec.files       =  Dir['lib/**/*']
  spec.homepage    = 'https://www.delores.io'
  spec.executables = ['dolores']
  
  spec.add_dependency 'thor','~> 0.18'
  spec.add_dependency 'twilio-ruby', '~> 4.11'
  spec.add_dependency 'activesupport', '~> 4.0'
  spec.add_dependency 'pry', '~> 0.10'
  spec.add_dependency 'httparty', '~> 0.13'
  spec.add_dependency 'logging', '~> 2.0'

  spec.add_development_dependency 'rspec', '~> 3.0'
end