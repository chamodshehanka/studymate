workflow "build and test app" {
  on = "push"
  resolves = ["build apk", "run tests"]
}

# Install dependencies
action "install dependencies" {
  uses = "Shehanka/studymate@master"
  args = "pub get"
}

# test app
action "run tests" {
  needs = "install dependencies"
  uses = "Shehanka/studymate@master"
  args = "test"
}

# Build APK
action "build apk" {
  needs = "install dependencies"
  uses  = "Shehanka/studymate@master"
  args  = "build apk --release"
}