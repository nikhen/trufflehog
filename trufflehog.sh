#!/bin/bash

function scan_repo() {
    echo "Scanning repository: " $1
    time trufflehog --regex --entropy=False $1
    echo ""
    echo "Done. Scanned repository " $1
    echo ""
}

function main() {
    echo "Starting repository scan"
    a_url=(
        'https://github.com/Zilliqa/savant-ide'
        'https://github.com/Zilliqa/scilla'
        'https://github.com/Zilliqa/Zilliqa'
        'https://github.com/Zilliqa/Zilliqa-JavaScript-Library'
        'https://github.com/cryptolandtech/moonlet-core/releases/tag/v0.0.1'
        'https://github.com/Zilliqa/nucleus-wallet'
    )
    for u in ${a_url[@]}
    do
         scan_repo $u
    done
}

main
