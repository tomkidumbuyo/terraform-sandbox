provider "aws" {
    region = "us-east-1"
    shared_credentials_files = ["/Users/tomkidumbuyo/.aws/credentials"]
    profile = "pulumi-personal"
}