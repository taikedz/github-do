gh:curl() {
    ( set -x
    curl -s -S -u "$GHUSER:$GHTOKEN" "$@"
    )
}
