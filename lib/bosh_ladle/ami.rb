require 'net/http'
module BOSHLadle
  class AMI
    def self.latest
      bosh_artifacts = 'bosh-lite-build-artifacts.s3.amazonaws.com'
      ami_index = '/ami/bosh-lite-ami.list'

      Net::HTTP.get(bosh_artifacts, ami_index).split("\n").last
    end
  end
end