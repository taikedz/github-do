#%include askuser.sh

gh:curl() {
    gh:getcreds
    ( # set -x
    curl -s -S -u "$GHUSER:$GHTOKEN" "$@"
    )
}

gh:getcreds() {
    [[ -n "${GHUSER:-}" ]] || GHUSER="$(askuser:ask "Github user name")"
    [[ -n "${GHTOKEN:-}" ]] || GHTOKEN="$(askuser:password "Github Personal Access Token"; echo >&2)"
    export GHUSER GHTOKEN
}
