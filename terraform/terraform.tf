terraform {
   backend "s3" {
     bucket = "rs07863121991"
     key = "vpc/terraform.tfstate"
     region = "us-east-1"
   }

}
