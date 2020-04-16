#!/bin/bash

function install_current {
  echo "trying to update $1"
  brew upgrade $1 || brew install $1 || true
  brew link $1
}

if [ "$1" != "" ]; then
    echo "Project name: $1"
else
    echo "Project name required!"
    exit 1
fi

if [ -e "Mintfile" ]; then
  install_current mint
  mint bootstrap
  mint run carthage carthage update --platform iOS --no-use-binaries --cache-builds
fi

mv ForkApp $1
mv ForkAppTests "$1Tests"
sed -i '' "s/#PROJECT_NAME#/$1/g" project.yml
mint run xcodegen

