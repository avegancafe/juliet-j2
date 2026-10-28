# Sourced by juliet-bootstrap (bash). Runs as part of the `extension` category:
#   juliet-bootstrap --enable=extension
# Only Juliet's stable extension helpers are used here (see Juliet's EXTENSIONS.md).

extension-setup() {
  setup-j2-dev-env
  setup-j2-opencode
}

# dev-env (private, j2-health/dev-env) carries the `j2` CLI and the fish
# initializers fish/config.fish sources. Clone it where both expect it; the
# repo's own `j2 bootstrap` does the rest of the J2 machine setup.
setup-j2-dev-env() {
  substep "Checking dev-env..."
  local dir="$HOME/workspace/dev-env"
  if [[ -d "$dir/.git" ]]; then
    skip "dev-env already cloned"
    return 0
  fi
  if [[ -e "$dir" ]]; then
    bootstrap_error "$dir exists but isn't a git clone." "Move it aside, then re-run: juliet-bootstrap --enable=extension"
    return 0
  fi
  if ! command -v gh &> /dev/null || ! gh auth status &> /dev/null; then
    warn "dev-env is private: run 'gh auth login' (with your J2 GitHub account), then re-run: juliet-bootstrap --enable=extension"
    skip "gh not authenticated"
    return 0
  fi
  mkdir -p "$HOME/workspace"
  spin "Cloning j2-health/dev-env..." gh repo clone j2-health/dev-env "$dir" -- -q || {
    bootstrap_error "Couldn't clone j2-health/dev-env." \
      "Check you have access to the j2-health org, then re-run: juliet-bootstrap --enable=extension"
    return 0
  }
  notice "dev-env cloned. Open a new shell and run 'j2 bootstrap' to finish the J2 setup."
}

# Juliet layers its own opencode config through OPENCODE_CONFIG; the global
# ~/.config/opencode/opencode.json (pinned J2 plugins, team MCP servers, LSPs)
# is laid down by dev-env's `j2 bootstrap`. Point at that when it's missing.
setup-j2-opencode() {
  substep "Checking the J2 opencode config..."
  if ! command -v opencode &> /dev/null; then
    skip "opencode isn't installed"
  elif [[ -e "$HOME/.config/opencode/opencode.json" ]]; then
    skip "global opencode.json already in place"
  else
    notice "No ~/.config/opencode/opencode.json yet: run 'j2 bootstrap' to install the J2 team config."
    skip "waiting on j2 bootstrap"
  fi
}
