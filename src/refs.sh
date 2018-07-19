
gh:refs:delete() {
    local owner repo branch ref
    ref="${1:-}" ; shift || out:fail "No ref specified"
    owner="${1:-}" ; shift || out:fail "No owner specified"
    repo="${1:-}" ; shift || out:fail "No repo specified"
    branch="${1:-}" ; shift || out:fail "No branch specified"

    gh:curl -X DELETE "https://api.github.com/repos/$owner/$repo/git/refs/$ref/$branch" \
        | jq .html_url
}

# ====

gh:branch:delete() {
    gh:refs:delete heads "$@"
}

# ====

gh:tag:delete() {
    gh:refs:delete tags "$@"
}
