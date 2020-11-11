#!/bin/bash

provider="libvirt"
#provider="virtualbox"

vagrant box add centos/7 --provider=$provider
