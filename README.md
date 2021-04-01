# quickjavahelloworld

This repository contains an example of a "hello world" java application along with a known example of a non-best practice java coding exmple of concatenating loops in a string.

The original idea was to understand how we can get both the codeql-runner and codeql CLI tools to work with [bazel](https://bazel.build/)

There is also a custom query at /my-basic-queries, to pick up the loop string concatenation. This gives a base example on how to include custom queries. The query itself is just a copy of the standard one at https://github.com/github/codeql/blob/main/java/ql/src/Performance/ConcatenationInLoops.ql but with a custom `@id java/affraes-string-concatenation-in-loop` so we can see it being picked up in analysis

## Notes
There is a bug in the current public build of the `codeql` CLI tool that does not pass on all the required environment variables to `bazel`. This is fixed in a bleeding edge build of `codeql` - the tool and bundle for which is contained in `/codeqlbinaries` (in OS-specific sub-directories). The scripts use this bundle where necessary.

## Setup

You will need to have `bazel` installed on your system and available in your $PATH.

- On a mac you can do this with [homebrew](https://brew.sh) and the command `brew install bazel`

You will also need the OS specific `codeql-runner` for your platform (eg `codeql-runner-macos` or `codeql-runner-linux`)and available in your $PATH. See https://docs.github.com/en/code-security/secure-coding/running-codeql-code-scanning-in-your-ci-system#downloading-the-codeql-runner for further details

A setup sctipt is forthcoming.

## Scripts (tested on macOS, not tested on linux, not written for win support, yet)

Some of these tools require `macos` or `linux` as an argument so they can execute the OS specific versions
- `mvnexec.sh` - just does a mavan build package and exec. Does not do anything involving bazel or codeql
- `javacbuild.sh` - uses `javac`. Performs a `codeql-runner-OS init` and `anazlyze` (with no uploading of results). Usage: `./javacbuild.sh macos|linux`
- `clibazel.sh` - uses the codeql CLI tool to create a codeql database using bazel as the build tool. Usage: `./clibazel.sh macos|linux`
- `bazelbuild.sh` - uses the codeql-runner-OS tool to create a codeql database using bazel as the build tool. Usage: `./bazelbuild.sh macos|linux`


## Workflows

There is a standard `codeql-analysis.yml` workflow file that autobuilds and analyzes so you can see this in actions without using `bazel`
In addition, there is a `codeql-build.yml` workflow that simply uses a GitHub Actions-supplied Linux VM to execute a codeql database build with `bazel`. This, however, uses the latest publicly available version of the `codeql` CLI tool and will currently break until the fix is released, but is included so you can get an idea of how it would work.
