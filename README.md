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

HW-06
Connect top app:
testapp_IP = 34.123.153.68
testapp_port = 9292


Additional task 1
Needs to update old requirements: in file Gemfile we need change version sinatra to 2.1.0 and haml to 5.0.4 at least!
gcloud command for create instance with deployed app:
gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-2004-lts \
--image-project=ubuntu-os-cloud \
--machine-type=e2-micro \
--tags puma-server \
--restart-on-failure \
--zone=us-central1-a \
--metadata=startup-script-url="https://raw.githubusercontent.com/insomniansk/infra/cloud-testapp/startup_script.sh"

Additional task 2
gcloud command for create firewall rule:
cloud compute firewall-rules create default-puma-server \
--allow=tcp:9292 \
--description="Created from gcloud cli" \
--direction=INGRESS \
--source-ranges="0.0.0.0/0" \
--target-tags="puma-server"
