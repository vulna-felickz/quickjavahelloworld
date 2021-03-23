#! /bin/zsh

# helloworld.java

timestamp() {
  date +"%Y%m%d.%H%M%S" # current time
}

rm -rf /private/var/tmp/_bazel_$USERNAME 

rm -rf bazel-*


mkdir -p java-database

#codeql database create --language java --command "bazel shutdown; bazel build --spawn_strategy=local --nouse_action_cache //path/to/build/targets/..." -vvv --source-root <path to clean source checkout> <output database directory to create>

# codeql database create "java-database/$(timestamp)" --language=java --command="bazel shutdown" --command="bazel clean" --command="bazel build --strategy=local --spawn_strategy=local --nouse_action_cache //:app" -vvv

codeql database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel build --spawn_strategy=local --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 


