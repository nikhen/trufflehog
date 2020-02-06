This is a wrapper for the trufflehog python script that scans git repositories for leaking credentials.

It takes a list of repositories to be scanned from file *repo_target_list.txt*. 

Execute 

    bash trufflehog.sh

to start digging through repositories.

#### Prerequisites
* Installation of [trufflehog](https://github.com/dxa4481/truffleHog) (i.e. typing *trufflehog* in the terminal should work).
* Local file repo_target_list.txt containing one or more entries of type https://github.com/REPO_NAME 
