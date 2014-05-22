Gem::Specification.new do |s|
  s.name        = 'bosh_ladle'
  s.version     = '0.0.2'
  s.license     = 'Apache 2.0'
  s.summary     = 'a CLI for deploying BOSH-lite to the first VPC in an AWS account.'
  s.description = 'a CLI for deploying BOSH-lite to the first VPC in an AWS account.'
  s.authors     = %w(mmb quavmo gajwani chou)
  s.email       = 'support@cloudfoundry.com'
  s.files         = `git ls-files -- lib/*`.split($/)
  s.executables   = ['bosh_ladle']
  s.homepage    = 'https://github.com/pivotal-cf-experimental/bosh_ladle'

  s.add_dependency 'trollop'
  s.add_dependency 'aws-sdk'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
end
