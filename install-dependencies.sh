#!/bin/bash
cd $(dirname $0)
EMACS=/usr/local/Cellar/emacs/24.3/bin/emacs
$EMACS -q --batch --load $(pwd)/my-install-dependencies.el
