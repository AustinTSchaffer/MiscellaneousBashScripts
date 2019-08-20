#!/bin/bash

UNPACKED_ZIP_DIR="~/path/to/zip/dir/without/ending/slash"
REPO_DIR="~/path/to/local/repo/dir/without/ending/slash"

cd "$REPO_DIR"
EARLIER_COMMITS=$(git log --format=%H)

for commit in $EARLIER_COMMITS
do
    echo "========================================================"
    echo "Testing Commit: $commit"
    echo "========================================================"

    git checkout $commit
    commit_is_different=0

    for file in $(git ls-files)
    do
        file_diff=$(diff "$UNPACKED_ZIP_DIR/$file" "$REPO_DIR/$file" 2> /dev/null)
        diff_result=$?
        
        if [ $diff_result -eq 2 ]
        then
            commit_is_different=1
            echo "Does not exist in ZIP: $file"
            continue
        fi

        if [ $diff_result -eq 1 ]
        then
            commit_is_different=1
            echo "File is different: $file"
            continue
        fi
    done

    if [ $commit_is_different -eq 0 ]
    then
        echo "This one appears to match: $commit"
        read -n 1 -p "Continue? (y/N): " selection
        
        if [[ ${selection,,} != "y" ]]
        then
            break
        fi
    fi
done
