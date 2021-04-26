fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
### tests
```
fastlane tests
```
Run all unit tests
### ci_check
```
fastlane ci_check
```
Run CI check for a commit
### create_release_pr
```
fastlane create_release_pr
```
Create release PR
### prepare_release
```
fastlane prepare_release
```
Prepare release of a new version
### publish_release
```
fastlane publish_release
```
Publish release

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
