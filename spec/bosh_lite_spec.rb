require 'bosh_ladle/bosh_lite'

module BOSHLadle
  describe BOSHLite do
    let(:subnet_id) { 'subnet-deadbeef' }
    let(:name) { 'poison-sumac' }

    let(:ec2) { double('AWS::EC2') }
    let(:fake_vpc) { double('AWS::EC2::VPC') }
    let(:fake_instance) { double('AWS::EC2::Instance') }
    let(:instances) { double('AWS::EC2::Instances') }
    let(:latest_ami) { 'pick-me-ami-187' }
    let(:security_group) { 'secluded-corner-of-the-internet' }
    let(:key_pair_name) { 'magic-sauce' }
    let(:instance_type) { 'rotund' }
    let(:disk_size) { 45 }
    let(:logger) { double('Logger').as_null_object }

    before do
      allow(ec2).to receive(:vpcs).and_return([fake_vpc])
      allow(fake_vpc).to receive(:instances).and_return(instances)
      allow(AMI).to receive(:latest).and_return latest_ami
    end

    it 'creates an AWS instance in the first VPC' do
      expect(instances).to receive(:create).with({image_id:         latest_ami,
                                                  subnet_id:        subnet_id,
                                                  security_groups:  security_group,
                                                  key_name:         key_pair_name,
                                                  instance_type:    instance_type,
                                                  block_device_mappings: [
                                                    {
                                                        device_name: '/dev/sda1',
                                                        ebs: {
                                                            volume_size: disk_size
                                                        }
                                                    },
                                                  ]}).and_return(fake_instance)
      expect(fake_instance).to receive(:tag).with('Name', value: name)

      pendings  = [:pending]*3
      nils      = [nil]*3

      expect(BOSHLite).to receive(:sleep).exactly(pendings.length + nils.length).times
      expect(fake_instance).to receive(:status).and_return(*pendings, :ready)
      expect(fake_instance).to receive(:private_ip_address).and_return(*nils, 'Mars')
      expect(logger).to receive(:info).with(/Mars/)

      BOSHLite.spinup(ec2, subnet_id, name, security_group, key_pair_name, instance_type, disk_size, logger)
    end
  end
end
