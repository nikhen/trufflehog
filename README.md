### trufflehog

This is a wrapper for the trufflehog python script that scans git repositories for leaking credentials.

It takes a list of repositories to be scanned from file *_repo_target_list.txt*. 

Execute 

    bash trufflehog.sh

to start digging through repositories.

You might optionally specify the name of a github organization

    bash trufflehog.sh -o ORGNAME

In this mode, input file *_repo_target_list* is not required. The script will try to fetch all repositories from the given github organization. This mode only operates on repositories hosted on *github.com*.

While the original trufflehog runs on a single repository, this wrapper is constructed to allow consecutive scanning of multiple repositories or organizations.

#### Prerequisites
* Installation of [trufflehog](https://github.com/dxa4481/truffleHog) (i.e. typing *trufflehog* in the terminal should work).
* Installation of *jq*, if you are using the *-o* option (typing *jq* in the terminal should work).
