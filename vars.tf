variable "APP" {
  default = "mytest1"
}

variable "REGION" {
  default = "us-east-1"
}

variable "VPC_CIDR" {
  default = "10.0.0.0/21"
}

variable "PUB_SUBNETS_COUNT" {
  default = 2
}

variable "PUBLIC_SUBNETS_CIDR" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "PRIV_SUBNETS_COUNT" {
  default = 2
}

variable "PRIVATE_SUBNETS_CIDR" {
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-09988af04120b3591"
    us-east-2 = "ami-0d1c47ab964ae2b87"
  }
}

variable "USERDATA" {
  default = <<EOF
  #!/bin/bash

            # Variable Declaration
            #PACKAGE="httpd wget unzip"
            #SVC="httpd"
            URL='https://www.tooplate.com/zip-templates/2098_health.zip'
            ART_NAME='2098_health'
            TEMPDIR="/tmp/webfiles"

            yum --help &> /dev/null

            if [ $? -eq 0 ]
            then
              # Set Variables for CentOS
              PACKAGE="httpd wget unzip"
              SVC="httpd"

              echo "Running Setup on CentOS"
              # Installing Dependencies
              echo "########################################"
              echo "Installing packages."
              echo "########################################"
              sudo yum install $PACKAGE -y > /dev/null
              echo

              # Start & Enable Service
              echo "########################################"
              echo "Start & Enable HTTPD Service"
              echo "########################################"
              sudo systemctl start $SVC
              sudo systemctl enable $SVC
              echo

              # Creating Temp Directory
              echo "########################################"
              echo "Starting Artifact Deployment"
              echo "########################################"
              mkdir -p $TEMPDIR
              cd $TEMPDIR
              echo

              wget $URL > /dev/null
              unzip $ART_NAME.zip > /dev/null
              sudo cp -r $ART_NAME/* /var/www/html/
              echo

              # Bounce Service
              echo "########################################"
              echo "Restarting HTTPD service"
              echo "########################################"
              systemctl restart $SVC
              echo

              # Clean Up
              echo "########################################"
              echo "Removing Temporary Files"
              echo "########################################"
              rm -rf $TEMPDIR
              echo

              sudo systemctl status $SVC
              ls /var/www/html/

            else
                # Set Variables for Ubuntu
              PACKAGE="apache2 wget unzip"
              SVC="apache2"

              echo "Running Setup on CentOS"
              # Installing Dependencies
              echo "########################################"
              echo "Installing packages."
              echo "########################################"
              sudo apt update
              sudo apt install $PACKAGE -y > /dev/null
              echo

              # Start & Enable Service
              echo "########################################"
              echo "Start & Enable HTTPD Service"
              echo "########################################"
              sudo systemctl start $SVC
              sudo systemctl enable $SVC
              echo

              # Creating Temp Directory
              echo "########################################"
              echo "Starting Artifact Deployment"
              echo "########################################"
              mkdir -p $TEMPDIR
              cd $TEMPDIR
              echo

              wget $URL > /dev/null
              unzip $ART_NAME.zip > /dev/null
              sudo cp -r $ART_NAME/* /var/www/html/
              echo

              # Bounce Service
              echo "########################################"
              echo "Restarting HTTPD service"
              echo "########################################"
              systemctl restart $SVC
              echo

              # Clean Up
              echo "########################################"
              echo "Removing Temporary Files"
              echo "########################################"
              rm -rf $TEMPDIR
              echo

              sudo systemctl status $SVC
              ls /var/www/html/
            fi 

    EOF
}

variable "ingressrules" {
    type = list(number)
    default = [80,443]
}
