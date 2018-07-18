#!/usr/bin/env bash

user=
pass=

r_delete() {
	local newName='{"name": "'"$repo_name"'"}'
	curl -u "$user:$pass" -X DELETE -s -S \
		"https://api.github.com/repos/$owner/${repo_name}"
}

owner="$1"; shift

for repo_name in "$@"; do
	echo "Deleting $repo_name ..."
	r_delete
done

