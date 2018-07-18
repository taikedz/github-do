#%include out.sh

#%include ghcurl.sh

gh:repo:create() {
    local owner repo url section
    owner="${1:-}" ; shift || out:fail "No owner specified"
    [[ -n "$*" ]] || out:fail "No repo(s) specified"

    baseurl="https://api.github.com"
    section="user"
    if [[ "$owner" != "$GHUSER" ]]; then
        section="orgs/$owner"
    fi

    for repo in "$@"; do
        gh:curl "$baseurl/$section/repos" \
            -d "{\"name\":\"$repo\", \"description\":\"$*\"}" \
        | jq .html_url
    done
}

gh:repo:reown() {
    local owner newowner repo
    owner="${1:-}" ; shift || out:fail "No owner specified"
    newowner="${1:-}" ; shift || out:fail "No new owner specified"
    [[ -n "$*" ]] || out:fail "No repo(s) specified"

    for repo in "$@"; do
        gh:curl -H "Accept: application/vnd.github.nightshade-preview+json" \
            "https://api.github.com/repos/$owner/$repo/transfer" \
            -d "{\"new_owner\":\"$newowner\"}" \
        | jq .html_url
    done
}

gh:repo:rename() {
    local owner newname repo
    owner="${1:-}" ; shift || out:fail "No owner specified"
    repo="${1:-}"; shift || out:fail "No repo specified"
    newname="${1:-}"; shift || out:fail "No new name specified"

    gh:curl -X PATCH -d "{\"name\": \"${newname}\"}" \
        "https://api.github.com/repos/$owner/$repo" \
    | jq .html_url
}

gh:repo:srename() {
    local owner substitution newname repo
    owner="${1:-}" ; shift || out:fail "No owner specified"
    substitution="${1:-}"; shift || out:fail "No sub string ('s///') specified"
    [[ -n "$*" ]] || out:fail "No repo(s) specified"

    for repo in "$@"; do
        newname="$(echo "$repo"|sed "$substitution")"
        gh:curl -X PATCH -d "{\"name\": \"${newname}\"}" \
            "https://api.github.com/repos/$owner/$repo" \
        | jq .html_url
    done
}

gh:repo:delete() {
    local owner repo
    owner="${1:-}" ; shift || out:fail "No owner specified"
    [[ -n "$*" ]] || out:fail "No repo(s) specified"

    for repo in "$@"; do
        out:info "Deleting $owner/$repo"
        gh:curl -X DELETE \
            "https://api.github.com/repos/$owner/$repo"
    done
}
