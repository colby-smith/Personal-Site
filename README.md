# Personal-Site
## About
This is a static website hosted in s3 using CloudFront and Route 53, created using Terraform. The full website can be found at [https://colby-smith-labs.com](https://colby-smith-labs.com). The CSS, JS and HMTL were provided using a free template which I have changed and modified to make my own.

## Architecture diagram
![S3-Static Site](https://github.com/colby-smith/Personal-Site/assets/160542058/e2f2a907-122c-4524-9f4e-1b4704bc8693)


## Prerequisites
There are no prerequisites to use/view the website, however if you wish to copy or use this software for your own, there are a few things you need to install to do so, such as:
* bash or zsh
* AWS CLI
* Terraform
  
## Installing WSL (Windows Subsystem for Linux)

1. Copy and paste the code below into your shell and hit enter.
```
wsl --install
```
3. Wait for the downloads to be complete, then restart your computer.

4. After restarting your computer, you should see an "Ubuntu" Window open automatically once you log back in. If you don't, search for the "Ubuntu" or "WSL" program in the start menu and launch it.

5. The window will prompt you to enter a username and password. Make sure you remember these! These are the credentials for your Linux user.

## Installing the AWS CLI

1. First make sure you have unzip and zip installed, if not run the commands below:
```
sudo apt install unzip
```
```
sudo apt install zip
```
2. Finally, run the command below:
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
3. If you already have the AWS CLI installed, you can update it using the command below:
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
```

## Installing Terraform

1. Ensure that your system is up-to-date, and you have installed the GnuPG, software-properties-common, and curl packages installed.

2. First, run the command below:
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```
3. Then, Install the HashiCorp GPG key.
```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```
4. Verify the key's fingerprint.
```
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```

6. Add the official HashiCorp repository to your system. The lsb_release -CS command finds the distribution release codename for your current system, such as buster, groovy, or SID.
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```
7. Install Terraform from the new repository.
```
sudo apt-get install terraform
```
8a. Finally, verify that the installation worked by opening a new terminal session and listing Terraform's available subcommands.
```
terraform -help plan
```
8b. Optionally, if you're using Bash or Zsh, you can instal tab completion below.
```
terraform -install-autocomplete
```

## Usage
If you are to use this code yourself to create your own personal website, I recommend you have a good knowledge of AWS and Terraform before continuing, as there are a few things you need to do:
* Change the S3 Bucket name, as it must be unique in AWS.
* Change to your specified region.
* Use your own AWS credentials when deploying with terraform.
