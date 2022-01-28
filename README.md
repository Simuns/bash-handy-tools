# bash-handy-tools
#### Handy bash scripts for easier workflow. Works best with bashrc aliases.

## autocompiletex.sh
Autocompiletex.sh automates compiling with pdflatex (Can be used with other latex versions with slight modifications).
With the usage of checksums, the script determines changes done on .tex files and compiles. 

#### prerequisites
Will run on any flavor of linux, but its nice to have evince as pdf viewer combined with code as IDE as there is autolaunch options for those tools (Not required)
### How to:
1. Write following line to your .bashrc file `alias autocompiletex='bash ~/path/to/script/autocompiletex.sh'
2. Run: `source .bashrc´
3. cd to target latex directory and run `autocompile´
##

# wwcon.sh
wwcon is great for system administrators that need to access a variety of RDP connections locked behind a variety of VPN tunnels.
It combines nmcli with Remmina RDP manager automating the vpn tunnel switching so you only have to care about what RDP host you need access to.
This makes for a more seemless dayly workflow if used correctly.

#### Will write how to later

## Author: Símun Højgaard Lutzen | simunhojgaard@gmail.com
