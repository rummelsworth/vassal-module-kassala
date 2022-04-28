# _Kassala_

This repo contains the assets of a game "module" for [Vassal Engine](https://vassalengine.org/).
You'll need Vassal Engine to use the module (i.e. to play the game).

The game is from [_The Complete Book of Wargames_ (1980)](https://www.google.com/books/edition/The_Complete_Book_of_Wargames/5giXGAAACAAJ?hl=en), Chapter 4.

It's a decent bit of fun and holds a special place in at least some folks' hearts, including my own.
I was nine years old, and it was the very first wargame I ever learned and played to completion.
I photocopied the thing, cut out the components, glued them onto some heavy cardstock from my older brother's comic book sleeve materials, similarly crafted a separate turn track, and had myself a pretty good time!

In decreasing order of ease and/or rectitude, there are three ways to get the module:

1. Download it from the [Vassal module catalog](https://vassalengine.org/wiki/Category:Modules).
2. Download it from this repo's [Releases](https://github.com/rummelsworth/vassal-module-kassala/releases).
3. Build it with this repo (see "Development" below).

The game's rules can be accessed via the Help menu in the Vassal user interface after the module is opened.

Enjoy!

![in-game footage](./in-game_footage.png)

## Design notes

- The unit colors are based _roughly_ on the contemporaneous flag colors of the combatant forces, referenced [via Wikipedia][eaw].
- The terrain colors are based _roughly_ on current satellite imagery of the area around [Kassala, Sudan](https://en.wikipedia.org/wiki/Kassala).
- The color design is, overall, minimal! Just a little spice to avoid bare black-and-white...

## Links of interest

- [Ethiopian-Adal War - Wikipedia][eaw]
- [Kassala | Board Game | BoardGameGeek](https://boardgamegeek.com/boardgame/14235/kassala)
- ["What happened where in 1541?" - History Stack Exchange](https://history.stackexchange.com/q/60529/27652)

[eaw]: https://en.wikipedia.org/wiki/Ethiopian%E2%80%93Adal_War

## Development

First and foremost, if you want to hack on this module (or do any Vassal module authoring at all), learn you some [Vassal Wiki](https://vassalengine.org/wiki/Main_Page) for great good!

This repo's "vmod" folder contains all the assets for this Vassal module.
There are helper scripts for the following build-related functions:
- Building the module file from the "vmod" folder.
  - This includes an optional "watch mode", see below.
- "Unbuilding" a module file into the "vmod" folder.
- Watching a module file for changes (and unbuilding on each change).
- Building the help HTML file.
  - This includes an optional "watch mode" that will rebuild the HTML on every change to the "source" MD file.

Tips:
- **Always run this repo's scripts from the repo's root folder.**
- Currently, any changes inside the "help" folder should be manually integrated into the module file using the Vassal module editor. When doing so, you will want to remove the old help item and then add a new help item using the "help" folder and the built HTML file to fill in the item's properties.
- When you finish editing the module file with the Vassal module editor, you should unbuild the module file into the repo so that all changes to the module can be detected and preserved in version control.

PowerShell Core v7.2.1 or later is strongly recommended.
PowerShell and early versions of PowerShell Core can produce incorrect zip archives that cannot be read on/by some systems, including Vassal Engine.
(I think PowerShell Core v7.0.0 or later are okay, but I've only tested down to v7.2.1.)
