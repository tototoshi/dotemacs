# Configuration for using M-x in vterm.
# If you simply set M-x as a key binding, it will conflict with vim.
function M-x() {
    emacsclient --eval '(helm-M-x "")'
}
zle -N M-x
bindkey "^[" M-x
