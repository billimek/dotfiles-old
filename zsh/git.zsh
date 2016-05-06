# Makes git auto completion faster favouring for local completions
__git_files () {
    _wanted files expl 'local files' _files
}

gf() {
  local branch=$1
  git checkout -b $branch origin/$branch
}
