user=
pass=

r_reown() {
	[[ -n "$new_owner" ]] || return 0

	curl -u "$user:$pass" -s -S \
		-H "Accept: application/vnd.github.nightshade-preview+json" \
		"https://api.github.com/repos/$cur_owner/${repo_slug}${repo_name}/transfer" \
		-d '{"new_owner":"'"$new_owner"'"}' \
	| jq .html_url
}

r_rename() {
	[[ -n "$repo_slug" ]] || return 0
	[[ -n "$new_owner" ]] || new_owner="$cur_owner"

	local newName='{"name": "'"$repo_name"'"}'
	curl -u "$user:$pass" -X PATCH -d "$newName" -s -S \
		"https://api.github.com/repos/$new_owner/${repo_slug}${repo_name}" \
	| jq .html_url
}

set -euo pipefail

main() {
	cur_owner="$1"; shift
	new_owner="$1"; shift
	repo_slug="$1"; shift

	for repo_name in "$@"; do
		echo "-- $repo_name --"
		r_reown
		r_rename
		sleep 0.5
	done
}

main "$@" || echo "Failed on [$repo_name]"
