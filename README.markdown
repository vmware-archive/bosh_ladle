[![Code Climate](https://codeclimate.com/github/pivotal-cf-experimental/bosh_ladle.png)](https://codeclimate.com/github/pivotal-cf-experimental/bosh_ladle) [![Build Status](https://travis-ci.org/pivotal-cf-experimental/bosh_ladle.png)](https://travis-ci.org/pivotal-cf-experimental/bosh_ladle)

#BOSH Ladle

*noun*

1. a large long-handled spoon with a cup-shaped bowl, used for serving soup, stew, or sauce.
2. a small single-command CLI tool used for deploying [BOSH-lite](http://github.com/cloudfoundry/bosh-lite) to the first VPC in an AWS account.

This script is meant to spin up BOSH lite VMs inside the GoCD VPC on AWS.  It requires AWS credentials stored in the
AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables to use EC2. Furthermore, it uses the most recently
created BOSH-lite AMI available on the AWS marketplace to create the VM.

## Installation

`gem install bosh_ladle`

If you are using rbenv you will need to rbenv rehash.

## Usage

```
Options:
   --instance-type, -i <s>:   AWS instance type to use (default: m3.xlarge)
   --subnet-id, -s <s>:       The subnet ID to put the VM into (e.g. 'subnet-123abc45')
   --security-group, -g <s>:  The security group to put the VM into (default: bosh)
   --key-pair, -k <s>:        The key pair to use (must be available in AWS)
                              (default: gocd_bosh_lite)
   --name, -n <s>:            A name passed to the BOSH lite image (e.g. <team-name>)
   --help, -h:                Show this message
```

## Examples

Minimal:

```sh
AWS_ACCESS_KEY_ID=ACKACKACKACKACKACK \
AWS_SECRET_ACCESS_KEY=foo+bar \
bosh_ladle \
--subnet-id 'subnet-deadbeef' \
--name 'sasquatch'
```

Full:

```sh
AWS_ACCESS_KEY_ID=ACKACKACKACKACKACK \
AWS_SECRET_ACCESS_KEY=foo+bar \
bosh_ladle \
--instance-type m3.xlarge \
--subnet-id 'subnet-deadbeef' \
--security-group topsecret \
--key-pair gocd_bosh_lite \
--name 'sasquatch'
```
