#! /bin/zsh

GIT_BRANCH="refs/heads/$(git branch --show-current)"
GIT_HASH=$(git rev-parse HEAD)

# helloworld.java
codeql-runner-macos init \
    --github-url 'https://github.com' \
    --repository 'affrae/quickhelloworld' \
    --languages 'java' \
    --config-file '.github/codeql/codeql-config.yml'

. codeql-runner/codeql-env.sh

rm src/main/java/hello/HelloWorld.class

# Execution from macOS
$CODEQL_RUNNER javac src/main/java/hello/HelloWorld.java

codeql-runner-macos analyze \
    --github-url 'https://github.com' \
    --repository 'affrae/quickhelloworld' \
    --commit $GIT_HASH \
    --no-upload \
    --ref $GIT_BRANCH
