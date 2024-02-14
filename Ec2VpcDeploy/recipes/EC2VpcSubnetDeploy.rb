#
# Cookbook:: Ec2VpcDeploy
# Recipe:: EC2VpcSubnetDeploy
#
# Copyright:: 2024, The Authors, All Rights Reserved.

chef_gem 'aws-sdk' do
compile_time true if respond_to?(:compile_time)
end


include_recipe 'aws'
aws_creds=data_bag_item('aws','credentials')
aws_access_key_id= aws_creds['enter your access key']
aws_secret_key_id= aws_creds['enter your secret key']
aws_region= 'ap-south-1a'

#vpc details
vpc_name='suvendu-custom-vpc'
vpc_cidr_block='10.0.0.0/16'

#subnet details
subnet_name='suvendu-public-subnet'
subnet_cidr_block='10.0.1.0/24'
availability_zone='aps1-az1'

#create a VPC
aws_vpc 'suvendu-custom-vpc' do
action :create
cidr_block '10.0.0.0/16'
region 'ap-south-1a'
aws_access_key_id= aws_creds['enter your access key']
aws_secret_key_id= aws_creds['enter your secret key']
end

#create Subnet
aws_subnet 'suvendu-public-subnet'
action :create
vpc 'suvendu-custom-vpc'
cidr_block '10.0.1.0/24'
availability_zone 'aps1-az1'
aws_access_key_id= aws_creds['enter your access key']
aws_secret_key_id= aws_creds['enter your secret key']
region 'ap-south-1a'
end

#create an internet gateway
aws_internet_gateway 'suvendu-internet-gateway' do
action :create
vpc 'suvendu-custom-vpc'
aws_access_key_id= aws_creds['enter your access key']
aws_secret_key_id= aws_creds['enter your secret key']
region 'ap-south-1a'
end

#create Route Table
aws_route_table 'suvendu-public-route' do
action :create
vpc 'suvendu-custom-vpc'
aws_access_key_id= aws_creds['enter your access key']
aws_secret_key_id= aws_creds['enter your secret key']
region 'ap-south-1a'
end

#associate the route table with the internet gateway
aws_route_table_association 'association-route-table'
action :create
vpc 'suvendu-custom-vpc'
subnet 'suvendu-public-subnet'
aws_access_key_id= aws_creds['enter your access key']
aws_secret_key_id= aws_creds['enter your secret key']
region 'ap-south-1a'
end

aws_instance 'suvendu-ec2instance-using-chef' do
aws_access_key_id aws_access_key_id
aws_secret_key_id aws_secret_key_id
region 'ap-south-1a'
image id 'ami-0449c34f967dbf18a'
instance_type 't2.micro'
key_name 'suvendu-key'
vpc 'suvendu-custom-vpc'
subnet_id 'suvendu-public-subnet'
securitygroup_id 'sg-07c272d718b76a8e4'

action :create
end




