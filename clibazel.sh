#! /bin/zsh

if [[ "$1" == "macos" ]] || [[ "$1" == "linux" ]]
then

  timestamp () {
    date +"%Y%m%d.%H%M%S" # current time
  }

  THEPATH=$PWD

  BINARY=$THEPATH/codeqlbinaries/$1/codeql

  if test -f "$BINARY"; then
    echo "Executing with codeql cli binary: $BINARY"

    echo "Brute force removing prior bazel output..."
    rm -rf bazel-*

    export SEMMLE_JAVA_INTERCEPT_VERBOSITY=6
    export SEMMLE_JAVA_INTERCEPT_LOG_FILE=true

    echo "Making sure directory java-database exists (folder and contents not being tracked by git - see .gitignore)"
    mkdir -p java-database

    TIMESTAMP=$(timestamp)

    echo "Creating database at java-database/$TIMESTAMP"
    $BINARY database create "java-database/$TIMESTAMP" --language=java --command="bazel shutdown" --command="bazel clean --expunge" --command="bazel build --strategy=local --spawn_strategy=local --nouse_action_cache //:app" -vvvv
    
    APP=./bazel-bin/app

    if test -f "$APP"; then
      echo "Executing $APP"
      ./bazel-bin/app
    else 
      echo "$APP does not exist"
      exit 3
    fi
  else 
    echo "$BINARY does not exist"
    exit 2
  fi
else
  echo "Usage $0 macos|linux"
  exit 1
fi
