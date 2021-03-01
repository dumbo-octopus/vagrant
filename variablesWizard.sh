#!/bin/bash
# run as `./variablesWizard.sh` to prepare the `variables.rb` file
function getInput {
    read -p "Enter ${1}: (default: ${2}) " inputValue
    printf "${1}="\""${inputValue:-${2}}"\""\n" >> variables.rb
}
printf "" > variables.rb
getInput VmOS ubuntu/focal64
getInput NameNodeCount 1
getInput DataNodeCount 2
getInput CpuCount 1
getInput Ram 1024
getInput Provider virtualbox
