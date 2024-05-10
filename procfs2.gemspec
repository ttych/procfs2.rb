# frozen_string_literal: true

require_relative 'lib/procfs2/version'

Gem::Specification.new do |spec|
  spec.name = 'procfs2'
  spec.version = Procfs2::VERSION
  spec.authors = ['Thomas Tych']
  spec.email = ['thomas.tych@gmail.com']

  spec.summary = 'read procfs or /proc pseudo-filesystem.'
  spec.homepage = 'https://gitlab.com/ttych/procfs2'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"

  spec.metadata['rubygems_mfa_required'] = 'true'

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .gitlab-ci.yml appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bump', '~> 0.10.0'
  spec.add_development_dependency 'bundler', '~> 2.5.6'
  spec.add_development_dependency 'byebug', '~> 11.1', '>= 11.1.3'
  spec.add_development_dependency 'minitest', '~> 5.16'
  spec.add_development_dependency 'rake', '~> 13.1'
  spec.add_development_dependency 'reek', '~> 6.1', '>= 6.1.4'
  spec.add_development_dependency 'rubocop', '~> 1.56'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.35.0'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'simplecov', '~> 0.22.0'
end
