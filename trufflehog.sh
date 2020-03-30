#!/bin/bash

#
#  global variables
#
#    MAX_RETRIES: maximum number of retries after failed requests
#
MAX_RETRIES=5

function scan_repo() {
    local j=0

    date
    echo "Scanning repository:" $1

    while [ $j -le $MAX_RETRIES ]
    do
        trufflehog --json --regex --entropy=False $1 --rules regex_rules.json -x exclude-patterns.txt | jq .
        if [ "$?" = "0" ]; then
            echo ""
            echo "Done. Scanned repository" $1
            echo ""
            break
        fi
        sleep 10
        j=$(( $j + 1 ))
    done
}

function print_separator() {
    echo "----"
}

function read_repositories_into_variable() {
    mkdir _tmp
    wget https://api.github.com/users/$organization/repos -O _tmp/_repo_list.json
    repo_list_json=$(<_tmp/_repo_list.json)
    echo $repo_list_json | jq . | grep clone_url | sed s/.*\"clone_url\":.*\"https/https/g | sed s/\",//g > _tmp/_repo_url_list.txt
    cp _tmp/_repo_url_list.txt _repo_target_list.txt
    rm -rf _tmp
}

function iterate_over_repos() {
    local i=0
    local a_url

    readarray -t a_url < _repo_target_list.txt

    local number_of_repos=${#a_url[@]}

    echo "Scanning "$number_of_repos "repositories."
    print_separator

    for u in ${a_url[@]}
    do
         scan_repo $u
         ((i++))
         echo "Triggered scan for" $i"/"$number_of_repos "repositories."
         print_separator
    done
}

function main() {

    if [ -n "$organization" ]; then
        read_repositories_into_variable
    fi

    iterate_over_repos

}

while getopts "o:" opt; do
    case $opt in
        o)  organization="$OPTARG"
            ;;
    esac
done

main
