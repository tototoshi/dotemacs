#!/bin/bash
cd $(dirname $0)
EMACS=/usr/local/Cellar/emacs/24.3/bin/emacs
$EMACS --batch -q --load $(pwd)/my-install-dependencies.el
