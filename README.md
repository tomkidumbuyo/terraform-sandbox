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

