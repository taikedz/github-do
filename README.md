githubctl
===

Basic command line operations to control github.

Written when in need of cleaning stuff up ...

Batch operations

   githubctl create OWNER REPOS ...

   githubctl reown OWNER NEWOWNER REPOS ...

   githubctl delete OWNER REPOS ...

   githubctl srename OWNER SUBSTITUTION REPOS ...

The `SUBSTITUTION` is of the form `s/old-content/new-content/`

Single-repo operations

   githubctl rename OWNER REPO NEWREPO


