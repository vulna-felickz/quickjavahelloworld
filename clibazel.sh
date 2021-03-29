#! /bin/zsh

# helloworld.java

timestamp() {
  date +"%Y%m%d.%H%M%S" # current time
}

echo "Will be running ./codeqlbinaries/$1/codeql"

# rm -rf /private/var/tmp/_bazel_$USERNAME 

rm -rf bazel-*

export SEMMLE_JAVA_INTERCEPT_VERBOSITY=6
export SEMMLE_JAVA_INTERCEPT_LOG_FILE=true

mkdir -p java-database

#codeql database create --language java --command "bazel shutdown; bazel build --spawn_strategy=local --nouse_action_cache //path/to/build/targets/..." -vvv --source-root <path to clean source checkout> <output database directory to create>

# codeql database create "java-database/$(timestamp)" --language=java --command="bazel shutdown" --command="bazel clean" --command="bazel build --strategy=local --spawn_strategy=local --nouse_action_cache //:app" -vvv

# codeql database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel build --spawn_strategy=local --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 

# codeql database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel --batch build --spawn_strategy=local --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 

# codeql database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel build --strategy=standalone --spawn_strategy=standalone --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 
./codeqlbinaries/$1/codeql database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel build --strategy=standalone --spawn_strategy=standalone --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 

# codeql database create "java-database/$(timestamp)" --language=java -vvvv --command="bazel shutdown" --command="bazel clean --expunge" --command "bazel --install_base=/var/tmp/_bazel_dfigucio/install/5ccdfa437f9a94a683a2b6383c9f8794 --output_base=/private/var/tmp/_bazel_dfigucio/822eb5194f92fb5bc2349f393bea30ae exec-server && bazel build --nouse_action_cache --modify_execution_info MNEMONIC=+no-cache //:app" --source-root . 


