#!/bin/bash
function getInput {
    read -p "Enter $1: (default: $2) " inputValue
    export $1=${inputValue:-"$2"} 
}
getInput provider virtualbox
getInput vmOS "centos/7"

vagrant box add $vmOS --provider=$provider
