# name: command.command
# key: command
# --
def ${1:command} = Command.command("${2:commandName}") { state =>
  $0
  state
}
