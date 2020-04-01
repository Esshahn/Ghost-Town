![screenshot 2019-04-28 um 20 59 43](https://user-images.githubusercontent.com/434355/56868875-925ec100-69f8-11e9-84e1-2cb37ed6f368.jpg)


# Ghost Town Disassembly

This is the fully disassembled source code of the Commodore 16 game "Ghost Town". It has been commented, restructured, bug fixed and optimized. In addition, new content has been added.


You can download the binaries here: http://www.kingsoft.de


## Plus/4 version (64k RAM)

* choose between english, german and hungarian language
* a new multicolor bitmap title screen
* greatly improved ingame graphics (updated charset)
* Fixed typos and text glitches for both original languages
* Fixed joystick routine to be more reliable
* lots of bug fixes


## C64 & C128 versions

* the game has been ported to the Commodore 64/128 for the first time
* completely new SID music from Spider Jerusalem based on original score
* choose between english, german and hungarian language
* a new multicolor bitmap title screen
* greatly improved ingame graphics (updated charset)
* Fixed typos and text glitches for both original languages
* Fixed joystick routine to be more reliable
* lots of bug fixes

# How to build

The game can be build with ACME and exomizer. This is my command line for the C64.

````
acme -v4 -f cbm -r ../build/report.asm -l ../build/labels -o ../build/main.prg main.asm && STARTADDR=$(grep 'intro_start' ../build/labels | cut -d$ -f2 | cut -f1) && exomizer sfx 0x$STARTADDR -n -t 64 -o ../build/main.prg ../build/main.prg && cat ../build/labels ../build/monitor_commands > ../build/vicelabels 
````

And the same for the Plus/4 version:

````
acme -v4 -f cbm -r ../build/report.asm -l ../build/labels -o ../build/main.prg main.asm && STARTADDR=$(grep 'intro_start' ../build/labels | cut -d$ -f2 | cut -f1) && exomizer sfx 0x$STARTADDR -n -t 4 -o ../build/main.prg ../build/main.prg && cat ../build/labels ../build/monitor_commands > ../build/vicelabels 
````

Please note that the directory structure will likely be different on your machine. If you use VSCode as an editor, you'll find a `tasks.json` file inside the `.vscode` folder that compiles, packs and displays the game in the VICE emulator.
