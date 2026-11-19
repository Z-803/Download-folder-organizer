Instructions on how to use (linux):
open the folder the .sh file is in and run 

"chmod +x sort-downloads.sh"

 Usage: sort-downloads.sh [-x] [dir]
  no flag : dry run (prints what would happen)
  -x      : actually move the files
  dir     : defaults to ~/Downloads

##################################################
  macOS: it mostly works but the built-in bash is old and the script uses ${1,,} to lowercase text which needs bash 4 or newer run brew install bash and it will work otherwise you’ll get a “bad substitution” error im not exactly sure tho
windows: it won’t run in power shell or cmd. You’d need WSL or git bash. For native windows you’d need a power shell version of the script also not tested
