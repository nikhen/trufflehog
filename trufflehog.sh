#!/bin/bash

# to do
#     - trufflehog content into temporary file
#         pipe into wc -c
#         report on findings or not in repo -> detailed scan later
#     - timestamp feature - scan since ...
#     - error handling: lost connection
#         error: RPC failed; curl 18 transfer closed with outstanding read data remainin

function scan_repo() {
    date
    echo "Scanning repository:" $1
    time trufflehog --regex --entropy=False $1 --rules regex_rules.json -x exclude-patterns.txt
    echo ""
    echo "Done. Scanned repository" $1
    echo ""
}

function print_separator() {
    echo "----"
}

function read_repositories_into_variable() {
    mkdir _tmp
    wget https://api.github.com/users/Comcast/repos -O _tmp/_repo_list.json
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
         echo "Scanned" $i"/"$number_of_repos "repositories."
         print_separator
    done
}

function main() {

    read_repositories_into_variable

    iterate_over_repos

}

main
