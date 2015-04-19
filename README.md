Simple shell script to dynamically update the desired dns A record with the current public IP of the server.

This script allows to use Google Cloud DNS as a Dynamic DNS server for your needs.

Before using this script please get and setup google cloud SDK from https://cloud.google.com/sdk/ and create a Zone for your domain in https://console.developers.google.com/ under Networking -> Cloud DNS. Please note that Google Cloud DNS is a paid service.

Once all prerequisites are done, configure the script by adjusting zone and domain variables.
Make sure gcloud_bin_path is correct if you plan to run this script in cron.
new_IP variable can be adjusted as well if needed.

gcloud_dyndns.sh doesn't require any arguments to run. 
