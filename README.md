# Introduction to terraform with AWS

## Connection to aws

Please create a file called `connections.tf`. Connection is done by providers. You can add the following code for connection

```tf
provider "aws" {
    region = "us-east-1"
    shared_credentials_files = ["location/to/.aws/credentials"]
    profile = "aws-profile"
}
```

you can use the `connection.tf.example` as a template. Then to initialize you run.
```sh
terraform init
```

## Running terraform

after initialization you can add resorces by creating a `.tf` file and creating new resorces as with the following format

```tf
resource "aws_<aws_resource_type>" "<aws_resource_name>" {
    <aws_resource_variables>
}
```
here is an example of adding an AWS VPC network

```tf
resource "aws_vpc" "environment-example" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "terraform-vpc-example"
    }
}
```
<i>the resource variables are uniques based on the resource</i>

then to run the resources first run 

```sh
terraform plan
```

This will go the the resource provider(ie AWS) to determine wether the addition of the resources is possible. It will also show if the resources you want to create are already created or not and weather its possible to do changes if you made changes on the code on terraform. then you will get back a report of action that will be taken into a server if you where to execute the code.

The result will be summarized at the end as 
```
Plan: n to add, n to change, n to destroy
```
Where n stands for number of resources

After the summary you can apply the changes by running

```sh
terraform apply
```
