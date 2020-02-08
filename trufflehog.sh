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

    iterate_over_repos

}

main
