#!/bin/sh
#
# https://github.com/zakhark/gcloud_dyndns
# Updated on 04/19/2015 by Zakhar Kleyman
#
##### Configuration Section #####
zone="google"
domain="www.google.com."
new_IP=`curl -s http://icanhazip.com`
gcloud_bin_path="~/google-cloud-sdk/bin"
##### End Configuration Section #####
##### Code Magic #####
export PATH=$gcloud_bin_path:$PATH
gcloud dns record-sets transaction abort -z $zone -q
existing_record=`gcloud dns record-sets -z $zone list --name="$domain" | grep $domain`
existing_ip=`echo $existing_record | awk {'print $4'}`
existinf_ttl=`echo $existing_record | awk {'print $3'}`
if [ "$existing_ip" = "$new_IP" ]; then
	echo IP address for $domain is already up to date
else
	gcloud dns record-sets transaction start -z $zone
	if [ -z "$existing_ip" ]; then
		echo Existing IP in DNS is not set - proceeding.
		gcloud dns record-sets transaction add -z $zone --name $domain --ttl 300 --type A "$new_IP"
	else
		echo Existing IP for $domain DNS record is $existing_ip
		echo Updating it to $new_IP
		gcloud dns record-sets transaction remove -z $zone --name $domain --ttl $existinf_ttl --type A "$existing_ip"	
		gcloud dns record-sets transaction execute -z $zone
		gcloud dns record-sets transaction start -z $zone
		gcloud dns record-sets transaction add -z $zone --name $domain --ttl 300 --type A "$new_IP"
	fi
	gcloud dns record-sets transaction execute -z $zone
fi
##### Done #####
