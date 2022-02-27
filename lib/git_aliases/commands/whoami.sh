#!/bin/sh

echo "Author: $(git config author.name || git config user.name) <${GIT_AUTHOR_EMAIL:-${EMAIL:-$(git config author.email || git config user.email)}}>"
echo "Committer: $(git config committer.name || git config user.name) <${GIT_COMMITTER_EMAIL:-${EMAIL:-$(git config committer.email || git config user.email)}}>"
