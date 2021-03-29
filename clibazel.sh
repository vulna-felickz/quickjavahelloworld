#! /bin/zsh

# helloworld.java

timestamp() {
  date +"%Y%m%d.%H%M%S" # current time
}

BINARY=./codeqlbinaries/$1/codeql
if test -f "$BINARY"; then
  echo "Executing with codeql cli binary: $BINARY"

  # rm -rf /private/var/tmp/_bazel_$USERNAME 

  rm -rf bazel-*

  export SEMMLE_JAVA_INTERCEPT_VERBOSITY=6
  export SEMMLE_JAVA_INTERCEPT_LOG_FILE=true

  mkdir -p java-database

  ## TEMPLATE

  # codeql database create --language java --command "bazel shutdown; bazel build --spawn_strategy=local --nouse_action_cache //path/to/build/targets/..." -vvv --source-root <path to clean source checkout> <output database directory to create>


  ## DOES NOT WORK

  # codeql database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel --install_base=/var/tmp/_bazel_dfigucio/install/5ccdfa437f9a94a683a2b6383c9f8794 --output_base=/private/var/tmp/_bazel_dfigucio/822eb5194f92fb5bc2349f393bea30ae exec-server && bazel build --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 

  ## WORKS

  $BINARY database create "java-database/$(timestamp)" --language=java --command="bazel shutdown" --command="bazel clean" --command="bazel build --strategy=local --spawn_strategy=local --nouse_action_cache //:app" -vvvv

  # $BINARY database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel build --strategy=standalone --spawn_strategy=standalone --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 

  # $BINARY database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel build --spawn_strategy=local --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 

  # $BINARY database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel build --strategy=standalone --spawn_strategy=standalone --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 
  APP=./bazel-bin/app

  if test -f "$APP"; then
    echo "Executing $APP"
    ./bazel-bin/app
    exit 0
  else 
    echo "$APP does not exist"
    exit 2
  fi
else 
  echo "$BINARY does not exist"
  exit 1
fi

