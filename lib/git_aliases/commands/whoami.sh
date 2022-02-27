#!/bin/sh

# See:
# - https://git-scm.com/docs/git-config#Documentation/git-config.txt-username
# - https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables#_committing

echo "Author: $(git config author.name || git config user.name) <${GIT_AUTHOR_EMAIL:-${EMAIL:-$(git config author.email || git config user.email)}}>"
echo "Committer: $(git config committer.name || git config user.name) <${GIT_COMMITTER_EMAIL:-${EMAIL:-$(git config committer.email || git config user.email)}}>"
