require 'trollop'
require 'aws-sdk'

require 'bosh_ladle/bosh_lite'

module BOSHLadle
  class Cli
    def initialize
      @opts = {}
    end

    def run(args)
      @opts = Trollop::options(args) do
        banner <<-PROGINFO
  This script is meant to spin up BOSH lite VMs inside the GoCD VPC on AWS.
  It requires AWS credentials stored in the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables to use EC2.
  Furthermore, it uses the most recently created BOSH-lite AMI available on the AWS marketplace to create the VM.

  Options:
        PROGINFO
        opt :instance_type, "AWS instance type to use",                             :type => :string, :default => 'm3.xlarge'
        opt :subnet_id, "The subnet ID to put the VM into (e.g. 'subnet-123abc45')", :type => :string, required: true
        opt :security_group, "The security group to put the VM into",               :type => :string, :default => 'bosh', :short => 'g'
        opt :key_pair, "The key pair to use (must be available in AWS)",            :type => :string, :default => 'gocd_bosh_lite'
        opt :name, "A name passed to the BOSH lite image (e.g. <team-name>)",       :type => :string, required: true
        opt :disk_size, "Root disk size in GB",                                     type: :integer, default: 40
      end

      raise ArgumentError.new('Please set AWS_ACCESS_KEY_ID in the environment') if ENV['AWS_ACCESS_KEY_ID'].nil?
      raise ArgumentError.new('Please set AWS_SECRET_ACCESS_KEY in the environment') if ENV['AWS_SECRET_ACCESS_KEY'].nil?


      ec2 = AWS::EC2.new(
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      )

      BOSHLite.spinup(ec2, opts.subnet_id, opts.name, opts.security_group, opts.key_pair, opts.instance_type,
                      opts.disk_size)
      0
    end

    attr_reader :opts
  end
end
