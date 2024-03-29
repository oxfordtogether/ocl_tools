$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'ocl_tools/version'

Gem::Specification.new do |spec|
  spec.name        = 'ocl_tools'
  spec.version     = OclTools::VERSION
  spec.authors     = ['VickyClose']
  spec.email       = ['vicky.r.close@gmail.com']
  spec.homepage    = 'https://github.com/oxfordtogether/ocl_tools'
  spec.summary     = 'Useful stuff for OCL rails applications'
  spec.description = 'Useful stuff for OCL rails applications'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,lib}/**/*', 'Rakefile', 'README.md']

  spec.add_dependency 'pagy', '~> 5.8'
  spec.add_dependency 'rails'
  spec.add_dependency 'stimulus_reflex', '~> 3.5.0-pre8'
  spec.add_dependency 'view_component'
  spec.add_development_dependency 'sqlite3'

  spec.add_development_dependency 'htmlbeautifier'
  spec.add_development_dependency 'solargraph'
end
