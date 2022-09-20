#!/bin/sh

. /etc/os-release

case "${ID}" in
  debian|ubuntu)
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get upgrade --quiet --yes
  ;;
  fedora|redhat|centos)
    yum -y update
  ;;
  *)
    echo "Uncertain of the distribution, failing."
    exit 1
  ;;
esac