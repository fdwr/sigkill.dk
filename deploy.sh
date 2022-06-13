#!/bin/sh

set -e

nix-build
result/bin/sigkill clean
result/bin/sigkill build
result/bin/sigkill deploy
git push
