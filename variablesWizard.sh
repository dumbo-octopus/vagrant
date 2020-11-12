#!/bin/bash
# run as `bash variablesWizard.sh` prepare the `vagrantVariables.sh` file
# run `source vagrantVariables.sh` to set up the environment for Vagrantfile
variables=""
function getInput {
    read -p "Enter $1: (default: $2) " inputValue
    export $1=${inputValue:-"$2"} 
    variables="${variables}export ${1}=${!1}\n"
}

getInput vmOS "centos/7"
getInput nameNodeCount 1
getInput dataNodeCount 2
getInput cpuCount 1
getInput ram 1024
getInput provider virtualbox

echo -e "$variables" > vagrantVariables.sh
#vagrant up


