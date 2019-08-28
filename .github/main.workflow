workflow "build and test app" {
  on = "push"
  resolves = ["build apk", "run tests"]
}

# Install dependencies
action "install dependencies" {
  uses = "steebchen/flutter@master"
  args = "pub get"
}

# test app
action "run tests" {
  needs = "install dependencies"
  uses = "steebchen/flutter@master"
  args = "test"
}

# Build APK
action "build apk" {
  needs = "install dependencies"
  uses  = "steebchen/flutter@master"
  args  = "build apk --release"
}