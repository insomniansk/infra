#!/usr/bin/env bash
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --boot-disk-type=pd-standard \
  --image=reddit-base-1636219264 \
  --machine-type=e2-micro \
  --tags puma-server \
  --zone=us-central1-a \
  --restart-on-failure
