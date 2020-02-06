#!/bin/bash

# to do
#     - trufflehog content into temporary file
#         pipe into wc -c
#         report on findings or not in repo -> detailed scan later
#     - read repo list from file
#     - timestamp feature - scan since ...
#     - error handling: lost connection
#         error: RPC failed; curl 18 transfer closed with outstanding read data remainin
#     - custom regex patterns - do not detect pgp keys, do not detect "test"-commits
function scan_repo() {
    date
    echo "Scanning repository:" $1
    time trufflehog --regex --entropy=False $1 --rules regex_rules.json
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
#        'https://github.com/Zilliqa/savant-ide'
        'https://github.com/algorand/go-algorand'
        'https://github.com/algorand/pyteal'
        'https://github.com/algorand/py-algorand-sdk'
        'https://github.com/algorand/algorand-sdk-testing'
        'https://github.com/algorand/java-algorand-sdk'
        'https://github.com/algorand/js-algorand-sdk'
        'https://github.com/algorand/go-algorand-sdk'
        'https://github.com/algorand/py-exebot'
        'https://github.com/algorand/pixel'
#        'https://github.com/Zilliqa/scilla'
#        'https://github.com/Zilliqa/Zilliqa'
#        'https://github.com/Zilliqa/Zilliqa-JavaScript-Library'
#        'https://github.com/cryptolandtech/moonlet-core'
#        'https://github.com/Zilliqa/nucleus-wallet'
#        'https://github.com/square/git-fastclone'
#        'https://github.com/square/go-jose'
#        'https://github.com/square/js-jose'
#        'https://github.com/square/keywhiz'
#        'https://github.com/square/keywhiz-fs'
#        'https://github.com/square/keysync'
#        'https://github.com/square/okhttp'
#        'https://github.com/square/okio'
# private       'https://github.com/square/pam_krb_cache'
#        'https://github.com/square/ghostunnel'
#        'https://github.com/square/rails-auth'
#        'https://github.com/square/retrofit'
#        'https://github.com/square/squalor'
#        'https://github.com/square/sudo_pair'
#        'https://github.com/square/valet'
#        'https://github.com/square/wire'
#       'https://github.com/freedomofpress/securedrop'
#        'https://github.com/freedomofpress/securedrop-workstation'
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
