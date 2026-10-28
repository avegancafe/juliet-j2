# J2 fish setup, sourced by every fish shell via Juliet (see Juliet's EXTENSIONS.md).

# dev-env's shell initializers (the `j2` CLI, helpers). Cloned by this
# extension's bootstrap step; `j2 bootstrap` finishes the setup.
if test -d ~/workspace/dev-env/initializers/fish
    for file in ~/workspace/dev-env/initializers/fish/*
        source $file
    end
end

# Tail App Engine logs for a J2 service, picked with fzf.
function logs --description 'Tail gcloud App Engine logs for a J2 service'
    set -l service (printf '%s\n' j2-network-manger network-intel-dashboard network-intel-dashboard-qa network-intel-dashboard-staging \
        | fzf --reverse --height 40% --prompt "Which service logs would you like to see? ")
    test -n "$service"; or return 1
    gcloud app logs tail --service $service
end
