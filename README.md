# aws-update-sg

## Purpose

### Problem
The problem I am trying to solve is that I am now using a new VPN service that does not allow static IP addresses. I am also on a dynamic IP address service. That means when I want to SSH into my AWS EC2, I normally would go to the console/CLI and add/remove existing security group inbound rules.

### Solution
Thus, the purpose of this script is to 1) delete the previous inbound rule; 2) check for my ip address; and 3) create a new inbound rule. Note: this assumes I only have 1 inbound rule for port 22 with my previous static IP created by my VPN.

### Usage

The script takes a single argument which is the name of your security group.

```
./awsSgUpdate.sh *security_group_name*
```

Ensure you have your aws cli configured. If you have used virtualenv or similar tools, make sure your source activate into your virtual environment.

Make sure the script has executable permissions:

```
sudo chmod +x awsSgUpdate.sh
```

Dependencies include curl.
