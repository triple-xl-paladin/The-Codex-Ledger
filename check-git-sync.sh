#!/bin/bash

# Fetch latest info from both remotes
# git fetch desktoprepo
git fetch github
git fetch marquet

# Get commit hashes
local_master=$(git rev-parse master)
# desktop_master=$(git rev-parse desktoprepo/master)
github_master=$(git rev-parse github/master)
marquet_master=$(git rev-parse marquet/master)

echo "Local master:      $local_master"
# echo "Desktop remote:    $desktop_master"
echo "GitHub remote:     $github_master"
echo "Marquet remote:    $marquet_master"
echo

# if [[ "$local_master" == "$desktop_master" && "$local_master" == "$github_master" && "$local_master" == "$marquet_master" ]]; then
if [[ "$local_master" == "$github_master" && "$local_master" == "$marquet_master" ]]; then
  echo "All repos are in sync on master."
else
  echo "Repos differ!"
#  echo "Commits present in desktoprepo but not in local or GitHub:"
#  git log --oneline --left-only --graph "$local_master".."$desktop_master"
#  echo
  echo "Commits present in GitHub but not in local:"
  git log --oneline --left-only --graph "$local_master".."$github_master"
  echo
  echo "Commits present in Marquet but not in local or GitHub:"
  git log --oneline --left-only --graph "$local_master".."$marquet_master"
fi

