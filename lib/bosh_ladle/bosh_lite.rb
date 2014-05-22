require 'bosh_ladle/ami'
require 'logger'

module BOSHLadle
  class BOSHLite
    def self.spinup(ec2, subnet, name, security_group, key_pair_name, instance_type, disk_size, logger=Logger.new(STDOUT))
      instance = ec2.vpcs.first.instances.create(
          subnet_id: subnet,
          image_id: AMI.latest,
          security_groups: security_group,
          key_name: key_pair_name,
          instance_type: instance_type,
          block_device_mappings: [
              {device_name: '/dev/sda1', ebs: {volume_size: disk_size}},
          ]
      )
      instance.tag('Name', value: name)

      wait_for_instance_ready(instance, logger)
      address = wait_for_ip(instance, logger)

      logger.info("Instance IP: #{address}")
    end

    private

    def self.wait_for_instance_ready(instance, logger)
      while instance.status == :pending
        logger.info('Waiting for instance to be available...')
        sleep 1
      end
    end

    def self.wait_for_ip(instance, logger)
      until address = instance.private_ip_address
        logger.info('Waiting for IP address...')
        sleep 1
      end

      address
    end
  end
end
