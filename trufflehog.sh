#!/bin/bash

function scan_repo() {
    echo "Scanning repository:" $1
    time trufflehog --regex --entropy=False $1
    echo ""
    echo "Done. Scanned repository" $1
    echo ""
}

function print_separator() {
    echo "----"
}

function iterate_over_repos() {
    local i=0
    local a_url=(
        'https://github.com/Zilliqa/savant-ide'
        'https://github.com/Zilliqa/scilla'
        'https://github.com/Zilliqa/Zilliqa'
        'https://github.com/Zilliqa/Zilliqa-JavaScript-Library'
        'https://github.com/cryptolandtech/moonlet-core/releases/tag/v0.0.1'
        'https://github.com/Zilliqa/nucleus-wallet'
    )
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
