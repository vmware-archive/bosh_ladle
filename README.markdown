#BOSH Ladle

*noun*

1. a large long-handled spoon with a cup-shaped bowl, used for serving soup, stew, or sauce.
2. a small single-command CLI tool used for deploying [BOSH-lite](http://github.com/cloudfoundry/bosh-lite) to the first VPC in an AWS account.


```
$ AWS_ACCESS_KEY_ID=ACKACKACKACKACKACK \
AWS_SECRET_ACCESS_KEY=foo+bar \
./bin/bosh_ladle \
--subnet-id 'subnet-deadbeef' \
--name 'sasquatch'
```