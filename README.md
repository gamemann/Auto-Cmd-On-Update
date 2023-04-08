# Auto Command On Update
## Description
A SourceMod plugin that executes a console command on SRCDS servers when a game update is detected. This plugins relies on a forward call in SteamWork's Update Check plugin [here](https://github.com/KyleSanderson/SteamWorks/blob/master/Pawn/UpdateCheck.sp). Therefore, you will need the plugin and SteamWorks for this plugin to operate.

Additionally, a warning timer is also supported.

This works great for servers that automatically check for SteamCMD updates on startup. This would essentially enable automatic game updating for your game servers.

## Requirements
* [SteamWorks](https://forums.alliedmods.net/showthread.php?t=229556)
* [SteamWorks - Update Check](https://github.com/KyleSanderson/SteamWorks/blob/master/Pawn/UpdateCheck.sp) 

For compiling the plugin, you need SteamWork's include file (`SteamWorks.inc`) alongside [MultiColors](https://forums.alliedmods.net/showthread.php?t=247770).

## ConVars
* `sm_acou_command` - The command to execute when a game update is detected (Default - `quit`).
* `sm_acou_warn_time` - Warning time in seconds before command is executed when an update is detected (Default - `10`).
* `sm_acou_version` - The plugin's current version.

## Commands
* `sm_acou_print_version` - Prints the current plugin's version to the server console.
* `sm_acou_test` - Executes the command when an update is detected and includes the warning time.

**Note** - Both commands require the `root` flag.

## Installation
1. Compile plugin with `spcomp(64)` or `compile` executable within SourceMod's `scripting/` directory.
1. Copy `auto_cmd_on_update.smx` file into `sourcemod/plugins` directory.
1. Copy `translations/acou.phrases.txt` file into `sourcemod/` directory.

## Credits
* [Christian Deacon](https://github.com/gamemann)