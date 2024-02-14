#
# Cookbook:: ec2deployment
# Recipe:: deployEc2instance
#
# Copyright:: 2024, The Authors, All Rights Reserved.

chef_gem 'aws-sdk' do
compile_time true if respond_to?(:compile_time)
end

include recipe 'aws'
aws_creds=data_bag_item('aws', 'credentials')
aws_access_key_id= aws_creds['AKIA3D5UWBF5XF4RBQUR']
aws_secret_key_id= aws_creds['Cu98W3e684BsAo9ehf2mU9Lu2QFP5ROQrrVpfOXI']
aws_region= 'ap-south-1a'

aws_instance 'suvendu-first-ec2instance-using-chef' do
aws_access_key_id aws_access_key_id
aws_secret_key_id aws_secret_key_id
region aws_region
image id 'ami-0449c34f967dbf18a'
instance_type 't2.micro'
key_name 'suvendu-key'
subnet_id 'subnet-02d25feb674b62ccb'
securitygroup_id 'sg-07c272d718b76a8e4'

action :create
end

