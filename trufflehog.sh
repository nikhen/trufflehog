#!/bin/bash

function scan_repo() {
    date
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
        'https://github.com/square/git-fastclone'
        'https://github.com/square/go-jose'
        'https://github.com/square/js-jose'
        'https://github.com/square/keywhiz'
        'https://github.com/square/keywhiz-fs'
        'https://github.com/square/keysync'
        'https://github.com/square/okhttp'
        'https://github.com/square/okio'
        'https://github.com/square/pam_krb_cache'
        'https://github.com/square/ghostunnel'
        'https://github.com/square/rails-auth'
        'https://github.com/square/retrofit'
        'https://github.com/square/squalor'
        'https://github.com/square/sudo_pair'
        'https://github.com/square/valet'
        'https://github.com/square/wire'
        'https://github.com/freedomofpress/securedrop'
        'https://github.com/freedomofpress/securedrop-workstation'
        'https://github.com/freedomofpress/securedrop-client'
        'https://github.com/freedomofpress/securedrop-sdk'
        'https://github.com/freedomofpress/securedrop-proxy'
        'https://github.com/freedomofpress/securedrop-export'
        'https://github.com/freedomofpress/securedrop-log'
        'https://github.com/freedomofpress/securedrop-debian-packaging'
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
