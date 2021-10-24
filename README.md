# insomniansk_infra
insomniansk Infra repository

HW-05

Ssh to someinternalhost through bastion by one command:
ssh -J <user_for_gcp>@<bastion_ip> <user_for_gcp>@<someinternalhost_ip>

Ssh to someinternalhost through bastion by one command through alias someinternalhost.
Let's use ssh aliases. We need to add these lines to file ~/.ssh/config:

# Someinternalhost (test alias for GCP)
Host someinternalhost
    HostName <someinternalhost_ip>
    User gcpuser
    IdentityFile ~/.ssh/<user_for_gcp>
    ProxyJump <user_for_gcp>@<bastion_ip>

Configuration for pritunl openvpn server was adjusted for ubuntu 20.04 LTS (focal) because repo for xenial of pritunl was broken.
According this we have changed dist in .travis.ynl file from trusty to focal

bastion_IP = 35.209.8.159
someinternalhost_IP = 10.128.0.3
