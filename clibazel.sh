#! /bin/zsh

# helloworld.java

timestamp() {
  date +"%Y%m%d.%H%M%S" # current time
}

mkdir -p java-database

codeql database create "java-database/$(timestamp)" --language=java --command="bazel shutdown" --command="bazel clean" --command="bazel build --spawn_strategy=local --nouse_action_cache //:app"
